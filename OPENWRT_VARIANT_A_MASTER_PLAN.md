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
STAGE 11 — DONE (permanent Zapret2 candidate validation)
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
- Постоянный /opt/zapret2/config содержит выбранные TCP/443 кандидат #52 и UDP/443 кандидат #1.

## STATUS
STAGE 11 — DONE.

## STAGE 11 — selected candidate validation
- TCP #52 — hostfakesplit:ip_ttl=3:repeats=1 — functional PASS for YouTube HTTPS.
- QUIC #1 — fake:blob=fake_default_quic:repeats=1 — functional PASS; Chrome DevTools behind hAP showed h3.
- Separate TLS1.2/TLS1.3 proof remains unavailable because openssl is absent and BusyBox wget has no direct TLS-version selector.
- Combined temporary validation PASS: YouTube works and client shows h3, h2, http/1.1.
- Permanent runtime validation PASS: after normal restart, client-side Chrome DevTools observed h3 and h2 through the hAP.

## Permanent config comparison / commit
- [PASS] Temporary TCP/443 is candidate #52: hostfakesplit:ip_ttl=3:repeats=1.
- [PASS] Temporary UDP/443 is QUIC #1: fake:blob=fake_default_quic:repeats=1.
- [CONFIRMED] Backup existed and matched permanent config before commit.
- [PASS] Permanent TCP/443 replacement completed and verified.
- [PASS] Permanent UDP/443 replacement completed and verified.
- [PASS] Normal /etc/init.d/zapret2 restart completed without startup error.
- [PASS] Runtime loaded TCP/443 candidate #52 and UDP/443 candidate #1.
- [PASS] Runtime applied nftables NFQUEUE rules for TCP 80/443 and UDP 443; qnum=300.
- [PASS] Permanent client validation observed h3/h2.
- [SAFETY] Stage 11 changes are persistent and rollback backup remains available.
- [STATUS] STAGE 11 DONE.

## Post-reboot autostart audit — 2026-09-23
- [PASS] User rebooted the hAP after enabling zapret2 autostart.
- [PASS] `/etc/init.d/zapret2 status` returned `running` after reboot.
- [STATUS] zapret2 autostart is functionally confirmed.

## Post-reboot configuration audit — 2026-09-23
- [PASS] Permanent config remains enabled for TCP 80/443 and UDP 443 after reboot.
- [PASS] TCP/80 baseline: `fake_default_http + tcp_md5 + multisplit pos=method+2`.
- [PASS] TCP/443 selected candidate #52: `hostfakesplit:ip_ttl=3:repeats=1`.
- [PASS] UDP/443 selected candidate #1: `fake:blob=fake_default_quic:repeats=1`.
- [STATUS] Persistent Zapret2 strategy configuration survived reboot unchanged.

## Boot order audit — 2026-09-23
- [RESULT] Startup links: dnsmasq `S19`, firewall `S19`, network `S20`, zapret2 `S21`.
- [IMPORTANT] zapret2 is scheduled after network, but the `S20network` link alone does not prove that the Wi-Fi STA/upstream interface was fully usable when zapret2 started.
- [STATUS] Boot-order race remains a plausible cause of the post-reboot failure; no configuration changes made.

## Post-reboot manual-restart functional comparison — 2026-09-23
- [PASS] After manual `/etc/init.d/zapret2 restart`, router-side YouTube HTTPS download succeeded: 888563 bytes.
- [IMPORTANT] This confirms the selected Zapret2 strategies remain functional and strongly isolates the failure to the boot-time startup state/order rather than the strategy itself.
- [STATUS] Post-reboot direct startup remains FAILED until the boot-time difference is identified; manual restart restores functionality.
- [SAFETY] No persistent Zapret2 configuration changes made.

## Post-reboot manual restart comparison — 2026-09-23
- [RESULT] Manual `/etc/init.d/zapret2 restart` completed without errors.
- [PASS] Restart loaded the same selected strategies: TCP/443 `hostfakesplit:ip_ttl=3:repeats=1`; UDP/443 `fake:blob=fake_default_quic:repeats=1`; TCP/80 baseline unchanged.
- [PASS] Restart reapplied NFQUEUE 300 rules for TCP 80/443 and UDP 443.
- [IMPORTANT] This establishes a meaningful difference between post-boot state and post-manual-restart state, but functional YouTube status after the restart has not yet been tested.
- [STATUS] No persistent configuration changes made.

## Post-reboot NFQUEUE rule activity audit — 2026-09-23
- [RESULT] `postnat` shows the expected IPv4 UDP/443 and TCP 80/443 NFQUEUE rules to queue 300.
- [LIMIT] The filtered nft output exposes no packet counters, so this command does not show whether YouTube traffic actually reached the queue.
- [STATUS] No configuration changes made.

