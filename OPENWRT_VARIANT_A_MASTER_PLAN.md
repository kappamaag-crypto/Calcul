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
STAGE 6 — DONE (Zapret2 boot persistence and post-reboot validation)
STAGE 7 — current baseline recorded; STAGE 8 — verified; STAGE 9 — verified; STAGE 10 — SKIPPED/RETIRED (DoH abandoned)
STAGE 11 — DONE (permanent Zapret2 candidate validation)
STAGE 12–20 — RETIRED/OBSOLETE FOR CURRENT PATH; STAGE 21 — IN_PROGRESS (WireGuard reopened); STAGE 22–23 — IN_PROGRESS/ALTERNATE PATH; STAGE 24–30 — NOT_STARTED

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
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → Zapret2 → WireGuard/WARP/Proton → PBR. DoH explicitly abandoned; do not reintroduce it unless the user separately requests.

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

## Zapret2 init dependency audit — 2026-09-23
- [RESULT] `/etc/init.d/zapret2` declares `USE_PROCD=1` and `START=21`.
- [IMPORTANT] No explicit `REQUIRE`, `START_DEPENDS`, or service dependency declaration was shown by the filtered check.
- [STATUS] The boot-order/race hypothesis remains plausible; no configuration changes made.

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

## Post-reboot WAN readiness audit — 2026-09-23
- [PASS] `ubus call network.interface.wan status` reports `up=true`, `pending=false`, `available=true`.
- [RESULT] WAN uptime at time of check: 1264 seconds; IPv4 address is present.
- [IMPORTANT] The current WAN state is healthy, but this snapshot does not prove WAN readiness at the exact moment zapret2 started during boot.
- [STATUS] Boot-time race/readiness hypothesis remains plausible; no configuration changes made.

## Post-reboot wanif set audit — 2026-09-23
- [PASS] `nft list set inet zapret2 wanif` shows `elements = { "phy0-sta0" }`.
- [IMPORTANT] The post-boot `wanif` set is populated with the expected upstream Wi-Fi interface, so an empty/missing wanif set is ruled out as the immediate cause of the YouTube timeout.
- [STATUS] Boot-time race hypothesis is narrowed but not eliminated; no configuration changes made.

## Zapret2 init script startup-path audit — 2026-09-23
- [RESULT] Filtered inspection shows `start_service()` at line 118 and `start_daemons_procd` at line 120; `stop_service()` starts at line 127.
- [RESULT] The script header contains the comment `# after network`, but this grep did not establish an explicit runtime wait for WAN readiness.
- [STATUS] No configuration changes made. Next inspection will target the compact `start_service()` block only.

## Zapret2 start_service audit — 2026-09-23
- [RESULT] `start_service()` directly calls `start_daemons_procd`, then applies firewall integration when `INIT_APPLY_FW=1`.
- [IMPORTANT] No explicit WAN/interface readiness wait is present in `start_service()` itself.
- [STATUS] This strengthens the startup-order/readiness hypothesis, but does not yet prove the exact failure point.
- [SAFETY] No configuration changes made.

## Zapret2 daemon startup-path audit — 2026-09-23
- [RESULT] `start_daemons_procd()` calls `standard_mode_daemons 1` and `custom_runner zapret_custom_daemons 1`; it contains no explicit WAN/interface readiness wait.
- [IMPORTANT] The remaining startup behavior is delegated to sourced Zapret2 functions, so changing the init script now would be premature.
- [STATUS] Diagnosis narrowed to the standard daemon/firewall startup path; no configuration changes made.

## Zapret2 standard daemon function location — 2026-09-23
- [RESULT] `standard_mode_daemons()` is defined at `/opt/zapret2/common/linux_daemons.sh:11`.
- [STATUS] Next inspection targets this small function; no configuration changes made.

## Zapret2 standard_mode_daemons audit — 2026-09-23
- [RESULT] `standard_mode_daemons()` only calls `standard_mode_nfqws $1`.
- [RESULT] `standard_mode_nfqws()` builds qnum/options, calls `filter_apply_hostlist_target opt`, then starts nfqws2 via `do_nfqws`.
- [IMPORTANT] No WAN/interface readiness wait is present in this daemon path.
- [STATUS] The next relevant function is `filter_apply_hostlist_target`; no configuration changes made.

## Zapret2 hostlist target function location — 2026-09-23
- [RESULT] `filter_apply_hostlist_target()` is defined at `/opt/zapret2/common/list.sh:24`.
- [STATUS] Next inspection targets this function only; no configuration changes made.

## Zapret2 filter_apply_hostlist_target audit — 2026-09-23
- [RESULT] In `MODE_FILTER=autohostlist`, the function sets `--hostlist-auto=$HOSTLIST_AUTO` and related auto-hostlist parameters; it also prepares `parm13=--hostlist=$HOSTLIST_AUTO`.
- [IMPORTANT] The displayed function portion ends before the final parameter assembly/assignment, so it is not yet safe to conclude whether `parm13` is applied to all traffic at startup.
- [STATUS] No configuration changes made; next inspection will fetch only the remaining lines of this function.

## Zapret2 hostlist parameter assembly — 2026-09-23
- [RESULT] `MODE_FILTER=autohostlist` builds two paths: normal hostlist-marked rules receive `--hostlist-auto=$HOSTLIST_AUTO` plus related parameters; `HOSTLIST_NOAUTO_MARKER` receives `--hostlist=$HOSTLIST_AUTO` via `parmNA`.
- [IMPORTANT] This behavior is deterministic and does not itself explain why manual restart differs from boot, because the same config is used after both starts.
- [STATUS] Hostlist substitution path is understood; no configuration changes made.

## Post-reboot lanif set audit — 2026-09-23
- [PASS] `nft list set inet zapret2 lanif` shows `elements = { "br-lan" }`.
- [IMPORTANT] Both interface sets are populated after reboot: `wanif=phy0-sta0`, `lanif=br-lan`.
- [STATUS] Empty/missing interface-set population is ruled out as the immediate cause; no configuration changes made.

## Post-reboot NFQUEUE rule counter check — 2026-09-23
- [RESULT] `nft list chain inet zapret2 postnat | grep -E 'queue|counter'` shows the expected IPv4 UDP/443 and TCP 80/443 NFQUEUE rules to queue 300.
- [LIMIT] The installed rules do not contain nftables `counter` statements, so this output cannot show whether a YouTube connection actually hit NFQUEUE.
- [STATUS] No configuration changes made; the direct traffic-hit question remains unresolved.

## Process timing diagnostic correction — 2026-09-23
- [INVALID COMMAND] The attempted `/proc/2206/stat` check failed because PID 2206 no longer exists; PID was from an earlier audit and is not persistent.
- [INVALID COMMAND] BusyBox `ps` on this router does not support `-o`; only the documented `w` wide-output option is available.
- [RESULT] No system state was changed by these failed diagnostics.
- [STATUS] Process timing check must use the current nfqws2 PID; no configuration changes made.

## Current nfqws2 PID audit — 2026-09-23
- [PASS] Current `nfqws2` process PID is `3573` and runs as user `daemon`.
- [IMPORTANT] Earlier PID 2206 was stale; process identity must not be assumed across restarts.
- [STATUS] No configuration changes made.

## nfqws2 process start tick — 2026-09-23
- [PASS] Current nfqws2 PID `3573` has `START_TICKS=109510` from `/proc/3573/stat` field 22.
- [STATUS] This gives the process start position relative to system boot; conversion to seconds requires the kernel clock tick rate (CLK_TCK), which has not yet been established.
- [STATUS] No configuration changes made.

## CLK_TCK diagnostic correction — 2026-09-23
- [BLOCKED] `getconf` is not installed on this OpenWrt BusyBox system; command returned `getconf: not found`.
- [STATUS] No package installation and no configuration changes.

## Diagnostic stop / simplified resolution path — 2026-09-23
- [DONE] Diagnostic expansion stopped by user request; no further timing/PID micro-tests planned.
- [FACT] Boot log shows zapret2 reaches nfqws2 startup, applies nftables, inserts IPv4 NFQUEUE rules for TCP/UDP, and exits startup without an error.
- [FACT] Same persistent configuration becomes functional immediately after manual `/etc/init.d/zapret2 restart`.
- [WORKING HYPOTHESIS] Boot-order/readiness race remains the simplest explanation; strategy selection is not being re-tested.
- [NEXT] Before changing autostart, inspect existing `/etc/rc.local` so any delayed post-boot restart can be added without overwriting existing user logic.

## rc.local audit — 2026-09-23
- [PASS] `/etc/rc.local` contains only the default comments and `exit 0`; no existing custom commands would conflict with a post-boot zapret2 action.
- [NEXT] A minimal delayed `zapret2 restart` can be considered as a workaround for the observed boot-order/readiness issue; no change made yet.

## Manual delayed restart confirmation — 2026-09-23
- [PASS] After waiting 20 seconds, manual `/etc/init.d/zapret2 restart` completed normally.
- [FACT] Restart recreated nfqws2 and the expected TCP 80/443 + UDP 443 NFQUEUE rules with qnum 300; no startup errors were reported.
- [STATUS] This reproduces the previously known working restart path. No persistent `rc.local` modification has been made.
- [NEXT] Verify functionality once after this restart before implementing any persistent delayed-start workaround.

## Delayed restart functional confirmation — 2026-09-23
- [PASS] After the delayed manual restart, router-side YouTube HTTPS test succeeded: `wget --timeout=15 -O /dev/null https://www.youtube.com/` downloaded `893226` bytes.
- [CONFIRMED] The same persistent zapret2 configuration is functional after a delayed restart; earlier immediate post-boot failure is therefore consistent with startup ordering/readiness rather than the selected desync strategies.
- [STATUS] Persistent autostart workaround has NOT yet been installed. `/etc/rc.local` remains unchanged.
- [NEXT] If user approves, implement the minimal persistent workaround: keep normal zapret2 autostart and add a delayed post-boot `/etc/init.d/zapret2 restart` via `/etc/rc.local`.

## Persistent delayed zapret2 restart installed — 2026-09-23
- [DONE] User approved and installed the persistent `/etc/rc.local` workaround.
- [CONFIG] After system init finishes, `rc.local` waits 20 seconds and runs `/etc/init.d/zapret2 restart`, then exits normally.
- [SCOPE] No zapret2 strategy, hostlist, NFQUEUE, or package configuration was changed.
- [NEXT] Reboot test is required to verify the workaround from a real cold boot/reboot; until then, startup workaround validation is pending.

## Cold-boot delayed restart validation — 2026-09-23
- [DONE] After reboot and SSH recovery, router-side YouTube HTTPS test succeeded without a manual zapret2 restart: `wget --timeout=15 -O /dev/null https://www.youtube.com/` downloaded `888457` bytes.
- [CONFIRMED] Persistent `/etc/rc.local` 20-second delayed `zapret2 restart` workaround fixes the previously observed post-boot failure.
- [RESULT] Zapret2 startup/boot workaround is functionally validated from a real reboot.


## Stage 6 closure — 2026-09-23
- [DONE] Zapret2 persistent autostart is enabled.
- [DONE] Boot-time readiness issue was reproduced: immediate post-boot YouTube failed while manual restart restored operation.
- [DONE] Minimal workaround installed in /etc/rc.local: sleep 20, then /etc/init.d/zapret2 restart.
- [DONE] Real reboot validation passed: YouTube HTTPS downloaded 888457 bytes without manual intervention.
- [DONE] Stage 6 is closed; no further Zapret2 strategy diagnostics are required unless a later regression appears.

## STAGE 7 current memory snapshot — 2026-09-23
- [PASS] RAM: total 54852 KiB, used 28408 KiB, free 19380 KiB, buff/cache 7064 KiB, available 10576 KiB.
- [PASS] Swap: total 550904 KiB, used 1612 KiB, free 549292 KiB.
- [PASS] Active swap devices: /dev/zram0 26620 KiB, priority 100; /dev/sda1 524284 KiB, priority -2.
- [FACT] ZRAM is prioritized above USB swap as intended.
- [STATUS] This is the current post-Zapret2/post-reboot operational memory snapshot, not a clean-base Stage 7 baseline.

## STAGE 8 current extroot audit — 2026-09-23
- [PASS] /dev/sda2 is mounted read-write at /overlay as ext4.
- [PASS] root filesystem uses overlayfs with upperdir=/overlay/upper and workdir=/overlay/work.
- [FACT] /mnt/data is not currently mounted according to the filtered mount output.
- [STATUS] Existing extroot is operational; no destructive USB changes are required. Stage 8 is treated as already implemented/verified in the current system state.

## STAGE 9 current ZRAM + USB swap audit — 2026-09-23
- [PASS] /dev/zram0 active, size 26620 KiB, priority 100, used 1612 KiB.
- [PASS] /dev/sda1 active as partition swap, size 524284 KiB, priority -2, used 0 KiB.
- [PASS] ZRAM has higher priority than USB swap; USB swap is available as fallback.
- [FACT] No swap is configured on /tmp in the observed state.
- [STATUS] Existing ZRAM + USB swap configuration is operational; no reconfiguration performed.


## STAGE 10 — DoH retirement — 2026-09-23
- [DECISION] DoH was explicitly abandoned by the user.
- [PASS] `/etc/init.d/https-dns-proxy status` returned `inactive`.
- [STATUS] STAGE 10 is SKIPPED/RETIRED and is not a pending configuration task.
- [RULE] Do not propose, install, enable, or test DoH/https-dns-proxy in the current Variant A sequence unless the user explicitly reopens this decision.


## Current stage map correction — 2026-09-23
- [DECISION] The old STAGE 12–20 SDK/build/dependency/NFQUEUE/Zapret2 sequence is historical and must not be repeated: Zapret2 is already installed, validated, persistent, and reboot-tested.
- [DECISION] STAGE 10 DoH is retired.
- [NEXT] The next applicable planned capability is STAGE 21 — WireGuard base.
- [RULE] Before configuring WireGuard, perform only the minimum read-only audit needed to establish the current WireGuard/package/kernel state. No installation or configuration change in the audit step.

## STAGE 21 WireGuard availability audit — 2026-09-23
- [RESULT] `command -v wg`, `command -v wg-quick`, and the filtered WireGuard module check produced empty output.
- [FACT] No `wg`/`wg-quick` executable was found in PATH and no matching loaded WireGuard kernel module was shown by the command.
- [STATUS] STAGE 21 remains IN_PROGRESS; this was a read-only availability check and made no changes.


