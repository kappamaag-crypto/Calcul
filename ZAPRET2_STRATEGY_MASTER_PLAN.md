# ZAPRET2 STRATEGY — MASTER PLAN
## Контур переноса, проверки и закрепления стратегий на OpenWrt hAP ac lite

Дата: 2026-09-27
Статус: AUTHORITATIVE FOR ZAPRET2 STRATEGY WORK
Цель: перенос проверенных blockcheck2-стратегий в уже существующий OpenWrt/nfqws2 без замены рабочего Zapret2.

---

## 1. Назначение

Этот документ управляет отдельным Strategy Work контуром.

Цель:
- взять результаты blockcheck2609_FULL.log;
- отделить реально прошедшие стратегии от Windows/WinDivert interception;
- адаптировать полезную часть под nfqws2;
- проверить стратегии на реальном hAP;
- определить минимальный общий профиль для YouTube / Instagram / WhatsApp / Telegram;
- определить домены и сервисы, которым нужны fallback-профили;
- закрепить только подтверждённые изменения.

Создание этого документа само по себе не меняет роутер.

---

## 2. Иерархия источников

1. Официальные исходники и документация bol-van/zapret2.
2. Официальные OpenWrt/Linux документы.
3. Измеренные результаты blockcheck2609_FULL.log.
4. Официальные обсуждения bol-van/zapret2 как практические примеры/ограничения.
5. Инженерный синтез AI как гипотеза, которую надо проверить.

Calcul — хранилище состояния и доказательств проекта, а не технический authority.

---

## 3. Исходная evidence-база

Основные raw-источники:

- `blockcheck2609_FULL.log`
  - blob SHA: `d42227bdc262c4437e4d1f78e28369c41075b3d6`
  - 34,569 строк
  - 140 доменных секций
- `blockcheck2709.log`
  - blob SHA: `f1413839059d5f86b2856aa6ddc62b2e7ed38bb3`
  - 70,258 строк
  - 301 доменная секция
  - 296 уникальных доменов

### 3.1. Полный каталог EXPLICIT FOUND

Критерий **EXPLICIT FOUND**:
raw-log содержит `working strategy found`.

После дедупликации одинаковой payload/desync-комбинации:

| ID | Класс | Exact strategy | 2609 FOUND | 2709 FOUND | Статус |
|---|---|---|---:|---:|---|
| S1 | HTTP | `http_methodeol` | 11 | 43 | WORKING_IN_BLOCKCHECK |
| S2 | TLS1.3 | `tcpseg:pos=0,-1:seqovl=1` + `drop` | 90 | 191 | WORKING_IN_BLOCKCHECK |
| S3 | HTTP | `http_hostcase` | 84 | 160 | WORKING_IN_BLOCKCHECK |
| S4 | HTTP | `fake:blob=fake_default_http:tcp_ts=-1000` | 0 | 0 explicit FOUND | CANDIDATE / HIGH-COVERAGE |
| S5 | QUIC | `fake:blob=fake_default_quic:repeats=11` | 42 | 108 | WORKING_IN_BLOCKCHECK |
| S6 | QUIC | `send:ipfrag` + `drop` | 1 | 2 | WORKING_IN_BLOCKCHECK / SPECIAL |
| S7 | TLS | `fake:blob=fake_default_tls:tcp_ts=-1000` | 11 | 12 | WORKING_IN_BLOCKCHECK / FALLBACK |
| S8 | TLS1.2 | `fake:blob=0x00000000:tcp_md5:repeats=1` + `fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1` + `multisplit:pos=2` | 0 | 2 | WORKING_IN_BLOCKCHECK / SPECIAL |

Итого:
- **2609: 6 уникальных explicit-FOUND стратегий, 239 FOUND records.**
- **2709: 7 уникальных explicit-FOUND стратегий, 518 FOUND records.**
- Совокупный дедуплицированный каталог обеих raw-выборок: **8 strategy IDs**, из которых 7 имеют FOUND уже в 2609/2709 основной общей совокупности, а S8 появляется только в 2709.

### 3.2. Важная коррекция прежней версии плана

Фраза «в 2609 найдено 7 уникальных рабочих комбинаций» была неверна.

Стратегия:

```
--payload=http_req
--lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
```

имеет значительный COVERAGE:
- 2609: 74/140
- 2709: 149/301

но в raw-логах **нет explicit `working strategy found` records**, поэтому она не может иметь статус WORKING_IN_BLOCKCHECK. Её статус здесь: **CANDIDATE / HIGH-COVERAGE**.

### 3.3. Raw COVERAGE 2709

| Strategy | COVERAGE |
|---|---:|
| `http_methodeol` | 198/301 |
| TLS `tcpseg:pos=0,-1:seqovl=1 + drop` | 193/301 |
| `http_hostcase` | 160/301 |
| `fake_default_http + tcp_ts=-1000` | 149/301 |
| QUIC `fake_default_quic:repeats=11` | 108/301 |
| QUIC `send:ipfrag + drop` | 70/301 |
| TLS `fake_default_tls + tcp_ts=-1000` | 10/301 |
| TLS12 S8 complex | 2/301 |

COVERAGE, AVAILABLE, `working without bypass`, `winws2 not working` и `test aborted` не считать взаимозаменяемыми доказательствами.

### 3.4. Exact raw command forms

S1:
```
--payload=http_req --lua-desync=http_methodeol
```

