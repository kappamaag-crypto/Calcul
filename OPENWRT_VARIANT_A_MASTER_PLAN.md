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
- В ответе ассистента показывать команду + ожидаемый компактный результат + PASS/FAIL; после выполнения ждать фактический вывод пользователя.

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
- Временная копия создана: /tmp/zapret2-config-test.
- Временный config содержит TCP/80 baseline, TCP/443 candidate #52 и UDP/443 candidate #1.
- Постоянный /opt/zapret2/config не изменялся.

## STATUS
STAGE 11 — IN_PROGRESS.

## STAGE 11 — TCP/QUIC candidate reduction
User selected 8 TCP and 2 QUIC candidates from the complete blockcheck2 intersection for mechanism coverage, not ranking.

### Selected candidates
- TCP #52 — hostfakesplit:ip_ttl=3:repeats=1. Functional PASS for YouTube HTTPS; separate TLS1.2/TLS1.3 proof remains unavailable because no openssl and BusyBox wget has no direct TLS-version selector.
- QUIC #1 — fake:blob=fake_default_quic:repeats=1. Functional PASS via client behind hAP: Chrome DevTools showed real h3 traffic while temporary config was active.
- Mixed h3/h2/http1.1 is normal; h3 confirms actual HTTP/3 traffic over UDP/443 behind hAP.
- The candidate PASS classification is functional under the controlled temporary configuration and does not isolate causal necessity from browser fallback/other factors.

## Combined validation
- [PASS] Temporary config contains TCP #52 + QUIC #1 simultaneously.
- [PASS] Restart with temporary config completed cleanly; nfqws2 qnum=300 started and nftables NFQUEUE rules for TCP 80/443 and UDP 443 were applied.
- [PASS] Combined client-side validation: user reports YouTube works and Chrome DevTools Network shows h3, h2, and http/1.1 requests while connected behind hAP.
- [INTERPRETATION] Presence of h3 confirms successful HTTP/3/QUIC client traffic behind hAP in the combined test. h2/http1.1 represent normal protocol fallback/mixed traffic.
- [CONFIRMED] Previous Command failed: Not found message did not recur.
- [CONFIRMED] Permanent /opt/zapret2/config remains untouched.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Before changing the permanent configuration, perform one compact read-only comparison of the selected temporary TCP/443 and UDP/443 entries against the permanent config and confirm the backup file exists. No configuration change in this step.

## Prior detailed sync record
Earlier detailed candidate-testing history remains represented by the selected-candidate records above; no earlier PASS/FAIL state is being overwritten.