## STAGE 21 — WireGuard retirement — 2026-09-23
- [DECISION] User explicitly abandoned the WireGuard stage because there is no free configuration/provider configuration available for the intended use.
- [STATUS] STAGE 21 is SKIPPED/RETIRED.
- [RULE] Do not install, configure, or test WireGuard unless the user explicitly reopens this decision.
- [NEXT] Continue to the next applicable stage without WireGuard.


## WARP reference from user's PC — 2026-09-23
- [REFERENCE] User reports Cloudflare One Client on PC is configured as “Traffic and DNS (HTTPS)” and appears to allow Telegram, WhatsApp, and torrent-related sites.
- [VERIFIED SEMANTICS] Cloudflare documents Traffic and DNS (HTTPS) as routing all device traffic through the WARP tunnel while encrypting DNS with DoH; this is not a DNS-only mode.
- [LIMIT] This is a working PC reference, not evidence that the same client can be installed on the hAP's MIPS OpenWrt environment.
- [RULE] Do not treat the PC configuration as a router implementation or install an unsupported Cloudflare client on hAP without an explicit, verified OpenWrt/MIPS-compatible method.


## STAGE 22 — WARP Free retirement after official compatibility check — 2026-09-23
- [CHECK] Current Cloudflare WARP documentation was reviewed.
- [FACT] Cloudflare's current Linux WARP client system requirements list x86-64/AMD64 and ARM64/AArch64 processors; MIPS is not listed.
- [FACT] Current WARP “Traffic and DNS” mode uses the WARP tunnel (MASQUE) for device traffic; DNS-only is a separate mode.
- [REFERENCE] User's PC uses Cloudflare One Client in “Traffic and DNS (HTTPS)” and reports Telegram, WhatsApp, and torrent-related sites work through that client.
- [DECISION] The PC behavior is retained as a reference configuration, but Stage 22 is skipped/retired for the hAP because the official client does not support its MIPS architecture.
- [RULE] Do not install unsupported third-party WARP binaries or substitute cloudflared for WARP: cloudflared is a Cloudflare Tunnel daemon, not the device-traffic WARP client.
- [STATUS] STAGE 22 — SKIPPED/RETIRED.
- [NEXT] STAGE 23 — Proton Free, subject to the same compatibility-first audit.


## Cloudflare One Client clarification — 2026-09-23
- [FACT] The previous OpenVPN availability command returned empty output; OpenVPN is not installed.
- [CLARIFICATION] That command did not itself test for Cloudflare One Client binaries.
- [OFFICIAL] Current Cloudflare One Client architecture uses the WARP daemon/service (warp-svc) plus warp-cli; Traffic and DNS mode routes device traffic through the encrypted tunnel and DNS through DoH. Current official Linux requirements list AMD64/x86-64 or ARM64/AArch64, not MIPS.
- [DECISION] The user's working Windows Cloudflare One Client setup remains a PC reference and is not directly available as an official hAP/MIPS client.


## STAGE 23 Proton Free package availability — 2026-09-23
- [PASS] OpenWrt package repository exposes `openvpn-openssl-2.7.6-r1`.
- [FACT] OpenVPN is not currently installed (`command -v openvpn` returned empty before this step).
- [DECISION] Proton Free router test will use OpenVPN, since WireGuard and WARP are retired for the current path.
- [RULE] Install only the core OpenVPN client first; do not add LuCI-specific packages unless needed.
- [STATUS] STAGE 23 remains IN_PROGRESS; no package has been installed yet in this step.


## STAGE 23 OpenVPN installation OOM — 2026-09-23
- [FAIL] `apk add openvpn-openssl` started installing dependencies but the process was killed during installation of `libopenssl3` at 47%.
- [FACT] Packages already reported as installed before termination include kmod crypto dependencies, kmod-udptunnel4/6, kmod-ovpn-backports, kmod-tun, libcap-ng, liblz4-1, liblzo2-2, libnl-core200, libnl-genl200 and libatomic1; `libopenssl3` installation was interrupted at the shown point.
- [IMPORTANT] The `Killed` result is consistent with the router's previously observed severe memory pressure; this is not treated as a successful OpenVPN installation.
- [SAFETY] Do not retry `apk add openvpn-openssl` blindly. First verify the post-abort package/system state with a minimal read-only check.
- [STATUS] STAGE 23 — IN_PROGRESS.


## STAGE 23 interrupted-installation state check — 2026-09-23
- [RESULT] `apk info | grep -E '^(openvpn-openssl|libopenssl3)'` returned empty output.
- [FACT] Neither `openvpn-openssl` nor `libopenssl3` is present in the installed-package database after the killed transaction.
- [FACT] Some dependency packages were reported installed before the interruption, so the transaction was partial and must not be assumed cleanly rolled back as a whole.
- [STATUS] STAGE 23 remains FAILED/PENDING recovery; no retry performed.


## STAGE 23 RAM/tmpfs storage hypothesis check — 2026-09-23
- [PASS] `/tmp` is a 26.8 MiB tmpfs with only 1.8 MiB used and 25.0 MiB available at the time of check.
- [PASS] `/overlay` has 6.2 GiB available; disk capacity is not the immediate constraint for the interrupted OpenVPN installation.
- [CONCLUSION] The observed process kill during `libopenssl3` installation is not explained by a nearly-full `/tmp` or `/overlay`; low available RAM remains the primary suspected cause.
- [STATUS] No cleanup or package changes performed in this step.


## STAGE 23 post-failure memory state — 2026-09-23
- [RESULT] After the interrupted OpenVPN installation, RAM: total 54852 KiB, used 31592 KiB, free 15184 KiB, buff/cache 8076 KiB, available 6932 KiB.
- [RESULT] Swap: total 550904 KiB, used 5988 KiB, free 544916 KiB.
- [IMPORTANT] Available RAM dropped from 10576 KiB before the installation attempt to 6932 KiB afterwards, while swap usage rose from 1612 KiB to 5988 KiB.
- [CONCLUSION] The data strongly supports memory pressure during the package transaction; `/tmp` and `/overlay` capacity were already confirmed sufficient.
- [SAFETY] Do not retry the OpenVPN installation while the current memory state remains this constrained.


## STAGE 23 temporary Zapret2 stop for memory recovery — 2026-09-23
- [ACTION] User ran `/etc/init.d/zapret2 stop` to temporarily release runtime memory before further package work.
- [RESULT] Zapret2 stopped cleanly; output shows `Clearing nftables` and conntrack liberal setting reset to 0.
- [SAFETY] Persistent Zapret2 configuration was not changed or removed; this is a runtime stop only.
- [NEXT] Measure current memory before any OpenVPN installation retry.


## STAGE 23 memory result after stopping Zapret2 — 2026-09-23
- [RESULT] After stopping Zapret2, RAM: total 54852 KiB, used 32172 KiB, free 13024 KiB, buff/cache 9656 KiB, available 5556 KiB.
- [IMPORTANT] Stopping Zapret2 did not increase available memory; Available decreased further from 6932 KiB to 5556 KiB in the observed snapshots.
- [CONCLUSION] Do not attribute the OpenVPN installation kill solely to Zapret2/nfqws2 RSS without further evidence.
- [NEXT] Verify whether the kernel recorded an OOM kill, using a compact filtered log check.


## STAGE 23 — kernel OOM confirmed during OpenVPN installation — 2026-09-23
- [CONFIRMED] Kernel log records `global_oom` at 13:33:19 and explicitly reports `Out of memory: Killed process 3533 (apk)`.
- [CONFIRMED] `apk` was killed during the `apk add openvpn-openssl` transaction; this is a kernel OOM event, not a package-manager error or `/tmp` capacity error.
- [RESULT] `netifd invoked oom-killer`; the OOM task was `apk` in the root memory cgroup.
- [CONCLUSION] The OpenVPN installation failure is definitively memory-pressure related. Available RAM before the failed transaction was already only 10.6 MiB and later fell to 6.9 MiB / 5.6 MiB in subsequent snapshots.
- [SAFETY] Do not retry the OpenVPN installation unchanged. First identify the largest current RAM consumers and determine a reversible way to create installation headroom.
- [STATUS] STAGE 23 — IN_PROGRESS.


## STAGE 23 RAM consumer audit — 2026-09-23
- [RESULT] Largest observed process RSS was `hostapd` 1480 KiB; `netifd` 1072 KiB; remaining listed processes were <=1028 KiB, including command-side `sort/head/ash` processes.
- [CONCLUSION] No single userspace process is consuming several MiB of RSS; the kernel OOM during `apk` installation likely involved overall low-memory conditions, kernel memory/cache/slab, and/or transient allocation pressure rather than one dominant daemon.
- [LIMIT] The command itself created small transient processes (`sort`, `head`, `ash`), so those entries are not meaningful persistent consumers.
- [NEXT] Inspect compact slab memory fields before deciding how to create installation headroom.


## STAGE 23 memory-pressure conclusion — 2026-09-23
- [RESULT] Slab = 8472 KiB; SReclaimable = 1200 KiB; SUnreclaim = 7272 KiB.
- [CONCLUSION] The hAP's very limited RAM is under substantial kernel-memory pressure. Combined with the confirmed global OOM killing `apk` during `libopenssl3` installation, the current hardware/runtime state does not provide a safe margin for installing the Proton OpenVPN stack.
- [USER CONSTRAINT] User explicitly requested no further diagnostic-test expansion.
- [DECISION] Do not continue probing RAM consumers or retry the same OpenVPN installation. The current Proton Free router path is treated as infeasible on this hAP unless a materially lighter, officially compatible approach is identified.
- [STATUS] STAGE 23 — IN_PROGRESS.
- [NEXT] STAGE 24 PBR depends on a VPN base, so it is also not actionable in the current path. Do not configure PBR until a supported VPN base is available.


## STAGE 23 alternate OpenVPN package path — 2026-09-23
- [NEW OPTION] Official OpenWrt 25.12.5 MIPS package feed contains `openvpn-mbedtls-2.7.6-r1` alongside `openvpn-openssl-2.7.6-r1`.
- [RATIONALE] The failed OpenSSL variant was killed by kernel global OOM while installing `libopenssl3`. The mbedTLS variant avoids the `libopenssl3` dependency path and is therefore the preferred next installation candidate on this 64-MiB router.
- [DECISION] Do not retry `openvpn-openssl`. A single controlled attempt of `openvpn-mbedtls` is justified before closing Proton Free as infeasible.
- [SAFETY] This is a package substitution, not a guarantee that installation will succeed; no VPN configuration will be applied yet.
- [STATUS] STAGE 23 remains IN_PROGRESS pending the lighter OpenVPN package attempt.


## STAGE 23 mbedTLS package switch blocked by apk world state — 2026-09-23
- [RESULT] `apk add openvpn-mbedtls` failed because apk reports a conflict between `openvpn-mbedtls-2.7.6-r1` and the world requirement `openvpn-openssl`.
- [FACT] Earlier interrupted `apk add openvpn-openssl` left an `openvpn-openssl` world entry even though `apk info` did not report the package as installed.
- [CONCLUSION] The mbedTLS attempt is blocked by residual apk package-selection state, not by a package incompatibility or a new RAM failure.
- [NEXT] Remove only the stale `openvpn-openssl` world requirement, then attempt the mbedTLS package once. No broad package cleanup or cache purge yet.


## STAGE 23 OpenVPN successful installation — 2026-09-23
- [CORRECTION] The earlier OpenVPN installation was not conclusively failed as a package-installation outcome; the user subsequently reran `apk add openvpn-openssl` and the full transaction completed successfully.
- [PASS] `openvpn-openssl-2.7.6-r1` installed successfully, including `libopenssl3` and required dependencies.
- [PASS] Final apk output: `OK: 20.8 MiB in 176 packages`.
- [FACT] The previous kernel OOM event did occur during an earlier installation attempt, but the same package installation later succeeded. Therefore OOM is a transient/conditions-dependent risk, not a definitive blocker for OpenVPN on this router.
- [DECISION] Keep `openvpn-openssl`; do not switch to or install `openvpn-mbedtls`, because the OpenSSL variant is now installed and the two variants conflict.
- [STATE] Zapret2 was intentionally stopped before the successful installation attempt and remains stopped until explicitly restarted.
- [STATUS] STAGE 23 — IN_PROGRESS.
- [NEXT] Proceed to obtaining/validating a Proton Free OpenVPN configuration; do not perform another package-installation experiment.


## STAGE 23 Proton OpenVPN configuration generation — 2026-09-23
- [USER INPUT] Proton account page offers Platform=Router and OpenVPN config generation for Free servers.
- [OFFICIAL] Proton documents router connections as available on Proton Free when the router supports OpenVPN or WireGuard. citeturn466218search3
- [OFFICIAL] For OpenVPN, Proton recommends UDP unless there is a concrete reason to use TCP; TCP can be a fallback if UDP cannot connect. citeturn466218search8
- [DECISION] First controlled config: Platform=Router, OpenVPN=UDP, VPN Accelerator=ON, NAT-PMP/port forwarding=OFF. Port forwarding is a paid-plan feature and is not needed for ordinary VPN egress. citeturn466218search0turn466218search1
- [SERVER] Use Proton's currently displayed recommended Free server `US-FREE#130` for the first test; do not treat the selected server as a permanent preference.
- [NEXT] Generate and download the `.ovpn` file. No router configuration change until the exact file is inspected.


## STAGE 23 Proton configuration type selected — 2026-09-23
- [DECISION] For the hAP test, use **OpenVPN configuration files**, not WireGuard configuration.
- [REASON] WireGuard is retired for this project; the installed router client is `openvpn-openssl`.
- [NEXT] Generate/download the Proton Free `.ovpn` configuration for the Router platform, starting with UDP.


## STAGE 23 Proton `.ovpn` inspection — 2026-09-23
- [PASS] User provided a Proton OpenVPN configuration for the Router platform using `proto udp` and multiple fallback remote ports.
- [FACT] The supplied file's header explicitly references exit server `NL-FREE#130` and provides the corresponding username suffix; this conflicts with the earlier UI selection shown by the user as `US-FREE#130`.
- [FACT] The config uses `auth-user-pass`, so the router will require Proton's separate OpenVPN username/password, not the normal Proton account password. citeturn726966search0turn726966search3
- [SAFETY] Do not expose or paste OpenVPN credentials into chat. Do not modify the embedded CA or tls-crypt material.
- [NEXT] Before creating the router-side instance, use the exact downloaded `.ovpn` file and resolve/confirm the server identity from the file; no routing or firewall changes yet.


