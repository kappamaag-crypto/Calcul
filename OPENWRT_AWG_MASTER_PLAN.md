# OPENWRT AWG MASTER PLAN

**Проект:** OpenWrt Variant A — MikroTik hAP ac lite  
**Назначение:** единый мастер-план всей ветки WireGuard / AmneziaWG / WARP / Full-Tunnel / backup / fail-open.  
**Актуальная дата:** 2026-10-03  
**Текущая точка:** контролируемый Full-Tunnel для клиента `192.168.1.170` собран и runtime-верифицирован; расширение на весь LAN, резервные endpoints и fail-open ещё не завершены.

> Этот файл является специализированным мастер-планом AWG. Перед любой новой технической работой по AWG необходимо читать этот файл вместе с `OPENWRT_VARIANT_A_MASTER_PROMPT.md`, `OPENWRT_VARIANT_A_MASTER_PLAN.md` и `OPENWRT_VARIANT_A_GLOSSARY.md`.

---

## 1. Цель AWG-ветки

Построить на hAP ac lite устойчивый IPv4 VPN-транспорт на базе AmneziaWG:

```
обычный WAN
    │
    ├── direct Internet / fail-open
    │
    └── AWG primary
          ├── validated backup endpoint(s)
          └── при отказе всех AWG → direct WAN
```

Целевая архитектура должна:

- сохранять обычный WAN/main route для управления роутером и аварийного выхода;
- направлять через AWG только тот клиентский трафик, который явно классифицирован для Full-Tunnel;
- не ломать доступ к `192.168.1.1` и локальным LAN-клиентам;
- не зацикливать внешний UDP-трафик AWG через сам AWG;
- иметь реальный запасной endpoint, подтверждённый на текущем hAP/WAN;
- при отказе AWG уметь безопасно перейти в direct-WAN (fail-open);
- не смешивать AWG-работы с DNS, Zapret2 и IPv6 без отдельной причины и отдельного gate.

---

## 2. Аппаратный и сетевой baseline

### Роутер

- MikroTik RB952Ui-5ac2nD hAP ac lite
- QCA9533 rev 2.0
- MIPS 24Kc, около 650 MHz
- RAM: 64 MiB
- OpenWrt 25.12.5 r33051-f5dae5ece4
- target: `ath79/mikrotik`
- profile: `mikrotik_routerboard-952ui-5ac2nD`
- kernel: 6.12.94

### Память и storage

- USB extroot: `/dev/sda2`, ext4, `/overlay`
- USB swap: `/dev/sda1`, 512 MiB, active
- ZRAM: около 26–32 MiB, active
- `/tmp` не использовать как swap
- из-за 64 MiB RAM CPU/RAM impact AWG-процессов является обязательным acceptance-критерием.

### Актуальный WAN

Текущая архитектура после отключения Archer C20:

```
ISP → Ethernet → hAP eth1/WAN → hAP LAN/Wi-Fi → clients
```

Подтвержденные параметры:

- WAN interface: `eth1`
- DHCP/IPoE
- IPv4: `100.96.79.207/16`
- gateway: `100.96.0.1`
- ordinary default route: `default via 100.96.0.1 dev eth1`

Archer C20 **не является частью целевой AWG-архитектуры** и не должен восстанавливаться как промежуточный WAN/NAT/DHCP/DNS path.

### LAN

- `br-lan`
- `192.168.1.1/24`
- контролируемый тестовый ноутбук: `192.168.1.170`

### IPv6

- AWG Full-Tunnel на текущем этапе = **IPv4 only**
- IPv6 не менять
- не добавлять IPv6 Full-Tunnel только ради симметрии.

---

## 3. Установленная AWG-платформа

Подтверждено runtime/evidence:

- `amneziawg-tools-3.1.20260812-r1`
- `kmod-amneziawg-6.12.94.3.1.20260906-r1`
- `kmod-wireguard` и `wireguard-tools` также установлены
- netifd/amneziawg integration поддерживает классические и современные AWG 3.1 параметры.

Используемый CLI:

- `awg` — AmneziaWG userspace tool
- `wg` — обычный WireGuard tool

Не смешивать:

- standard WireGuard;
- старые AWG 1.x/2.x рецепты;
- AWG 3.1;
- WARP/WGCF;
- Proton WireGuard;
- VLESS/REALITY.

Они являются разными ветками и не должны считаться взаимозаменяемыми.

---

## 4. Главный рабочий профиль — MegaConfig

Источник: `MegaConfig.conf`.

Текущий production interface:

- interface: `mega-awg`
- inner IPv4: `172.16.0.2/32`
- endpoint: `188.114.96.8:939`
- peer AllowedIPs: `0.0.0.0/0`
- PersistentKeepalive: `25`
- MTU: `1280`
- DNS в исходной конфигурации: Cloudflare
- AWG 3.1 parameters include:
  - `Jc=4`
  - `Jmin=40`
  - `Jmax=70`
  - `S1=0`
  - `S2=0`
  - `S3=0`
  - `S4=0`
  - `H1=1`
  - `H2=2`
  - `H3=3`
  - `H4=4`
  - `ContentPaddingAddition=24-87`
  - `RandomTrailers=on`
  - `DisableCookies=on`

Секретные значения (private key, HeaderProtectionKey и т.п.) в этот план не записывать.

### Production endpoint protection

Внешний UDP endpoint `188.114.96.8:939` должен достигаться через ordinary WAN:

```
188.114.96.8/32 → 100.96.0.1 → eth1
```

Нельзя допускать recursive routing endpoint → mega-awg → endpoint.

---

## 5. Текущий доказанный production baseline

### Router-only AWG

Статус: **DONE**

Подтверждено:

- `mega-awg` — native AmneziaWG;
- interface UP/LOWER_UP;
- свежие handshakes;
- bidirectional RX/TX;
- router-originated HTTPS через AWG работает;
- ordinary WAN route сохраняется;
- Zapret2 продолжает работать;
- AWG не заменяет main default route.

Это protected rollback baseline. Любые следующие эксперименты должны сохранять его как рабочую точку отката.

### Контролируемый Full-Tunnel

Тестовый клиент:

`192.168.1.170` — ноутбук.

Статус: **DONE**

Рабочая цепочка:

```
client .170
  ↓
br-lan
  ↓
nft prerouting classification
  ↓
fwmark 0x1
  ↓
ip rule 10040
  ↓
routing table 51821
  ├── 192.168.1.0/24 → br-lan
  └── default → mega-awg
  ↓
native fw4 early ACCEPT
  ↓
mega-awg
  ↓
masquerade
  ↓
AWG endpoint
```

Подтверждено:

- `10040: from all fwmark 0x1/0x1 lookup 51821`
- table 51821 содержит `192.168.1.0/24 dev br-lan`
- table 51821 содержит `default dev mega-awg`
- mark применяется только к forwarded Internet traffic клиента .170;
- LAN destination `192.168.1.0/24` исключается;
- explicit `br-lan → mega-awg` ACCEPT находится в начале native `inet fw4 forward`;
- masquerade работает для .170 через `mega-awg`;
- AWG endpoint остаётся в ordinary WAN path;
- laptop Internet/application traffic через Full-Tunnel работает;
- после firewall persistence и reload datapath сохранился.

Последнее зафиксированное runtime-доказательство:

- fresh AWG handshake;
- bidirectional AWG transfer;
- Cloudflare trace через AWG возвращает `warp=on`;
- fwmark/firewall/NAT counters реально растут;
- ноутбук .170 имеет рабочий Internet.

### Persistent state

Статус: **DONE**

UCI/netifd persistence и fw4/nftables persistence для контролируемого .170 уже прошли reload-проверку.

Принцип persistent representation:

- UCI/netifd для `mega-awg`;
- UCI rule для fwmark → table 51821;
- fw4 UCI-managed nftables includes;
- chain-pre:
  - `mangle_prerouting` — mark;
  - `forward` — early ACCEPT;
  - `srcnat` — masquerade.

В persistent state допускается ровно:

- одна mark rule;
- один early forward ACCEPT;
- одна AWG masquerade rule.

---

## 6. Запрещённые конструкции

### 6.1 Broad source-subnet rule

Никогда не возвращаться к:

```
ip rule add pref 10000 from 192.168.1.0/24 lookup 51821
```

Эта схема уже приводила к потере LAN/SSH-доступа и была восстановлена reboot.

### 6.2 Отдельная forward base-chain

Не создавать дополнительную nftables base chain с hook forward.

Причина: ACCEPT в отдельной base-chain не гарантировал прекращение дальнейшей обработки native OpenWrt forward chain.

### 6.3 Поздний ACCEPT

Не добавлять AWG ACCEPT после стандартного `forward_lan`/reject path.

Для этого проекта нужен early ACCEPT в native `inet fw4 forward`.

### 6.4 rc.local/ad-hoc runtime persistence

Не делать production persistence через:

- `rc.local`;
- ручные команды после boot;
- непрозрачные shell hooks.

Основной механизм — OpenWrt UCI/netifd/fw4.

### 6.5 Удаление WAN default

Обычный:

```
default via 100.96.0.1 dev eth1
```

должен сохраняться.

Он нужен для:

- management;
- outer AWG endpoint;
- fail-open;
- восстановления после отказа VPN.

---

## 7. Почему выбран fwmark

Для этого проекта fwmark разделяет:

1. firewall classification;
2. routing decision.

Firewall определяет, какой именно forwarded traffic должен идти через AWG.

Только после этого policy rule:

```
fwmark 0x1 → table 51821
```

Local LAN traffic и router-originated traffic не получают mark и остаются в normal/main routing path.

Это проектное архитектурное решение, основанное на фактической ошибке broad source-subnet метода; это не универсальное утверждение о всех OpenWrt-системах.

---

## 8. Что уже было проверено по Proton/AWG

Эта история сохраняется как negative evidence и не должна повторяться без новой гипотезы.

### Proton standard WireGuard

Проверялись стандартные Proton WireGuard endpoint/configuration variants.

Наблюдалось:

- outbound UDP;
- отсутствие ответа;
- no handshake;
- 0 RX.

### Proton AmneziaWG

Проводились изолированные тесты:

- baseline AWG;
- ContentPadding;
- S1/S2/S3/S4;
- Jc/Jmin/Jmax;
- полноценный AWG 3.1 profile;
- варианты с Proton endpoint.

Observed:

- interface могла подниматься;
- TX мог расти;
- RX оставался 0;
- handshake не наблюдался.

Отдельно проверялся вариант с временным Zapret2 UDP/51820 вмешательством: существенного результата не дал; изменение не оставлено.

### Header Protection

Для Proton-ветки Header Protection не был доказан, поскольку отсутствовал соответствующий подтверждённый `HeaderProtectionKey`.

H1-H4 сами по себе нельзя считать доказательством Header Protection.

Существующие Proton-specific отрицательные результаты не означают, что любой AmneziaWG endpoint не работает: MegaConfig доказал работоспособный AWG-транспорт на другом реальном endpoint.

---

## 9. Full-Tunnel: граница текущего результата

Очень важно не смешивать:

- router-only AWG;
- controlled .170 Full-Tunnel;
- LAN-wide Full-Tunnel;
- backup/fail-open.

Текущие статусы:

| Подсистема | Статус |
|---|---|
| AWG platform | DONE |
| MegaConfig router-only | DONE |
| Controlled .170 Full-Tunnel runtime | DONE |
| Persistent .170 UCI/netifd | DONE |
| Persistent .170 fw4/nftables | DONE |
| LAN-wide Full-Tunnel | NOT_STARTED |
| Backup endpoint inventory | IN_PROGRESS |
| Fail-open watchdog | NOT_STARTED |
| Automatic primary→backup switching | NOT_STARTED |
| Selective routing | NOT_STARTED |
| IPv4-only scope | DONE |
| IPv6 Full-Tunnel | NOT_STARTED |

---

## 10. Backup endpoint strategy

Цель — иметь несколько реальных резервных конфигураций, чтобы отказ одного AWG endpoint не означал потерю VPN-пути.

Backup нельзя выбирать только по наличию config-файла.

### Допустимый источник кандидата

Endpoint должен существовать в реальной конфигурации/provider evidence.

Запрещено:

- придумывать IP/port;
- переносить старый endpoint на новое имя;
- считать имя профиля доказательством;
- считать историческую скорость текущей работоспособностью.

### Исторический пул кандидатов

Следующие профили имеют историческое evidence успешной работы/скорости и подходят для fresh screening:

| Профиль | Исторический download, Mbit/s | Исторический upload, Mbit/s | Текущее состояние |
|---|---:|---:|---|
| cmsWARPv1_22 | 16.41 | 3.29 | NOT_STARTED |
| cmsWARPv2_76 | 8.07 | 7.77 | NOT_STARTED |
| cmsWARPv3_39 | 9.60 | 7.09 | NOT_STARTED |
| ghdWARPv1_45 | 7.54 | 4.31 | NOT_STARTED |
| ghdWARPv2_59 | 16.80 | 4.21 | NOT_STARTED |
| ghdWARPv2_97 | 14.16 | 7.70 | IN_PROGRESS |
| ghdWARPv3_46 | 5.08 | 1.70 | NOT_STARTED |

Для `ghdWARPv2_97` уже существует отдельный свежий speed result: **9.35 / 2.98 Mbit/s**. Этот результат является свежим speed evidence, но сам по себе не заменяет isolated handshake + RX + HTTPS acceptance.

### Извлечённые endpoint mappings

Эти mappings уже были получены из реальных локальных конфигураций:

- cmsWARPv1_22 → `162.159.195.2:5956`
- cmsWARPv2_76 → `8.47.69.8:1018`
- cmsWARPv3_39 → `8.39.214.5:1070`
- ghdWARPv1_45 → `188.114.97.9:7152`
- ghdWARPv2_59 → `8.34.70.8:4198`
- ghdWARPv2_97 → `188.114.96.10:1843`
- ghdWARPv3_46 → `8.39.214.2:5956`

Эти значения нельзя переносить на другие конфиги без проверки исходного файла.

### Навсегда исключённые профили

**US-FREE#90** — RETIRED.

Не:

- восстанавливать;
- пересоздавать;
- ретестировать;
- переименовывать;
- использовать как backup;
- использовать для PBR;
- использовать в fail-open.

**WARPv3_72.conf** — также исключён из текущего inventory; файл был удалён из GitHub и не должен молча возвращаться в пул.

---

## 11. Правильный backup screening

### Цель первой стадии

Сначала определить, отвечает ли реальный endpoint и способен ли он передавать tunnel traffic.

Не надо сразу строить для каждого кандидата:

- Full-Tunnel;
- NAT;
- firewall;
- DNS;
- production PBR.

### Изолированный acceptance gate

Candidate может перейти дальше только при последовательном доказательстве:

1. реальный config загружается локально;
2. native `amneziawg` interface создаётся;
3. handshake наблюдается;
4. RX становится > 0;
5. bounded HTTPS через изолированный tunnel succeeds;
6. endpoint outer UDP остаётся на ordinary WAN;
7. временный interface/route/rule/table очищаются.

### Классификация результатов

Использовать отдельные классы причины:

- `SETCONF_FAIL` — локальная incompatibility/setup;
- `NO_HANDSHAKE` — interface/config загрузились, но handshake не наблюдается;
- `HANDSHAKE_RX0` — handshake есть, receive traffic отсутствует;
- `RX_OK` — handshake + receive traffic;
- последующий HTTPS/speed gate — отдельная стадия.

Harness failure нельзя записывать как candidate failure.

### Уже найденные ошибки тестового harness

#### v5

Временный интерфейс был ошибочно создан как:

```
type wireguard
```

а для AWG нужен:

```
type amneziawg
```

Все `SETCONF_FAIL` от v5 = **INCONCLUSIVE**.

#### v6/v7

Временная NAT-схема использовала неверный nft hook `post` вместо `postrouting`.

Затем в IPv4 SNAT попал dual-stack `Address`.

Это были ошибки harness, а не доказательства отказа кандидатов.

#### v9

Переход к упрощённому endpoint-only screen:

- native `amneziawg`;
- `awg setconf`;
- без назначения production/inner IP;
- без NAT;
- без production policy route;
- только handshake/RX/TX;
- затем удаление interface.