S2:
```
--payload=tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop
```

S3:
```
--payload=http_req --lua-desync=http_hostcase
```

S4:
```
--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
```

S5:
```
--payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
```

S6:
```
--payload=quic_initial --lua-desync=send:ipfrag --lua-desync=drop
```

S7:
```
--payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
```

S8:
```
--payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
```

### 3.5. Evidence hierarchy

1. **EXPLICIT FOUND** — raw `working strategy found`.
2. **COVERAGE / AVAILABLE** — useful candidate evidence, но не равно FOUND.
3. **RUNTIME_VERIFIED** — фактически проверено на hAP.
4. **VALIDATED_ON_HAP** — повторно подтверждено в текущем проектном baseline.
5. **UNIVERSAL** — разрешено только после реальной service/domain matrix на hAP.

Ни одна стратегия из raw blockcheck не считается автоматически RUNTIME_VERIFIED/VALIDATED_ON_HAP/UNIVERSAL.

## 4. Что НЕ переносится с Windows

Не переносить буквально:

    --wf-l3=ipv4
    --wf-tcp-out=80
    --wf-tcp-out=443
    --wf-udp-out=443

Это WinDivert/winws2 interception для Windows.

На OpenWrt переносится логика payload/desync, а interception выполняется через firewall/nftables/NFQUEUE.

---

## 5. Текущий hAP baseline

До появления более нового проверенного результата считать baseline таким:

- Zapret2 уже установлен и активен.
- NFQWS2_ENABLE=1.
- TCP ports=80,443.
- UDP port=443.
- FLOWOFFLOAD=donttouch.
- INIT_APPLY_FW=1.
- IPv6 в текущем Zapret2 отключён.
- основной QNUM=300.
- отдельный QNUM=65300 существует для WireGuard-pattern трафика.
- SET_MAXELEM=522288.
- Zapret2 watchdog уже установлен/активен.
- второй watchdog запрещён.
- существующий Zapret2 нельзя заменять чужим конфигом только ради Strategy Work.
- DNS, routing, PBR, VPN и firewall не являются частью strategy tuning без отдельной гипотезы.
- hAP имеет 64 MB RAM; новые профили должны быть минимальными.

---

## 6. Архитектура профилей

Использовать отдельные L7-профили:

    TCP/80  -> filter-l7=http  -> HTTP strategy
    TCP/443 -> filter-l7=tls   -> TLS strategy
    UDP/443 -> filter-l7=quic  -> QUIC strategy

Не применять одну desync-стратегию ко всему трафику.

Официальный zapret2 подход поддерживает отдельные профили, hostlists/autohostlist и принцип intercept required minimum.

---

## 7. Первичные кандидаты

### S1 — HTTP primary

    --filter-tcp=80 --filter-l7=http <HOSTLIST>
    --payload=http_req
    --lua-desync=http_methodeol
    --new

Blockcheck: 95/95.
Статус: CANDIDATE / NOT_VALIDATED_ON_HAP.

### S2 — TLS primary

    --filter-tcp=443 --filter-l7=tls <HOSTLIST>
    --payload=tls_client_hello
    --lua-desync=tcpseg:pos=0,-1:seqovl=1
    --lua-desync=drop
    --new

Blockcheck: 92/95.
Статус: CANDIDATE / NOT_VALIDATED_ON_HAP.

### S5 — QUIC primary

    --filter-udp=443 --filter-l7=quic <HOSTLIST_NOAUTO>
    --payload=quic_initial
    --lua-desync=fake:blob=fake_default_quic:repeats=11

Blockcheck: 42/95.
Статус: CANDIDATE / NOT_VALIDATED_ON_HAP.

---

### S8 — TLS1.2 special fallback

    --filter-tcp=443 --filter-l7=tls <HOSTLIST>
    --payload=tls_client_hello
    --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1
    --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1
    --lua-desync=multisplit:pos=2
    --new

Blockcheck: 0/2609 explicit FOUND; 2/2709 explicit FOUND.
Статус: SPECIAL / NOT_VALIDATED_ON_HAP.

## 8. Fallback-кандидаты

HTTP:
1. S1 http_methodeol
2. S3 http_hostcase
3. S4 fake_default_http + tcp_ts=-1000

TLS:
1. S2 tcpseg + drop
2. S7 fake_default_tls + tcp_ts=-1000

QUIC:
1. S5 fake_default_quic:repeats=11
2. S6 send:ipfrag + drop

Это первоначальный порядок проверки, а не абсолютная гарантия «лучше на любом DPI».

---

## 9. tcp_ts policy

S4 и S7 содержат tcp_ts=-1000.

Не использовать их как безусловный global default.

Они остаются fallback/targeted candidates до тех пор, пока runtime-тест не докажет их необходимость и отсутствие регрессии.

---

## 10. Четырёхсервисная matrix — обязательный gate

Нельзя присвоить статус UNIVERSAL без матрицы:

YouTube × Instagram × WhatsApp × Telegram

Для каждого сервиса:
- собрать все реально относящиеся к нему домены из blockcheck2609_FULL.log и blockcheck2709.log;
- для каждой S1...S8 записать PASS/FAIL/UNKNOWN;
- построить пересечение;
- построить уникальные стратегии;
- определить минимальный общий профиль;
- получить список непокрытых доменов.

Правило:
- PASS = реально прошёл тест;
- FAIL = реально не прошёл;
- UNKNOWN = домен/сценарий не тестировался или доказательств недостаточно.