## STAGE 23 Proton `.ovpn` repository file verified — 2026-09-23
- [PASS] The user stored `nl-free-130.protonvpn.udp (1).ovpn` in the project GitHub repository; the exact file was fetched successfully.
- [PASS] File contents match the previously supplied Proton Router OpenVPN configuration: `proto udp`, remote 185.107.56.133 with fallback ports 4569/5060/80/51820/1194, embedded CA and `tls-crypt`, and `auth-user-pass`.
- [IDENTITY] The downloaded file is for the `NL-FREE#130` configuration family, as stated in its header and filename.
- [SECURITY] The file does not contain the user's OpenVPN password; credentials must remain outside the repository/chat.
- [NEXT] Copy this exact configuration to `/etc/openvpn/` on the hAP. Do not yet enable it as the default WAN route or alter firewall/PBR.


## STAGE 23 Proton `.ovpn` copied to hAP — 2026-09-23
- [PASS] Created `/etc/openvpn` and downloaded `proton-nl-free-130.ovpn` from the repository raw URL.
- [PASS] Router reports `Download completed (5101 bytes)`.
- [FACT] The router now has the exact Proton NL-FREE#130 UDP configuration file at `/etc/openvpn/proton-nl-free-130.ovpn`.
- [SAFETY] OpenVPN has not been started, default routing has not been changed, and firewall/PBR have not been modified.
- [NEXT] Configure Proton OpenVPN credentials locally on the router without exposing them in chat.


## STAGE 23 Proton credentials file creation — 2026-09-23
- [STATE] User opened `/etc/openvpn/proton.auth` in `vi`; screen shows an empty one-page buffer, so credentials have not yet been entered/saved.
- [SECURITY] OpenVPN credentials remain local to the router and are not requested in chat.
- [NEXT] User must enter the Proton OpenVPN username on line 1 and OpenVPN password on line 2, save, and exit `vi`.


## STAGE 23 Proton credentials structural verification pending — 2026-09-23
- [STATE] User reports credentials were entered into `/etc/openvpn/proton.auth`.
- [SECURITY] Credential contents must not be displayed in chat.
- [NEXT] Verify only that the file has exactly two non-empty lines, without revealing values.


## STAGE 23 Proton credentials correction — 2026-09-23
- [RESULT] Structural check found 3 non-empty lines in `/etc/openvpn/proton.auth`; expected exactly 2.
- [ACTION] Remove only lines 3 and onward, preserving the first two credential lines.
- [SECURITY] Credential values remain undisclosed.


## STAGE 23 Proton credentials line correction result — 2026-09-23
- [RESULT] `sed -i '3,$d' /etc/openvpn/proton.auth` completed with empty output.
- [STATUS] The third and later lines were removed; first two credential lines were preserved.
- [SECURITY] Do not print the password into chat. For verification, display the username locally and only password length/masked representation.


## STAGE 23 Proton credentials correction required — 2026-09-23
- [FAIL] Structural verification showed the stored username is exactly one character (`i`); this is not the expected Proton-generated OpenVPN username.
- [FACT] Proton states that OpenVPN username/password are separate credentials found under Account → OpenVPN username, distinct from the normal Proton account credentials. citeturn626998search0turn626998search1
- [SECURITY] Password must not be pasted into chat.
- [NEXT] User will retrieve the dedicated OpenVPN username/password from Proton and replace both lines in `/etc/openvpn/proton.auth`.
- [STATUS] STAGE 23 — IN_PROGRESS, credentials correction pending.


## STAGE 23 Proton credentials corrected by user — 2026-09-23
- [USER CONFIRMATION] User states the Proton OpenVPN username and password in `/etc/openvpn/proton.auth` have now been entered correctly.
- [SECURITY] Credentials are not displayed or copied into chat.
- [NEXT] Perform one masked structural check before starting OpenVPN.
- [STATUS] STAGE 23 — IN_PROGRESS.


## STAGE 23 Proton credentials structural verification — 2026-09-23
- [PASS] `/etc/openvpn/proton.auth` now contains exactly two credential lines with username length 16 and password length 32.
- [SECURITY] Actual credential values remain undisclosed.
- [NEXT] Run a non-routing OpenVPN handshake test using the exact Proton `.ovpn` plus the local auth file; do not make VPN the default route yet.


## STAGE 23 Proton OpenVPN handshake attempt — 2026-09-23
- [RESULT] OpenVPN 2.7.6 starts successfully on MIPS/OpenWrt using OpenSSL 3.5.7 and DCO kernel support.
- [RESULT] The client resolved/selected Proton endpoint `185.107.56.133:4569` over UDP and opened the UDP link.
- [LIMIT] The supplied output stops before TLS/authentication or `Initialization Sequence Completed`; therefore VPN authentication success is not yet established.
- [SAFETY] `--route-nopull` was used, so this test is not intended to replace the router's default route.
- [STATUS] STAGE 23 — IN_PROGRESS; handshake result pending from the same process.


## STAGE 23 Proton UDP TLS handshake failure — 2026-09-23
- [FAIL] The Proton `NL-FREE#130` UDP OpenVPN test did not complete TLS negotiation: after 60 seconds OpenVPN reported `TLS key negotiation failed` and `TLS handshake failed`, then rotated to fallback UDP port 80/1194.
- [IMPORTANT] This result does not by itself prove ISP/TSPU blocking, incorrect credentials, or certificate/time failure; it only proves that the TLS handshake did not complete over the tested UDP endpoints.
- [CORRECTION] Do not manually convert the UDP `.ovpn` by changing `proto` and ports. Use Proton's separately generated TCP OpenVPN configuration instead.
- [NEXT] Stop the current OpenVPN process, then obtain/use the official Proton TCP Router `.ovpn` for the same Free server family before another connection test.


## STAGE 23 Proton TCP fallback selected — 2026-09-23
- [DECISION] Because the official Proton NL-FREE#130 UDP configuration reached the server address but never completed TLS negotiation, test Proton's separately generated TCP configuration next.
- [OFFICIAL] Proton states UDP is recommended generally, but TCP uses port 443 and is the fallback when UDP cannot connect; TCP can also help on networks where UDP VPN traffic is blocked. citeturn757013search0turn757013search9
- [RULE] Do not manually edit the UDP `.ovpn` to convert it to TCP; download Proton's official TCP Router configuration.
- [NEXT] Generate/download the TCP Router `.ovpn` for `NL-FREE#130` and provide/store that exact file before another router-side test.


## STAGE 23 Proton TCP `.ovpn` verified — 2026-09-23
- [PASS] Repository file `nl-free-130.protonvpn.tcp.ovpn` fetched successfully.
- [PASS] Configuration uses `proto tcp` with Proton endpoints `185.107.56.133:8443`, `:7770`, and `:443` and `remote-random`.
- [IDENTITY] Header explicitly identifies the `NL-FREE#130` exit configuration family.
- [PASS] Embedded CA and `tls-crypt` blocks are present; `auth-user-pass` is retained for the local credentials file.
- [DECISION] Use the official TCP file unchanged for the next connection test; do not manually rewrite ports or protocol.
- [NEXT] Copy the exact TCP file to `/etc/openvpn/` on the hAP. Keep `--route-nopull` for the first connectivity test so the existing default route is preserved.


## STAGE 23 Proton TCP `.ovpn` copied to hAP — 2026-09-23
- [PASS] Downloaded official `nl-free-130.protonvpn.tcp.ovpn` to `/etc/openvpn/proton-nl-free-130-tcp.ovpn`.
- [PASS] Router reports `Download completed (5047 bytes)`.
- [SAFETY] No OpenVPN process started and no routing/firewall/PBR changes performed in this step.
- [NEXT] Run a controlled TCP OpenVPN handshake test using the existing local credentials and `--route-nopull`.


## STAGE 23 Proton TCP handshake interpretation — 2026-09-23
- [CORRECTION] `TCP connection established` proves only successful TCP establishment to the Proton endpoint; it does not by itself prove DPI/TSPU blocking.
- [RESULT] The official TCP config already includes port 443. The hAP successfully established TCP to `185.107.56.133:443`, but OpenVPN TLS negotiation still timed out.
- [CONCLUSION] The generic recommendation to simply change `8443` to `443` is not applicable because the official config already tested 443 and the failure persisted at the OpenVPN TLS layer.
- [NEXT] Stop the automatic OpenVPN retry loop before selecting the next controlled test.


## STAGE 23 assessment of Proton TCP failure — 2026-09-23
- [ANALYSIS] With Zapret2 stopped, the official Proton TCP configuration established TCP connections to `185.107.56.133:8443` and `:443`, but no OpenVPN TLS handshake completed within 60 seconds.
- [CORRECTION] This does not prove that Russian ISP/TSPU DPI is responsible. OpenVPN's own troubleshooting documentation lists multiple possible causes for TLS key-negotiation timeout, including reachability/port/server-side filtering and incorrect connection parameters. citeturn695236search0turn695236search1
- [CORRECTION] The suggestion to simply switch `8443` to `443` is not applicable to the official TCP file, because the file already contains `remote ... 443`, and the 443 TCP connection itself was established before the TLS timeout.
- [IMPORTANT] Because Zapret2 was stopped during this test, the failure cannot currently be attributed to the Zapret2 NFQUEUE/desync path.
- [STATUS] STAGE 23 remains IN_PROGRESS; no conclusion of ISP/DPI blocking has been recorded as fact.


## STAGE 23 Proton integration target — 2026-09-23
- [DECISION] User's goal is to determine whether Proton VPN can be integrated into the hAP, not merely installed as a standalone client.
- [ARCHITECTURE] Target design: Proton OpenVPN as a separate `tun*` VPN interface; keep the existing Archer/Wi-Fi WAN as the ordinary underlay/default path initially.
- [ARCHITECTURE] Do not make Proton the default route during initial validation. First establish the tunnel, verify the assigned VPN state, and only then consider selective routing.
- [NEXT LOGIC] If the tunnel becomes functional, use OpenWrt PBR/netifd mechanisms to route selected hosts/subnets/domains through the Proton interface while leaving other traffic on the normal WAN. OpenWrt PBR explicitly supports VPN split-tunneling and unmanaged OpenVPN `tun*` interfaces. citeturn184409search5turn184409search9
- [LIMIT] Current blocker is upstream of integration: the Proton OpenVPN TLS handshake has not completed on the tested NL-FREE#130 UDP and TCP configurations.
- [OFFICIAL] Proton supports router connections on Proton Free and provides an OpenWrt OpenVPN procedure. citeturn184409search0turn184409search6
- [STATUS] STAGE 23 — IN_PROGRESS.


## STAGE 23 Proton server-isolation test selected — 2026-09-23
- [DECISION] To determine whether the NL-FREE#130 TLS failure is server-specific or affects the Proton Free OpenVPN path generally, test one alternate Free server only.
- [SERVER] Use `US-FREE#130`, because this was the server shown as Proton's selected/recommended Free server in the user's earlier account-page output.
- [CONTROL] Keep protocol and configuration method unchanged for comparability: official Router OpenVPN TCP configuration; do not manually edit the file.
- [LIMIT] This is not a claim that US-FREE#130 is objectively better; it is a controlled server-variable test.
- [NEXT] Generate/download the official TCP Router `.ovpn` for `US-FREE#130` and upload it to the GitHub repository. No router changes yet.


## STAGE 23 Proton US-FREE#115 TCP config verified — 2026-09-23
- [PASS] Repository file `us-free-115.protonvpn.tcp.ovpn` fetched successfully.
- [IDENTITY] The file explicitly identifies `US-FREE#115`.
- [PASS] Configuration uses `proto tcp` with endpoints `84.20.27.33:8443`, `:443`, and `:7770`.
- [CONTROL] This is an alternate Free server test; the server variable changed from NL-FREE#130 to US-FREE#115 while keeping TCP OpenVPN unchanged.
- [NEXT] Copy the official file unchanged to `/etc/openvpn/` and test it with the existing local Proton credentials and `--route-nopull`.


## STAGE 23 Proton US-FREE#115 TCP config copied to hAP — 2026-09-23
- [USER RESULT] User reports the official `us-free-115.protonvpn.tcp.ovpn` file was copied to the hAP at `/etc/openvpn/proton-us-free-115-tcp.ovpn`.
- [CONTROL] No protocol/package change; only the Proton Free server was changed from NL-FREE#130 to US-FREE#115.
- [SAFETY] No default-route, firewall, or PBR changes have been made for this test.
- [NEXT] Run one controlled OpenVPN TCP handshake test with `--route-nopull` using the existing local credentials.


## STAGE 21 WireGuard reopened after Proton Free verification — 2026-09-23
- [CORRECTION] Earlier retirement of WireGuard was based on the assumption that Proton Free did not provide manual WireGuard configurations. That assumption is now corrected.
- [OFFICIAL] Proton's current documentation explicitly states that Free users can generate WireGuard configuration files for third-party WireGuard clients, including router clients. On Free, VPN Accelerator is the available VPN option during configuration. citeturn891093search0turn891093search9
- [DECISION] Reopen STAGE 21 and prefer Proton Free WireGuard as the router VPN candidate over OpenVPN, because Proton itself recommends WireGuard for OpenWrt unless there is a strong reason to use OpenVPN. citeturn891093search9
- [STATUS] STAGE 21 — IN_PROGRESS.
- [NEXT] Generate one official Proton Free WireGuard `.conf` for the Router platform; no hAP package/configuration changes yet.


## STAGE 21 Proton Free WireGuard config audit — 2026-09-23
- [PASS] User generated and uploaded `wg-NL-FREE-128.conf`; configuration identifies Proton `NL-FREE#128`, VPN Accelerator=on, NAT-PMP off, Bouncing=1.
- [PASS] WireGuard interface parameters are structurally coherent: `Address=10.2.0.2/32`, DNS `10.2.0.1`, peer endpoint `185.107.56.235:51820`, `PersistentKeepalive=25`, full-tunnel AllowedIPs for IPv4/IPv6.
- [SECURITY INCIDENT] The uploaded repository file contains a WireGuard `PrivateKey`. It must be treated as compromised because it was placed in a GitHub repository. Do not use that key/configuration for the router.
- [ACTION REQUIRED] Delete the exposed config from GitHub and generate a fresh Proton WireGuard configuration with a new private key. Never paste the new private key into chat or the repository.
- [STATUS] STAGE 21 — IN_PROGRESS, blocked on credential regeneration.
- [NEXT] After a fresh config is generated, inspect only non-secret fields and then install the minimum WireGuard packages on hAP.


