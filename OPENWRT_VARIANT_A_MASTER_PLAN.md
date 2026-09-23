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
STAGE 12–22 — RETIRED/SKIPPED FOR CURRENT PATH; STAGE 23 — NEXT; STAGE 24–30 — NOT_STARTED

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