Это должно оставаться первым screening gate.

#### Последний выполненный route-check

Использование уже занятого production destination `1.1.1.1/32` привело к `ROUTE-CONFLICT-1.1.1.1` и кандидаты фактически не тестировались.

Этот результат не является candidate failure.

---

## 12. Методика throughput comparison

Исторические скорости используются только как baseline.

Для окончательного выбора нескольких backup-кандидатов сравнение должно делаться одинаковым методом:

- один и тот же hAP;
- тот же direct WAN `eth1`;
- одинаковый MTU test policy;
- одинаковая длительность;
- одинаковый тестовый ресурс;
- одинаковая точка времени настолько, насколько возможно;
- download и upload измерять отдельно;
- сохранить handshake/RX/HTTPS evidence вместе со скоростью.

Нельзя выбирать резерв только по одному числу download.

После fresh screening список нужно разделить на:

- технически пригоден для backup;
- пригоден, но throughput ниже;
- непригоден;
- не протестирован.

Никаких ранжирующих выводов в документации до воспроизводимого сравнительного теста.

---

## 13. План fail-open

Целевая схема:

```
PRIMARY mega-awg
      │
      ├── healthy → keep
      │
      └── unhealthy
             ↓
       validated BACKUP #1
             ↓
       validated BACKUP #2
             ↓
       all failed
             ↓
       FAIL-OPEN → ordinary WAN
```

### Обязательные состояния

- PRIMARY
- BACKUP
- FAIL-OPEN
- RECOVERED

### Что должен проверять watchdog

Не просто наличие процесса.

Минимум:

- interface exists/up;
- recent handshake;
- receive traffic;
- bounded HTTPS/health probe;
- доступность outer endpoint;
- корректность current policy path;
- сохранение management path.

### Fail-open правило

При отказе AWG необходимо убрать/отключить только клиентский Full-Tunnel policy path.

Не удалять:

- основной WAN default route;
- LAN interface;
- management access;
- DNS без отдельной причины.

Результат отказа должен быть:

```
AWG broken → client traffic returns to direct WAN
```

а не:

```
AWG broken → client loses Internet + router management
```

### Watchdog resource rule

На 64 MiB hAP watchdog должен быть лёгким:

- без continuous tcpdump;
- без тяжёлого daemon;
- без отдельного package только ради мониторинга;
- без постоянного изменения Zapret2.

Статус watchdog: **NOT_STARTED**.

---

## 14. Расширение .170 → весь LAN

Это отдельный gate.

Нельзя менять классификатор на:

```
192.168.1.0/24
```

пока контролируемый .170 baseline не сохранён и все persistent/invariant checks не пройдены.

Когда расширение будет разрешено, критерии:

- LAN clients → Internet реально идут через AWG;
- LAN local traffic остаётся local;
- hAP management остаётся доступным;
- ordinary WAN path остаётся целым;
- outer AWG endpoint не зацикливается;
- NAT работает;
- отказ AWG возвращает direct WAN.

---

## 15. Selective routing

Selective routing отложен до завершения основной Full-Tunnel/backup ветки.

Статус: **NOT_STARTED**

Это отдельная архитектура и не должна добавляться во время:

- .170 persistence;
- LAN-wide Full-Tunnel;
- backup screening;
- fail-open development.

---

## 16. Взаимодействие с Zapret2

Zapret2 не является частью AWG routing design.

При AWG screening/full-tunnel:

- не менять Zapret2 qnum;
- не менять `MODE_FILTER`;
- не менять strategy;
- не менять autohostlist;
- не менять watchdog.

Исключение возможно только при отдельной сформулированной гипотезе, подтверждённой packet-level evidence.

Отдельно ранее тестировался временный UDP/51820 path; он не дал доказанного Proton/AWG handshake и в production не сохранён.

---

## 17. Безопасность конфигураций

Никогда не записывать в этот план:

- private keys;
- preshared keys;
- HeaderProtectionKey;
- provider credentials;
- tokens;
- Wi-Fi passwords.

Можно хранить:

- имя профиля;
- endpoint IP/port;
- публично видимые параметры;
- измерения скорости;
- status/evidence;
- путь к локальному evidence-файлу;
- контрольные суммы/commit IDs, если они не раскрывают секрет.