## STAGE 21 fresh Proton Free WireGuard config — 2026-09-23
- [PASS] User supplied a sanitized fresh Proton WireGuard configuration for `NL-FREE#128`; the private key was intentionally omitted from chat.
- [PASS] Safe fields: `Address=10.2.0.2/32`, `DNS=10.2.0.1`, peer endpoint `185.107.56.235:51820`, `AllowedIPs=0.0.0.0/0, ::/0`, `PersistentKeepalive=25`; VPN Accelerator=on, NAT-PMP off, Bouncing=1.
- [SECURITY] The actual private key must remain only on the user's local machine/router and must never be committed to GitHub or pasted into chat.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [PENDING SECURITY] Previously uploaded `wg-NL-FREE-128.conf` containing the old private key still needs deletion from GitHub; do not reuse that exposed key.
- [NEXT] Verify availability of the minimum WireGuard packages in the current OpenWrt package feed; no router configuration change yet.


## STAGE 21 WireGuard package availability — 2026-09-23
- [PASS] Official OpenWrt package feed exposes `kmod-wireguard-6.12.94-r1` and `wireguard-tools-1.0.20260223-r1` for the current system.
- [AVAILABLE] `luci-proto-wireguard`, `rpcd-mod-wireguard`, and a Prometheus WireGuard exporter are also available, but they are not required for the first controlled tunnel test.
- [DECISION] Install only `kmod-wireguard` and `wireguard-tools`; keep the configuration CLI-based to minimize RAM/package footprint.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [PENDING SECURITY] Previously uploaded WireGuard config containing an old private key must be deleted from GitHub and not reused.


## STAGE 21 exposed WireGuard config cleanup check — 2026-09-23
- [PASS] Previous `wg-NL-FREE-128.conf` is no longer found in the repository (GitHub fetch returned 404).
- [SECURITY] The exposed old private key is no longer present in the current default-branch file path; the old config must not be reused.
- [NEXT] Install only the minimum WireGuard runtime packages: `kmod-wireguard` and `wireguard-tools`.


## STAGE 21/22 AWG assessment — 2026-09-23
- [OFFICIAL AMNEZIA] AmneziaWG on OpenWrt requires a compatible AmneziaWG server/configuration; Amnezia's official OpenWrt guide describes using AmneziaWG 1.5/2.0 with Amnezia Self-hosted and notes OpenWrt native support for 1.5/2.0 from 24.10.3. citeturn927064search1turn927064search0
- [FACT] The Proton Free config generated by the user is standard WireGuard and contains no AmneziaWG-specific parameters (`S3`, `S4`, `I1`). Proton documents its third-party configs as standard WireGuard implementations. citeturn927064search6
- [CONCLUSION] AWG cannot be substituted transparently for the Proton Free WireGuard server; Proton would need to support the corresponding AmneziaWG protocol/configuration. No evidence of that support has been established.
- [PACKAGE STATUS] A third-party custom OpenWrt package feed currently publishes AWG-2.0 packages for OpenWrt 25.12.5, including all supported targets, but this is not the official OpenWrt package feed and therefore falls under the project's 'no unverified packages' constraint. citeturn953970search0turn953970search2
- [DECISION] Do not install AWG packages from the third-party feed solely to connect to Proton. Continue with standard Proton WireGuard as the direct Proton integration candidate.
- [ALTERNATIVE] AWG remains a separate future path only if a compatible AWG server/configuration is available; it would be a different VPN provider/server path, not a Proton Free endpoint.


## STAGE 21 WireGuard packages installed — 2026-09-23
- [PASS] User completed `apk add kmod-wireguard wireguard-tools` successfully.
- [RESULT] Final apk state reported `OK: 21.0 MiB in 181 packages`.
- [FACT] Standard WireGuard kernel module and userspace tools are now installed on the hAP.
- [SECURITY] Fresh Proton private key remains outside chat/GitHub and has not been written into the router yet.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [NEXT] Create the router-side WireGuard configuration locally using the fresh Proton NL-FREE#128 parameters; do not enable default routing yet.


## STAGE 21 WireGuard config directory correction — 2026-09-23
- [RESULT] `/etc/wireguard` does not exist yet, so `vi /etc/wireguard/proton.conf` could not open the target path.
- [FACT] WireGuard packages are installed, but the configuration directory/file has not been created.
- [NEXT] Create `/etc/wireguard` only; no configuration or routing changes yet.


## STAGE 21 WireGuard config directory created — 2026-09-23
- [USER RESULT] `/etc/wireguard` was created successfully; no output indicates normal completion of `mkdir -p`.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [NEXT] Create the Proton WireGuard config locally with restrictive file permissions (`0600`); the private key must stay only on the router and must not appear in chat/GitHub.


## STAGE 21 Proton WireGuard local config created — 2026-09-23
- [USER RESULT] Fresh Proton WireGuard configuration was written locally to `/etc/wireguard/proton.conf` with `umask 077`.
- [SECURITY] PrivateKey was entered only on the router and was not shared in chat or GitHub.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [NEXT] Perform a metadata-only validation of file permissions and required sections; do not print the private key or full config.


## STAGE 21 WireGuard validation command correction — 2026-09-23
- [RESULT] The long metadata-only `awk` command was not executed; the shell entered continuation prompt `>` because the pasted command was incomplete/line-wrapped.
- [FACT] No WireGuard configuration was changed by this failed command entry.
- [DECISION] Replace the oversized validation command with a shorter one to respect the user's compact-command preference.


## STAGE 21 concise WireGuard config validation — 2026-09-23
- [NEXT] After the interrupted oversized `awk` entry, use a compact validation that checks file permissions and required WireGuard fields while masking the private key.
- [RULE] Do not print the private key or upload the fresh Proton WireGuard config to GitHub.


## STAGE 21 WireGuard config permissions correction — 2026-09-23
- [PASS] `/etc/wireguard/proton.conf` contains the required Interface/Peer fields; `PrivateKey` is set and masked in verification output.
- [SECURITY ISSUE] File mode is `0644` (`-rw-r--r--`), which is too permissive for a WireGuard private key.
- [ACTION] Change only the file mode to `0600`; do not alter configuration contents or private key.
- [NEXT] After chmod, verify permissions only, then proceed to controlled tunnel activation.


## STAGE 21 WireGuard permissions corrected — 2026-09-23
- [RESULT] `chmod 600 /etc/wireguard/proton.conf` completed with no output.
- [STATE] The Proton WireGuard config permissions are now expected to be restricted to root; content remains unchanged.
- [NEXT] Verify mode only, without exposing configuration contents.


## STAGE 21 WireGuard config permission verification — 2026-09-23
- [PASS] `/etc/wireguard/proton.conf` is mode `0600`, owned by `root:root`.
- [PASS] Required Proton WireGuard fields were previously verified; private key remains undisclosed.
- [STATUS] STAGE 21 — IN_PROGRESS.
- [NEXT] Start a route-isolated WireGuard test: bring up the Proton interface with routing disabled so the existing default WAN remains unchanged.


## STAGE 21 route-isolated WireGuard test preparation — 2026-09-23
- [DECISION] User approved creating a separate test copy of the Proton WireGuard config.
- [SAFETY] Original `/etc/wireguard/proton.conf` will remain unchanged.
- [TEST DESIGN] The test copy will contain `Table = off` in `[Interface]`, preventing wg-quick from installing the full-tunnel routes during the first handshake test.
- [NEXT] Create `/etc/wireguard/proton-test.conf` from the current config and set mode 0600.


## STAGE 21 route-isolated WireGuard test copy created — 2026-09-23
- [RESULT] `/etc/wireguard/proton-test.conf` created from the fresh Proton config and modified only by adding `Table = off` under `[Interface]`.
- [PASS] Test copy permissions set to `0600`.
- [SAFETY] Original `/etc/wireguard/proton.conf` remains unchanged; no default route was changed during preparation.
- [NEXT] Bring up `proton-test` with `wg-quick`; first test must remain route-isolated.


## STAGE 21 `wg-quick` correction — 2026-09-23
- [RESULT] `/bin/ash` reports `wg-quick: not found` when attempting to bring up the route-isolated test config.
- [CORRECTION] OpenWrt's supported WireGuard integration uses netifd with `proto wireguard`; `wireguard-tools` supplies `wg` and a netifd protocol helper rather than requiring `wg-quick`. citeturn894353search2turn894353search9
- [DECISION] Do not install another package solely to obtain `wg-quick`.
- [NEXT] Perform a temporary runtime-only WireGuard handshake using `wg`/`ip`, with no routes added. The persistent UCI configuration will be created only after handshake success.


## STAGE 21 WireGuard runtime interface created — 2026-09-23
- [RESULT] `ip link add proton type wireguard && ip addr add 10.2.0.2/32 dev proton && ip link set proton up` completed with empty output.
- [PASS] Temporary WireGuard interface `proton` now exists and is up with address `10.2.0.2/32`.
- [SAFETY] No routes were added and the default WAN route was not changed during this step.
- [NEXT] Load the Proton peer/private-key parameters from the local protected config into the temporary `proton` interface; private key will not be printed.


## STAGE 21 WireGuard peer load attempt — 2026-09-23
- [RESULT] The runtime `wg set` command did not complete cleanly: shell returned `You have stopped jobs.` and the prompt returned.
- [UNKNOWN] Do not assume the Proton private key/peer was successfully applied to `proton`.
- [SAFETY] No route was intentionally added by the attempted command.
- [NEXT] Verify the current WireGuard runtime state with a compact `wg show proton`; do not expose the private key.


## STAGE 21 WireGuard runtime peer state verified — 2026-09-23
- [RESULT] `wg show proton` confirms the temporary `proton` interface has a local public key and a hidden private key loaded.
- [RESULT] Proton peer public key: `ocCFVEDN+6fTFKg96mQ6fW+oBTTZ9gW6xEk8gxTiR1E=`; endpoint `185.107.56.235:51820`; AllowedIPs `0.0.0.0/0, ::/0`; PersistentKeepalive 25s.
- [RESULT] Runtime reports `2.31 KiB sent, 0 B received`; no `latest handshake` is shown.
- [STATUS] WireGuard tunnel handshake is NOT established yet. This is not sufficient evidence to diagnose the cause.
- [SAFETY] No default route has been added; normal WAN remains the underlay.
- [NEXT] Verify the ordinary routing path to the Proton endpoint before changing any WireGuard settings.


## STAGE 21 Underlay route verification — 2026-09-23
- [RESULT] `ip route get 185.107.56.235` resolves via `192.168.0.1` on `phy0-sta0`, source `192.168.0.100`.
- [PASS] The Proton WireGuard endpoint has a normal underlay route through the Archer-side WAN/STA path.
- [STATUS] No WireGuard handshake yet; routing to the endpoint is not the current missing prerequisite.
- [NEXT] Verify that the local private key in the protected Proton config derives to the same public key currently loaded on `proton`, without printing the private key.


## STAGE 21 WireGuard key consistency verified — 2026-09-23
- [RESULT] Deriving the public key from the private key stored in `/etc/wireguard/proton.conf` produced `NH0oKZdjcC0rLTF4cW6qYWygVGihaujnr0Fxl35SBSI=`.
- [PASS] This exactly matches the public key reported for runtime interface `proton` by `wg show proton`.
- [CONCLUSION] The loaded local keypair is internally consistent; no key mismatch is indicated.
- [NEXT] Generate one controlled packet through `proton` to force a WireGuard handshake, using only a temporary tunnel-local route and removing it in the same command.


## STAGE 21 WireGuard handshake trigger — 2026-09-23
- [RESULT] A one-packet `ping` to `10.2.0.1` via temporary route on `proton` transmitted 1 packet and received 0; the temporary route was then targeted for deletion.
- [RESULT] Shell again reported `You have stopped jobs.` after the test, so the command wrapper is not suitable for further combined route/test/cleanup sequences.
- [STATUS] No successful Proton WireGuard handshake has been demonstrated yet.
- [CAUTION] Do not infer the cause from the ping failure alone; `10.2.0.1` need not answer ICMP. The keypair and endpoint underlay are already verified.
- [NEXT] Check WireGuard's handshake state directly with a compact `wg show` output.


## STAGE 21 WireGuard no-response state — 2026-09-23
- [RESULT] Repeated `wg show proton` after the handshake trigger shows transfer increased to `7.52 KiB sent`, while `0 B received` remains and no `latest handshake` appears.
- [CONCLUSION] WireGuard is actively transmitting handshake/keepalive traffic, but no peer response has been observed.
- [NOT YET DIAGNOSED] Do not label this as ISP/DPI/Proton-side blocking solely from this result; the remaining possibilities still include endpoint-specific connectivity/configuration issues.
- [NEXT] Check whether UDP/51820 to the exact Proton endpoint is reachable at the socket level, without changing routes or tunnel configuration.


## STAGE 21 Tool availability check — 2026-09-23
- [RESULT] `command -v nc` -> `/usr/bin/nc`; `command -v tcpdump` returned empty.
- [IMPACT] BusyBox/netcat is available, but packet capture is not available for a direct observation of UDP/51820 responses.
- [NEXT] Check basic IP reachability of the exact Proton endpoint before considering UDP-specific causes.


## STAGE 21 Proton endpoint IP reachability verified — 2026-09-23
- [RESULT] `ping -c 1 -W 3 185.107.56.235` succeeded: 1/1 reply, 0% packet loss, RTT 70.955 ms.
- [CONCLUSION] The exact Proton endpoint IP is reachable over the ordinary underlay path.
- [STATUS] WireGuard still has `0 B received` and no handshake despite transmitted traffic; the unresolved issue is now specific to the WireGuard/UDP path or peer/configuration, not basic IP reachability.
- [NEXT] Inspect the local Proton WireGuard configuration fields while excluding `PrivateKey`, `DNS`, and any secret material from output.


## STAGE 21 Proton config fields verified — 2026-09-23
- [RESULT] Safe fields from `/etc/wireguard/proton.conf` match the runtime peer: `Address 10.2.0.2/32`, peer public key `ocCFVEDN+6fTFKg96mQ6fW+oBTTZ9gW6xEk8gxTiR1E=`, `AllowedIPs 0.0.0.0/0, ::/0`, endpoint `185.107.56.235:51820`, keepalive 25s.
- [CONCLUSION] No mismatch is visible between the local Proton config and the runtime WireGuard peer parameters.
- [STATUS] Handshake remains unestablished (`0 B received`).
- [NEXT] Determine whether the endpoint's UDP port is being rejected/filtered on the path, using the available BusyBox `nc` tool; this is only a transport probe and will not alter routing.


