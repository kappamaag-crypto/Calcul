# OPENWRT VARIANT A — START HERE

Это корневой handoff-файл проекта. Перед любой технической работой по роутеру новый AI обязан выполнить project preflight.

## Обязательный порядок чтения

1. `OPENWRT_VARIANT_A_MASTER_PROMPT.md` — обязательные правила, безопасность и workflow.
2. `OPENWRT_VARIANT_A_MASTER_PLAN.md` — фактическое состояние, история, стадии, завершенные проверки и точка остановки.
3. `OPENWRT_VARIANT_A_GLOSSARY.md` — команды, термины и уже реализованные возможности.
4. Затем — только релевантные implementation/evidence-файлы из корня репозитория.

## Правила

- Не начинать техническую работу с команды на роутере до чтения трех обязательных документов.
- Сначала определить последнюю подтвержденную точку в MASTER PLAN.
- Перед установкой или созданием чего-либо проверить, не реализована ли эта возможность уже.
- Не считать наличие файла, профиля или исторической команды доказательством активного состояния роутера.
- Свежий подтвержденный результат пользователя имеет приоритет над устаревшим историческим результатом; после этого MASTER PLAN должен быть синхронизирован.
- Репозиторий `Calcul` хранит состояние проекта и доказательства; техническую семантику OpenWrt/Linux/packages проверять по официальной документации.
- Соблюдать one-router-command-at-a-time.
- После user result + assistant response синхронизировать MASTER PLAN до следующей команды.

## На что обратить особое внимание

У проекта уже существуют реализованные функции, которые нельзя создавать заново без проверки: USB extroot, ZRAM/USB swap, диагностический CLI-набор, Zapret2 v1.0.3, Zapret2 nftables/NFQUEUE runtime и активный Zapret2 watchdog.

Запрет2 watchdog уже установлен и работает под OpenWrt procd. Не создавать второй watchdog.

## Текущая точка

На 2026-09-25: STAGE 14 IN_PROGRESS. Zapret2 watchdog deployment/activation DONE. Proton Gate 1 DONE. Proton Gate 2 DONE. Proton Gate 3 IN_PROGRESS. Endpoint host route protection DONE.

Следующий точный контролируемый шаг: создать изолированную UCI AWG-секцию `proton-awg-test`, не запускать её и не создавать default route.

## История

Подробная история находится в MASTER PLAN. Глоссарий содержит полный реестр команд и устойчивые определения. MASTER PROMPT содержит hard rules и workflow enforcement.
## CURRENT HANDOFF ENFORCEMENT — 2026-09-25

Перед любой новой командой/изменением AI обязан:
1. прочитать OPENWRT_VARIANT_A_MASTER_PROMPT.md;
2. прочитать OPENWRT_VARIANT_A_MASTER_PLAN.md;
3. прочитать OPENWRT_VARIANT_A_GLOSSARY.md;
4. сверить Capability Registry и evidence level (IMPLEMENTED IN REPOSITORY / DEPLOYED TO ROUTER / ACTIVE AT RUNTIME / VALIDATED);
5. восстановить точку остановки и только после этого читать релевантные implementation/evidence-файлы.

### Последнее подтвержденное изменение 2026-09-25
Google DoH instance 127.0.0.1:5054 удалён из UCI по решению пользователя; Cloudflare 127.0.0.1:5053 оставлен. https-dns-proxy успешно перезапущен. Проверка фактического post-restart runtime ещё ожидается.

Текущий проектный gate не меняется: STAGE 14 / Proton-AWG Gate 3 остаётся IN_PROGRESS. После завершения DoH post-restart validation следующий проектный шаг — изолированная UCI AWG-секция proton-awg-test без запуска и без default route.
## HANDOFF UPDATE — 2026-09-25 — latest diagnostic branch

The latest chat evidence is synchronized into MASTER PLAN and GLOSSARY:
- Proton OpenVPN TCP/443 direct and isolated multisplit/fakedsplit tests did not establish a control channel; do not treat either desync variant as a fix.
- proton.auth metadata is structurally ordinary; secrets are not stored in project docs.
- A plaintext HTTP probe to TCP/443 was non-diagnostic.
- The router's current BusyBox wget does not support -S.
- The router currently reports no openssl executable, which conflicts with an older package-install record; reconcile only if the tool is actually needed.
- No temporary qnum 65301 process or nft rule remains.

Future AI must classify tool/syntax failures separately from network/service failures and must not reopen exhausted desync testing without a new hypothesis.
