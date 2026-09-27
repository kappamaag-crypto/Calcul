# ZAPRET2 STRATEGY — MASTER PROMPT
## Mandatory AI instructions for strategy migration to OpenWrt hAP ac lite

Версия: 2026-09-27
Назначение: MANDATORY EXECUTION PROMPT FOR ZAPRET2 STRATEGY WORK

---

## 1. Твоя задача

Ты переносишь и проверяешь desync strategies внутри уже существующего Zapret2 на OpenWrt hAP ac lite.

Цель:
получить минимальный подтверждённый HTTP/TLS/QUIC профиль с максимальным доказанным покрытием YouTube, Instagram, WhatsApp и Telegram, без разрушения текущей рабочей конфигурации.

Не обещай универсальность заранее.

---

## 2. Обязательный preflight

Перед любым техническим ответом:
1. прочитать OPENWRT_VARIANT_A_MASTER_PROMPT.md;
2. прочитать OPENWRT_VARIANT_A_MASTER_PLAN.md;
3. прочитать OPENWRT_VARIANT_A_GLOSSARY.md;
4. прочитать ZAPRET2_STRATEGY_MASTER_PLAN.md;
5. прочитать этот prompt;
6. найти последнюю authoritative/current-state запись;
7. проверить, не реализована ли нужная функция уже.

Не начинать с router command.

---

## 3. Источники

Техническая семантика:
официальные bol-van/zapret2 и OpenWrt/Linux.

Evidence:
blockcheck2609_FULL.log.

AI:
только синтез и гипотеза.

Не использовать Calcul как технический authority.

---

## 4. Существующий Zapret2 сохранять

Уже существуют Zapret2 и watchdog.

Запрещено ради Strategy Work:
- устанавливать второй Zapret/Zapret2;
- создавать второй watchdog;
- заменять рабочий config чужим конфигом;
- менять DNS;
- менять routing/PBR/VPN;
- менять firewall без отдельной причины;
- одновременно менять несколько крупных подсистем.

Strategy Work = изменение только стратегии внутри существующего datapath.

---

## 5. Windows параметры не переносить

Не копировать на OpenWrt:

    --wf-l3=ipv4
    --wf-tcp-out=80
    --wf-tcp-out=443
    --wf-udp-out=443

Это Windows/WinDivert interception.

На OpenWrt адаптировать payload/desync через nfqws2 filters, L7 detection и hostlist scope.

---

## 6. Текущие strategy candidates

S1:
    --payload=http_req
    --lua-desync=http_methodeol
    blockcheck 95/95

S2:
    --payload=tls_client_hello
    --lua-desync=tcpseg:pos=0,-1:seqovl=1
    --lua-desync=drop
    blockcheck 92/95

S3:
    --payload=http_req
    --lua-desync=http_hostcase
    blockcheck 84/95

S4:
    --payload=http_req
    --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
    blockcheck 74/95

S5:
    --payload=quic_initial
    --lua-desync=fake:blob=fake_default_quic:repeats=11
    blockcheck 42/95

S6:
    --payload=quic_initial
    --lua-desync=send:ipfrag
    --lua-desync=drop
    blockcheck 26/95

S7:
    --payload=tls_client_hello
    --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
    blockcheck 10/95

Все: WORKING_IN_BLOCKCHECK, не VALIDATED_ON_HAP.

---

## 7. Не называй стратегию универсальной без matrix

Высокий blockcheck coverage — это evidence для приоритета тестирования.

Это не доказательство:
- лучшего результата у текущего ISP;
- работы на hAP;
- покрытия всех четырёх сервисов;
- покрытия API/CDN/media;
- устранения IP-level block.

UNIVERSAL разрешено только после полной matrix и hAP validation.

---

## 8. Сначала matrix

Построй:

YouTube × Instagram × WhatsApp × Telegram
×
all relevant domains from blockcheck2609_FULL.log
×
S1...S7

Каждая ячейка:
PASS / FAIL / UNKNOWN.

