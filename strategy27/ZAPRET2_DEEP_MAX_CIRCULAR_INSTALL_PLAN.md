# ZAPRET2 DEEP MAX CIRCULAR — FULL INSTALLATION PLAN FOR hAP ac lite

Дата: 2026-09-28
Статус: **NOT_STARTED**
Назначение: пошаговая установка подготовленного Strategy27 Deep Max Circular на MikroTik hAP ac lite без предварительного runtime-теста стратегий на hAP.

---

## 1. ЦЕЛЬ

Установить на hAP готовый пакет:

`ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz`

и заменить текущий permanent Strategy27 exact-layer:

```
ME + HC + TS + QF
        ↓
existing autohostlist fallback
```

на evidence-conditioned deep circular architecture:

```
HTTP:
HC → ME → HF

TLS:
TS → TF → TC → LX (last resort)

QUIC:
QF → QI
```

Главная идея: один и тот же домен не должен получать все стратегии подряд только потому, что они существуют. Hostlists в пакете уже разделяют домены на точные ladder-группы, полученные из blockcheck2609_FULL.log + blockcheck2709.log.

---

## 2. КАКАЯ МАШИНА

Целевой роутер:

- MikroTik hAP ac lite / RB952Ui-5ac2nD
- 64 MB RAM
- MIPS 24Kc ~650 MHz
- OpenWrt 25.12.5 r33051-f5dae5ece4
- ath79/mikrotik
- mips_24kc
- kernel 6.12.94
- QCA9533
- текущий zapret2: v1.0.3, commit b78b52c4
- apk-tools 3.0.5; opkg отсутствует

Сеть:

- основной роутер: TP-Link Archer C20 v4; **не заменяется**
- hAP upstream через Archer Wi-Fi: `phy0-sta0`
- hAP upstream IPv4: 192.168.0.100/24
- upstream gateway: 192.168.0.1
- hAP LAN bridge: `br-lan`
- hAP LAN IPv4: 192.168.1.1/24
- DHCP: 192.168.1.100–249

Хранилище:

- USB sda1: swap 512 MB
- zram0: 32 MB
- sda2: extroot, mounted /overlay
- sda3: /mnt/data
- /mnt/data используется как независимое место для пользовательских rollback-копий.

Важно: установка относится только к hAP. Archer C20 не изменяется.

---

## 3. ТЕКУЩИЙ ZAPRET2 BASELINE, КОТОРЫЙ НЕЛЬЗЯ СЛУЧАЙНО СЛОМАТЬ

До установки текущий permanent слой:

- ME = 44 host
- HC = 159 host
- TS = 194 host
- QF = 111 host
- existing autohostlist fallback после exact profiles

Сохраняются:

- MODE_FILTER=autohostlist
- QNUM=300
- существующий QNUM=65300 для WireGuard-pattern обработки
- FLOWOFFLOAD=donttouch
- INIT_APPLY_FW=1
- IPv6 disabled в текущем zapret2
- SET_MAXELEM=522288
- существующий zapret2 watchdog
- существующие DNS/routing/VPN/PBR/firewall настройки

Нельзя во время этой установки:

- менять DNS;
- менять routing;
- менять PBR;
- включать WARP;
- менять WireGuard/AWG;
- менять QNUM;
- менять MODE_FILTER;
- очищать autohostlist;
- устанавливать второй watchdog;
- ставить новый zapret2 поверх текущего;
- делать sysupgrade/reboot только ради этой установки.

Обычная автохостлист-база `/opt/zapret2/ipset/zapret-hosts-auto.txt` должна остаться на месте.

---

## 4. ВЕРСИЯ ZAPRET2

Роутер сейчас работает на zapret2 v1.0.3 (b78b52c4).

Официальный upstream уже имеет более новые версии, включая v1.0.5.2.

**Обновление zapret2 в рамках этой установки запрещено.**

Причина: пакет и конфигурация должны применяться к уже работающему baseline; одновременная смена версии движка и Strategy27 уничтожит диагностическую определённость.

После успешной установки и отдельного решения можно сделать независимый upgrade-аудит.

---