UNKNOWN никогда не считать PASS.

---

## 11. «Сервис» не равен одному домену

Не ограничиваться:
- youtube.com;
- instagram.com;
- whatsapp.com;
- telegram.org.

Учитывать API/CDN/media/shared hostnames только когда они реально присутствуют в evidence.

Не добавлять домены по памяти AI.

---

## 12. Telegram / WhatsApp

Основной MASTER PLAN уже содержит ограничение: часть Telegram/WhatsApp проблемы классифицирована как BLOCKED для текущего Zapret2-only подхода с возможным IP-level фактором.

Поэтому новая strategy:
- может улучшить DPI coverage;
- не доказывает устранение IP-level блока;
- не должна становиться поводом для бесконечного перебора desync.

Если blockcheck PASS, но hAP runtime FAIL — различить DPI, IP, route/path, DNS и application-layer причины.

---

## 13. Этапы

### STAGE S0 — документальный каркас
DONE

### STAGE S1 — полная service/domain matrix
NOT_STARTED
Следующее действие: анализ blockcheck2609_FULL.log без изменения роутера.

### STAGE S2 — OpenWrt translation map
NOT_STARTED

Для каждой стратегии определить filter, L7 detector, payload, desync, hostlist scope и profile boundary.

### STAGE S3 — backup current Zapret2
NOT_STARTED

Перед первым runtime change:
- сохранить текущий /opt/zapret2/config;
- сохранить необходимые evidence;
- проверить наличие rollback-копии на /mnt/data.

### STAGE S4 — single-strategy runtime validation
NOT_STARTED

Одна смысловая переменная за эксперимент.
Не менять одновременно strategy + MODE_FILTER + QNUM + firewall + DNS + routing.

### STAGE S5 — TCP composite validation
NOT_STARTED

Проверить S1 и S2, затем только необходимые HTTP/TLS fallbacks.

### STAGE S6 — QUIC validation
NOT_STARTED

Проверить S5.
S6 применять только при подтверждённом QUIC gap.

### STAGE S7 — hAP four-service validation
NOT_STARTED

Проверить YouTube / Instagram / WhatsApp / Telegram по реальной доменной выборке.

### STAGE S8 — fallback/circular
NOT_STARTED

Circular разрешён только после доказательства, что primary profile не покрывает требуемый класс.

### STAGE S9 — autohostlist evaluation
NOT_STARTED

Текущий MODE_FILTER=autohostlist не менять без отдельной гипотезы.

### STAGE S10 — final profile
NOT_STARTED

Только доказанные стратегии + минимальный scope + fallback + rollback.

### STAGE S11 — final validation
NOT_STARTED

Критерии:
- четыре сервиса;
- все домены тестовой выборки;
- ordinary HTTPS baseline;
- restart stability;
- watchdog health;
- без очевидного memory regression;
- ожидаемая nftables/NFQUEUE structure.

---

## 14. Запрет на бессистемное stacking

Не включать сразу все 7 стратегий.

Каждая дополнительная стратегия должна иметь роль:
- primary;
- fallback;
- targeted exception.

Если стратегия не даёт измеримого дополнительного покрытия/надёжности — её не включать.

---

## 15. Rollback

Любое изменение до VALIDATED считать экспериментом.

При регрессии:
1. прекратить добавление стратегий;
2. вернуть последний известный рабочий конфиг;
3. выполнить минимальный functional check;
4. выполнить structural Zapret2 check;
5. проверить watchdog;
6. записать evidence и причину отката.

Не накладывать новую стратегию поверх неисправного datapath.

---

## 16. Минимальный evidence на один тест

Пользователь предпочитает короткие проверки.

Для одного этапа достаточно:
1. точный активный профиль;
2. результат приложения/сервиса;
3. один структурный Zapret2 health-check;
4. memory snapshot только когда он нужен.

Избегать тяжёлого непрерывного tcpdump.

---

## 17. Статусы

- NOT_STARTED
- IN_PROGRESS
- BLOCKED
- FAILED
- DONE
- CANDIDATE
- WORKING_IN_BLOCKCHECK
- RUNTIME_VERIFIED
- VALIDATED_ON_HAP
- UNIVERSAL_CANDIDATE
- UNIVERSAL_VALIDATED
- UNKNOWN
- PAUSED
- RETIRED

Не смешивать BLOCKED и FAILED.

---

## 18. Stop conditions

Остановить blind tuning, если:
- покрытие больше не растёт;
- несколько вариантов дают одинаковый FAIL;
- проблема выглядит IP-level/route-level;
- ухудшается память;
- watchdog фиксирует structural failure;
- ломается ordinary HTTPS;
- fallback не добавляет measurable value.

---

## 19. Mandatory AI handoff

Перед любым router action AI обязан прочитать:

1. OPENWRT_VARIANT_A_MASTER_PROMPT.md
2. OPENWRT_VARIANT_A_MASTER_PLAN.md
3. OPENWRT_VARIANT_A_GLOSSARY.md
4. ZAPRET2_STRATEGY_MASTER_PLAN.md
5. ZAPRET2_STRATEGY_MASTER_PROMPT.md

После результата пользователя:
- сначала синхронизировать Strategy MASTER PLAN;
- при изменении workflow/safety — обновить Strategy MASTER PROMPT;
- только затем переходить к следующему action.