Сделай:
- intersection;
- unique strategies;
- minimal common profile;
- uncovered domains;
- необходимый fallback.

UNKNOWN не превращать в PASS.

---

## 9. Не своди сервис к одному домену

Не ограничиваться только:
youtube.com
instagram.com
whatsapp.com
telegram.org

Использовать только реальные домены из evidence и runtime observations.

Не придумывать домены по памяти.

---

## 10. Профили

Использовать:

    TCP/80  -> HTTP profile
    TCP/443 -> TLS profile
    UDP/443 -> QUIC profile

Не делать global one-strategy-for-everything.

---

## 11. Первоначальный порядок

HTTP:
S1 -> S3 -> S4

TLS:
S2 -> S7

QUIC:
S5 -> S6

Это initial test order, а не абсолютная гарантия.

---

## 12. tcp_ts

S4 и S7 не делать unconditional global defaults.

Сначала primary.
Fallback только по evidence.

---

## 13. Circular/fallback

Не строить длинные chains ради количества strategies.

Перед circular определить:
- failure condition;
- fails;
- retrans;
- time;
- observed transition.

Если threshold не срабатывает, fallback может не запускаться.
Поэтому chain проверяется отдельно.

---

## 14. Hostlist / autohostlist

Использовать hostlist scope.

Поддерживаются:
- <HOSTLIST>
- <HOSTLIST_NOAUTO>
- autohostlist

Но текущий MODE_FILTER=autohostlist не менять только ради strategy test.

Если нужна смена mode, это отдельная hypothesis и отдельный stage.

---

## 15. Telegram / WhatsApp

Основной MASTER PLAN содержит текущий статус: часть Telegram/WhatsApp проблем считается BLOCKED для текущего Zapret2-only подхода с возможным IP-level фактором.

Поэтому:
blockcheck PASS != proof of Telegram/WhatsApp recovery on hAP.

Если runtime не меняется после strategy test:
не продолжать бессмысленный desync sweep.
Разделить DPI / IP / route / DNS / application causes.

---

## 16. One variable at a time

Один эксперимент = одна смысловая переменная.

Не делать:

    strategy + MODE_FILTER + QNUM + DNS + firewall

Делать:

    current known-good state
    -> one strategy change
    -> test
    -> result
    -> plan sync

---

## 17. 64-MB router discipline

Не:
- запускать много тяжёлых profiles одновременно;
- включать тяжёлый мониторинг;
- делать непрерывный tcpdump;
- менять SET_MAXELEM/QNUM вместе со strategy;
- складывать несколько VPN/proxy stacks.

После значимого теста проверять только необходимое health/memory состояние.

---

## 18. Rollback

Перед первым runtime change должен существовать backup.

При регрессии:
1. stop;
2. rollback;
3. minimal functional check;
4. structural Zapret2 check;
5. watchdog check;
6. record evidence.

Не накладывать новые strategies поверх broken datapath.

---

## 19. Формат шага

Перед router command:

    STAGE: Sx
    STATUS: IN_PROGRESS
    GOAL: ...
    CHANGE: ...
    RISK: NONE / LOW / MEDIUM / HIGH
    ROLLBACK: ...
    NEXT: one command

После user result:
- сначала интерпретировать;
- не выдавать пакет следующих команд;
- синхронизировать Strategy MASTER PLAN;
- при необходимости обновить prompt;
- только потом дать следующий один action.

---

## 20. Status vocabulary

Использовать:
NOT_STARTED
IN_PROGRESS
BLOCKED
FAILED
DONE
CANDIDATE
WORKING_IN_BLOCKCHECK
RUNTIME_VERIFIED
VALIDATED_ON_HAP
UNIVERSAL_CANDIDATE
UNIVERSAL_VALIDATED
UNKNOWN
PAUSED
RETIRED

---

## 21. Stop conditions

Остановить blind tuning, если:
- coverage больше не растёт;
- несколько strategies дают одинаковый failure;
- проблема выглядит IP-level;
- ухудшается memory state;
- watchdog фиксирует structural failure;
- ordinary HTTPS regress;
- fallback не добавляет measurable value.

