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
- Временная копия создана: /tmp/zapret2-config-test.
- Последняя проверка существования: ls -l /tmp/zapret2-config-test → файл существует, размер 5542 bytes, права -rw-r--r--, владелец root:root, время Sep 23 10:42.
- Временный config содержит TCP/80 baseline, TCP/443 candidate #52 и UDP/443 candidate #1.
- Постоянный /opt/zapret2/config не изменялся.

## STATUS
STAGE 11 — IN_PROGRESS.

## STAGE 11 — TCP/QUIC candidate reduction from complete blockcheck2 intersection
User re-reviewed all 75 exact common TCP TLS1.2+TLS1.3 results independently. This is a coverage-based selection, NOT an efficiency ranking.

### TCP: 8 candidates
1. TCP #27 — hostfakesplit:disorder_after:ip_autottl=-1,3-20:repeats=1
2. TCP #32 — hostfakesplit:disorder_after:ip_ttl=3:repeats=1
3. TCP #47 — hostfakesplit:ip_autottl=-1,3-20:repeats=1
4. TCP #52 — hostfakesplit:ip_ttl=3:repeats=1
5. TCP #24 — fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 + multisplit:pos=1,midsld
6. TCP #25 — fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 + multisplit:pos=1,midsld,1220
7. TCP #70 — multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 + fakedsplit:pos=host+1:tcp_seq=-3000
8. TCP #73 — multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 + multisplit:pos=1,midsld

### QUIC: 2 candidates
- QUIC #1 — fake:blob=fake_default_quic:repeats=1
- QUIC #2 — fake:blob=fake_default_quic:repeats=1 + send:ipfrag:ipfrag_pos_udp=16 + drop

### Test order / isolation
Do NOT test all 16 TCP×QUIC combinations. First select a working TCP strategy, then independently select a working QUIC strategy, then compose the final NFQWS2_OPT and test it on hAP.

### Current selected candidates
- TCP #52 — functional PASS for YouTube HTTPS; separate TLS1.2/TLS1.3 proof unavailable because no openssl and BusyBox wget has no direct TLS-version selector.
- QUIC #1 — functional PASS via client behind hAP: Chrome DevTools showed real h3 traffic while temporary config was active. Mixed h3/h2/http1.1 is normal.
- This PASS means functional candidate validation under the controlled temporary configuration; it does not isolate causal necessity of the candidate from browser fallback/other factors.

## Combined validation state
- Both selected strategies are already combined in /tmp/zapret2-config-test.
- User ran ZAPRET_CONFIG=/tmp/zapret2-config-test /etc/init.d/zapret2 restart.
- [PASS] Restart completed cleanly: nfqws2 started with qnum=300; TCP/80 baseline, TCP/443 candidate #52, UDP/443 candidate #1 were loaded; nftables NFQUEUE rules for TCP 80/443 and UDP 443 were applied.
- [CONFIRMED] The previous Command failed: Not found message did not recur in this restart.
- [CONFIRMED] net.netfilter.nf_conntrack_tcp_be_liberal changed 0 → 1 as part of the normal service start sequence.
- [CONFIRMED] Permanent /opt/zapret2/config remains untouched.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform one combined client-side YouTube functional check with the temporary config active. Do not modify configuration before the result.

## Prior detailed sync record
Earlier detailed candidate-testing history remains represented by the selected-candidate records above; no earlier PASS/FAIL state is being overwritten.
