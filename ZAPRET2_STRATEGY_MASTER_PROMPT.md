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