---

## 22. Main project integrity

Не:
- откатывать подтверждённые функции;
- переустанавливать watchdog;
- возвращать retired DoH;
- включать PBR;
- трогать frozen tunnel branch;
- создавать второй Zapret stack.

Strategy branch работает внутри существующего проекта.

---

## 23. Synchronization

После каждого user result:
1. обновить ZAPRET2_STRATEGY_MASTER_PLAN.md;
2. при необходимости обновить OPENWRT_VARIANT_A_MASTER_PLAN.md;
3. при изменении workflow/safety обновить ZAPRET2_STRATEGY_MASTER_PROMPT.md;
4. только затем следующий router action.

Не заявлять GitHub sync без фактического write.

---

## 24. Current exact next action

STAGE S0 = DONE
STAGE S1 = NOT_STARTED
ROUTER CONFIG CHANGED BY DOCUMENT CREATION = NO

Следующее действие:
полная service/domain matrix из blockcheck2609_FULL.log.

До завершения S1:
- не менять NFQWS2_OPT;
- не менять MODE_FILTER;
- не менять QNUM;
- не добавлять новые desync strategies на роутер.

---

## 25. Technical references

https://github.com/bol-van/zapret2
https://github.com/bol-van/zapret2/blob/master/config.default
https://github.com/bol-van/zapret/blob/master/docs/readme.md

Главные upstream principles:
- отдельные L7 профили;
- hostlist/autohostlist;
- minimal interception;
- controlled fallback/multi-profile.

---

## FINAL RULE

Не угадывай «магическую стратегию».

MEASURE
-> CLASSIFY
-> TRANSLATE
-> TEST ONE CHANGE
-> VALIDATE
-> RECORD
-> COMPOSE ONLY AFTER EVIDENCE

Главный критерий — доказанное покрытие при минимальном вмешательстве и сохранении стабильности hAP.


## CURRENT HANDOFF OVERRIDE — 2026-09-27 — S4 RENDERER AUDIT

The installed renderer behavior is verified read-only:
- `<HOSTLIST>` under `MODE_FILTER=autohostlist` includes auto-hostlist handling.
- `<HOSTLIST_NOAUTO>` under the same mode still includes `--hostlist=$HOSTLIST_AUTO`.
- The init wrapper passes rendered NFQWS2 arguments to the daemon; `--new` separates profiles.
- No router configuration was changed and no restart occurred.

Never describe `<HOSTLIST_NOAUTO>` as an exact-only mechanism in this installation.

Required runtime hierarchy remains:
`exact hostlist -> specialized strategy -> no exact match -> autohostlist fallback`.

Before activation, explicitly separate exact domains from the fallback auto profile. Do not change MODE_FILTER or unrelated router subsystems merely to achieve this.

After every user result, synchronize the relevant master plan before the next router action.
## 2026-09-27 — S5 RENDER-PATH HANDOFF

The installed-tree search located the two relevant `filter_apply_hostlist_target` call sites:
- `common/linux_daemons.sh:7`
- `common/installer.sh:798`

No runtime change occurred. Before any strategy activation, inspect only the surrounding code to determine the source of the `opt` variable and how profiles are assembled. Then design the exact/fallback separation. Synchronize before the next router action.


## CURRENT HANDOFF OVERRIDE — 2026-09-27 — EXACT HOSTLIST DEPLOYMENT AND DRY-RUNS COMPLETE

The following work is already complete and must not be repeated:
- S3 rollback backup exists and was verified: /opt/zapret2/config.s3-backup-20260927.
- Zapret2 was temporarily stopped only for hostlist transfer and then successfully restarted with the unchanged live configuration.
- Persistent hostlists exist on the hAP:
  - /etc/zapret2/strategy27/strategy27-me.txt — 44 hosts
  - /etc/zapret2/strategy27/strategy27-hc.txt — 159 hosts
  - /etc/zapret2/strategy27/strategy27-ts.txt — 194 hosts
  - /etc/zapret2/strategy27/strategy27-qf.txt — 111 hosts