## 5. ЧТО ВНУТРИ DEEP MAX ПАКЕТА

Архив:

`strategy27/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz`

GitHub blob SHA:

`54a9e7aef6c2552f756b0475af0bef37291868cd`

Ожидаемый SHA256 архива:

`63029e3a6821f079dc7544f1166713e65475fec2164d0cf16e9b88d47abc6dcc`

Пакет содержит:

- installer `install-strategy27-deep-max-circular.sh`
- HTTP/TLS/QUIC deep hostlists
- evidence matrix
- README
- evidence addendum.

Установщик по умолчанию использует:

- config: `/opt/zapret2/config`
- strategy dir: `/etc/zapret2/strategy27`
- deep directory: `/etc/zapret2/strategy27/deep-circular`

На hAP не задавать `STRAT_DIR` или `CFG` вручную.

---

## 6. СТРАТЕГИИ И ГЛУБИНА

### HTTP

`HC → ME → HF`

HF остаётся candidate-only по evidence; он используется только как пользовательский последний fallback.

Группы:

- HC→ME→HF = 142 domains
- HC→ME = 13
- HC→HF = 4
- ME→HF = 2
- ME only = 42

### TLS

Evidence-backed:

- TS→TF = 15
- TS→TC = 2
- TS only = 178

Дополнительный tested-not-found:

- LX = 0 AVAILABLE / 0 FOUND

По пользовательскому запросу LX включён только как последняя экспериментальная попытка:

- TS→TF→LX
- TS→TC→LX
- TS→LX

### QUIC

- QF→QI = 68
- QF only = 43
- QI only = 2

Максимальная operational depth:

- HTTP = 3
- TLS = 3
- QUIC = 2

Evidence-backed successful depth:

- HTTP = 3
- TLS = 2
- QUIC = 2

Не путать operational depth и evidence-backed depth.

---

## 7. КАК РАБОТАЕТ CIRCULAR

Для каждого circular-профиля:

- `strategy=1` = primary;
- `strategy=2` = backup;
- `strategy=3` = backup;
- `:final` = последняя стратегия, после которой дальнейшая ротация прекращается.

Используемый detector:

`circular:fails=1:retrans=1:reset`

Это не означает, что браузер сообщает Zapret2 «сайт не открылся». Circular переключается по внутреннему failure detector.

Официальный код zapret2 требует последовательные strategy numbers, начиная с 1, без пропусков, и поддерживает остановку на `:final`. В официальном коде нет фиксированного потолка в три стратегии. urlОфициальный zapret2 circular implementationhttps://github.com/bol-van/zapret2/blob/master/lua/zapret-auto.lua

---

## 8. ВАЖНАЯ БЕЗОПАСНОСТЬ ДЛЯ 64 MB RAM

hAP — малоресурсный роутер.

Установка не должна:

- запускать массовый resolver scan;
- строить 297 live connections;
- запускать 4×N service matrix;
- ставить дополнительные большие пакеты;
- включать второй daemon;
- менять conntrack architecture.

После restart контрольный memory snapshot обязателен.

Проектный stop-condition:

- OOM / kernel kill;
- резкое ухудшение available RAM;
- structural watchdog failure;
- nft/NFQUEUE failure;
- zapret2 не поднимается.

При таком результате — rollback, а не stacking новых стратегий.

---

## 9. ЭТАП I0 — CONNECTION / IDENTITY

Статус: **NOT_STARTED**

Подключиться непосредственно к hAP по SSH.

Перед изменениями убедиться, что shell находится именно на hAP, а не на Archer.

Команда:

```sh
echo '=== IDENTITY ==='
ubus call system board
echo '=== UPTIME ==='
uptime
echo '=== ROUTE ==='
ip -4 route
```

Ожидается:

- OpenWrt 25.12.5
- ath79/mikrotik
- hAP board
- default route через 192.168.0.1.

Если identity неправильная — остановиться.

---

## 10. ЭТАП I1 — READ-ONLY BASELINE

Статус: **NOT_STARTED**

Один сгруппированный read-only snapshot:

```sh
echo '=== ZAPRET2 STATUS ==='
/etc/init.d/zapret2 status || true

echo '=== WATCHDOG ==='
/usr/bin/zapret2-watchdog --check || true

echo '=== MEMORY ==='
free -h

echo '=== STORAGE ==='
df -h /overlay /mnt/data /tmp

echo '=== CONFIG HASH ==='
sha256sum /opt/zapret2/config

echo '=== CURRENT STRATEGY HOSTLIST COUNTS ==='
for f in /etc/zapret2/strategy27/strategy27-{me,hc,ts,qf}.txt; do
  printf '%s: ' "$f"
  wc -l < "$f"
done

echo '=== NFQWS2 OPT ANCHORS ==='
grep -nE 'NFQWS2_OPT=|strategy27-(me|hc|ts|qf).txt|MODE_FILTER=|QNUM=|SET_MAXELEM=|FLOWOFFLOAD=|INIT_APPLY_FW=|DISABLE_IPV6=' /opt/zapret2/config
```

Не менять ничего по результату этого snapshot.

---

## 11. ЭТАП I2 — INDEPENDENT BACKUP В /mnt/data

Статус: **NOT_STARTED**

Это дополнительный backup помимо встроенного backup installer.

Команда:

```sh
STAMP=$(date +%Y%m%d-%H%M%S)
BK="/mnt/data/zapret2-deep-max-pre-$STAMP"
mkdir -p "$BK"

cp -a /opt/zapret2/config "$BK/"
for f in strategy27-me.txt strategy27-hc.txt strategy27-ts.txt strategy27-qf.txt; do
  cp -a "/etc/zapret2/strategy27/$f" "$BK/"
done
cp -a /opt/zapret2/ipset/zapret-hosts-auto.txt "$BK/" 2>/dev/null || true
cp -a /usr/bin/zapret2-watchdog "$BK/" 2>/dev/null || true

sha256sum   "$BK/config"   "$BK"/strategy27-*.txt   "$BK/zapret-hosts-auto.txt"   "$BK/zapret2-watchdog" 2>/dev/null || true

echo "BACKUP_DIR=$BK"
```

Записать значение `BACKUP_DIR`.

Этот backup не является технической частью installer; он нужен для независимого ручного rollback.

---

## 12. ЭТАП I3 — ПОЛУЧЕНИЕ АРХИВА

Статус: **NOT_STARTED**

Архив должен попасть на hAP в:

`/tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz`

Допускаются два способа:

1. скачать файл с GitHub на hAP;
2. скачать на ПК и передать на hAP через SCP.

Не использовать неизвестный сторонний источник.

---

## 13. ЭТАП I4 — ПРОВЕРКА SHA256

Статус: **NOT_STARTED**

Команда:

```sh
sha256sum /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz
```

Должно быть ровно:

```
63029e3a6821f079dc7544f1166713e65475fec2164d0cf16e9b88d47abc6dcc
```

Если SHA256 не совпадает:

**FAILED**

Не распаковывать и не запускать installer.

---

## 14. ЭТАП I5 — ПРОВЕРКА СОДЕРЖИМОГО АРХИВА

Статус: **NOT_STARTED**

Команды:

```sh
tar -tzf /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz
```

Затем:

```sh
rm -rf /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709
mkdir -p /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709
tar -xzf /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709.tar.gz   -C /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709   --strip-components=1

ls -lah /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709
ls -lah /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709/hostlists
```

Ожидаются:

- README
- installer
- hostlists/
- evidence/
- MATRIX_COUNTS.txt.

---

## 15. ЭТАП I6 — STRUCTURAL PRECHECK INSTALLER

Статус: **NOT_STARTED**

Команда:

```sh
cd /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709

sh -n ./install-strategy27-deep-max-circular.sh

for f in hostlists/*.txt; do
  echo "=== $f ==="
  awk 'NF!=1 {exit 1}' "$f"
  sort -u "$f" | cmp -s "$f" -
  wc -l "$f"
done
```

Любая ошибка:

**FAILED**

На этом этапе live config ещё не меняется.

---

## 16. ЭТАП I7 — INSTALLER

Статус: **NOT_STARTED**