---

## 20. Текущий exact stopping point

Strategy Master Plan = CREATED / READY

STAGE S0 = DONE
STAGE S1 = NOT_STARTED
Router configuration changed by this document = NO

NEXT EXACT ACTION:
закрепить полную matrix YouTube × Instagram × WhatsApp × Telegram по всем соответствующим доменам из blockcheck2609_FULL.log и blockcheck2709.log, сохранив различие EXPLICIT FOUND / COVERAGE / UNKNOWN.

До завершения S1 не объявлять профиль универсальным.

---

## 21. Upstream technical references

- https://github.com/bol-van/zapret2
- https://github.com/bol-van/zapret2/blob/master/config.default
- https://github.com/bol-van/zapret/blob/master/docs/readme.md
- официальные zapret2 discussions по nfqws2 profiles/fallback/circular.



---

## 2026-09-27 — BLOCKCHECK2709 MATRIX COMPLETION

### New evidence source

- `blockcheck2709.log`
- Blob SHA: `f1413839059d5f86b2856aa6ddc62b2e7ed38bb3`
- New evidence summary: `ZAPRET2_BLOCKCHECK2709_EVIDENCE.md`
- The new run contains **301 domains** in its final coverage summary.

### Four-service matrix result

The current blockcheck evidence was analyzed for YouTube / Instagram / WhatsApp / Telegram.

| Service | Evidence-matched domains with working strategies | Working strategy classes found |
|---|---:|---|
| YouTube | 6 | HTTP `http_hostcase`; QUIC `fake_default_quic:repeats=11` |
| Instagram | 4 | HTTP `http_methodeol`; TLS1.3 `tcpseg + drop`; QUIC `fake_default_quic:repeats=11` |
| WhatsApp | 2 | HTTP `http_hostcase`; TLS1.3 `tcpseg + drop` |
| Telegram | 0 | none in this run |

Telegram tested domains represented in the log include:
`telegram.org`, `www.telegram.org`, `t.me`, `telegram.me`, `api.telegram.org`, `core.telegram.org`, `web.telegram.org`, `desktop.telegram.org`.
For these, blockcheck2709 records `winws2 not working` for HTTP, TLS1.2, TLS1.3 and QUIC.

### Intersection result

- YouTube ∩ Instagram = QUIC `fake_default_quic:repeats=11`
- YouTube ∩ WhatsApp = HTTP `http_hostcase`
- Instagram ∩ WhatsApp = TLS1.3 `tcpseg:pos=0,-1:seqovl=1 + drop`
- YouTube ∩ Instagram ∩ WhatsApp = empty intersection of one exact strategy.
- Telegram intersection = empty because no WORKING_IN_BLOCKCHECK strategy was found for the tested Telegram domains.

Therefore **no universal single strategy for all four services is established**.

### Coverage summary from 2709

- HTTP `http_methodeol`: 198/301
- TLS1.3 `tcpseg:pos=0,-1:seqovl=1 + drop`: 193/301
- HTTP `http_hostcase`: 160/301
- HTTP `fake_default_http + tcp_ts=-1000`: 149/301
- QUIC `fake_default_quic:repeats=11`: 108/301
- QUIC `send:ipfrag + drop`: 70/301
- TLS1.2 `fake_default_tls + tcp_ts=-1000`: 10/301

These are blockcheck evidence counts, not hAP runtime validation.

### Status transition

- STAGE S0 — document control: **DONE**
- STAGE S1 — four-service/domain evidence matrix: **DONE FOR CURRENT BLOCKCHECK2709 EVIDENCE**
- STAGE S2 — OpenWrt translation map: **IN_PROGRESS / NEXT**
- STAGE S3 — current Zapret2 backup: **NOT_STARTED**
- STAGE S4 — single-strategy runtime validation: **NOT_STARTED**
- STAGE S5 — TCP composite validation: **NOT_STARTED**
- STAGE S6 — QUIC validation: **NOT_STARTED**
- STAGE S7 — hAP four-service validation: **NOT_STARTED**
- STAGE S9 — autohostlist evaluation: **DEFERRED UNTIL CORE RUNTIME VALIDATION**
- STAGE S10 — final profile: **NOT_STARTED**
- STAGE S11 — final validation: **NOT_STARTED**

### Important conclusion

The new evidence is sufficient to move from blind blockcheck strategy discovery to controlled OpenWrt translation/runtime validation.

It is **not** sufficient to:
- call any strategy UNIVERSAL;
- declare Telegram solved;
- replace the current working Zapret2 configuration;
- enable all candidates simultaneously.

### Next exact strategy action

Before any router-changing command:
1. Read the current hAP Zapret2 configuration.
2. Build the OpenWrt/nfqws2 translation map for the minimal candidate set.
3. Create and verify a rollback backup.
4. Test one meaningful strategy change at a time.

The first runtime candidate should be selected from the highest-coverage evidence-backed TCP classes, while preserving the current working baseline and avoiding unnecessary QUIC/TLS1.2 stacking.


## 2026-09-27 — strategy27 DOMAIN MATRIX

Полная объединённая матрица raw `blockcheck2609_FULL.log` + `blockcheck2709.log` сохранена отдельно:

- `strategy27.md`
- GitHub commit: `096bf52c11c46b40a71cb28285c19972a451e3ba`
- 297 уникальных тестовых целей в объединении двух логов.
- 225 уникальных целей имеют ≥1 explicit FOUND strategy.
- 72 цели не имеют explicit FOUND.
- Полный mapping: каждый домен → все explicit FOUND strategy classes + источник 2609/2709.
- Математический минимум set-cover для всех 225 FOUND-доменов: **4 strategy classes**.
- Два эквивалентных минимальных набора: **HC + ME + TS + TF** и **HC + ME + TS + QF**.
- Это только evidence-domain cover; это **не** означает, что 4 runtime-профиля автоматически решат все приложения/протоколы на hAP.

Для controlled runtime baseline как отдельная гипотеза сохранён каркас **HC + ME + TS + QF**: два HTTP-профиля + TLS1.3 + QUIC. TF/QI/TC и HF остаются fallback/special/candidate evidence и не удаляются.

S1 evidence matrix: **DONE / strategy27.md**.
S2 OpenWrt translation map: **NOT_STARTED**.
Router configuration changed by strategy27: **NO**.


## 2026-09-27 — S2 NFQWS2 TRANSLATION COMPLETED

S2 документальный этап завершён: `strategy27.md` содержит exact OpenWrt/nfqws2 translation map для 7 explicit FOUND classes, 4-profile minimal evidence-cover и deterministic hostlist assignment.

### Fixed design
- P1 HTTP-ME: `http_methodeol`
- P2 HTTP-HC: `http_hostcase` для HC-only доменов
- P3 TLS-TS: `tcpseg:pos=0,-1:seqovl=1 + drop`
- P4 QUIC-QF: `fake_default_quic:repeats=11`

Hostlist files (design paths only): `strategy27-me.txt`, `strategy27-hc.txt`, `strategy27-ts.txt`, `strategy27-qf.txt` under `/etc/zapret2/strategy27/`.

Counts from raw explicit FOUND matrix: ME=44, HC-only=159, TS=194, QF=111.

Fallback/special evidence remains: TF, QI, TC; HF remains HIGH-COVERAGE candidate only.

**S2 = DONE (DESIGN ONLY).** No router configuration was changed.

**S3 = NOT_STARTED.** Next action: read/backup the current live Zapret2 config before any runtime change.


## AUTHORITATIVE OVERRIDE — 2026-09-27 — SYNCHRONIZED WITH OPENWRT_VARIANT_A_MASTER_PLAN

This section supersedes older strategy-work status notes in this document where they conflict. The main `OPENWRT_VARIANT_A_MASTER_PLAN.md` remains authoritative for router-wide state; this document governs only the Zapret2 strategy-work branch.

### Current synchronized state

- Manual blockcheck discovery from `blockcheck2609_FULL.log` + `blockcheck2709.log`: **DONE FOR CURRENT EVIDENCE**.
- Merged evidence/domain matrix S1: **DONE** in `strategy27.md`.
- S2 OpenWrt/nfqws2 translation: **DONE / DESIGN ONLY**.
- S3 live Zapret2 backup: **NOT_STARTED**.
- S4 single-strategy hAP runtime validation: **NOT_STARTED**.
- S5 TCP composite validation: **NOT_STARTED**.
- S6 QUIC validation: **NOT_STARTED**.
- S7 four-service hAP validation: **NOT_STARTED**.
- Final universal profile: **NOT_ESTABLISHED**.
- Telegram Zapret2-only: **NOT_FOUND_IN_SUPPLIED_RUNS / main-plan scope remains BLOCKED**.

### strategy27 evidence

`strategy27.md` contains the complete merged mapping for **297 unique test targets**, of which **225 have at least one explicit FOUND strategy** and **72 have none**.

The explicit FOUND catalogue is:

- HC — HTTP `http_hostcase`
- ME — HTTP `http_methodeol`
- TS — TLS1.3 `tcpseg:pos=0,-1:seqovl=1 + drop`
- TF — TLS `fake_default_tls + tcp_ts=-1000`
- TC — special TLS1.2 `tcp_md5 + tls_mod + multisplit` (2709 only, 2 FOUND)
- QF — QUIC `fake_default_quic:repeats=11`
- QI — QUIC `send:ipfrag + drop`

HF — HTTP `fake_default_http + tcp_ts=-1000` remains **HIGH-COVERAGE CANDIDATE**, not explicit FOUND.

The mathematical minimum evidence-domain set-cover is **4 strategy classes**. The two exact minima are:

- HC + ME + TS + TF
- HC + ME + TS + QF

The selected runtime-design hypothesis remains **HC + ME + TS + QF**, pending hAP validation.

### S2 design synchronized with the main plan

The four-profile design is:

- P1 HTTP-ME → `http_methodeol`
- P2 HTTP-HC → `http_hostcase` for HC-without-ME domains
- P3 TLS-TS → `tcpseg:pos=0,-1:seqovl=1 + drop`
- P4 QUIC-QF → `fake_default_quic:repeats=11`

Custom strategy hostlists are designed under **`/etc/zapret2/strategy27/`**. They are not to be placed directly in the generated `/opt/zapret2/ipset/` directory; upstream zapret2 discussion explicitly warns that custom files there may be removed on update and that custom list paths should be full paths.

No S2 design change authorizes activation, restart, firewall edits, DNS changes, routing/PBR changes, or VPN changes.

### Inherited main-plan invariants