- All four exact profile definitions were accepted by the installed nfqws2 v1.0.3 in --dry-run with RC=0.
- No strategy27 profile is active in /opt/zapret2/config yet.
- The live fallback remains the existing HTTP/TLS/QUIC autohostlist configuration.
- TF, TC and QI remain preserved explicit FOUND classes for later controlled fallback evaluation; HF remains a candidate only.

The current requested architecture is:
exact hostlist -> specialized ME/HC/TS/QF profile -> no exact match -> existing autohostlist fallback.

Important formal stage naming:
- Formal S5 = composite exact-strategy validation.
- Formal S6 = QUIC exact-strategy validation.
The current chat may call the composite pre-activation dry-run "S6"; do not renumber the formal stages in the documents.

Next action: run one read-only nfqws2 --dry-run containing the four exact profiles followed by the current rendered fallback profiles. Do not alter MODE_FILTER, QNUM, DNS, routing, firewall, VPN, PBR or /opt/zapret2/config during this dry-run.


## 2026-09-27 — S4 RUNTIME-GATE REFRAME

The previous one-strategy-at-a-time S4 procedure is stopped and superseded by a minimal runtime gate. The purpose is not to runtime-test every discovered strategy individually. Dry-run/parser validation is already complete for the four deployed exact profiles ME/HC/TS/QF, including the composite exact→fallback dry-run and dedicated QF dry-run.

New minimal runtime gate: validate representative traffic behavior by strategy class, not every strategy. Gate A = HTTP class using the already discovered ME/HC candidates; Gate B = TLS class using TS; Gate C = QUIC class using QF. Only after these representative gates pass is the four-service matrix evaluated. TF/TC/QI and other secondary/special classes remain deferred unless the representative gate exposes a concrete coverage gap requiring them. Telegram/WhatsApp are not to be declared solved by Zapret2-only evidence; the existing IP-level/blocking limitation remains.

The current live Zapret2 configuration remains unchanged. MODE_FILTER=autohostlist, QNUM=300, QNUM=65300 and existing fallback profiles are preserved. The S4 backup /opt/zapret2/config.s4-pre-me-20260927 was created and verified byte-for-byte by SHA256; it is a rollback point, not a reason to perform repeated per-strategy swaps.

Execution rule: one controlled runtime gate at a time, minimal changes, no simultaneous changes to strategy + MODE_FILTER + QNUM + DNS + routing. Do not activate all strategy27 profiles globally. Exact-hostlist → specialized strategy → existing autohostlist fallback remains the target architecture.


## 2026-09-27 — RUNTIME VALIDATION EFFICIENCY OVERRIDE

Never turn the runtime phase into exhaustive per-domain testing. blockcheck2609_FULL.log and blockcheck2709.log already contain domain-level evidence. Runtime testing must validate representative traffic classes and the exact→fallback architecture with the fewest meaningful live requests.

Required method:
- Gate A: HTTP representative(s) for ME/HC.
- Gate B: TLS representative for TS.
- Gate C: QUIC representative for QF.
- Do not runtime-test every exact-hostlist entry.
- After class gates, use at most one smoke endpoint per priority service only when it resolves a concrete architecture question. No full 4×N matrix.
- Tooling limitations are recorded as BLOCKED rather than solved by unnecessary package installation.
- One controlled change at a time; restore the verified baseline after each live experiment.
- Domain-level coverage comes from blockcheck evidence; live tests validate runtime behavior, not every domain.

Current checkpoint: Gate A/ME = IN_PROGRESS/NOT PROVEN; Gate B/TS = PASS; Gate C/QF = BLOCKED due to missing HTTP/3 support in installed curl/libcurl. strategy27 remains inactive in live config.

This override supersedes older instructions that requested a full four-service/domain matrix.


## 2026-09-27 — S5 COMPOSITE RUNTIME CHECKPOINT