Предупреждение: installer изменяет конфигурационные файлы hAP. Сервис в этот момент не перезапускается, но active config на диске изменится.

Запуск:

```sh
cd /tmp/ZAPRET2_DEEP_MAX_CIRCULAR_READY_2609_2709
sh ./install-strategy27-deep-max-circular.sh
```

Успешный результат должен закончиться:

```
INSTALL=SUCCESS
```

и сообщить:

- BACKUP_CONFIG=...
- BACKUP_BASE=...
- HTTP_MAX_DEPTH=3
- TLS_MAX_DEPTH=3
- QUIC_MAX_DEPTH=2
- LUAEXEC_LX_STATUS=TESTED_NOT_FOUND_LAST_RESORT
- NOTE=NO_HAP_RUNTIME_TEST_PERFORMED
- ACTION_REQUIRED=restart zapret2 to apply config

---

## 17. ВСТРОЕННЫЙ ROLLBACK INSTALLER

Если ошибка возникает после изменения файлов, installer использует EXIT/INT/TERM trap.

Ожидаемый результат:

```
ROLLBACK=START
ROLLBACK=COMPLETE
```

Новая failed-install директория не удаляется: она сохраняется для аудита.

Если installer завершился `INSTALL_FAILED`, **не делать restart**.

Сначала проверить сообщение rollback.

---

## 18. ЭТАП I8 — STRUCTURAL CHECK ДО RESTART

Статус: **NOT_STARTED**

После `INSTALL=SUCCESS`, но до restart:

```sh
echo '=== DEEP PROFILES ==='
grep -n 'deep-circular/' /opt/zapret2/config

echo '=== OLD EXACT PROFILES SHOULD BE ABSENT FROM NFQWS2_OPT ==='
grep -nE '/etc/zapret2/strategy27/strategy27-(me|hc|ts|qf).txt' /opt/zapret2/config || true

echo '=== DEEP HOSTLISTS ==='
find /etc/zapret2/strategy27/deep-circular -maxdepth 1 -type f -name '*.txt' -exec sh -c 'echo "### $1"; wc -l "$1"' sh {} \;

echo '=== AUTOLIST PRESENCE ==='
ls -lh /opt/zapret2/ipset/zapret-hosts-auto.txt 2>/dev/null || true
```

Ожидается:

- deep-circular profiles присутствуют;
- старые exact Strategy27 profiles удалены из сохранённого fallback body;
- autohostlist всё ещё существует;
- ME/HC/TS/QF original hostlists не удалены.

---

## 19. ЭТАП I9 — RESTART ZAPRET2

Статус: **NOT_STARTED**

**ВНИМАНИЕ:** restart временно прервёт/перезапустит обработку трафика через Zapret2.

Команда:

```sh
/etc/init.d/zapret2 restart
```

Не использовать reboot.

Не перезапускать Archer.

---

## 20. ЭТАП I10 — POST-RESTART STRUCTURAL HEALTH

Статус: **NOT_STARTED**

Это не тест сайтов. Это только проверка, что сервис и datapath поднялись.

```sh
echo '=== ZAPRET2 STATUS ==='
/etc/init.d/zapret2 status

echo '=== WATCHDOG ==='
/usr/bin/zapret2-watchdog --check

echo '=== NFQWS2 PROCESS ==='
pgrep -af nfqws2 || true

echo '=== NFQ TABLE ==='
nft list table inet zapret2

echo '=== NFQUEUE ==='
cat /proc/net/netfilter/nfnetlink_queue

echo '=== MEMORY ==='
free -h
```

Классификация:

- service alive + watchdog healthy + expected nft/NFQUEUE structure = **DONE**
- service down / structural failure / OOM = **FAILED**, затем rollback
- tooling-specific inability to show a component = **BLOCKED**, если причина именно в отсутствующей утилите.

---

## 21. ЭТАП I11 — SITE / APPLICATION TESTS

Статус: **NOT_STARTED**

По текущему решению **не является частью обязательной установки**.

Не делать автоматически:

- 297 domain matrix;
- YouTube × Instagram × WhatsApp × Telegram exhaustive matrix;
- all-domain curl loop;
- QUIC sweep;
- repeated blockcheck.