## Post-reboot auto-hostlist audit — 2026-09-23
- [PASS] `zapret-hosts-auto.txt` exists and contains 45 entries.
- [PASS] The file contains YouTube-related domains including `www.youtube.com`, `s.youtube.com`, `accounts.youtube.com`, and multiple `googlevideo.com`/YouTube subdomains.
- [STATUS] A completely empty/missing auto-hostlist is ruled out as the immediate cause of the post-reboot YouTube failure.
- [SAFETY] No configuration changes made.

## Post-reboot nfqws2 command-line audit — 2026-09-23
- [PASS] PID 2206 is running with qnum=300 and the selected TCP/UDP desync strategies.
- [IMPORTANT] Runtime uses `--hostlist-auto=/opt/zapret2/ipset/zapret-hosts-auto.txt` for TCP 80/443 and `--hostlist=/opt/zapret2/ipset/zapret-hosts-auto.txt` for QUIC.
- [STATUS] This exposes a possible post-reboot functional dependency on the auto-hostlist file; its contents/state have not yet been checked.
- [SAFETY] No configuration changes made.

## Post-reboot NFQUEUE consumer audit — 2026-09-23
- [PASS] `/proc/net/netfilter/nfnetlink_queue` shows queue `300` bound to PID `2206`, matching the running `nfqws2` process.
- [PASS] Queue 300 has an active consumer after reboot; this rules out an unbound NFQUEUE as the immediate cause.
- [STATUS] YouTube timeout remains unexplained; no configuration changes made.

## Post-reboot nfqws2 process audit — 2026-09-23
- [PASS] `ps w | grep '[n]fqws'` shows `/opt/zapret2/nfq2/nfqws2` running as user `daemon` after reboot.
- [STATUS] nfqws2 process is present; YouTube timeout is not explained by a missing nfqws2 process.
- [SAFETY] No configuration changes made.

## Post-reboot YouTube client/router failure — 2026-09-23
- [FAIL] User reports YouTube does not work from a phone behind the hAP after reboot.
- [FAIL] Router-side `wget --timeout=15 -O /dev/null https://www.youtube.com/` resolved YouTube to `142.251.153.4:443` but timed out.
- [INVALID TEST] Prior `wget -S ...` diagnostic was invalid because this BusyBox wget treated `-S` as unsupported and printed help; no network conclusion was drawn from it.
- [STATUS] Post-reboot functional validation remains FAILED; root cause not yet identified.
- [SAFETY] No Zapret2 configuration changes made.

## Post-reboot functional test — 2026-09-23
- [FAIL] Router-side YouTube HTTPS test after reboot: `wget -qO- --timeout=15 https://www.youtube.com/ | wc -c` returned `0`.
- [STATUS] Post-reboot Zapret2 functional validation is FAILED/needs investigation, despite autostart and NFQUEUE application being confirmed.
- [SAFETY] No configuration changes made; selected persistent Zapret2 strategies remain unchanged pending diagnosis.

## Post-reboot nftables audit — 2026-09-23
- [PASS] `inet zapret2` table is present after reboot with `wanif`, `wanif6`, and `lanif` sets and NAT-chain references.
- [PASS] NFQUEUE rules are active for IPv4 UDP/443 (original packets 1–5, reply packets 1–3) and TCP 80/443 (original packets 1–20, reply packets 1–10).
- [PASS] All shown NFQUEUE rules use queue number 300 and `flags bypass`.
- [STATUS] Post-reboot nftables application is confirmed; no configuration changes made.

## Autostart check — 2026-09-23
- [PASS] Startup symlink confirmed: `/etc/rc.d/S21zapret2 -> ../init.d/zapret2`.
- [STATUS] zapret2 is enabled for boot autostart.
- [LIMIT] This confirms the boot symlink only; actual post-reboot startup has not yet been tested.

- [ACTION] Ran `/etc/init.d/zapret2 enable`.
- [RESULT] Command returned empty output; this is normal for a successful init-script enable operation, but startup-link creation has not yet been rechecked.
- [STATUS] Autostart enable command executed; confirmation remains pending.

- [CHECK] Command: `ls -l /etc/rc.d/*zapret2* 2>/dev/null`
- [RESULT] Empty output; no matching startup symlink was found.
- [STATUS] zapret2 autostart is NOT_CONFIRMED / currently appears not enabled.
- [SAFETY] No configuration was changed and no reboot was performed.

## Prior detailed sync record
Earlier detailed candidate-testing history remains represented by the selected-candidate records above; no earlier PASS/FAIL state is being overwritten.