## STAGE 21 BusyBox nc limitation — 2026-09-23
- [RESULT] `nc -u -z -v -w 3 ... 51820` returned BusyBox usage because this `nc` only supports `nc [IPADDR PORT]`.
- [CORRECTION] Do not repeat GNU/OpenBSD `nc` UDP-option syntax on this router.
- [STATUS] No new network conclusion from this probe; WireGuard remains without a received handshake.
- [NEXT] Use WireGuard's own compact handshake timestamp/status output instead of an unsupported UDP netcat probe.


## STAGE 21 Handshake timestamp confirmed absent — 2026-09-23
- [RESULT] `wg show proton latest-handshakes` returns the Proton peer public key with timestamp `0`.
- [CONFIRMED] No WireGuard handshake has ever been received by the runtime interface during the current test.
- [CONTEXT] Local keypair consistency, Proton peer parameters, endpoint underlay route, and ICMP reachability to `185.107.56.235` are already verified.
- [NEXT] Inspect the existing firewall ruleset for UDP handling before making any firewall change.


## STAGE 21 Firewall inspection — 2026-09-23
- [RESULT] Ruleset grep shows no explicit rule for UDP/51820 or UDP/52235 and shows the standard fw4 `ct state established, related` accepts for inbound/forwarded/outbound flows.
- [CONCLUSION] No evidence from this compact inspection justifies changing firewall policy yet.
- [SAFETY] Firewall configuration remains untouched.
- [NEXT] Inspect the complete fw4 output chain to verify how locally generated WireGuard UDP packets are handled before any change.


## STAGE 21 Methodology correction: AllowedIPs / routing isolation — 2026-09-23
- [USER CONCERN ACKNOWLEDGED] A Proton config containing `AllowedIPs = 0.0.0.0/0, ::/0` must not be brought up with `wg-quick` for an isolated test unless route creation is explicitly disabled (e.g. `Table = off`). Upstream `wg-quick` infers routes from AllowedIPs and treats a default route specially; `Table = off` disables route creation. This is documented in the upstream `wg-quick` manual.
- [FACTUAL DISTINCTION] That route-changing path was NOT used on this OpenWrt router because `wg-quick` is unavailable. We manually created `proton`, assigned `10.2.0.2/32`, and used `wg set` to load the peer. `wg set` configures runtime WireGuard parameters; it does not itself install kernel routes. OpenWrt's native netifd route behavior is controlled separately via `route_allowed_ips`.
- [PERSISTENT CONFIG] `/etc/wireguard/proton.conf` was not modified by the runtime `wg set` commands. The separate `proton-test.conf` copy with `Table = off` remains only a local test artifact.
- [ROUTING STATE] The previously verified route to Proton endpoint remained `via 192.168.0.1 dev phy0-sta0`; no default route switch to `proton` was intentionally performed.
- [PROCESS CORRECTION] Before any persistent WireGuard integration, first use an isolated native OpenWrt/netifd configuration or an explicit `Table = off` test copy. Never bring the original Proton full-tunnel config up blindly on this small router.


## STAGE 21 fw4 output chain verified — 2026-09-23
- [RESULT] `inet fw4 output` has policy `accept`.
- [RESULT] Locally generated traffic is accepted on loopback; established/related is accepted; traffic leaving via `eth1` or `phy0-sta0` is passed to `output_wan`.
- [CONCLUSION] The top-level output policy does not itself block locally generated WireGuard handshake traffic.
- [NEXT] Inspect `output_wan` only, because that is the chain actually handling local traffic sent via the Archer-side underlay `phy0-sta0`.


## STAGE 21 fw4 output_wan chain verified — 2026-09-23
- [RESULT] `inet fw4 output_wan` contains only `jump accept_to_wan`.
- [CONCLUSION] The WAN-specific output chain does not itself impose an additional block; WireGuard handshake traffic leaving through `phy0-sta0` is passed to `accept_to_wan`.
- [NEXT] Inspect `accept_to_wan` to verify its exact rule set before changing anything.


## STAGE 21 fw4 accept_to_wan verified — 2026-09-23
- [RESULT] `inet fw4 accept_to_wan` drops only IPv4 `ct state invalid` on `eth1`/`phy0-sta0`; the following rule explicitly accepts WAN IPv4/IPv6 traffic on those interfaces.
- [CONCLUSION] The hAP fw4 WAN output path is not an obvious blocker for locally generated WireGuard UDP handshake traffic.
- [SAFETY] No firewall rule was changed.
- [STATUS] WireGuard handshake remains absent despite: valid local keypair, matching peer parameters, reachable endpoint IP, and permissive WAN output policy.
- [NEXT] Stop expanding firewall inspection and move to a controlled endpoint/peer validation outside the hAP, because the remaining evidence no longer points to local routing or fw4 output filtering.


## STAGE 21 Evidence threshold reached — 2026-09-23
- [RESULT] `/proc/net/nf_conntrack` shows UDP flow `192.168.0.100:52235 -> 185.107.56.235:51820` with `packets=160` sent and `packets=0` received, state `[UNREPLIED]`.
- [CONCLUSION] The hAP is transmitting WireGuard UDP packets toward the Proton endpoint, but no UDP response is arriving back to `192.168.0.100:52235` during the observation period.
- [CORRELATION] This matches `wg show proton`: increasing sent bytes, `0 B received`, and `latest-handshakes=0`.
- [ALREADY VERIFIED] Local keypair consistency, peer public key, endpoint/AllowedIPs/keepalive, underlay route, endpoint ICMP reachability, and fw4 WAN output acceptance.
- [PROCESS] Diagnostic expansion is intentionally STOPPED here to avoid excessive tests. No firewall changes, route changes, or persistent WireGuard changes were made.
- [STATUS] Stage 21 WireGuard tunnel integration remains BLOCKED at handshake establishment. The evidence is sufficient to pause router-side troubleshooting and later perform a single controlled external/Proton-side validation if needed.


## STAGE 21 Resume: clock prerequisite check — 2026-09-23
- [PROCESS] Stage 21 diagnostics resumed at the user's request, still one command at a time and without broadening into multiple probes.
- [NEXT] Check the hAP system clock because WireGuard handshakes depend on valid time-based cryptographic state; this is a prerequisite check before externalizing the diagnosis.


## STAGE 21 Clock check — 2026-09-23
- [RESULT] Router reports `Wed Sep 23 15:10:22 GMT 2026`.
- [OBSERVATION] At the same point in the session the actual user-local time is 15:10 at UTC+5, i.e. approximately 10:10 UTC. Therefore the router's displayed time is approximately 5 hours ahead of UTC, not merely a local-time display difference.
- [SIGNIFICANCE] WireGuard puts a current TAI64N timestamp into handshake initiation; gross clock skew is therefore a relevant prerequisite to correct, although this evidence alone does not prove it is the cause of the missing handshake. OpenWrt documents BusyBox NTP as the normal time-synchronization mechanism.
- [SAFETY] No clock/configuration change has been made yet.
- [NEXT] Inspect the current OpenWrt NTP client configuration once, then decide on a minimal time-sync correction.


## STAGE 21 NTP configuration verified — 2026-09-23
- [RESULT] `uci show system.ntp` confirms the standard OpenWrt NTP client is enabled (`enabled='1'`), NTP server mode disabled, with the four default `openwrt.pool.ntp.org` servers.
- [OFFICIAL CONTEXT] OpenWrt documents this exact `system.ntp` structure for the built-in NTP client and notes that `busybox-ntpd` is the standard synchronization mechanism. citeturn228382search0turn228382search1
- [ISSUE] Despite the client being enabled, the previously observed router clock is approximately 5 hours ahead of UTC.
- [NEXT] Perform the minimal runtime action of restarting the existing `sysntpd` service, without changing the persistent NTP configuration, then re-check the clock.


## STAGE 21 Clock assessment corrected — 2026-09-23
- [CORRECTION] The previous assessment that the hAP clock was approximately 5 hours ahead was incorrect. The router's `date` output showed `15:10`, matching the user's actual wall-clock time of approximately 15:10; the `GMT` label indicates the configured/displayed timezone name and is not by itself evidence that the underlying clock/epoch is wrong.
- [CONCLUSION] Do NOT treat the clock as the cause of the missing WireGuard handshake based on the `date` output alone.
- [ACTION] No NTP restart or time-setting change was performed; persistent NTP configuration remains untouched.
- [STATUS] The prior WireGuard evidence remains: endpoint IP reachable, underlay route valid, WAN output accepted, peer/key parameters match, but handshake timestamp remains `0` and conntrack is `[UNREPLIED]`.


## STAGE 21 External control test planned — 2026-09-23
- [PROCESS] Router-side diagnostic expansion is paused after reaching the evidence threshold.
- [NEXT] Use the same freshly generated Proton WireGuard configuration as a control test on the user's Windows PC, preferably from the same Archer-side Internet connection. Do not paste or upload the private key.
- [DIAGNOSTIC PURPOSE] If the identical config handshakes on the PC, the investigation returns to the hAP/OpenWrt WireGuard implementation/path. If it also fails on the PC, the evidence for an upstream/protocol/Proton-endpoint issue becomes materially stronger. This is a comparative test, not a claim of ISP/TSPU blocking.


## STAGE 21 Control-test limitation and alternate path — 2026-09-23
- [RESULT] External Windows control test is not available because Proton is inaccessible on the user's PC in the user's current region; do not require it.
- [CONTEXT] Earlier Proton OpenVPN TCP testing to `185.107.56.235` reached TCP but did not complete TLS; this is consistent with, but does not prove, protocol/path filtering.
- [DECISION] Do not continue broad WireGuard/firewall diagnostics on the hAP without new evidence.
- [NEXT] Use the previously prepared Proton OpenVPN `US-FREE#115` profile as a single alternate-endpoint control test. Its result has not yet been recorded, so it must not be assumed to work.


## STAGE 21 Proton clean-config branch closed — 2026-09-23
- [USER RESULT] User confirms that clean Proton VPN configurations do not work in the current environment; no further endpoint-by-endpoint Proton config testing is desired.
- [VERIFIED] Official Proton router documentation currently supports router setup using WireGuard or OpenVPN. Proton's app-specific protocols/features include Stealth and Smart Protocol; they are not presented as standard router `.conf` protocols in the official OpenWrt guides. Source: https://protonvpn.com/support/openwrt-wireguard and https://protonvpn.com/support/how-to-set-up-protonvpn-on-openwrt-routers
- [CONCLUSION] Do not continue retrying clean Proton WireGuard/OpenVPN configurations on the hAP as the primary troubleshooting path.
- [STATUS] Stage 21 Proton WireGuard integration: BLOCKED. Stage 23 Proton OpenVPN fallback: BLOCKED based on previously recorded failed TLS tests.
- [SAFETY] Existing local Proton configs remain untouched; no firewall/routing changes were made from this branch.
- [NEXT ARCHITECTURAL QUESTION] Select an actual obfuscated/transported VPN architecture or an external VPN gateway if Proton-through-hAP remains mandatory. Do not install unverified third-party obfuscation packages without a separate compatibility/source review.


## STAGE 21 Finalize current Proton attempt — 2026-09-23
- [STATUS] Proton clean WireGuard/OpenVPN integration on the hAP is BLOCKED in the current network/environment.
- [EVIDENCE] WireGuard runtime sent repeated UDP traffic to the Proton endpoint but received no response and never recorded a handshake. Earlier OpenVPN UDP/TCP profiles also failed to complete TLS.
- [PROTOCOL LIMIT] Official Proton router guidance currently exposes WireGuard and OpenVPN for OpenWrt; Stealth/Smart Protocol are app-side protocol/features rather than alternate router `.conf` transports. citeturn705764search0turn705764search1turn705764search8
- [DECISION] Stop endpoint/config cycling for Proton on this hAP. Keep local Proton configuration files for future use; do not expose or upload private keys/credentials.
- [NEXT] Remove only the temporary runtime `proton` interface; do not delete the persistent `/etc/wireguard/proton.conf` or alter routing/firewall.


## STAGE 21 Temporary Proton interface removed — 2026-09-23
- [RESULT] `ip link delete proton` completed with empty output.
- [PASS] The temporary WireGuard runtime interface used for the isolated Proton test is removed.
- [PRESERVED] Persistent `/etc/wireguard/proton.conf` remains untouched; no firewall or route configuration was changed by the removal.
- [STATUS] Stage 21 Proton WireGuard integration remains `BLOCKED` for the current network/environment.
- [NEXT] Do not continue Proton endpoint cycling. Return to the main project roadmap; before the next VPN architecture, account for current Zapret2 state (it was previously stopped for VPN testing and has not been assumed running).


## ZAPRET2 resumed after Proton branch — 2026-09-23
- [RESULT] `/etc/init.d/zapret2 restart` restarted zapret2 successfully enough to launch `nfqws2`, apply nftables, and insert the expected IPv4 TCP/UDP NFQUEUE rules at qnum 300.
- [OBSERVATION] Restart output contains an intermediate `Command failed: Not found`, but the daemon launch and subsequent nftables application completed; this did not abort the service startup.
- [ACTIVE CONFIG] TCP 80: `fake:blob=fake_default_http:tcp_md5` + `multisplit:pos=method+2`; TCP 443: `hostfakesplit:ip_ttl=3:repeats=1`; UDP 443: `fake:blob=fake_default_quic:repeats=1`; `hostlist-auto` for TCP and hostlist for QUIC; qnum 300.
- [PROCESS] No additional functional traffic tests are being started yet; first verify the init service status compactly.


## ZAPRET2 operational status confirmed — 2026-09-23
- [RESULT] `/etc/init.d/zapret2 status` returns `running` after the restart.
- [STATUS] Zapret2 is active again with the previously recorded working configuration; no further Zapret2 diagnostics are required at this point.
- [PROJECT] The clean Proton VPN branch remains `BLOCKED`; the temporary WireGuard interface has been removed and persistent Proton config preserved.
- [NEXT] Do not spend additional router-side tests on the already-established Proton failure. The next VPN step should be an architecture choice compatible with the hAP's MIPS/OpenWrt constraints.