Причина: blockcheck evidence уже используется для domain-level selection; live hAP work не должен превращаться в 4×N test.

Позже можно сделать отдельный функциональный этап с минимальным количеством smoke tests, только если есть конкретный вопрос.

---

## 22. ЧТО КОНКРЕТНО БУДЕТ ПРОИСХОДИТЬ ПОСЛЕ УСТАНОВКИ

До:

```
ME exact
HC exact
TS exact
QF exact
↓
autohostlist
```

После:

```
TCP/80
  ├─ домены HC→ME→HF
  ├─ домены HC→ME
  ├─ домены HC→HF
  ├─ домены ME→HF
  └─ домены ME

TCP/443
  ├─ TS→TF→LX
  ├─ TS→TC→LX
  └─ TS→LX

UDP/443
  ├─ QF→QI
  ├─ QF
  └─ QI

↓
existing autohostlist fallback
```

Важно: `HF` и `LX` намеренно являются последними experimental fallbacks.

---

## 23. ROLLBACK ПОСЛЕ УСПЕШНОГО INSTALLER, ЕСЛИ RESTART НЕУДАЧЕН

Installer специально не перезапускает сервис, поэтому rollback после restart выполняется отдельно.

Использовать **точные** пути, напечатанные installer:

```
BACKUP_CONFIG=/opt/zapret2/config.deep-max-circular-pre-YYYYMMDD-HHMMSS
BACKUP_BASE=/etc/zapret2/strategy27/deep-circular-pre-YYYYMMDD-HHMMSS
```

Для rollback:

```sh
set -eu

BACKUP_CONFIG='ВСТАВИТЬ_ТОЧНЫЙ_BACKUP_CONFIG'
BACKUP_BASE='ВСТАВИТЬ_ТОЧНЫЙ_BACKUP_BASE'
STAMP=$(date +%Y%m%d-%H%M%S)
FAILED="/etc/zapret2/strategy27/deep-circular-failed-manual-$STAMP"

[ -f "$BACKUP_CONFIG" ] || { echo "MISSING BACKUP_CONFIG"; exit 1; }

# Preserve the failed installed state rather than deleting it.
if [ -e /etc/zapret2/strategy27/deep-circular ]; then
  mv /etc/zapret2/strategy27/deep-circular "$FAILED"
fi

# Restore previous deep-circular directory when installer had one.
if [ -d "$BACKUP_BASE" ]; then
  mv "$BACKUP_BASE" /etc/zapret2/strategy27/deep-circular
fi

cp -a "$BACKUP_CONFIG" /opt/zapret2/config

/etc/init.d/zapret2 restart

echo "ROLLBACK=COMPLETE"
echo "FAILED_STATE=$FAILED"
```

Если `BACKUP_BASE=NONE_PREVIOUSLY_ABSENT`, просто не выполнять ветку восстановления directory; failed current directory всё равно сохранить.

После rollback повторно проверить только:

- `/etc/init.d/zapret2 status`
- `/usr/bin/zapret2-watchdog --check`
- `free -h`.

---

## 24. НЕ ДЕЛАТЬ ПРИ ПРОБЛЕМЕ

Не делать:

- добавление ещё одного watchdog;
- изменение QNUM;
- изменение MODE_FILTER;
- смену DNS;
- запуск VPN;
- изменение PBR;
- установку xray/sing-box;
- массовый blockcheck;
- очистку autohostlist;
- blind stacking дополнительных desync;
- sysupgrade.

Сначала rollback и классификация проблемы.

---

## 25. ОТДЕЛЬНО ПРО QF / QUIC

Текущий hAP runtime gate не должен требовать установки нового curl только ради HTTP/3.

Ранее QF live testing был BLOCKED из-за отсутствия HTTP/3 в установленном curl/libcurl.

Это не является основанием для установки пакетов в текущей installation stage.

QF/QI устанавливаются согласно evidence matrix, но их live effectiveness остаётся отдельным статусом.

---

## 26. ОТДЕЛЬНО ПРО ME

ME уже присутствует в permanent exact layer.

