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

Основной лог:
blockcheck2609_FULL.log

Исходный blob SHA:
d42227bdc262c4437e4d1f78e28369c41075b3d6

В логе найдено 7 уникальных рабочих комбинаций:

| ID | Класс | Стратегия | AVAILABLE |
|---|---|---|---:|
| S1 | HTTP | http_methodeol | 95/95 |
| S2 | TLS | tcpseg:pos=0,-1:seqovl=1 + drop | 92/95 |
| S3 | HTTP | http_hostcase | 84/95 |
| S4 | HTTP | fake_default_http + tcp_ts=-1000 | 74/95 |
| S5 | QUIC | fake_default_quic:repeats=11 | 42/95 |
| S6 | QUIC | send:ipfrag + drop | 26/95 |
| S7 | TLS | fake_default_tls + tcp_ts=-1000 | 10/95 |

AVAILABLE означает WORKING_IN_BLOCKCHECK.
Это не означает CONFIRMED_ON_HAP.

---

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
- собрать все реально относящиеся к нему домены из blockcheck2609_FULL.log;
- для каждой S1...S7 записать PASS/FAIL/UNKNOWN;
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
построить полную matrix YouTube × Instagram × WhatsApp × Telegram по всем соответствующим доменам из blockcheck2609_FULL.log.

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