A controlled live composite test completed and rolled back automatically. HC HTTP YouTube: RC=0, 892572 bytes — RUNTIME_VERIFIED. ME HTTP Instagram: RC=4 — NOT_PROVEN because the same endpoint had already failed at baseline. TS TLS Instagram: RC=0, 416466 bytes — RUNTIME_VERIFIED. Restore: RC=0. QF was loaded in the composite but live QUIC remains BLOCKED because installed curl/libcurl has no HTTP/3 support.

Exact selection model remains domain + traffic class -> evidence-derived exact profile -> existing autohostlist fallback when no exact match. Runtime must not become a per-domain matrix. Permanent strategy27 activation remains NOT_AUTHORIZED.
## 2026-09-27 — AUTHORITATIVE S7 WORKFLOW OVERRIDE

The runtime workflow is now evidence-reconciled.

Formal S7 may be closed without additional live tests when:
- representative HTTP/TLS gates have demonstrated the exact→fallback architecture;
- blocked tooling limitations are explicitly classified as BLOCKED;
- unresolved individual strategies are NOT_PROVEN rather than silently promoted;
- the existing domain/service evidence already answers whether a broad service matrix would change the architecture decision.

Never turn S7 into a 297-domain or 4×N live test matrix.

Current S7 disposition: **DONE / EVIDENCE_RECONCILED — no additional router runtime matrix required**.

This does not authorize permanent strategy27 activation. A later activation stage must remain a separate controlled change with rollback and baseline health verification.

After every user result:
1. interpret the result;
2. synchronize the Strategy Master Plan;
3. update this prompt only if workflow/safety changed;
4. only then issue one next action.


## 2026-09-27 — MANDATORY CURRENT HANDOFF — PERMANENT ME/HC/TS/QF ACTIVATION

The prepared rollback-protected activation was executed and returned `ACTIVATION=SUCCESS`.

Current live architecture:
**exact ME/HC/TS/QF hostlist profile → existing autohostlist fallback**.

Activation safeguards that passed:
- exact pre-change backup created at `/opt/zapret2/config.strategy27-pre-20260927-212254`;
- Zapret2 restart succeeded;
- service status succeeded;
- ordinary HTTPS health to `https://example.com` succeeded;
- automatic rollback was not needed.

Do not infer universal traffic effectiveness from this checkpoint. ME remains NOT_PROVEN, QF live traffic remains BLOCKED by missing HTTP/3 tooling, while HC and TS have representative runtime verification. The permanent configuration is nevertheless the current live baseline and must not be reverted merely to repeat prior gates.

After every subsequent user result, synchronize the relevant master plan before issuing the next router action. Any new runtime strategy change must remain controlled, rollback-protected and isolated from DNS/routing/VPN/PBR/QNUM changes.


## 2026-09-27 — AUTHORITATIVE STRATEGY27 CLASS STATUS RECONCILIATION

This section is authoritative over any older wording in this file that conflicts with it. Historical evidence and prior stage notes are retained for traceability.

### Current strategy-class disposition

| Class | Exact strategy | Evidence status | Current disposition | Reason |
|---|---|---|---|---|
| **ME** | HTTP `http_methodeol` | **EXPLICIT FOUND** | **ACTIVE** | 44 domains; included in permanent exact HTTP layer |
| **HC** | HTTP `http_hostcase` | **EXPLICIT FOUND** | **ACTIVE** | 159 domains; included in permanent exact HTTP layer; representative HTTP runtime verified |
| **TS** | TLS `tcpseg:pos=0,-1:seqovl=1 + drop` | **EXPLICIT FOUND** | **ACTIVE** | 194 domains; included in permanent exact TLS layer; representative TLS runtime verified |
| **QF** | QUIC `fake_default_quic:repeats=11` | **EXPLICIT FOUND** | **ACTIVE** | 111 domains; included in permanent exact QUIC layer; parser/config accepted; live HTTP/3 effectiveness remains unverified because installed curl lacks HTTP/3 |
| **TF** | TLS `fake_default_tls:tcp_ts=-1000` | **EXPLICIT FOUND** | **DEFERRED / FOUND** | 15 domains; valid FOUND evidence, intentionally excluded from first permanent layer to avoid unnecessary TLS stacking; eligible for targeted follow-up |
| **TC** | TLS1.2 special | **EXPLICIT FOUND** | **DEFERRED / FOUND** | 2 domains; narrow special-case profile; no current demonstrated coverage gap requiring permanent activation |
| **QI** | QUIC `send:ipfrag + drop` | **EXPLICIT FOUND** | **DEFERRED / FOUND** | 2 domains; narrow special-case profile; no current demonstrated coverage gap requiring permanent activation |
| **HF** | HTTP high-coverage `fake_default_http + tcp_ts=-1000` | **CANDIDATE / HIGH-COVERAGE** | **CANDIDATE ONLY / NOT ACTIVATED** | substantial coverage but no explicit `working strategy found` evidence; must not be promoted to FOUND without new evidence |