Previous representative runtime:

- ME = NOT_PROVEN, потому что baseline endpoint тоже не отвечал.

Поэтому отсутствие мгновенного результата одного ME endpoint не должно автоматически классифицироваться как FAILED.

---

## 27. ОТДЕЛЬНО ПРО HF

HF:

```
http_req
fake_default_http
tcp_ts=-1000
```

HF имеет высокий coverage в raw logs, но 0 explicit `working strategy found`.

В этом user-requested installation mode HF включён как последний HTTP fallback.

Это осознанное расширение от evidence-backed режима к experimental fallback mode.

---

## 28. ОТДЕЛЬНО ПРО LX

LX:

```
luaexec
tls_mod(fake_default_tls,'rnd,rndsni,dupsid,padencap',desync.reasm_data)
generated tcpseg
drop
```

В supplied raw logs:

- 0 AVAILABLE
- 0 EXPLICIT FOUND

Поэтому LX нельзя называть рабочей стратегией.

Он присутствует только потому, что пользователь запросил максимально глубокий fallback.

Если LX станет источником parser/runtime errors, следующий шаг — удалить только LX fallback и не менять остальные layers.

---

## 29. УСТАНОВОЧНЫЙ STOP CONDITION

Установка считается **DONE**, только если:

- SHA256 архива совпал;
- installer завершился INSTALL=SUCCESS;
- structural checks прошли;
- restart завершился успешно;
- service status OK;
- watchdog healthy;
- nft/NFQUEUE structure присутствует;
- нет OOM/очевидной memory regression.

Это не означает UNIVERSAL validation.

Application effectiveness остаётся отдельным этапом.

---

## 30. ФИНАЛЬНАЯ СХЕМА ПРОЕКТА

```
blockcheck2609 + blockcheck2709
        ↓
explicit FOUND / AVAILABLE / NOT_FOUND
        ↓
deep per-domain matrix
        ↓
L7-specific circular ladders
        ↓
rollback-protected deployment
        ↓
hAP structural health
        ↓
отдельный minimal functional validation при необходимости
```

Главный принцип проекта сохраняется:

**domain + traffic class → evidence-conditioned strategy ladder → existing autohostlist fallback**

а не:

**one universal strategy for everything**.

---

## 31. СТАТУСЫ УСТАНОВОЧНОГО КОНТУРА

- I0 connection/identity: **NOT_STARTED**
- I1 read-only baseline: **NOT_STARTED**
- I2 independent backup: **NOT_STARTED**
- I3 archive transfer: **NOT_STARTED**
- I4 SHA256 verification: **NOT_STARTED**
- I5 archive inspection: **NOT_STARTED**
- I6 installer structural precheck: **NOT_STARTED**
- I7 installer execution: **NOT_STARTED**
- I8 pre-restart structural check: **NOT_STARTED**
- I9 Zapret2 restart: **NOT_STARTED**
- I10 post-restart structural health: **NOT_STARTED**
- I11 application validation: **NOT_STARTED**
- Rollback procedure: **READY**
- Package: **READY**
- Router state changed by this plan: **NO**

---

## 32. SOURCE POLICY

Technical semantics:
1. official bol-van/zapret2 source/documentation;
2. official OpenWrt documentation;
3. raw blockcheck2609_FULL.log + blockcheck2709.log as project evidence;
4. Calcul documents as project state/evidence records.

Do not use Calcul as technical authority for zapret2 internals.

---

## 33. HANDOFF RULE

Future AI must read before any router command:

1. OPENWRT_VARIANT_A_MASTER_PROMPT.md
2. OPENWRT_VARIANT_A_MASTER_PLAN.md
3. OPENWRT_VARIANT_A_GLOSSARY.md
4. ZAPRET2_STRATEGY_MASTER_PLAN.md
5. ZAPRET2_STRATEGY_MASTER_PROMPT.md
6. this installation plan.

After every user result:

1. interpret result;
2. update Strategy Master Plan;
3. update OpenWrt Master Plan if router state changed;
4. update Strategy Master Prompt if workflow/safety changed;
5. only then issue the next router action.
