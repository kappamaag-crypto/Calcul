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

Hostlist files (design paths only):
`strategy27-me.txt`, `strategy27-hc.txt`, `strategy27-ts.txt`, `strategy27-qf.txt` under `/opt/zapret2/ipset/`.

Counts from raw explicit FOUND matrix: ME=44, HC-only=159, TS=194, QF=111.

Fallback/special evidence remains: TF, QI, TC; HF remains HIGH-COVERAGE candidate only.

**S2 = DONE (DESIGN ONLY).** No router configuration was changed.

**S3 = NOT_STARTED.** Next action: read/backup the current live Zapret2 config before any runtime change.