### Critical distinction

**TF is NOT an unproven candidate.** TF has explicit FOUND evidence. Its status is **DEFERRED / FOUND**, not FAILED, BLOCKED, or candidate-only.

Likewise **TC** and **QI** are explicit FOUND strategies, but each is a narrow special-case class with only two currently evidenced domains. They were intentionally deferred from the first permanent activation.

**HF is different:** it has high coverage/candidate evidence but no explicit FOUND records. It remains candidate-only.

### Permanent architecture

The live architecture is:

`domain + traffic class -> exact evidence-derived specialized profile -> no exact match -> existing autohostlist fallback`

Current exact permanent layer:
- ME: 44 hosts
- HC: 159 hosts
- TS: 194 hosts
- QF: 111 hosts

Deferred FOUND layer:
- TF: 15 hosts
- TC: 2 hosts
- QI: 2 hosts

Candidate-only:
- HF: not activated

### Activation policy for deferred FOUND classes

Do **not** activate TF, TC or QI merely because they are FOUND. They require a concrete coverage gap, targeted domain need, or other discriminating runtime hypothesis. Do not activate HF without new evidence upgrading it beyond candidate status.

### Evidence boundary

Blockcheck **FOUND** proves that the strategy worked in the source test environment. It does not by itself prove runtime effectiveness on this hAP. Conversely, a deferred strategy is not considered failed merely because it is not in the current permanent layer.



## 2026-09-27 — MANDATORY HANDOFF — TC SKIPPED / QI SKIPPED

Latest follow-up disposition:
- TC hostlist exists locally with 2 domains, but TC was not added to permanent NFQWS2_OPT.
- TC baseline for `hdrzk.org` returned `BASE_RC=8`, `BASE_SIZE=0`; no differential TC benefit was established.
- User explicitly skipped TC and then explicitly skipped QI.
- QI remains FOUND/DEFERRED, not active.
- HF remains candidate-only.

Future AIs MUST preserve the live baseline as **ME + HC + TS + QF + existing autohostlist fallback**. Do not activate TC/QI without a concrete coverage gap and controlled evidence. Do not alter unrelated DNS/routing/VPN/PBR/QNUM settings.
## 2026-09-27 — HF PER-DOMAIN EVIDENCE RULE

HF = HTTP `fake:blob=fake_default_http:tcp_ts=-1000` remains **CANDIDATE ONLY**.

Do not infer an HF hostlist from aggregate coverage counters such as 74/140 or 149/301. These counters are not an exact per-domain set.

When HF domain delta analysis is requested, require direct per-domain evidence from `blockcheck2609_FULL.log` and `blockcheck2709.log`, then calculate HF ∩ ME, HF ∩ HC, and HF \ (ME ∪ HC) before any activation decision.

If the raw logs are not readable through the current source path, record the result as **BLOCKED / SOURCE EXTRACTION REQUIRED** and do not fabricate or approximate the HF domain list.

Reference artifact: `ZAPRET2_HF_DOMAIN_DELTA_AUDIT.md`.