- Archer C20 v4 remains the main router; hAP ac lite remains downstream.
- Current live Zapret2 configuration is preserved until S3 rollback backup is verified.
- Current `MODE_FILTER=autohostlist` is preserved; S2 does not change it.
- Current QNUM/memory/watchdog policy from the main plan is preserved.
- Do not activate all discovered strategies simultaneously.
- Do not copy Windows `--wf-*` interception selectors to OpenWrt.
- `WORKING_IN_BLOCKCHECK` never implies `RUNTIME_VERIFIED`, `VALIDATED_ON_HAP`, or `UNIVERSAL`.

### Cross-document authority

1. `OPENWRT_VARIANT_A_MASTER_PLAN.md` — authoritative router-wide state and safety gates.
2. `ZAPRET2_STRATEGY_MASTER_PLAN.md` — strategy-work workflow and current stage state.
3. `strategy27.md` — complete raw-evidence domain/strategy matrix and S2 design.

### Exact next action

**S3: read-only capture of live Zapret2 configuration + create and verify rollback backup.**

Until S3 is complete, do not create or activate strategy27 hostlists and do not change `NFQWS2_OPT`.


## 2026-09-27 — AUTHORITATIVE TWO-LEVEL RUNTIME ARCHITECTURE

The project now fixes the runtime order:

### LEVEL 1 — EXACT EVIDENCE-BACKED HOSTLISTS
If a destination has an explicit FOUND strategy in strategy27.md, route it to the corresponding specialized nfqws2 profile first. Preserve all seven explicit FOUND classes: HC, ME, TS, TF, TC, QF and QI. The previous 4-class set-cover is a mathematical minimum only and must not be interpreted as permission to discard confirmed fallback/special strategies.

### LEVEL 2 — EXISTING AUTOHOSTLIST FALLBACK
If a destination is not covered by an exact strategy hostlist, it falls through to the existing MODE_FILTER=autohostlist behavior, preserving automatic handling for unknown domains.

### Fixed logical order
exact hostlist -> specialized strategy -> no exact match -> autohostlist fallback

The architecture is not all strategies globally enabled, not all seven stacked indiscriminately, not a replacement of autohostlist, and not a universal-strategy claim.

### Validation update
S4 onward must test this hierarchy. Before activation, verify how the installed zapret2 init/config renderer combines explicit --hostlist rules with MODE_FILTER=autohostlist. Then introduce profiles in controlled groups with rollback and one meaningful change at a time.

### Current S-stage status
S1 evidence matrix: DONE
S2 translation design: DONE / DESIGN ONLY
S3 live backup: DONE
S4 exact-hostlist runtime validation: NOT_STARTED
S5 composite exact-strategy validation: NOT_STARTED
S6 QUIC exact-strategy validation: NOT_STARTED
S7 two-level four-service validation: NOT_STARTED
Final universal profile: NOT_ESTABLISHED

### Verified S3 rollback point
/opt/zapret2/config.s3-backup-20260927 matches /opt/zapret2/config with SHA-256 bc2bbe687543e3bbda87f96d793f917e404fa5d1e19ced0ffdfd9e804f18c4b6.


## AUTHORITATIVE CURRENT OVERRIDE — 2026-09-27 — S4 RENDERER AUDIT COMPLETE

The installed renderer/init behavior has now been verified read-only.

### Verified facts
1. `/opt/zapret2/common/list.sh` uses `<HOSTLIST>` and `<HOSTLIST_NOAUTO>`.
2. With `MODE_FILTER=autohostlist`, `<HOSTLIST>` receives normal hostlists plus `--hostlist-auto=$HOSTLIST_AUTO` and auto thresholds.
3. With `MODE_FILTER=autohostlist`, `<HOSTLIST_NOAUTO>` receives normal hostlists plus `--hostlist=$HOSTLIST_AUTO`.
4. The OpenWrt init wrapper passes the rendered argument string to `nfqws2`; `--new` separates strategy profiles.
5. No runtime configuration was changed and no restart/stop/start was performed.

### Consequence for two-level architecture

The required hierarchy remains:

`EXACT -> specialized profile -> UNKNOWN -> existing autohostlist fallback`

However, `<HOSTLIST_NOAUTO>` cannot by itself implement an exact-only profile while the current `MODE_FILTER=autohostlist` is active. The fallback auto list must be explicitly separated from exact domains, or the profile construction must otherwise ensure that exact domains do not enter the fallback profile.

### Stage state
- S1: **DONE**
- S2: **DONE / DESIGN ONLY**
- S3: **DONE**
- S4 renderer audit: **DONE**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level four-service validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next single action
Read-only inspection of the installed config-rendering path that builds `NFQWS2_OPT` and calls `filter_apply_hostlist_target()`. Then design the exact/fallback profile layout. No restart and no configuration change yet.
## 2026-09-27 — S5 RENDER-PATH AUDIT RESULT

The read-only search of the installed tree found the renderer call sites:
- `/opt/zapret2/common/linux_daemons.sh:7` calls `filter_apply_hostlist_target opt`.
- `/opt/zapret2/common/installer.sh:798` calls `filter_apply_hostlist_target opt` from the NFQWS2 dry-run path.
- No direct `NFQWS2_OPT=` assignment was found in the searched `common`/OpenWrt init paths by this command.
- No runtime configuration or service state was changed.

Interpretation: the next read-only step should inspect the small surrounding sections of `linux_daemons.sh` and `installer.sh` to identify how the base `opt` variable is sourced and rendered. This is the final structural inspection before designing the exact/fallback profile layout.