Исходные конфиги с секретами не считать публичными artefacts только потому, что они находятся в рабочей директории.

---

## 18. Канонические evidence-файлы Calcul

Ключевые источники:

- `OPENWRT_VARIANT_A_MASTER_PROMPT.md`
- `OPENWRT_VARIANT_A_MASTER_PLAN.md`
- `OPENWRT_VARIANT_A_GLOSSARY.md`
- `OPENWRT_VARIANT_A_START_HERE.md`
- `OPENWRT_VARIANT_A_AWG_CONTINUITY_2026-09-27.md`
- `OPENWRT_VARIANT_A_WG_AWG_FREEZE_2026-09-27.md`
- `MegaConfig.conf`
- `WanHap.md`
- `WANHAP_W3_DIRECT_WAN_DHCP_CLIENT_ID.md`

Generic master plan сохраняет историю и cross-project context.

Этот AWG plan является специализированной текущей картой состояния именно AWG-ветки.

---

## 19. Current checkpoints

### CP-AWG-01 — AWG platform

Статус: **DONE**

Native AmneziaWG 3.1 platform работает на текущем hAP.

### CP-AWG-02 — MegaConfig router-only

Статус: **DONE**

Рабочий production endpoint:

```
188.114.96.8:939
```

### CP-AWG-03 — .170 temporary Full-Tunnel

Статус: **DONE**

Реальный ноутбук `192.168.1.170` ходит в Internet через AWG.

### CP-AWG-04 — .170 fwmark architecture

Статус: **DONE**

FWMark → 51821 → mega-awg доказан packet counters + E2E.

### CP-AWG-05 — .170 persistent UCI/netifd

Статус: **DONE**

Network reload не ломает рабочий tunnel.

### CP-AWG-06 — .170 persistent fw4/nftables

Статус: **DONE**

Одна mark rule + один early ACCEPT + одна NAT rule переживают fw4 reload.

### CP-AWG-07 — backup inventory

Статус: **IN_PROGRESS**

Семь non-retired candidates identified. Fresh candidate screening ещё не завершён.

### CP-AWG-08 — fail-open

Статус: **NOT_STARTED**

### CP-AWG-09 — LAN-wide Full-Tunnel

Статус: **NOT_STARTED**

### CP-AWG-10 — selective routing

Статус: **NOT_STARTED**

---

## 20. Текущий следующий логический порядок

Следующий порядок после сохранённого .170 baseline:

```
1. backup candidates fresh screening
2. выбрать несколько реально validated backup endpoints
3. разработать fail-open state machine
4. интегрировать primary/backup/fail-open без потери management
5. после этого расширить classifier с .170 на весь LAN
6. провести LAN-wide E2E + failure/recovery validation
7. только затем вернуться к selective routing
```

При этом backup screening должен оставаться изолированным от production `mega-awg`.

---

## 21. Главное правило проекта

**Не считать AWG готовым только потому, что конфигурация принимается, interface поднимается или TX увеличивается.**

Для каждого уровня нужна своя доказательная граница:

```
config accepted
    ≠
interface UP
    ≠
handshake
    ≠
RX traffic
    ≠
HTTPS
    ≠
throughput
    ≠
Full-Tunnel client E2E
    ≠
persistent production
    ≠
backup/fail-open
```

В проектной документации эти состояния нельзя объединять в одно "работает".

---

## 22. Current authoritative status — 2026-10-03

- **AWG overall:** IN_PROGRESS
- **mega-awg router-only:** DONE
- **Full-Tunnel .170:** DONE
- **persistent .170 implementation:** DONE
- **LAN-wide Full-Tunnel:** NOT_STARTED
- **backup endpoints:** IN_PROGRESS
- **fail-open:** NOT_STARTED
- **selective routing:** NOT_STARTED
- **IPv6 Full-Tunnel:** NOT_STARTED
- **US-FREE#90:** RETIRED / excluded from future work
- **WARPv3_72:** excluded from current inventory
- **production WAN:** eth1 / direct ISP
- **production AWG endpoint:** 188.114.96.8:939

No secrets are recorded in this file.