## Proton recommendations reassessed — 2026-09-23
- [CORRECTION 1] The suggestion to change Proton TCP from port 8443 to 443 does not add a new test in the current project state. Earlier recorded testing already established TCP connections to `185.107.56.133:443` as well as `:8443`; both reached TCP but TLS handshake timed out. The official Proton OpenVPN TCP configuration path uses port 443. citeturn553566search6
- [CORRECTION 2] The suggested command `openvpn ... --proto tcp --mssfix 1360` is not a valid MTU diagnostic for this TCP OpenVPN test. OpenVPN's official 2.7 manual states `--mssfix` is meaningful for UDP peer-to-peer transport, not OpenVPN TCP. It is intended for path-MTU problems where a VPN connection starts and then stalls, not for a TLS handshake that never completes. citeturn553566search9turn553566search10
- [AWG] AmneziaWG is a separate protocol/implementation and requires an AmneziaWG-compatible server/config; it cannot simply consume a standard Proton WireGuard config. Current Amnezia documentation also uses third-party OpenWrt installation material rather than presenting standard Proton configs as AmneziaWG configs. citeturn553566search2
- [DECISION] Do not modify the existing Proton TCP `.ovpn` file just to switch 8443→443, and do not add `--mssfix` to the TCP test. The previously recorded evidence is stronger than either proposed change.


## FREE VPN candidates for hAP — 2026-09-23
- [CURRENT RESEARCH] For a router-based free VPN, the service must provide a manual WireGuard/OpenVPN configuration usable by a third-party client.
- [CANDIDATE] hide.me Free is currently the clearest candidate: free plan offers unlimited data, 8 locations, 1 simultaneous connection, and WireGuard is available on Free. hide.me also publishes OpenWrt setup documentation and a WireGuard configuration-file workflow. OpenVPN manual files remain Premium-only. citeturn910070search0turn910070search1turn910070search16
- [CANDIDATE/SECONDARY] VPN Gate is a free public relay system with downloadable OpenVPN configurations, including TCP/UDP endpoints. It is not a conventional commercial free VPN account; relay servers are community-operated, so availability, speed and trust characteristics can vary. citeturn621577search0turn621577search1
- [EXCLUDED] Privado Free currently allows WireGuard through its own app, but its manual WireGuard configuration generator is Premium-only; therefore it does not meet the router/manual-config requirement on the free tier. citeturn113494search5turn113494search10
- [EXCLUDED] Windscribe's WireGuard configuration files are currently a paid-account feature. citeturn113494search12
- [EXCLUDED] Cloudflare WARP is not a suitable direct client for this hAP: current official Linux requirements list AMD64/x86-64 or ARM64/AArch64, not MIPS. citeturn910070search11
- [DECISION] Do not install anything yet. First candidate for a single controlled router test is hide.me Free via WireGuard, provided the user can obtain the free WireGuard configuration. No claim is made yet that hide.me works from the user's ISP/RF network.


## Free VPN assessment corrected — 2026-09-23
- [CORRECTION] hide.me Free officially provides WireGuard configuration generation, but hide.me states that free users cannot use third-party OpenVPN clients; manual OpenVPN files require a paid plan. Therefore the earlier candidate table must not list free manual OpenVPN for hide.me. citeturn856534search0turn856534search1turn856534search6
- [RESOURCE NUANCE] Do not claim that 64 MB RAM makes OpenVPN categorically impossible. This hAP has already installed `openvpn-openssl` successfully after an earlier package-install OOM; the remaining question would be runtime resource use, not package-install feasibility. No new RAM test is requested.
- [AMNEZIA] Amnezia Free is currently advertised as free and uses AmneziaWG 3.1. However, Amnezia's current router documentation says routers do not yet support AmneziaWG 3.1 and router setup continues to use AmneziaWG 2.0; Amnezia says 3.1 configs cannot be converted to 2.0. Therefore Amnezia Free is not currently a clean official route to this hAP. citeturn228280search6turn228280search3
- [FREE ROUTER CANDIDATE] VPN Gate remains the notable truly free manual OpenVPN option. Its live public VPN list currently exposes OpenVPN configurations over TCP 443 on some relays. It is a community relay network, not a private commercial free tier; server availability and trust characteristics vary, and the site currently states a 2-week logging policy. citeturn228280search8
- [DECISION] For a truly free router experiment, VPN Gate is the only candidate worth considering before paid/self-hosted options, but it is standard OpenVPN rather than an obfuscated VPN and therefore is not assumed to bypass the user's network filtering.


## AntiZapret architecture assessment — 2026-09-23
- [VERIFIED] The current public AntiZapret site advertises a free selective-bypass VPN for routers: only resources from the Russian blocklist are proxied, while other traffic remains direct. The current public VPN download presented on the site is an OpenVPN profile. citeturn604273view0
- [VERIFIED] Current self-hosted AntiZapret-VPN implementations support split tunneling plus WireGuard and AmneziaWG. One current implementation explicitly says WireGuard uses UDP 51080/51443 and AmneziaWG uses 52080/52443; it also recommends AmneziaWG if the provider blocks standard WireGuard. citeturn275509search0turn374306search1
- [ARCHITECTURE] A public free AntiZapret selective VPN and a self-hosted AntiZapret server are different offerings. The self-hosted WG/AWG implementation is not a free public VPN service: it requires an external server.
- [RESOURCE] Do not describe OpenVPN on the 64 MB hAP as categorically impossible. The router already installed `openvpn-openssl`; the practical concern is runtime RAM/CPU headroom alongside Zapret2, not protocol impossibility.
- [DECISION] AntiZapret remains a meaningful architecture candidate because selective routing fits the project's goal. For zero-cost use, the realistic public service path is its OpenVPN profile; for obfuscated WG/AWG, self-hosting requires a server. No router changes made.


## AntiZapret public free VPN confirmed — 2026-09-23
- [VERIFIED] Current official AntiZapret page explicitly recommends its VPN method for Android/iOS, computers, and routers and links the free `antizapret-tcp.ovpn` profile. citeturn871685view1
- [VERIFIED] The service states that only sites from the Russian unified blocklist are proxied while other sites go directly; this matches the project's desired selective-routing architecture. citeturn871685view1
- [DECISION] AntiZapret public VPN/OpenVPN becomes the primary zero-cost VPN candidate for this project. It is distinct from Proton/hide.me because the service itself is specifically built for selective access to blocked resources.
- [STATUS] No AntiZapret router configuration has yet been applied or changed. Zapret2 remains `running`.
- [NEXT] Obtain/use the public `antizapret-tcp.ovpn` profile on the hAP as a controlled OpenVPN test. Do not combine the first test with permanent routing changes; preserve the current OpenWrt WAN as fallback.


## AntiZapret profile download from hAP failed — 2026-09-23
- [RESULT] Router command `wget -qO /tmp/antizapret-tcp.ovpn https://antizapret.prostovpn.org/antizapret-tcp.ovpn` failed with `SSL error: SSL - The connection indicated an EOF`.
- [IMPORTANT] This is a failure to download the public profile over HTTPS from the hAP's BusyBox wget; it is NOT evidence that the AntiZapret VPN tunnel itself fails.
- [WEB VERIFICATION] The current AntiZapret page still advertises the VPN method for routers and links the `antizapret-tcp.ovpn` profile. The web fetcher could not parse the profile directly because its content type is `application/x-openvpn-profile`, but the page confirms the profile exists. citeturn742447view0
- [PROCESS] Avoid further router-side HTTPS/client permutations. The practical next step is to obtain the public profile outside the hAP (browser/PC/phone) and transfer only the `.ovpn` file to the router; it contains service connection parameters and must be treated as untrusted external configuration until inspected.


## AntiZapret OpenVPN profile safety gate — 2026-09-23
- [USER] User downloaded the public `antizapret-tcp.ovpn` profile and asks whether it is safe to use.
- [ASSESSMENT] The profile is a public service configuration, not a personal credential file. However, a downloaded OpenVPN profile should be reviewed before execution because directives such as routes, DNS options, scripts, or other client directives can change router behavior. OpenWrt's OpenVPN documentation explicitly treats the client profile as configuration that must be reviewed/adjusted to the server before use. citeturn379838search0turn379838search3
- [SAFETY] Do not copy the profile into `/etc/openvpn`, enable OpenVPN, or change routing/firewall yet.
- [NEXT] Inspect the actual downloaded `antizapret-tcp.ovpn` content before running it. User may upload the file for direct review; do not expose or run any embedded secret material without need.


## AntiZapret TCP profile inspected — 2026-09-23
- [FILE REVIEW] User supplied the downloaded `antizapret-tcp.ovpn`; static inspection completed before any router execution.
- [PROFILE] Uses `client`, `dev tun`, `proto tcp`, `remote v.31337.lol`, `remote-cert-tls server`, `cipher AES-128-CBC`, optional `data-ciphers AES-128-GCM:AES-256-GCM:AES-128-CBC`, `resolv-retry infinite`, `persist-key`, `persist-tun`.
- [SECURITY] The profile embeds a client certificate and a corresponding private key whose certificate subject is `antizapret-client-shared`; the private key is shared by design in the public profile. It is not a user-specific password/key, but it still must not be uploaded to the project's GitHub repo or reused for unrelated services.
- [INTEGRITY] Local cryptographic inspection confirmed the embedded private key matches the embedded client certificate. Certificate validity in the supplied file is 2023-03-12 through 2033-03-09.
- [SCRIPT AUDIT] No active `script`, `up`, `down`, `plugin`, or `auth-user-pass` directive is present. The DNS helper examples are commented out. `setenv FRIENDLY_NAME` is metadata, not an executable hook.
- [ROUTING] The static file contains no explicit `redirect-gateway`, `route`, or `route-ipv6` directives. Server-pushed options may still change routes/DNS when the client connects; therefore the profile must not be enabled persistently until pushed options are inspected.
- [TRANSPORT] `proto tcp` is explicit; no port is specified on the `remote` line, so OpenVPN's default port behavior applies unless server-pushed/other configuration changes it.
- [DECISION] Profile is acceptable for a controlled test, but not yet for permanent OpenWrt integration. Preserve current WAN/Zapret2 fallback and inspect runtime server-pushed options before accepting routing/DNS changes.


## Cloudflare One Client gateway architecture — 2026-09-23
- [VERIFIED] Current Cloudflare One Client `Traffic and DNS (HTTPS)` uses MASQUE/HTTP3 as the default tunnel transport; current client docs state MASQUE is the default and describe the WireGuard/MASQUE choices. citeturn762714search2turn762714search13
- [VERIFIED] Current Cloudflare desktop/Linux builds support AMD64/x86-64 and ARM64/AArch64, not MIPS. Linux client uses `warp-cli` and currently defaults to MASQUE. citeturn425871search5turn425871search3
- [ARCHITECTURE CANDIDATE] Use an x86-64 PC/Linux VM as a WARP gateway: official Cloudflare One Client runs there in MASQUE mode; the hAP remains a pure router and sends only selected destinations to the gateway. The gateway NATs those selected flows into WARP. This is an experimental network topology, not an officially documented Cloudflare router-gateway mode; forwarded-traffic behavior must be validated before adoption.
- [ALTERNATE] Cloudflare One Client Local proxy mode exists on Windows/Linux/macOS, uses MASQUE, listens on `127.0.0.1` (default port 40000), supports HTTP/SOCKS5 proxy-aware applications, and has a 10-second request timeout. Therefore it is unsuitable as a transparent router-wide gateway and would require an additional proxy relay on the PC plus proxy/transparent handling on the hAP. citeturn834584search0
- [RECOMMENDATION] Prefer the x86-64 VM gateway architecture over trying to port WARP to MIPS or building a transparent proxy chain on the 64 MB hAP. Keep the existing Windows Cloudflare One Client untouched; use a separate VM only if this architecture is pursued.
- [STATUS] No hAP configuration changes made. Zapret2 remains `running`. Proton branches remain `BLOCKED`.


## WireGuard-over-zapret2 reassessment — 2026-09-23
- [USER REQUEST] Return to the WireGuard path and investigate whether zapret2 can desync the Proton WireGuard handshake.
- [OFFICIAL FINDING] bol-van's current zapret2 includes `init.d/custom.d.examples.linux/50-wg4all`, specifically described as desyncing WireGuard handshake initiation, response, and cookie packets. Its default action uses `--payload=wireguard_initiation,wireguard_response,wireguard_cookie` plus a fake blob repeated twice; firewall matching is based on WireGuard packet lengths/types, not UDP port 443. citeturn884219search4
- [IMPORTANT] The suggested `NFQWS_OPT_DESYNC_UDP="--desync-split-pos=2"` is rejected as the proposed implementation. zapret documentation states UDP cannot be fragmented at the transport layer; current zapret2's WireGuard-specific example instead identifies WireGuard payload types and applies fake desync. citeturn129770search3turn884219search4
- [COMPATIBILITY] The official example notes it is intended for original WireGuard and that the special `@ih` matching requires nft 1.0.1+ and a sufficiently recent kernel; the hAP is on OpenWrt 25.12.5/kernel 6.12.94, so compatibility is plausible but must be checked on the installed v1.0.3 files before applying changes. citeturn884219search4
- [PROCESS] Preserve the current working Zapret2 HTTP/TLS/QUIC configuration. Do not modify `NFQWS2_OPT` or firewall rules until the locally installed `50-wg4all` example is confirmed and reviewed.


## WireGuard 50-wg4all example presence — 2026-09-23
- [RESULT] `test -f /opt/zapret2/init.d/custom.d.examples.linux/50-wg4all` returned `PRESENT` twice (the terminal input appears duplicated, but the file existence check passed).
- [PASS] The official WireGuard-specific zapret2 example is present in the installed local v1.0.3 tree.
- [STATUS] No configuration or runtime behavior was changed by this check.
- [NEXT] Inspect the example's active/non-commented lines before adapting it to the existing Proton WireGuard test.


## WireGuard 50-wg4all local rule audit — 2026-09-23
- [RESULT] Installed `/opt/zapret2/init.d/custom.d.examples.linux/50-wg4all` exactly contains the dedicated WireGuard desync example.
- [MECHANISM] It defines `NFQWS_OPT_DESYNC_WG` as `--payload=wireguard_initiation,wireguard_response,wireguard_cookie` with `fake:blob=0x00000000000000000000000000000000:repeats=2`, creates a dedicated `DNUM_WG4ALL` and `QNUM_WG4ALL`, and installs three UDP match rules for WireGuard message lengths/types 156/100/72.
- [IMPORTANT] It does not replace the existing Zapret2 TCP 80/TCP 443/QUIC configuration; it is an additional custom daemon/firewall path when loaded by the custom.d mechanism.
- [SAFETY] No Zapret2 configuration or runtime state was changed by this inspection.
- [NEXT] Verify the installed nft version/feature level before applying the example, because its nft path uses `@ih` payload matching.


## WireGuard 50-wg4all nft prerequisite verified — 2026-09-23
- [RESULT] `nft --version` returns `nftables v1.1.6 (Commodore Bullmoose #7)`.
- [PASS] This satisfies the local `50-wg4all` example's `@ih` nft payload-matching prerequisite; the router is also running kernel 6.12.94, well above the example's stated recent-kernel requirement. citeturn884219search4
- [STATUS] No runtime or persistent configuration changed.
- [NEXT] Verify how the installed zapret2 loads `custom.d` examples before making any configuration change, so the official `50-wg4all` path is integrated without disturbing the working TCP/443 and QUIC configuration.