S5 render-path inspection: **IN_PROGRESS**.


## 2026-09-27 — S5 RENDER-PATH CONTEXT CONFIRMED

Read-only context inspection confirms that `standard_mode_nfqws()` builds `opt="--qnum=$QNUM $NFQWS2_OPT"`, then calls `filter_apply_hostlist_target opt`, then passes the rendered options to `do_nfqws`. The installer dry-run follows the same pattern: copy `NFQWS2_OPT` to `opt`, render hostlist markers, then run `nfqws2 --dry-run`.

This confirms that `filter_apply_hostlist_target()` is directly in the live NFQWS2 option-rendering path. Under `MODE_FILTER=autohostlist`, `<HOSTLIST_NOAUTO>` still expands to normal hostlists plus `--hostlist=$HOSTLIST_AUTO`; therefore it cannot by itself mean exact-only.

No router configuration or service state was changed.

Stage state:
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **NEXT**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

Next: inspect only the remaining source/assembly of `NFQWS2_OPT` and marker-bearing profile definitions needed to design the safe `EXACT -> specialized -> UNKNOWN -> autohostlist fallback` layout. No restart/change yet.


## 2026-09-27 — S5 NFQWS2_OPT SOURCE CONFIRMED

Read-only inspection of the installed configuration confirms the live base option source and current marker-bearing profiles.

### `/opt/zapret2/config`
- `NFQWS2_OPT` is explicitly defined at line 87.
- Current profiles are:
  - TCP/80 HTTP: `<HOSTLIST>` + `http_req` + `fake_default_http:tcp_md5` + `multisplit:pos=method+2`, then `--new`.
  - TCP/443 TLS: `<HOSTLIST>` + `tls_client_hello` + `hostfakesplit:ip_ttl=3:repeats=1`, then `--new`.
  - UDP/443 QUIC: `<HOSTLIST_NOAUTO>` + `quic_initial` + `fake_default_quic:repeats=1`.
- `MODE_FILTER=autohostlist` remains the live mode.
- The config comments explicitly state that `<HOSTLIST_NOAUTO>` appends `ipset/zapret-hosts-auto.txt` as a normal list, confirming the earlier renderer finding.

### Consequence
The live baseline is already a three-profile NFQWS2 configuration, but all three marker-bearing profiles are tied to the current global hostlist renderer. The QUIC profile using `<HOSTLIST_NOAUTO>` is therefore not an exact-only fallback boundary.

No configuration was changed and no service was restarted.

### Stage state
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **IN_PROGRESS**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next single action
Inspect the complete small `NFQWS2_OPT` block plus the nearby config variables around it, and the `init.d` option-source section, to determine whether the safest exact-profile implementation can be expressed within the existing renderer without modifying the renderer itself.


## 2026-09-27 — S5 COMPLETE OPT SOURCE CONTEXT

The requested read-only inspection confirms the full option assembly context.

### Confirmed assembly
- `/opt/zapret2/config` contains the complete `NFQWS2_OPT` string with exactly three profiles separated by `--new`.
- `NFQWS2_OPT` itself contains no `USEROPT`/`LUAOPT` placeholders; those are prepended by init as `NFQWS2_OPT_BASE="$USEROPT --fwmark=$DESYNC_MARK $LUAOPT"`.
- `USEROPT=--user=$WS_USER`.
- `LUAOPT` loads `zapret-lib.lua`, `zapret-antidpi.lua`, and `zapret-auto.lua`.
- `run_daemon` receives the rendered profile arguments through the existing init path; no second independent option source was found in this inspection.
- The three live config profiles remain HTTP/80, TLS/443, and QUIC/443, with `<HOSTLIST>` on the first two and `<HOSTLIST_NOAUTO>` on QUIC.
- `MODE_FILTER=autohostlist` is global.

### Design implication
The existing renderer can only inject its global hostlist expansion into a marker-bearing option string. It does not provide per-profile marker state. Therefore, a strict architecture of `exact hostlist -> specialized strategy -> no exact match -> existing autohostlist fallback` cannot be obtained merely by assigning different files to the existing `<HOSTLIST>` and `<HOSTLIST_NOAUTO>` markers. A safe next design step is to determine whether exact profiles should be added as explicit marker-free `--hostlist=/etc/zapret2/strategy27/...` profiles before the existing fallback profiles, while leaving the current autohostlist profiles intact.

No router configuration was changed and no service was restarted.

### Stage state
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **IN_PROGRESS**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**


## 2026-09-27 — OFFICIAL PROFILE ORDER / EXACT→FALLBACK SEMANTICS CONFIRMED

Official zapret documentation and current upstream `zapret2/nfq2/desync.c` were checked before any router change.

### Confirmed engine semantics
- Profiles are separated by `--new` and evaluated from first to last; the first profile whose filter matches is selected. Upstream `dp_find()` iterates the profile list in order and returns immediately on the first `dp_match()` success. citeturn425928search0turn565749view1
- A normal `--hostlist` is a genuine profile filter. When hostname is known, `HostlistCheck()` decides whether that profile matches; otherwise the engine can continue to later profiles. citeturn565749view1
- An autohostlist profile (`--hostlist-auto`) has special matching semantics: once the hostname is known and the hard/L7 filters match, that profile wins regardless of whether the hostname is already in the autohostlist. citeturn565749view2
- Official documentation explicitly says highly specialized profiles should not use the standard `<HOSTLIST>` marker; specialized profiles should use their own filter/hostlist, while standard `<HOSTLIST>` is intended for final/fallback strategies. citeturn425928search1
- Official zapret2 discussion #76 confirms that separate strategies can be assigned to separate hostlists and that an exclude of the same list is unnecessary because the include profile already claims that hostname. citeturn425928view0

