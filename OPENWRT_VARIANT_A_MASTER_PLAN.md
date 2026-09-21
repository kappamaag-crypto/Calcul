# MASTER PLAN — OpenWrt Variant A
## Clean rebuild with extroot + ZRAM + USB swap
Дата: 2026-09-18
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
STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation)
STAGE 12–30 — NOT_STARTED

## One-step-at-a-time rule
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянием. Следующий router command выдаётся только после фактического результата предыдущего.
Запрещено объединять текущую синхронизацию результата с выдачей следующей команды.

## Architecture
TP-Link Archer C20 v4 остаётся главным маршрутизатором.
MikroTik hAP ac lite работает downstream через Wi-Fi STA.
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.

## Safety
Без явного отдельного подтверждения запрещены destructive storage operations. Во время post-reboot audit изменения сервисов/конфигурации не выполняются.
Избегать больших `logread | grep` pipelines из-за ранее подтверждённых OOM.
Для swap использовать `swapon -s`; `swapon --show` на этом BusyBox не поддерживается.

## CHANGELOG — 2026-09-21 — nfqws2 absent after reboot
[FACTUAL RESULT] The user executed `pgrep -a nfqws2`; the output was empty.
[CONCLUSION] No nfqws2 process is running after reboot.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 start command path not found
[FACTUAL RESULT] The user executed `/opt/zapret2/init.d/sysv/zapret2 start`; BusyBox ash returned `-ash: /opt/zapret2/init.d/sysv/zapret2: not found`.
[CONCLUSION] The previously referenced Zapret2 init-script path is not executable/resolvable at that exact path after reboot. This does not yet establish whether Zapret2 files are missing, relocated, or the script has an interpreter/path dependency problem.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 files present, init layout differs
[FACTUAL RESULT] Read-only directory listing shows `/opt/zapret2` is present with binaries, config, nfq2, ipset, and `init.d`. Under `/opt/zapret2/init.d` there is no `sysv` directory; available directories are `custom.d.examples.linux` and `openwrt`.
[CONCLUSION] The earlier `init.d/sysv/zapret2` path was incorrect for the currently deployed Zapret2 tree. Zapret2 itself is present; no deletion is indicated by this result.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — OpenWrt Zapret2 init script found
[FACTUAL RESULT] Read-only listing of `/opt/zapret2/init.d/openwrt` shows executable `zapret2` (2987 bytes), plus `90-zapret2`, `firewall.zapret2`, `functions`, and `custom.d`.
[CONCLUSION] The correct executable init script in the current deployment is `/opt/zapret2/init.d/openwrt/zapret2`.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 started successfully after reboot
[FACTUAL RESULT] The user executed `/opt/zapret2/init.d/openwrt/zapret2 start`. The command started `/opt/zapret2/nfq2/nfqws2` with qnum 300, TCP ports 80/443, UDP 443, and the configured autohostlist desync rules. Output reports successful nftables application, creation/reload of the nftables set backend, population of zapret/ipban/nozapret sets, insertion of IPv4 NFQWS postrouting/prerouting rules for TCP/UDP, and `net.netfilter.nf_conntrack_tcp_be_liberal = 1`. The command returned to the shell without an error.
[CONCLUSION] Zapret2/NFQWS2 start procedure completed successfully after reboot. This establishes successful startup/configuration application, but does not yet establish stable runtime, absence of OOM recurrence, or application-level service functionality.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — nfqws2 remains running
[FACTUAL RESULT] The user executed `pgrep -a nfqws2`; output was `3578 /opt/zapret2/nfq2/nfqws2`.
[CONCLUSION] The nfqws2 process started by Zapret2 is still running at the verification point after startup.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Router-side HTTPS baseline passes with Zapret2
[FACTUAL RESULT] The user executed `wget -O /dev/null -T 10 https://example.com` while nfqws2 was running. Connection to `8.6.112.6:443` completed successfully and 559 bytes were downloaded.
[CONCLUSION] Basic router-side HTTPS connectivity remains functional with the current Zapret2 configuration. This does not yet establish application-level functionality for Telegram, WhatsApp, or other client applications.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Client service validation after Zapret2 restart
[FACTUAL RESULT] User reports: Google works; YouTube does not work; Telegram does not work; WhatsApp does not work.
[CONCLUSION] Current autohostlist Zapret2 configuration passes basic router-side HTTPS and Google client access, but client-side YouTube, Telegram, and WhatsApp are not working. Application-level validation therefore remains FAILED for those services under the current configuration; STAGE 11 remains IN_PROGRESS because diagnosis/strategy validation is incomplete.
[USER NOTE] User recalls that an automatic strategy-selection/autodetection mechanism had previously been launched. This recollection is recorded as a hypothesis/previous workflow reference, not yet as a verified current runtime state.

## CHANGELOG — 2026-09-21 — Zapret2 configuration audit: autohostlist confirmed
[FACTUAL RESULT] The user executed:
`grep -E '^(MODE_FILTER|NFQWS2_ENABLE|NFQWS2_OPT|NFQWS2_PORTS_TCP|NFQWS2_PORTS_UDP|FLOWOFFLOAD|INIT_APPLY_FW|DISABLE_IPV6)=' /opt/zapret2/config`
Output:
`NFQWS2_ENABLE=1`
`NFQWS2_PORTS_TCP=80,443`
`NFQWS2_PORTS_UDP=443`
`NFQWS2_OPT="`
`MODE_FILTER=autohostlist`
`FLOWOFFLOAD=donttouch`
`INIT_APPLY_FW=1`
`DISABLE_IPV6=1`
The command did not display the contents of the multiline `NFQWS2_OPT` value because the value starts with a quote and continues on subsequent lines.
[CONCLUSION] NFQWS2 is enabled; configured TCP ports are 80/443; configured UDP port is 443; MODE_FILTER is `autohostlist`; FLOWOFFLOAD is `donttouch`; INIT_APPLY_FW is `1`; DISABLE_IPV6 is `1`. The exact multiline desync strategy block remains not yet re-read by this command and therefore is not re-verified by this result.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Continue with a read-only inspection that captures the complete multiline `NFQWS2_OPT` block before any strategy change.

## CHANGELOG — 2026-09-21 — compact diagnostic output rule
[DOCUMENTATION CHANGE] Added a compact-output rule to MASTER PROMPT and GLOSSARY.
[MASTER PROMPT] Diagnostic commands should return only data required for the current PASS/FAIL criterion; prefer targeted grep/awk/sed/head/tail/tr over large raw outputs.
[GLOSSARY] Added the same rule as a named glossary concept.
[SAFETY] This does not change one-step-at-a-time: independent diagnostics are not combined merely to reduce message count.
[COMMITS] MASTER PROMPT: b707d537a392475ed1d81f1c2af36fab19320649; GLOSSARY: ce5c9aa0da52504c095ad6d097531d1dfb617c15.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