## SYNC CHECKPOINT — 2026-09-23 16:00 +05:00 — current conversation boundary
- [SYNC] Recorded from the user's latest message before any new router command is executed.
- [CONFIRMED] Latest router-side command actually reported by the user: nft --version.
- [PASS] Reported output: nftables v1.1.6 (Commodore Bullmoose #7).
- [RESULT] nftables 1.1.6 is the currently established nft runtime version on the hAP.
- [CONTEXT] This version is compatible with the planned 50-wg4all integration review; no configuration change was authorized or performed from the version check alone.
- [NEXT PENDING DIAGNOSTIC] Previously proposed read-only command to determine how installed Zapret2 connects custom.d is pending user execution: grep -nE 'custom\.d|custom_d|zapret_custom_' /etc/init.d/zapret2 /opt/zapret2/init.d/* 2>/dev/null | head -30
- [IMPORTANT] The pending command is PROPOSED/PENDING, not EXECUTED; its output is not yet known.
- [SAFETY] No router configuration, firewall/nftables rules, Zapret2 config, WireGuard config, or service state was changed by this synchronization.
- [STATUS] Current diagnostic gate remains IN_PROGRESS; wait for the factual output of the pending command before issuing another router command.
- [DOCUMENTATION] This checkpoint follows the project rule: after each user+assistant pair, synchronize factual state in the Master Plan; update the Master Prompt when the workflow/safety rule itself changes.

## SYNC CHECKPOINT — 2026-09-23 — Zapret2 custom.d hook audit
- [PASS] Executed read-only grep against /etc/init.d/zapret2 and /opt/zapret2/init.d/*.
- [RESULT] Only matching line: /etc/init.d/zapret2:73: custom_runner zapret_custom_daemons 1.
- [IMPORTANT] No literal custom.d/custom_d path was found by this filtered search.
- [RESULT] The installed init script invokes the function/hook name zapret_custom_daemons through custom_runner.
- [LIMIT] This result identifies the hook invocation but does not yet establish where zapret_custom_daemons is defined or whether/how it maps to custom.d files.
- [SAFETY] Read-only inspection only; no Zapret2, nftables, WireGuard, firewall, or service state was changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.
- [NEXT PENDING INSPECTION] Locate the definition/source path for custom_runner and zapret_custom_daemons before any configuration change.

## SYNC CHECKPOINT — 2026-09-23 — continuation gate
- Previous read-only audit result has been recorded: /etc/init.d/zapret2 invokes `custom_runner zapret_custom_daemons 1` at line 73.
- No router configuration was changed in the preceding step.
- [STATUS] Diagnostic gate remains IN_PROGRESS.
- [NEXT STEP] Locate the definitions of `custom_runner` and `zapret_custom_daemons`; read-only inspection only.

## SYNC CHECKPOINT — 2026-09-23 — Zapret2 custom hook definitions located
- [PASS] Read-only grep located `custom_runner()` in `/opt/zapret2/common/custom.sh:1`.
- [PASS] The installed Zapret2 tree contains example custom daemon hooks implementing `zapret_custom_daemons()`:
  - `/opt/zapret2/init.d/custom.d.examples.linux/20-fw-extra`
  - `/opt/zapret2/init.d/custom.d.examples.linux/40-webserver`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-stun4all`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-wg4all`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-dht4all`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-discord-media`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-quic4all`
  - `/opt/zapret2/init.d/custom.d.examples.linux/50-nfqws-ipset`
- [RESULT] The installed package has a dedicated `common/custom.sh` implementation plus a Linux custom.d examples directory; the exact loader/source selection behavior of `custom_runner()` still needs inspection.
- [IMPORTANT] `50-wg4all` is present in the installed examples, but it has NOT been enabled or copied into the active custom.d path and no configuration change was made.
- [SAFETY] Read-only inspection only; no Zapret2/nftables/WireGuard/firewall/service state changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — custom_runner implementation confirmed
- [PASS] Read-only inspection of `/opt/zapret2/common/custom.sh` completed.
- [RESULT] `custom_runner()` returns immediately when `DISABLE_CUSTOM=1`.
- [RESULT] Otherwise it checks `[ -d "$CUSTOM_DIR/custom.d" ]` and requires that directory to be non-empty.
- [RESULT] It iterates over every regular file in `"$CUSTOM_DIR/custom.d/"*`, unsets the target function, sources the script, then invokes the function when present.
- [IMPORTANT] Therefore active custom scripts are loaded from `${CUSTOM_DIR}/custom.d/`; the remaining unknown is the actual runtime value of `CUSTOM_DIR` and whether the desired `50-wg4all` example is intended to be copied/enabled there.
- [SAFETY] No Zapret2, nftables, WireGuard, firewall, or service configuration was changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.
- [NEXT PENDING INSPECTION] Determine the current `CUSTOM_DIR` value and active `${CUSTOM_DIR}/custom.d` contents before any enablement action.

## SYNC CHECKPOINT — 2026-09-23 — CUSTOM_DIR probe result
- [RESULT] User entered `${CUSTOM_DIR}/custom.d/` at the shell prompt.
- [OBSERVED] Shell expanded an unset/empty `CUSTOM_DIR` to `/custom.d/`, producing `-ash: /custom.d/: not found`.
- [IMPORTANT] This does NOT prove the Zapret2 runtime variable `CUSTOM_DIR` is permanently unset; it only shows that the interactive shell currently has no value for that environment variable.
- [CORRECTION] The previous pending question remains: determine where/how Zapret2 defines `CUSTOM_DIR` for the init process, and inspect the active custom.d directory safely.
- [SAFETY] No configuration or service state was changed; this was an unsuccessful interactive probe only.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — diagnostic scope reduced
- [USER FEEDBACK] User asked whether the number of tests is excessive.
- [WORKFLOW UPDATE] Agreed to reduce diagnostic fragmentation: from this point, combine closely related read-only checks into one compact command where practical, avoid redundant tests, and stop once the required fact is established.
- [STATUS] Zapret2 custom hook diagnosis remains IN_PROGRESS.
- [NEXT] Use one consolidated read-only search for `CUSTOM_DIR` definitions/references, then decide from the result rather than adding speculative probes.

## SYNC CHECKPOINT — 2026-09-23 — CUSTOM_DIR runtime path established
- [PASS] Consolidated read-only search located the active OpenWrt Zapret2 `CUSTOM_DIR` assignment.
- [RESULT] `/opt/zapret2/init.d/openwrt/90-zapret2:15` sets `CUSTOM_DIR="$ZAPRET_RW/init.d/openwrt"`.
- [RESULT] `/opt/zapret2/init.d/openwrt/functions:16` contains the same assignment.
- [RESULT] Therefore the OpenWrt integration's active custom-script directory is `$ZAPRET_RW/init.d/openwrt/custom.d`.
- [IMPORTANT] The prior interactive `${CUSTOM_DIR}` probe was not representative of the init environment; the runtime path is defined inside the OpenWrt integration files.
- [RESULT] Installer references also confirm separate sysv/openwrt custom locations, but no installer behavior was changed or executed.
- [SAFETY] Read-only inspection only; no Zapret2, nftables, WireGuard, firewall, or service configuration changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.
- [WORKFLOW] Diagnostic scope has been deliberately reduced: next action will be chosen from the established runtime path, with no redundant probing.

## SYNC CHECKPOINT — 2026-09-23 — active custom.d direct probe
- [RESULT] User checked the previously established runtime path via the interactive shell.
- [OBSERVED] `ZAPRET_RW` is empty in the interactive shell (`ZAPRET_RW=`), so the expanded path could not be resolved there.
- [OBSERVED] `$ZAPRET_RW/init.d/openwrt/custom.d` therefore was not found from the interactive shell.
- [IMPORTANT] This is analogous to the earlier `CUSTOM_DIR` probe: it does not prove the init-time `ZAPRET_RW` is empty. The OpenWrt integration may define it internally before `custom_runner()` runs.
- [CONCLUSION] We have established the path construction in the OpenWrt integration, but not the init-time value of `ZAPRET_RW` or the resulting concrete active custom.d path.
- [SAFETY] No configuration/service state changed; this was read-only.
- [STATUS] Diagnostic gate remains IN_PROGRESS, with reduced scope and no redundant broad testing.

## SYNC CHECKPOINT — 2026-09-23 — workflow format update
- [USER RULE] For this troubleshooting sequence, use the cadence: synchronize the just-reported result → give the single next command. Do not narrate or announce a future stage/step.
- [STATUS] Zapret2 custom hook diagnostic remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — OpenWrt functions initialization confirmed
- [PASS] Read-only inspection of `/opt/zapret2/init.d/openwrt/functions` completed.
- [RESULT] `ZAPRET_BASE` defaults to `/opt/zapret2`.
- [RESULT] `ZAPRET_RW` defaults to `"$ZAPRET_BASE"` unless already set.
- [RESULT] `ZAPRET_CONFIG` defaults to `"$ZAPRET_RW/config"`, and that config is sourced before `CUSTOM_DIR` is assigned.
- [RESULT] `CUSTOM_DIR` is explicitly assigned to `"$ZAPRET_RW/init.d/openwrt"`.
- [IMPORTANT] Because `/opt/zapret2/config` is sourced before `CUSTOM_DIR` is assigned, the remaining concrete check is whether the active config overrides `ZAPRET_RW`.
- [SAFETY] Read-only inspection only; no service, nftables, firewall, WireGuard, or Zapret2 configuration changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — Zapret config variable probe
- [RESULT] Read-only grep of `/opt/zapret2/config` for `ZAPRET_BASE`, `ZAPRET_RW`, and `ZAPRET_CONFIG` returned an empty output.
- [CONCLUSION] The active config does not explicitly override these three variables. With the OpenWrt integration defaults, `ZAPRET_RW` therefore resolves to `/opt/zapret2` unless supplied externally by the init environment.
- [RESULT] The expected OpenWrt custom script directory is consequently `/opt/zapret2/init.d/openwrt/custom.d` for the current installation.
- [SAFETY] No configuration or service state changed; read-only check only.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — active custom.d directory verified
- [PASS] Read-only inspection confirmed `/opt/zapret2/init.d/openwrt/custom.d` exists.
- [RESULT] Directory currently contains only `.keep`; no active custom Zapret2 scripts are enabled there.
- [IMPORTANT] This explains why the installed `50-wg4all` example is not currently being executed through `custom_runner zapret_custom_daemons`.
- [SAFETY] No files were copied, edited, enabled, or executed; Zapret2/nftables/WireGuard/firewall/service state unchanged.
- [STATUS] Diagnostic gate remains IN_PROGRESS.
- [WORKFLOW] Continue with synchronization → concise explanation → one command → wait for the user's output.

## SYNC CHECKPOINT — 2026-09-23 — `50-wg4all` example inspected
- [PASS] Read-only inspection of `/opt/zapret2/init.d/custom.d.examples.linux/50-wg4all` completed.
- [RESULT] The example defines `NFQWS_OPT_DESYNC_WG` with a default WireGuard payload desync using `fake` and a zero blob, repeats=2; this is an option for desynchronizing WireGuard handshake initiation/response/cookie packets.
- [RESULT] The script allocates a dedicated daemon number and queue number, then defines `zapret_custom_daemons()` to start `nfqws` on that queue.
- [RESULT] It also defines `zapret_custom_firewall()` and `zapret_custom_firewall_nft()` to match WireGuard initiation/response/cookie packet lengths and message types and send them to the dedicated queue.
- [COMPATIBILITY NOTE] The example itself states nft 1.0.1+ and an updated kernel are required for `@ih`; current reported system has nftables 1.1.6 and kernel 6.12.94, so the documented version/kernel prerequisite is met.
- [IMPORTANT] This does not yet establish whether Zapret2's active firewall integration calls `zapret_custom_firewall_nft()` on this OpenWrt path. No script was copied or activated.
- [SAFETY] Read-only inspection only; no Zapret2/nftables/WireGuard/firewall/service state changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — custom firewall hook path confirmed
- [PASS] Read-only grep confirmed active firewall hook integration points:
  - `/opt/zapret2/common/nft.sh:686` → `custom_runner zapret_custom_firewall_nft`
  - `/opt/zapret2/common/nft.sh:708` → `custom_runner zapret_custom_firewall_nft_flush`
  - `/opt/zapret2/common/ipt.sh:302` → `custom_runner zapret_custom_firewall $1`
- [RESULT] Therefore the `50-wg4all` example's `zapret_custom_firewall_nft()` is compatible with the discovered custom-runner mechanism in principle, subject to its activation and surrounding runtime conditions.
- [IMPORTANT] User pasted an external recommendation to set `NFQWS_OPT_DESYNC_UDP="--desync-split-pos=2"` and referred to `/opt/zapret/config`; these are NOT adopted or validated. Current installed config path established earlier is `/opt/zapret2/config`.
- [IMPORTANT] No configuration change was made and no `50-wg4all` script was activated.
- [SAFETY] Read-only inspection only; nftables/Zapret2/WireGuard/firewall/service state unchanged.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — nft custom firewall execution confirmed
- [PASS] Read-only inspection of `/opt/zapret2/common/nft.sh` completed.
- [RESULT] `zapret_apply_firewall_rules_nft()` first applies the standard Zapret2 nftables rules and then calls `custom_runner zapret_custom_firewall_nft`.
- [RESULT] `zapret_apply_firewall_nft()` invokes `zapret_apply_firewall_rules_nft()`, so active custom nft firewall hooks are part of the normal firewall application path.
- [RESULT] `zapret_unapply_firewall_nft()` calls `custom_runner zapret_custom_firewall_nft_flush` during nftables cleanup.
- [CONCLUSION] The `50-wg4all` example can integrate with the installed nftables firewall path through its `zapret_custom_firewall_nft()` function once the script is actually placed in the active `custom.d`; this is now confirmed from source, not assumed.
- [IMPORTANT] The example has still NOT been enabled. No configuration, firewall, nftables, WireGuard, or service state changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — installer search result
- [RESULT] Read-only search found one relevant installer line: `/opt/zapret2/install_easy.sh:382` copies both `init.d/openwrt` and `init.d/custom.d.examples.linux` into the installation tree.
- [CONCLUSION] The installer bundles the Linux custom-script examples, but this result does not show that an individual example such as `50-wg4all` is automatically enabled into the active `/opt/zapret2/init.d/openwrt/custom.d`.
- [RESULT] No active custom script was enabled by this inspection.
- [SAFETY] No configuration, file, firewall, nftables, WireGuard, or service state changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — installer flow-offload logic reviewed
- [PASS] Read-only inspection of `/opt/zapret2/install_easy.sh:700-755` completed.
- [RESULT] With `FLOWOFFLOAD=donttouch` and `NFQWS2_ENABLE=1`, the installer considers system-wide flow offloading incompatible with nfqws TCP data tampering and will disable it if found enabled.
- [RESULT] If system-wide flow offloading is already disabled, installer reports it as OK.
- [RESULT] If custom scripts are present, the installer explicitly warns that nfqws-based custom scripts will not work with system-wide offloading.
- [IMPORTANT] Current project setting `FLOWOFFLOAD=donttouch` remains unchanged; no UCI or firewall setting was modified by this inspection.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — do_nfqws location confirmed
- [RESULT] Read-only search located the active `do_nfqws()` implementation at `/opt/zapret2/init.d/openwrt/zapret2:65`.
- [RELEVANCE] This is the last unresolved integration point before deciding whether the bundled `50-wg4all` example can be enabled safely alongside the current `NFQWS2_ENABLE=1` setup.
- [USER FEEDBACK] User asked to avoid an excessively long test sequence; the remaining inspection is intentionally limited to this integration point.
- [SAFETY] No configuration or service state changed.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — repeated command output
- [RESULT] User's latest message repeated the prior grep command and returned the same confirmed location: `/opt/zapret2/init.d/openwrt/zapret2:65:do_nfqws()`.
- [NOTE] The requested `sed -n '55,105p' /opt/zapret2/init.d/openwrt/zapret2` command was not executed in this message; therefore its output remains unknown.
- [STATUS] Diagnostic gate remains IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — `50-wg4all` daemon integration confirmed
- [PASS] Read-only inspection of `/opt/zapret2/init.d/openwrt/zapret2:55-105` completed.
- [RESULT] `do_nfqws()` delegates to `run_nfqws()`, which launches the configured `$NFQWS2` binary with `$NFQWS2_OPT_BASE` plus the custom options.
- [CONCLUSION] The bundled `50-wg4all` custom script will use the already configured native `nfqws2` runtime; no second nfqws binary is required.
- [RESULT] `start_daemons_procd()` runs both standard Zapret2 daemons and `custom_runner zapret_custom_daemons 1`, so an enabled custom script participates in normal service startup.
- [IMPORTANT] `50-wg4all` remains disabled; no file was copied and no service restart occurred.
- [STATUS] Diagnostic gate IN_PROGRESS; evidence for safe integration is now sufficient to move to controlled activation.
- [WORKFLOW] Continue with synchronization → concise explanation → one command → user output.

## SYNC CHECKPOINT — 2026-09-23 — `50-wg4all` activated in active custom.d (file deployment)
- [PASS] User copied the bundled `/opt/zapret2/init.d/custom.d.examples.linux/50-wg4all` to `/opt/zapret2/init.d/openwrt/custom.d/50-wg4all`.
- [RESULT] Active custom script now exists with mode `-rw-r--r--`, owner `root:root`, size 1566 bytes.
- [IMPORTANT] This is a file deployment only. The running Zapret2 service has NOT yet been restarted, so the new custom daemon/firewall hooks are not yet active in the running process/ruleset.
- [SAFETY] No existing config was edited; only the previously inspected vendor example was copied into the designated active custom.d directory.
- [STATUS] Zapret2 custom WireGuard integration: IN_PROGRESS; activation pending service restart.

## SYNC CHECKPOINT — 2026-09-23 — `50-wg4all` runtime activation successful
- [PASS] `/etc/init.d/zapret2 restart` completed successfully.
- [PASS] Standard Zapret2 daemon 1 restarted on queue 300 with the established TCP 80/443 and UDP 443 configuration.
- [PASS] Custom WireGuard daemon 2000 started using `nfqws2` with queue `65300` and `--payload=wireguard_initiation,wireguard_response,wireguard_cookie --lua-desync=fake:blob=0x00000000000000000000000000000000:repeats=2`.
- [PASS] nftables added three `50-wg4all` postrouting matches on queue 65300 for UDP lengths/message types 156/0x01000000, 100/0x02000000, and 72/0x03000000.
- [PASS] Normal Zapret2 nftables rules on queue 300 were recreated; no errors were reported by the restart.
- [CONCLUSION] The bundled `50-wg4all` integration is now active in the running Zapret2 service.
- [STATUS] Custom WireGuard desync activation = DONE; end-to-end WireGuard/Proton functional validation remains IN_PROGRESS.
- [SAFETY] This was the first intended service restart after copying the vendor example; no other configuration was changed.

## SYNC CHECKPOINT — 2026-09-23 — WireGuard runtime state check
- [RESULT] User ran `wg show`; output was empty.
- [CONCLUSION] No WireGuard interface is currently instantiated/active in the kernel, so end-to-end validation of the newly activated `50-wg4all` against a WireGuard tunnel cannot yet be performed.
- [IMPORTANT] This does not invalidate `50-wg4all`; it only means there is no active WireGuard tunnel to exercise its UDP handshake matching rules.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton functional validation = BLOCKED pending a configured/started WireGuard interface.
- [SAFETY] No configuration or service state changed; `wg show` is read-only.

## SYNC CHECKPOINT — 2026-09-23 — no WireGuard UCI configuration
- [RESULT] User ran `uci show network | grep -E 'wireguard|wg[0-9]'`; output was empty.
- [CONCLUSION] There is no WireGuard interface/peer definition in the current `/etc/config/network` UCI configuration.
- [CORRELATION] This matches the previous empty `wg show`: no active WireGuard tunnel is currently configured through OpenWrt UCI.
- [STATUS] `50-wg4all` integration = DONE; end-to-end WireGuard/Proton validation = BLOCKED because no WireGuard tunnel/profile is configured.
- [SAFETY] Read-only inspection only; no network configuration changed.

## SYNC CHECKPOINT — 2026-09-23 — WireGuard profile files found
- [RESULT] `/etc/wireguard` exists and contains two profiles: `proton-test.conf` (357 bytes) and `proton.conf` (345 bytes), both mode `600`.
- [IMPORTANT] This explains why the absence of UCI `network` WireGuard entries does not mean no Proton WireGuard profiles exist; they are stored as native WireGuard configuration files.
- [SAFETY] Private key material was not displayed, copied, or modified.
- [STATUS] `50-wg4all` integration = DONE; Proton/WireGuard end-to-end validation remains IN_PROGRESS pending inspection of the non-secret profile parameters.

## SYNC CHECKPOINT — 2026-09-23 — Proton WireGuard profile parameters inspected
- [RESULT] Read-only inspection of `/etc/wireguard/proton-test.conf` and `proton.conf` completed with `PrivateKey` redacted.
- [RESULT] Both profiles target the same Proton peer `NL-FREE#128`, endpoint `185.107.56.235:51820`, address `10.2.0.2/32`, and `PersistentKeepalive=25`.
- [IMPORTANT] `proton-test.conf` has `Table=off`, making it the safer profile for initial handshake testing because it does not install full-tunnel routes.
- [SAFETY] No key material was exposed; no profile was modified.
- [STATUS] `50-wg4all` integration = DONE; WireGuard end-to-end validation = IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — `wg-quick` unavailable
- [RESULT] `wg-quick up /etc/wireguard/proton-test.conf` returned `-ash: wg-quick: not found`.
- [CONCLUSION] The test profile was not brought up and no network state changed from this command.
- [IMPORTANT] `wg show` is available in the environment, but the `wg-quick` helper is not installed.
- [STATUS] `50-wg4all` integration = DONE; WireGuard end-to-end validation = IN_PROGRESS.
- [NEXT] Determine the available native WireGuard control path without changing configuration.

## SYNC CHECKPOINT — 2026-09-23 — WireGuard tooling inventory
- [RESULT] `command -v wg` returned `/usr/bin/wg`.
- [RESULT] `command -v wg-quick` returned nothing.
- [RESULT] Installed package list contains `kmod-wireguard` and `wireguard-tools`.
- [CONCLUSION] WireGuard kernel support/tools are installed, but the `wg-quick` helper is not present in this OpenWrt environment.
- [STATUS] `50-wg4all` integration = DONE; WireGuard end-to-end validation = IN_PROGRESS.
- [SAFETY] Read-only inventory only; no network or package state changed.

## SYNC CHECKPOINT — 2026-09-23 — native WireGuard path selected
- [RESULT] `wireguard-tools` package contains only `/usr/bin/wg`; `wg-quick` is not included.
- [DECISION] For the current controlled validation, use OpenWrt's existing native `wg` and `ip` tooling rather than installing another package or changing the package set.
- [SAFETY] No network configuration was changed by this decision; it is a tooling choice for the next controlled test.
- [STATUS] `50-wg4all` integration = DONE; WireGuard end-to-end validation = IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — native WireGuard test interface created
- [PASS] Created `proton-test` WireGuard interface using the existing native `ip` + `wg` tools and the non-secret parameters from `proton-test.conf`.
- [PASS] Assigned `10.2.0.2/32`, brought the interface up, and added the host route to `10.2.0.1`.
- [RESULT] `wg show proton-test` reports endpoint `185.107.56.235:51820`, persistent keepalive 25s, `148 B sent`, `0 B received`.
- [INTERPRETATION] Outbound WireGuard traffic was generated, but no response/handshake was received at the moment of inspection. This is not yet a failure diagnosis; it is the first end-to-end runtime observation with `50-wg4all` active.
- [IMPORTANT] Private key remained hidden; the source profile was not modified.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.
- [SAFETY] The only state change was creation of the temporary `proton-test` interface for the requested validation; no persistent UCI configuration was added.

## SYNC CHECKPOINT — 2026-09-23 — command explanation requirement
- [USER RULE] Every router command in this troubleshooting sequence must be accompanied by a brief explanation of what the command does and what result we are looking for.
- [WORKFLOW] Keep the cadence: synchronize the just-reported result → explain the next command briefly → give exactly one command → wait for the user's output.

## SYNC CHECKPOINT — 2026-09-23 — WireGuard handshake still unanswered
- [RESULT] After 5 seconds, `wg show proton-test` reports `1.73 KiB sent`, `0 B received`, persistent keepalive 25s, and no `latest handshake` field.
- [INTERPRETATION] WireGuard continues transmitting toward the Proton endpoint, but no response has been received yet.
- [NEXT DIAGNOSTIC] Inspect packet counters for the newly installed `qnum=65300` nftables rules to determine whether WireGuard packets are actually matching `50-wg4all`.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — qnum 65300 rule presence, match not proven
- [RESULT] `nft -a list table inet zapret2 | grep -E '65300|counter'` showed three rules for qnum `65300` with handles 135, 136, 137, matching UDP lengths 156/100/72 and WireGuard message types `0x01000000/0x02000000/0x03000000`.
- [IMPORTANT] The rules contain no nft `counter`, so this output proves installation of the rules but does NOT prove that live WireGuard packets have matched them.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.
- [SAFETY] Read-only inspection; no nftables or WireGuard state changed.

## SYNC CHECKPOINT — 2026-09-23 — `50-wg4all` nft hook location confirmed
- [RESULT] qnum `65300` rules are in chain `postnat`, under the nftables postrouting path.
- [CONCLUSION] The installed firewall hook targets outbound IPv4 UDP WireGuard handshake packets before WAN transmission, consistent with the vendor `50-wg4all` example.
- [STATUS] `50-wg4all` integration = DONE; end-to-end WireGuard/Proton validation = IN_PROGRESS.
- [NEXT] Keep diagnostics minimal; verify only that the dedicated `nfqws2` consumer for qnum `65300` remains running.

## SYNC CHECKPOINT — 2026-09-23 — two nfqws2 processes confirmed
- [RESULT] `ps w | grep '[n]fqws2'` shows two running `nfqws2` processes, PIDs 4852 and 4853, both owned by `daemon`.
- [LIMIT] The command output is truncated before the queue argument, so it does not by itself prove which PID is standard qnum 300 and which is WireGuard qnum 65300.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.
- [SAFETY] Read-only process listing only; no state changed.

## SYNC CHECKPOINT — 2026-09-23 — dedicated nfqws2 queue verified
- [RESULT] `/proc/<pid>/cmdline` confirmed PID 4852 uses `qnum=300` and PID 4853 uses `qnum=65300`.
- [CONCLUSION] The dedicated `50-wg4all` nfqws2 consumer is running as a separate process and is bound to the intended WireGuard queue.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.
- [NEXT] Use a single passive packet capture against the Proton endpoint to distinguish outbound-only behavior from any returned UDP response.

## SYNC CHECKPOINT — 2026-09-23 — external WireGuard advice reviewed
- [USER INPUT] User supplied an external recommendation to add generic UDP variables such as `MODE_UDP=nfqws`, `NFQWS_OPT_DESYNC_UDP`, and `UDP_PORTS=51820`, followed by a generic `/etc/init.d/zapret restart`.
- [DECISION] These suggested changes are NOT adopted. The installed Zapret2 already has the vendor `50-wg4all` custom integration specifically matching WireGuard initiation/response/cookie packets and using a dedicated qnum 65300.
- [FACT CHECK] The current official Zapret2 configuration model uses `NFQWS2_ENABLE`, `NFQWS2_PORTS_UDP`, and custom scripts; there is no need to introduce the pasted legacy/generic variable names into the current config based on that advice. citeturn761261search0
- [IMPORTANT] The user did not provide the output of the earlier `tcpdump` command, so the claim that the incoming response is blocked by TSPU is not independently established by packet capture yet.
- [SAFETY] No config/service/nftables/WireGuard changes were made in response to the pasted recommendation.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.

## SYNC CHECKPOINT — 2026-09-23 — tcpdump unavailable
- [RESULT] `tcpdump -ni phy0-sta0 'host 185.107.56.235 and udp port 51820' -c 6` returned `-ash: tcpdump: not found`.
- [CONCLUSION] Packet capture via tcpdump is unavailable on the current installation; no package was installed for this diagnostic.
- [SAFETY] No network, package, firewall, nftables, or WireGuard configuration changed.
- [STATUS] `50-wg4all` integration = DONE; WireGuard/Proton end-to-end validation = IN_PROGRESS.
- [NEXT] Use existing kernel NFQUEUE runtime statistics instead of adding tcpdump solely for this test.