### Architectural consequence for this project
The desired two-level architecture is technically supported:

`exact hostlist -> specialized strategy -> later fallback profile`

For a strict exact-first design, the exact profile must be **before** the fallback profile, use a full persistent path such as `/etc/zapret2/strategy27/...`, and remain marker-free. The fallback profile may retain the existing `<HOSTLIST>`/autohostlist mechanism.

However, an important limitation is now explicit: if the later fallback profile contains `--hostlist-auto` and its TCP/L7 filter matches, it can become the selected profile after the exact profile fails. That is desirable for the intended fallback. It also means exact-domain ownership must be validated using debug/profile-selection evidence, not inferred solely from hostlist contents.

No router configuration was changed.

### Stage state update
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **DONE (engine semantics confirmed)**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite exact-strategy validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next single router action
Before writing the composite profile, validate the installed `nfqws2` binary's support for the exact profile syntax with `--dry-run` only. This avoids changing service state and confirms the persistent hostlist path plus the selected Lua desync verbs are accepted by the binary actually running on this hAP.


## 2026-09-27 — S5 EXACT PROFILE DRY-RUN RESULT

The installed `nfqws2` v1.0.3 (commit `b78b52c4cd7f843da3ff0848a3430afbd401bdf2`) accepted the command-line structure far enough to attempt hostlist registration, but the dry-run returned:

`cannot access hostlist file '/etc/zapret2/strategy27/strategy27-ts.txt'`
`failed to register hostlist '/etc/zapret2/strategy27/strategy27-ts.txt'`
`RC=1`

Interpretation: the test is **BLOCKED by the missing persistent hostlist file**. This result does not establish that `tcpseg:pos=0,-1:seqovl=1` and `drop` are invalid; the parser reached hostlist registration first. No service restart or configuration change occurred.

### Stage state
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **DONE (engine semantics confirmed)**
- S5 exact-profile binary dry-run: **BLOCKED — required hostlist file absent**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite exact-strategy validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next single action
Read-only inventory of `/etc/zapret2` is required to determine whether the strategy27 hostlists already exist under another path before creating anything. Do not create directories/files yet.


## 2026-09-27 — S5 HOSTLIST PATH INVENTORY

Read-only inventory confirms `/etc/zapret2` does not exist on the router, and therefore no `/etc/zapret2/strategy27/` directory exists. The previous dry-run blocker is consequently confirmed as a missing persistent strategy27 hostlist path, not a malformed nfqws2 option.

No directories, files, configuration, or services were changed.

### Stage state
- S5 render-path inspection: **DONE**
- S5 exact/fallback profile design: **DONE**
- S5 exact-profile binary dry-run: **BLOCKED — persistent strategy27 hostlists not yet deployed**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite exact-strategy validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next decision point
The hostlist contents must come from the already researched `strategy27.md` domain→strategy matrix. Before deploying them, verify the exact files/content intended for P1–P4 and ensure they are represented in the project documentation. Then deploy only the required persistent lists; do not alter the live Zapret2 configuration yet.


## 2026-09-27 — PERSISTENT STRATEGY27 HOSTLISTS CREATED

Derived directly from the complete domain→strategy matrix in `strategy27.md` (source blob SHA `14204103e753f8b0f0ede1da9fa41e2158a8e388`). Only domains marked **EXPLICIT FOUND** for the corresponding class were included; COVERAGE/UNKNOWN/NONE were excluded.

Created four inactive persistent hostlist artifacts in GitHub:

| File | Explicit-FOUND domains | Blob SHA |
|---|---:|---|
| `strategy27/strategy27-me.txt` | 44 | `a41ebb146cf73e5bee013d0ce11cd3f66a18a811` |
| `strategy27/strategy27-hc.txt` | 159 | `38c1d0346c5ccb943dc4d586aab2d368b9ef43aa` |
| `strategy27/strategy27-ts.txt` | 194 | `23378283883377b07e2469e400aacc0e8d47bdf9` |
| `strategy27/strategy27-qf.txt` | 111 | `23f4344246dbea25a9115af5a541e94042871de9` |

Verification after creation: all four fetched files matched the generated content byte-for-byte and had the expected domain counts.

These files are **not active on the hAP yet**. The live `/opt/zapret2/config` and running Zapret2 service remain unchanged.

### Stage state
- S5 exact/fallback profile design: **DONE**
- Strategy27 persistent hostlist artifacts: **DONE / NOT DEPLOYED TO ROUTER**
- S5 exact-profile binary dry-run: **BLOCKED → ready to retry after deployment**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
- S5 composite exact-strategy validation: **NOT_STARTED**
- S6 QUIC validation: **NOT_STARTED**
- S7 two-level validation: **NOT_STARTED**
- Universal: **NOT_ESTABLISHED**

### Next single router action
Create the persistent directory and copy the four already-verified hostlists from the conversation's GitHub artifacts to the hAP. This deployment must not modify `/opt/zapret2/config`, nftables, DNS, routing, or restart Zapret2.
