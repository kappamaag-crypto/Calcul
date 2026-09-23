# MASTER PLAN — OpenWrt Variant A
## Clean rebuild with extroot + ZRAM + USB swap
Дата: 2026-09-21
Устройство: MikroTik hAP ac lite / RB952Ui-5ac2nD
Целевая ОС: OpenWrt 25.12.5
Target: ath79/mikrotik
Главный роутер: TP-Link Archer C20 v4
Статусы: NOT_STARTED / IN_PROGRESS / BLOCKED / FAILED / DONE

## Current state
STAGE 0 — DONE
STAGE 1 — DONE
STAGE 2 — DONE
STAGE 3 — DONE
STAGE 4 — DONE
STAGE 5 — DONE
STAGE 6 — IN_PROGRESS
STAGE 7–10 — see detailed status below
STAGE 11 — IN_PROGRESS (router-side Zapret2 candidate validation)
STAGE 12–30 — NOT_STARTED

## Compact command-output policy
- Цель: минимизировать текст, который пользователь копирует в ИИ.
- Каждая router-команда должна давать компактный диагностический вывод: только поля/строки, необходимые для PASS/FAIL или следующего шага.
- Не использовать полные cat, logread, dmesg, nft list ruleset, iw ... info и аналогичные большие выводы, если достаточно grep/sed/awk/head/tail с ограничением строк.
- Предпочитать однострочные фильтры и агрегаты; ориентир обычно 3–15 строк вывода, а при необходимости — явно указать причину большего объёма.
- Не объединять несколько независимых диагностических команд в один шаг только ради компактности: one-step-at-a-time сохраняется.
- В ответе ассистента показывать команду + ожидаемый компактный результат + PASS/FAIL; после выполнения ждать фактического вывода пользователя.

## One-step-at-a-time rule
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянинием. Следующий router command выдаётся только после фактического результата предыдущего.
Запрещено объединять текущую синхронизацию результата с выдачей следующей команды.

## Architecture
TP-Link Archer C20 v4 остаётся главным маршрутизатором.
MikroTik hAP ac lite работает downstream через Wi-Fi STA.
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.

## Safety
Без явного отдельного подтверждения запрещены destructive storage operations. Во время post-reboot audit изменения сервисов/конфигурации не выполняются.
Избегать больших logread | grep pipelines из-за ранее подтверждённых OOM.
Для swap использовать swapon -s; swapon --show на этом BusyBox не поддерживается.

## Zapret2 router-side candidate validation — current record
- Рабочий baseline сохранён в: /opt/zapret2/config.backup-before-router-selection.
- Полный baseline NFQWS2_OPT подтверждён:
  - TCP 80: fake_default_http + tcp_md5 + multisplit pos=method+2.
  - TCP 443: fake_default_tls + tcp_md5 + tcp_seq=-10000 + multidisorder pos=1,midsld.
  - UDP 443: fake_default_quic repeats=6.
- Официальный init-скрипт zapret2 использует ZAPRET_CONFIG, по умолчанию /opt/zapret2/config; временный config может быть выбран через эту переменную без изменения постоянного файла.
- Временная копия: /tmp/zapret2-config-test; содержит TCP/80 baseline, TCP/443 candidate #52, UDP/443 candidate #1.
- Постоянный /opt/zapret2/config теперь содержит выбранный TCP/443 кандидат #52; UDP/443 пока baseline.

## STATUS
STAGE 11 — IN_PROGRESS.

## STAGE 11 — selected candidate validation
- TCP #52 — hostfakesplit:ip_ttl=3:repeats=1 — functional PASS for YouTube HTTPS.
- QUIC #1 — fake:blob=fake_default_quic:repeats=1 — functional PASS; Chrome DevTools behind hAP showed h3.
- Separate TLS1.2/TLS1.3 proof remains unavailable because openssl is absent and BusyBox wget has no direct TLS-version selector.
- Combined temporary validation PASS: YouTube works and client shows h3, h2, http/1.1.

## Permanent config comparison / commit
- [PASS] Temporary TCP/443 is candidate #52: hostfakesplit:ip_ttl=3:repeats=1.
- [PASS] Temporary UDP/443 is QUIC #1: fake:blob=fake_default_quic:repeats=1.
- [CONFIRMED] Backup existed and matched permanent config before commit.
- [PASS] Permanent TCP/443 replacement completed; verified exact line:
  --filter-tcp=443 --filter-l7=tls <HOSTLIST> --payload=tls_client_hello --lua-desync=hostfakesplit:ip_ttl=3:repeats=1 --new
- [SAFETY] Service was not restarted by this edit; UDP/443 remains unchanged.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Persist the validated UDP/443 candidate #1 as the second and final strategy-line change, then verify before restart.

## Prior detailed sync record
Earlier detailed candidate-testing history remains represented by the selected-candidate records above; no earlier PASS/FAIL state is being overwritten.
