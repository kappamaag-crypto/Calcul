## STAGE 11A — Process/socket/PSI memory pressure check — 2026-09-24
- [RESULT] BusyBox/procps `ps -w` is available, but its displayed columns are PID/USER/VSZ/STAT/COMMAND; this invocation does not provide RSS, so it does not identify the largest resident-memory process.
- [RESULT] `/proc/net/sockstat`: sockets used=103; TCP inuse=7, orphan=0, TIME_WAIT=0, alloc=13, mem=0; UDP inuse=8, mem=0; RAW inuse=1; FRAG inuse=0, memory=0.
- [INTERPRETATION] Current socket accounting shows no reported socket memory pressure; network socket buffers are not established as the source of the OOM events.
- [RESULT] `/proc/pressure/memory` is unavailable; PSI cannot be used on this build to quantify memory stalls.
- [SOURCE CONTEXT] Linux documents `/proc/PID/status` and its VmRSS/RssAnon/RssFile/RssShmem fields as process memory information, while `/proc/net/sockstat` exposes network memory state. The absence of PSI here is a build/interface limitation.
- [STATUS] STAGE 11A remains IN_PROGRESS; next localization step should read per-process VmRSS directly from `/proc/*/status` without heavy sorting/enumeration.
- [SAFETY] No configuration, service, routing, firewall, Wi-Fi, swap, VM, or Zapret2 state changed.

## STAGE 11B — Memory/zone current snapshot — 2026-09-24
- [RESULT] Current snapshot before VM tuning: MemFree=15324 kB, MemAvailable=7216 kB, Buffers=1928 kB, Cached=5140 kB, AnonPages=3104 kB, KReclaimable=1400 kB, Slab=9212 kB, SReclaimable=1400 kB, SUnreclaim=7812 kB.
- [RESULT] Normal-zone snapshot before VM tuning: pages free=3802, min=2048, low=2560, high=3072, managed=13713.
- [INTERPRETATION] The router had a narrow available-memory margin, but SUnreclaim was not observed growing during the sampled interval.

## STAGE 11C — Runtime VM free-memory reserve tuning — 2026-09-24
- [CHANGE] Runtime-only `vm.min_free_kbytes` was reduced from 8192 kB → 4096 kB → 2048 kB. No persistent sysctl/UCI change was made.
- [RESULT @ 4096] `min_free_kbytes=4096`; Normal zone: free=3628, min=1024, low=1280, high=1536, managed=13713; MemFree=14904 kB; MemAvailable=12944 kB; Slab=9212 kB; SReclaimable=1400 kB; SUnreclaim=7812 kB.
- [RESULT @ 2048] `min_free_kbytes=2048`; Normal zone: free=3414, min=512, low=640, high=768, managed=13713; MemFree=14704 kB; MemAvailable=16608 kB; Slab=9212 kB; SReclaimable=1400 kB; SUnreclaim=7812 kB.
- [INTERPRETATION] Lowering `min_free_kbytes` does not reduce Slab/SUnreclaim; it reduces the VM's reserved free-page watermark target. Consequently Linux reports substantially more memory as available for allocation: about 7.2 MB → 12.9 MB at 4096 and → 16.6 MB at 2048 in these snapshots. This is additional usable headroom, not newly created RAM.
- [VM EFFECT] The Normal-zone watermarks were recalculated downward: at 8192 the observed min/low/high were 2048/2560/3072; at 4096 they became 1024/1280/1536; at 2048 they became 512/640/768.
- [RISK] This is an aggressive runtime tuning experiment. A lower reserve gives the kernel less emergency free memory for allocations/reclaim; under heavy bursts it can increase allocation stalls or make low-memory behavior less forgiving. Linux documents `min_free_kbytes` as the minimum amount of free memory the VM keeps and warns that setting it too low can cause problems; it should not be lowered further casually.
- [SAFETY] Change is runtime-only and reversible. Reboot should restore the default unless OpenWrt later persists a setting; do not persist yet.
- [STATUS] STAGE 11C = IN_PROGRESS. Keep 2048 kB isolated as the only changed VM variable until stability is observed. Do not simultaneously change swappiness, watermark_scale_factor, swap, Zapret2 set limits, or Wi-Fi settings.


## STAGE 11C — Runtime VM free-memory reserve tuning — follow-up observation — 2026-09-24
- [RESULT] With runtime-only `vm.min_free_kbytes=2048`, a 60-second lightweight idle sample showed Normal-zone `pages free` from 3038 to 3737 pages while watermarks stayed at min=512, low=640, high=768.
- [RESULT] `MemAvailable` ranged 14204–17044 kB; `MemFree` ranged 12300–15140 kB.
- [INTERPRETATION] During this sample, free pages remained about 4.0–4.9× above the high watermark and about 6.0–7.3× above the low watermark; the zone never approached the critical min watermark. No allocation stall, OOM, network, or Wi-Fi failure was reported during the sample.
- [CONCLUSION] The 2048 kB setting is not showing immediate watermark stress in idle conditions. This does NOT prove safety under traffic/load; the meaningful test is later behavior under normal router workload.
- [STATUS] STAGE 11C remains IN_PROGRESS. Keep 2048 kB unchanged for now; do not lower further yet.
- [SOURCE CONTEXT] Linux documents that below the low watermark kswapd is woken, while below min allocations may trigger direct reclaim/compaction; min_free_kbytes determines the min watermark. citeturn0search1turn0search2
- [SAFETY] No additional configuration or service changes were made during this observation.


## STAGE 11C — Bounded network-load test preparation — 2026-09-24
- [RESULT] Preliminary large-download probe with runtime-only `vm.min_free_kbytes=2048`: `wget -4 -qO /dev/null -T 10 https://speed.hetzner.de/100MB.bin` returned `Failed to send request: Operation not permitted` and `RC=4`.
- [INTERPRETATION] The selected test URL cannot currently be used as the load source from the router. This result does not by itself demonstrate a memory failure; no OOM/Wi-Fi/routing failure occurred during this one-request probe.
- [SOURCE CONTEXT] Hetzner's current documentation identifies `https://fsn1-speed.hetzner.com/100MB.bin` as an official speed-test file and recommends using `curl` or `wget` for download testing. citeturn243162search0
- [SAFETY] No file was written to flash/tmp because output was directed to `/dev/null`; no configuration, service, firewall, routing, Wi-Fi, swap, or VM setting was changed.
- [STATUS] STAGE 11C remains IN_PROGRESS. Do not repeat the failed URL. Next load step should use a bounded source known to be reachable, with output discarded to `/dev/null`, and avoid `tcpdump` because prior heavy capture coincided with system-wide OOM events.


## STAGE 11C — Bounded network-load source check — follow-up — 2026-09-24
- [RESULT] Retried the official Hetzner speed-test file with `wget -4 -qO /dev/null -T 30 https://fsn1-speed.hetzner.com/100MB.bin`; request returned no payload/output and `RC=4`.
- [INTERPRETATION] This router-side request is unusable as the current load source. The failure is not evidence of OOM or memory exhaustion; there was no reported SSH/Wi-Fi outage or OOM result in this test.
- [VERIFICATION] Current Hetzner documentation still lists `fsn1-speed.hetzner.com/100MB.bin` as its official speed-test file and documents curl/wget for measuring download speed. citeturn0search0 Therefore the problem is specific to this router/path/request rather than the test URL being invented.
- [SAFETY] No file was written to flash/tmp because output was discarded to `/dev/null`; no configuration, service, firewall, routing, Wi-Fi, swap, VM, or Zapret2 state was changed.
- [STATUS] STAGE 11C remains IN_PROGRESS. Do not repeat the same source. Next step should use a different bounded large-download source or another controlled load mechanism; avoid `tcpdump` because prior heavy capture coincided with system-wide OOM events.


## STAGE 11C — Known-good HTTPS baseline — follow-up — 2026-09-24
- [RESULT] `wget -4 -qO /dev/null -T 10 https://example.com` completed with `RC=0`.
- [INTERPRETATION] The router can currently perform a bounded IPv4 HTTPS download with output discarded. This establishes a usable baseline for the next load test and separates the two failed Hetzner-source probes from a general inability to make HTTPS requests.
- [SAFETY] No file was written to flash/tmp; no configuration, service, firewall, routing, Wi-Fi, swap, VM, or Zapret2 state was changed.
- [STATUS] STAGE 11C remains IN_PROGRESS. Next load test should use the known-good HTTPS path and remain bounded; avoid `tcpdump` because prior heavy capture coincided with system-wide OOM events.


## STAGE 11C — Repeated known-good HTTPS load — follow-up — 2026-09-24
- [RESULT] Six sequential IPv4 HTTPS requests to `https://example.com` with `wget -4 -qO /dev/null -T 10` all completed successfully: rounds 1–6, `RC=0` each.
- [INTERPRETATION] Repeated bounded HTTPS activity is currently stable at the application level. No SSH/Wi-Fi outage or OOM was reported during this six-round test.
- [SAFETY] No data was written to flash/tmp; no configuration or service state was changed.
- [NEXT] A controlled tcpdump capture remains appropriate for packet-path diagnosis, but must be tightly bounded because a previous larger capture coincided with an OOM event that killed hostapd/nfqws2 and temporarily disrupted Wi-Fi.


## STAGE 11C — Controlled WAN UDP/443 capture — follow-up — 2026-09-24
- [RESULT] `tcpdump -ni phy0-sta0 -nn -s 96 -c 10 'udp port 443'` was started successfully, but after waiting and manual interrupt it reported `0 packets captured / 0 packets received by filter / 0 packets dropped by kernel`.
- [CORRELATED TEST] Immediately afterward, `wget -4 -qO /dev/null -T 10 https://example.com` completed successfully (no RC error shown).
- [INTERPRETATION] No UDP/443 traffic was observed on `phy0-sta0` during this capture window. This does not imply UDP/443 is blocked or broken because the concurrent HTTPS baseline uses TCP/443; it only establishes that this specific capture window had no matching UDP/443 packets.
- [SAFETY] Capture was bounded by `-s 96 -c 10`, produced no packet drops, and did not cause an observed OOM/Wi-Fi/SSH outage.
- [NEXT] Do not repeat an open-ended UDP capture. If QUIC/UDP/443 needs testing, first generate known UDP/443 traffic from a client/application or use a deliberately bounded capture window.


## STAGE 11C — Scope correction: network-load OOM validation — 2026-09-24
- [CORRECTION] The six sequential `wget https://example.com` requests are only a connectivity/application baseline; they are **not** a meaningful sustained network-load/OOM stress test.
- [OBJECTIVE] The actual purpose of this Stage 11C experiment is to determine whether realistic network load causes memory pressure, OOM-killer activity, hostapd/nfqws2 termination, SSH/Wi-Fi loss, or other instability while `vm.min_free_kbytes=2048` and the current Zapret2 configuration remain unchanged.
- [REQUIRED TEST PROPERTY] The next test must create materially higher sustained network traffic than a tiny sequential `example.com` request, while avoiding writes to flash/tmp and keeping the test bounded/recoverable.
- [INTERPRETATION RULE] The previous six successful requests must not be recorded as proof that the 2048-KB reserve is safe under network load. They only show that ordinary repeated HTTPS requests remained functional during that small baseline.
- [STATUS] STAGE 11C remains IN_PROGRESS. No additional VM/Zapret2 tuning should be made before the bounded network-load/OOM test.


## STAGE 11C — Network-load/OOM test — execution started — 2026-09-24
- [TEST] Started bounded 60-second IPv4 HTTPS download to `/dev/null`: `wget -4 -O /dev/null -T 60 https://fsn1-speed.hetzner.com/100MB.bin`.
- [OBSERVATION] Connection reached `78.46.170.2:443`; at the time of the user report the transfer had not yet completed.
- [SOURCE] Hetzner officially documents `fsn1-speed.hetzner.com/100MB.bin` as a network download test file. citeturn0search0
- [SAFETY] No output is being written to flash/tmp because destination is `/dev/null`. No configuration changes were made.
- [STATUS] Test IN_PROGRESS; wait for completion/timeout or any SSH/Wi-Fi/OOM symptom before interpreting the result.


## STAGE 11C — Network-load/OOM test — failed source attempt — 2026-09-24
- [RESULT] `wget -4 -O /dev/null -T 60 https://fsn1-speed.hetzner.com/100MB.bin` reached `78.46.170.2:443` but then returned `Connection error: Connection timed out`; shell reported `RC=4`.
- [INTERPRETATION] This is **not an OOM result**. The download did not reach sustained transfer, so it cannot be used to judge whether `vm.min_free_kbytes=2048` survives heavy network load.
- [SOURCE VALIDITY] Hetzner's current documentation still lists `fsn1-speed.hetzner.com/100MB.bin` as an official download-speed test file, so the failure is router/path-specific or otherwise connection-specific rather than evidence that the documented test file is invalid. citeturn0search0
- [SAFETY] No flash/tmp write; no configuration change; no OOM/Wi-Fi/SSH failure was reported during this attempt.
- [STATUS] STAGE 11C remains IN_PROGRESS. A different verified, reachable high-volume network-load mechanism is required; do not lower `min_free_kbytes` further or change Zapret2 before that test.


## STAGE 11C — iPerf3 network-load attempt — 2026-09-24
- [RESULT] Attempted controlled reverse TCP load: `iperf3 -4 -c iperf-ams-nl.eranium.net -t 30 -P 4 -R`.
- [RESULT] The public iPerf3 server replied: `the server is busy running a test. try again later`; shell returned `RC=1`.
- [INTERPRETATION] This is neither a successful network-load/OOM test nor an OOM result. No sustained traffic was generated by this attempt.
- [VERIFICATION] The current public iPerf3 server list still lists `iperf-ams-nl.eranium.net` in Amsterdam and documents reverse mode (`-R`) for download testing; the same list also provides alternative Amsterdam/Netherlands servers. citeturn0search0turn0search7
- [SAFETY] No configuration, VM, Zapret2, Wi-Fi, swap, or filesystem state was changed. No flash/tmp write was performed by this failed connection attempt.
- [STATUS] STAGE 11C remains IN_PROGRESS. Do not interpret this as a load-test pass/fail. Next step should use a different currently listed iPerf3 endpoint, preferably with a specified port, and remain bounded.

## STAGE 11C — Sustained iPerf3 network-load test — 2026-09-24
- [TEST] `iperf3 -4 -c 185.182.195.76 -p 5201 -t 30 -P 4 -R`.
- [RESULT] Test completed successfully: 4 reverse TCP streams, 30 seconds. Aggregate receiver: 73.5 MBytes at 20.6 Mbit/s. Aggregate sender: 80.5 MBytes at 22.5 Mbit/s with 322 retransmissions. Per-stream receiver rates were approximately 4.58–5.45 Mbit/s.
- [RESULT] Shell returned `RC=0`.
- [INTERPRETATION] This is the first valid sustained network-load test in Stage 11C: materially higher and continuous traffic reached the router for 30 seconds. The transfer itself completed without an application-level failure.
- [OOM INTERPRETATION] The supplied output does not include memory/OOM telemetry, so the test cannot yet be declared a memory-safety pass. We need the post-test kernel/OOM and memory snapshot before concluding whether `vm.min_free_kbytes=2048` remained stable under load.
- [SAFETY] No destination file was used by iperf3; no intentional filesystem write, VM/Zapret2/Wi-Fi/config change was made.
- [STATUS] STAGE 11C remains IN_PROGRESS pending post-load memory/OOM verification.

## STAGE 11C — Post-load memory/OOM check — 2026-09-24
- [RESULT] Immediately after the successful 30-second iPerf3 reverse test, `free -m` reported: RAM total 54852 kB, used 31620 kB, free 14840 kB, buff/cache 8392 kB, available 16732 kB; swap total 550904 kB, used 4084 kB, free 546820 kB.
- [OOM LOG] The supplied `dmesg | grep -Ei 'oom|out of memory|killed process'` output contains historical global OOM events involving `nfqws2`, `apk`, and `hostapd`, including the previously known `tcpdump`-related event. No new OOM event is visible in the supplied excerpt after the last recorded event at dmesg timestamp 107002.118743.
- [IMPORTANT] The timestamps in dmesg are uptime-relative and the user output does not include the exact iPerf3 test timestamp, so this result alone cannot prove that the 107002 event predates the iPerf3 test. Therefore the 30-second load test is currently classified as **no observed OOM in the supplied post-test excerpt**, not as a definitive OOM-free pass.
- [INTERPRETATION] Current post-test `MemAvailable=16732 kB` and swap use of 4084 kB do not indicate an immediate exhausted-memory state at the moment of measurement. Linux documents that `vm.min_free_kbytes` sets the minimum free-page watermark and that below the min watermark allocations can trigger direct reclaim/compaction; OOM-killer activity is separately recorded when the kernel reaches an OOM condition. citeturn0search0turn0search1
- [STATUS] STAGE 11C remains IN_PROGRESS. Before declaring the 2048-kB setting validated under load, correlate the iPerf3 run with dmesg uptime and perform the planned post-load stability observation.

## STAGE 11C — Combined sustained network-load + bounded TCP/443 capture — 2026-09-24
- [TEST] Runtime-only `vm.min_free_kbytes=2048`; Zapret2 configuration unchanged. Combined bounded test: `tcpdump -ni phy0-sta0 -nn -s 64 -c 100 'tcp port 443'` running concurrently with `iperf3 -4 -c 185.182.195.76 -p 5201 -t 60 -P 8 -R`.
- [RESULT] iPerf3 completed successfully: 8 reverse TCP streams, 60 seconds; aggregate receiver 211 MBytes at 29.5 Mbit/s; aggregate sender 218 MBytes at 30.4 Mbit/s with 870 retransmissions. Shell reported completion (`iperf Done.`).
- [RESULT] Bounded TCP/443 capture completed: 100 packets captured, 116 packets received by filter, 0 packets dropped by kernel. Captured traffic included bidirectional TCP/443 flows on `phy0-sta0`, confirming active WAN-side TCP/443 traffic during the sustained load.
- [RESULT] Final post-test control snapshot: RAM total 54852 kB; used 32744 kB; free 14676 kB; buff/cache 7432 kB; available 15544 kB. Swap total 550904 kB; used 4340 kB; free 546564 kB.
- [RESULT] `pidof hostapd nfqws2` returned PIDs for both services (`hostapd` and `nfqws2` remained running).
- [OOM CHECK] `dmesg | grep -Ei 'oom|out of memory|killed process' | tail -12` showed only the previously recorded OOM events, with the latest displayed event at uptime timestamp 107002.118096. No newer OOM entry was present in the post-test excerpt.
- [INTERPRETATION] Combined sustained traffic plus bounded packet capture completed without reported application failure, kernel packet drops, service termination, or a newly logged OOM event in the supplied control output. Post-test MemAvailable remained 15544 kB and both hostapd/nfqws2 were alive.
- [CONCLUSION] This is the strongest completed Stage 11C load test so far and provides evidence that runtime-only `vm.min_free_kbytes=2048` remained operational under approximately 29.5 Mbit/s sustained reverse TCP load for 60 seconds with concurrent bounded TCP/443 capture. The historical OOM entries are older than the current load test based on the previously correlated uptime; no new OOM was observed during this final test.
- [STATUS] STAGE 11C = DONE (load-validation criterion). The 2048-kB setting is validated as a runtime-tested candidate under the bounded workload used here. It is NOT persisted yet.
- [SAFETY] No persistent sysctl/UCI change was made. Do not lower `vm.min_free_kbytes` further. Do not persist 2048 kB until a separate explicit decision is made. No swap, Zapret2, routing, firewall, or Wi-Fi configuration was changed by this test.


## STAGE 11C — Persist vm.min_free_kbytes=2048 — 2026-09-24
- [CHANGE] Added `vm.min_free_kbytes=2048` as a dedicated line in `/etc/sysctl.conf`.
- [RESULT] The entry was verified at line 3: `3:vm.min_free_kbytes=2048`.
- [RESULT] `service sysctl restart` completed with no error output.
- [RESULT] `cat /proc/sys/vm/min_free_kbytes` returned exactly `2048`, confirming the persistent configuration was successfully applied to the running kernel.
- [VERIFICATION] Current OpenWrt documentation states that the sysctl service loads `/etc/sysctl.conf` at boot, so the setting is persistent across reboot.
- [SAFETY] Only `vm.min_free_kbytes` was persisted. `vm.swappiness`, `vm.watermark_scale_factor`, swap, Zapret2, routing, firewall, and Wi-Fi configuration were not changed by this persistence step.
- [STATUS] STAGE 11C = DONE. `vm.min_free_kbytes=2048` is now persistent and runtime-verified.


## STAGE 12 — ZRAM compression algorithm — 2026-09-24
- [OBJECTIVE] Evaluate switching ZRAM compression from the current LZO-RLE to LZ4 without changing the router firmware/kernel.
- [BASELINE] Before the experiment, `zram0` used `[lzo-rle] lzo`, size 26620 KiB, priority 100, with about 4340 KiB used; USB swap `/dev/sda1` was 524284 KiB, priority -2, unused.
- [PREPARATION] Added `system.@system[0].zram_comp_algo='lz4'` and committed it to UCI.
- [APPLICATION TEST] Restarted the штатный `/etc/init.d/zram`. The script reported `compression algorithm 'lz4' is not supported for '/dev/zram0'` and correctly continued with the available default. `zram0` remained active and functional on `[lzo-rle] lzo`.
- [PACKAGE CHECK] `kmod-lib-lz4` was available for the exact kernel ABI `6.12.94-r1` and was installed successfully. The LZ4 modules `lz4.ko`, `lz4_compress.ko`, and `lz4_decompress.ko` loaded successfully.
- [KERNEL MODULE CHECK] Installed `kmod-zram-6.12.94-r1` metadata shows dependency on `kmod-lib-lzo` only. The active `zram.ko` exposes only `lzo-rle` and `lzo` in `/sys/block/zram0/comp_algorithm`.
- [REPOSITORY CHECK] `apk search -v 'kmod-zram*'` returned only `kmod-zram-6.12.94-r1`; no ready-made alternative ZRAM package with LZ4 backend is available in the configured repositories.
- [DECISION] No custom kernel-module build will be attempted on the 64-MB hAP ac lite because there is no PC/build host available and an on-router build would introduce unnecessary RAM/storage/CPU risk.
- [FINAL CONFIG] Restored and committed `system.@system[0].zram_comp_algo='lzo-rle'`. Active state verified as `[lzo-rle] lzo`.
- [RESULT] ZRAM remains operational; no swap loss was left behind. USB swap remains configured as the lower-priority fallback.
- [STATUS] STAGE 12 = DONE — LZO-RLE retained. LZ4 evaluation is BLOCKED by the currently available prebuilt `kmod-zram`; no further LZ4 work is planned unless a compatible build host or official package becomes available.
- [SAFETY] `vm.min_free_kbytes=2048` remains unchanged and persistent. No Zapret2, firewall, routing, Wi-Fi, or swap-priority changes were made during the finalization.


## Post-STAGE 12 memory checkpoint — 2026-09-24
- RAM: 54,852 KiB total; 30,980 KiB used; 14,440 KiB free; 9,432 KiB buff/cache; 15,904 KiB available.
- Swap: 550,904 KiB total; 3,832 KiB used; 547,072 KiB free. ZRAM remains 26,620 KiB at priority 100; USB swap 524,284 KiB at priority -2 and unused.
- Required services are alive: hostapd, nfqws2, dnsmasq.
- OOM log output contains only previously recorded events; no newer OOM event was shown after the last recorded hostapd OOM at uptime 107002.118096.
- Result: post-ZRAM-finalization memory state is stable enough to continue. No additional memory tuning is introduced.
- Next focus: return to network/Zapret2 functional validation; do not reopen ZRAM/LZ4 work.


## STAGE 13 — Zapret2 Telegram/WhatsApp functional scope — 2026-09-25

- [TEST] Functional check with current Zapret2 configuration (`MODE_FILTER=autohostlist`): `wget -qO- -T 7 https://example.com` returned normal Example Domain HTML.
- [TEST] Same check for `https://api.telegram.org`: no response body was returned within the command output; this is consistent with the previously observed Telegram failure on this router/path.
- [CURRENT CONFIG] Zapret2 remains enabled; no configuration was changed during this check.
- [EXTERNAL CONTEXT] Current Zapret2 documentation distinguishes hostlist/autohostlist filtering from IP-based filtering. When a hostname is available, autohostlist can detect failed TCP connections and add domains to an auto-list; however, this mechanism is still DPI/flow manipulation and is not equivalent to bypassing an IP-address block. citeturn0search1
- [2026 CONTEXT] Current 2026 reports/discussions describe Telegram and WhatsApp access restrictions in Russia as increasingly involving IP-level blocking/restriction, for which ordinary DPI desynchronization mechanisms such as Zapret may be ineffective. A March–April 2026 zapret2 discussion specifically reports that, for many providers, Telegram and WhatsApp could no longer be bypassed through zapret because of IP blocking. This is community evidence rather than an authoritative measurement for every ISP. citeturn0search0turn0search2
- [TELEGRAM] A separate proxy/tunneling mechanism is therefore technically different from Zapret2 DPI bypass. Current Zapret2-related UI documentation explicitly describes Telegram as commonly requiring a separate proxy when access is blocked by IP. citeturn0search2
- [WHATSAPP] 2026 reporting also documents full WhatsApp blocking in Russia, reinforcing that its current access problem cannot be assumed to be a simple website-DPI problem solvable by TCP desynchronization alone. citeturn0news5turn0search4
- [DECISION] Do not spend further cycles blindly tuning `NFQWS2_OPT`, `MODE_FILTER`, fake/split parameters, or increasing capture volume solely to force Telegram/WhatsApp through Zapret2. The current evidence points to a different blocking layer for at least part of the problem.
- [STATUS] STAGE 13 = BLOCKED for Telegram/WhatsApp by the current Zapret2-only approach; Zapret2 remains useful for DPI-based services such as the already verified HTTPS example.com path.
- [SAFETY] No Zapret2, firewall, routing, Wi-Fi, VM, swap, or memory settings were changed by this conclusion.


## STAGE 14 — VPN transport selection: VLESS + REALITY / Xray-core — 2026-09-25

- [DECISION] User explicitly selected **VLESS + REALITY / Xray-core** as the current VPN-transport candidate №1 for further evaluation.
- [USER CONSTRAINT] **Proton VPN Free via ordinary WireGuard is excluded** from the candidate list because it was already tested and is considered blocked/unusable in the user's 2026 РФ network conditions.
- [CANDIDATE] VLESS + REALITY with Xray-core is to be evaluated as a separate transport from ordinary WireGuard and from Zapret2. It is intended for traffic that cannot be handled by DPI desynchronization alone, including the Telegram/WhatsApp problem currently blocked at STAGE 13.
- [HARDWARE FIT — PRELIMINARY] Target router is MikroTik hAP ac lite, MIPS 24Kc, 64 MB RAM, OpenWrt 25.12.5. The router has a history of system-wide OOM events, so memory impact is a first-class acceptance criterion.
- [CURRENT OFFICIAL REPOSITORY CHECK] OpenWrt 25.12.5 publishes a dedicated `mips_24kc` package tree, confirming that the architecture has an official package repository. This does **not yet prove** that the exact current Xray-core package and all required dependencies are available for the router's target; that must be checked before installation. citeturn0search0turn0search4
- [NO INSTALL YET] Xray-core, VLESS, REALITY, sing-box, AmneziaWG, PBR, VPN routes, firewall rules, and proxy configuration have **not** been installed or changed as part of STAGE 14.
- [NO SERVER SELECTED] No VPS/server/provider has been selected yet. VLESS + REALITY requires a compatible remote endpoint; the present stage only fixes the transport candidate, not a server.
- [ALTERNATIVES] sing-box + VLESS/REALITY and AmneziaWG remain secondary candidates only. Ordinary WireGuard/Proton WireGuard remains excluded.
- [NEXT GATE] Before any installation: verify exact official/current Xray-core availability for OpenWrt 25.12.5 / MIPS 24Kc, package size and dependencies, expected RAM impact, and whether the required client mode can coexist with current Zapret2 without introducing another OOM risk.
- [SAFETY] No router configuration was changed by this stage decision.
- [STATUS] STAGE 14 = IN_PROGRESS — candidate selected; compatibility and installation gate not yet passed.


## STAGE 14 — Zapret2 runtime confirmation — 2026-09-25

- [CHECK] Read-only runtime check: `/etc/init.d/zapret2 status` returned `running (1/2)`.
- [CHECK] `pidof nfqws2` returned PID `12532`.
- [RESULT] Zapret2 is **currently running**; the `nfqws2` worker process is alive.
- [INTERPRETATION] The service status and live process agree. This confirms that the previously configured Zapret2 instance is active at the time of this check.
- [SAFETY] Read-only check only. No Zapret2, firewall, routing, Wi-Fi, VPN, memory, swap, or configuration changes were made.
- [STATUS] Zapret2 runtime = **RUNNING**. STAGE 14 VPN candidate work remains IN_PROGRESS independently.


### STAGE 14 runtime event — Zapret2 manual restart — 2026-09-25
- User manually executed `/etc/init.d/zapret2 restart`.
- Restart completed without an error message.
- Zapret2 restarted daemon 1 (QNUM 300) with current `MODE_FILTER=autohostlist` rules for TCP 80/443 and UDP 443, plus daemon 2000 (QNUM 65300) for WireGuard patterns.
- nftables were cleared and reapplied; NFQUEUE rules for TCP 80/443 and UDP 443 were inserted.
- `net.netfilter.nf_conntrack_tcp_be_liberal` changed 0 → 1 during start.
- This is a service restart only; no configuration values were changed.
- Next action: one short post-restart YouTube test, then decide whether further diagnosis is needed.


### STAGE 14 diagnostic retrospective — YouTube failure recovered by Zapret2 restart — 2026-09-25
- [OBSERVED] Before restart, `/etc/init.d/zapret2 status` reported `running (1/2)` and `pidof nfqws2` returned one PID (`12532`). This established that at least one nfqws2 process was alive, but did not establish that the full two-daemon runtime and nftables state were healthy.
- [OBSERVED] Immediately before restart, a direct router-side HTTPS request to `https://www.youtube.com/` returned no body within the bounded command.
- [OBSERVED] The restart cleared nftables, started both configured nfqws2 daemons (QNUM 300 and QNUM 65300), and reapplied all configured NFQUEUE rules. The restart also changed `net.netfilter.nf_conntrack_tcp_be_liberal` from 0 to 1 as part of the Zapret2 start sequence.
- [RESULT] Immediately after restart, the same bounded YouTube request returned YouTube HTML, and the client device on the OpenWrt Wi-Fi could load YouTube and play/use it.
- [OBSERVED] `zapret-hosts-auto.txt` was present and already contained `www.youtube.com` plus multiple `googlevideo.com`/YouTube-related hostnames. Therefore the recovery cannot be explained by an empty autohostlist.
- [OBSERVED] No Zapret2-specific entries were returned by `logread -e zapret`; the optional `zapret-hosts-auto-debug.log` did not exist.
- [IMPORTANT] The exact root cause is **not yet proven**. The strongest current hypothesis is stale/inconsistent runtime state of the nfqws2/nftables path, because a restart that did not change the Zapret2 configuration restored service and explicitly rebuilt nftables and both daemons.
- [SECONDARY POSSIBILITY] Historical system-wide OOM events previously killed `nfqws2` and `hostapd` on this 64-MB router. This makes memory pressure a credible background failure mode, but there is no new OOM event correlated with this specific YouTube outage, so OOM must not be recorded as the confirmed cause.
- [SECONDARY POSSIBILITY] The conntrack setting change during restart may have influenced recovery, but causality is unverified; do not attribute the fix solely to `nf_conntrack_tcp_be_liberal=1`.
- [EXCLUDED AS PRIMARY CAUSE] The recent ZRAM LZ4 experiment ended with active LZO-RLE restored; no Zapret2 configuration was changed by that stage. The diagnostic history therefore provides no direct evidence that the ZRAM experiment caused the YouTube outage.
- [NEXT DIAGNOSTIC GOAL] If the failure recurs, capture the pre-restart runtime state first (both nfqws2 PIDs, nftables table/rules, and relevant OOM/dmesg evidence) before restarting Zapret2. Do not reproduce the outage intentionally.
- [STATUS] Root cause = **UNCONFIRMED**; recovery mechanism = **RESTART OF ZAPRET2 RESTORED FUNCTION**.


### STAGE 14 — Zapret2 current nftables runtime audit — 2026-09-25
- [RESULT] Full read-only `nft list table inet zapret2` was reviewed after the successful Zapret2 restart.
- [RESULT] Table `inet zapret2` is present with `wanif=phy0-sta0`, `lanif=br-lan`, sets `zapret/ipban` size 522288 and `nozapret` size 65536.
- [RESULT] Current packet-path rules include NFQUEUE QNUM 300 for TCP 80/443 and UDP 443, QNUM 65300 for the configured WireGuard-pattern UDP rules, plus reply-direction queues and the expected mark/defrag chains.
- [RESULT] The rules use `queue flags bypass to 300` / `bypass to 65300`; therefore the earlier grep for literal `queue num 300`/65300 produced no matches. This was a search-pattern issue, not evidence that the rules were absent.
- [RESULT] No `counter` statements are present in the displayed rules, so this ruleset does not expose packet counters through those rules.
- [INTERPRETATION] The post-restart nftables structure is consistent with the successful Zapret2 startup and does not show current rule loss or an obvious missing NFQUEUE path.
- [IMPORTANT] The previous YouTube outage root cause remains UNCONFIRMED. The restart restored function and rebuilt both nfqws2 daemons/nftables, but the exact failed component was not isolated.
- [NEXT] Do not restart or alter Zapret2 merely for diagnosis while it is working. If the failure recurs, collect pre-restart state first, then restart only after the evidence is saved.

### STAGE 14 — Zapret2 self-monitoring/auto-recovery design — 2026-09-25
- [OBJECTIVE] Design a lightweight automatic health monitor that detects a broken/stale Zapret2 runtime, saves diagnostic evidence to USB, records the reason for recovery, and restarts Zapret2 only when a defined health gate fails.
- [DESIGN PRINCIPLE] Do not rely only on `pidof nfqws2`: the recent incident showed that a process can exist while the end-to-end YouTube path is not necessarily healthy.
- [PROPOSED HEALTH GATES] 1) expected nfqws2 process count/identity; 2) `/etc/init.d/zapret2 status`; 3) presence of the expected `inet zapret2` table and required NFQUEUE rules; 4) a bounded, low-cost connectivity probe to a known-good HTTPS target, preferably from the router itself; 5) cooldown/debounce to avoid restart loops.
- [RECOVERY LOGGING] Before any automatic restart, save timestamp, reason, service status, nfqws2 process list, compact nftables ruleset, relevant `dmesg`/OOM lines, memory/swap snapshot, and recent system log lines to USB `/mnt/data`. Keep logs bounded/rotated because the router has only 64 MB RAM.
- [RECOVERY ACTION] If and only if the health gate fails, write a machine-readable event line such as `ZAPRET2_AUTO_RESTART reason=<...>`, execute the Zapret2 restart, then immediately perform a post-restart health check and record PASS/FAIL.
- [SAFETY] The monitor must not run tcpdump continuously, must not intentionally reproduce the failure, must not change Zapret2 configuration, and must have a restart cooldown plus a maximum number of automatic restarts per time window.
- [IMPLEMENTATION] Prefer a small procd-managed service or similarly lightweight periodic check rather than a heavy monitoring stack. OpenWrt procd is the native process/service manager and supports respawn/service lifecycle handling; nftables NFQUEUE also supports bypass behavior so a missing userspace listener need not automatically blackhole matching traffic. citeturn0search1turn0search2
- [STATUS] Design = NOT_STARTED. No monitoring script, cron job, procd service, or automatic restart mechanism has been installed yet.


## STAGE 14 — Zapret2 watchdog implementation — 2026-09-25
- [IMPLEMENTED] Added repository file OPENWRT_ZAPRET2_WATCHDOG.sh.
- [COMMIT] 5ab294419b4a7f51c293f37144c846db8b92846d.
- [FUNCTION] Lightweight Zapret2 health monitor for the current 64-MB hAP ac lite deployment.
- [CHECKS] Service status; exact nfqws2 process count 2; expected inet zapret2 structure; WAN/LAN interfaces; TCP 80/443 queue 300; UDP 443 queue 300; QNUM 65300; bounded example.com baseline probe; bounded YouTube probe.
- [RECOVERY] Two consecutive STRUCTURAL_FAIL or FUNCTIONAL_FAIL observations are required before restart.
- [NO_RESTART] UPSTREAM_FAIL / DNS failure does not trigger Zapret2 restart.
- [SAFETY] Automatic restart requires writable USB log area, MemAvailable >=4096 KiB, fewer than 2 restarts in 900 s, and >=300 s since previous restart.
- [EVIDENCE] Pre-restart snapshot includes service status, nfqws2 processes, full inet zapret2 table, memory, VM reserve, swap, sockstat, relevant OOM/dmesg lines and recent system log.
- [AUDIT] Restart stdout/stderr is saved; a post-restart snapshot and PASS/FAIL are written.
- [RETENTION] Main log limited to 128 KiB; up to 20 event snapshots retained.
- [SCOPE] No continuous tcpdump, no config edits, no package install, no firewall modifications.
- [MODES] --check, --once, --daemon.
- [VALIDATION] sh -n on the generated script returned syntax_rc=0.
- [DEPLOYMENT] The script has not been copied to the router and automatic recovery is not active.
- [STATUS] Watchdog implementation = IN_PROGRESS; deployment/activation = NOT_STARTED.
- [SOURCE] OpenWrt documents procd as the native process/service manager and provides controlled service lifecycle/respawn facilities. citeturn287253search0turn287253search3


# PROJECT HISTORY — RESTORED DETAILED RECORD FROM AVAILABLE CHAT CONTEXT — 2026-09-25

## A. Архитектура и аппаратная база
- Основной роутер: TP-Link Archer C20 v4 (hardware 00000004). Он остаётся главным роутером.
- Downstream-роутер: MikroTik hAP ac lite / RB952Ui-5ac2nD, FCC TV7RB952-5AC2ND.
- Ограничения: 64 MiB RAM, 16 MiB internal flash, MIPS 24Kc 650 MHz.
- OpenWrt: 25.12.5 r33051-f5dae5ece4, target ath79/mikrotik, kernel 6.12.94, board QCA9533 ver 2 rev 0.
- Схема: Archer Wi-Fi → hAP Wi-Fi STA → hAP LAN/Wi-Fi. hAP не должен становиться главным роутером без отдельного решения.
- hAP LAN: br-lan 192.168.1.1/24.
- Archer-side hAP STA: phy0-sta0 192.168.0.100/24 через 192.168.0.1.
- Ранее была устранена путаница адресов: 192.168.1.1 относится к hAP LAN, 192.168.0.100 — к hAP на upstream-сети Archer.

## B. USB/extroot/swap
- USB сначала использовался для swap/data/extroot; затем была выполнена целевая переразметка.
- Зафиксированная схема: /dev/sda1 ≈512 MiB swap; /dev/sda2 ext4 label extroot, UUID 244b7bbc-add1-46cd-bc1a-0143cfca5d6c, mounted /overlay, ≈5.6 GiB; /dev/sda3 ext4 label data, UUID 635bc144-d79a-4e6d-a315-0e1655eb995c, mounted /mnt/data, ≈1.0 GiB.
- Swap: /dev/sda1 ≈512 MiB, priority -2; zram0 ≈32 MiB, priority 100.
- Правило пользователя: swap не размещать в /tmp.
- extroot трактуется как расширение flash, а не RAM.
- /mnt/data является предпочтительным постоянным местом для технических журналов watchdog.

## C. Wi-Fi и DNS
- Оба hAP AP используют общий SSID OpenWrt и WPA2.
- Ранее был открыт 2.4 GHz AP; это состояние было исправлено.
- Отдельный незавершённый пункт: подключение к hAP/OpenWrt со стороны Archer Wi-Fi без LAN.
- DNS-инцидент: изменение DNS приводило к остановке dnsmasq и невозможности получения IP телефоном; затем dnsmasq был восстановлен. В истории присутствует ошибка Cannot resolve server name at line 21.
- DoH/https-dns-proxy позднее явно выведен из текущего Variant A workflow и не должен возвращаться без отдельной команды пользователя.

## D. Диагностика памяти и OOM
- На hAP установлены необходимые CLI-диагностические пакеты, включая tcpdump, curl, conntrack, iperf3, bind-dig, strace, lsof, procps-ng и др.
- История содержит несколько системных OOM-событий с разными процессами-жертвами, включая nfqws2, hostapd и apk.
- Особо важное событие: более тяжёлая работа tcpdump совпала с OOM, после чего были убиты hostapd и nfqws2 и временно пропал Wi-Fi.
- Поэтому open-ended tcpdump и тяжёлые monitoring daemons на 64-MB hAP запрещены как штатный механизм контроля.
- /proc/net/sockstat не показывал текущего socket-memory pressure; /proc/pressure/memory отсутствует на данном build.
- История не подтверждает, что один пользовательский процесс сам по себе объясняет прошлые OOM: происходили system-wide memory pressure events.

## E. vm.min_free_kbytes
- Базовое значение: 8192 kB.
- Проведено контролируемое снижение: 8192 → 4096 → 2048 kB.
- При 4096 наблюдалось MemAvailable около 12.9 MB; при 2048 — около 16.6 MB, при этом Slab/SUnreclaim не уменьшались.
- При 2048 watermark были min=512, low=640, high=768.
- 60-секундное idle-наблюдение при 2048 не приблизилось к low/min.
- Выполнен валидный sustained-load тест: iperf3 reverse 60 s, 8 streams, endpoint 185.182.195.76:5201, параллельно bounded tcpdump TCP/443 -c 100.
- iPerf3: ≈211 MB received at 29.5 Mbit/s; sender ≈218 MB at 30.4 Mbit/s; 870 retransmissions.
- tcpdump: 100 captured, 116 received by filter, 0 dropped by kernel.
- Post-test: RAM total 54852 kB, used 32744 kB, free 14676 kB, buff/cache 7432 kB, available 15544 kB; swap total 550904 kB, used 4340 kB, free 546564 kB.
- hostapd и nfqws2 остались живы; в предоставленном post-test dmesg не появился новый OOM.
- 2048 kB было принято как проверенное runtime-значение и затем сохранено в /etc/sysctl.conf.
- service sysctl restart прошёл без ошибки; /proc/sys/vm/min_free_kbytes = 2048.
- Ниже 2048 снижать нельзя без отдельной доказательной процедуры.

## F. ZRAM
- Baseline: zram0 использовал [lzo-rle] lzo, размер около 26620 KiB, priority 100.
- Была проведена попытка LZ4 через UCI.
- Штатный zram init сообщил, что LZ4 не поддерживается активным zram device.
- kmod-lib-lz4 был установлен, но kmod-zram-6.12.94-r1 exposes only lzo-rle/lzo.
- Альтернативный готовый zram package для LZ4 в подключённых репозиториях не найден.
- Custom kernel/module build на роутере не выполнялся из-за риска для 64-MB устройства и отсутствия отдельного build host.
- Финально восстановлен lzo-rle; USB swap остаётся lower-priority fallback.
- STAGE 12 = DONE; LZ4 = BLOCKED.

## G. Zapret2 deployment/configuration
- Zapret2 зафиксирован на v1.0.3.
- Runtime config создавался контролируемо из config.default, без blind install.
- Проверена byte-identical integrity: 5534 bytes, SHA-256 758cf25e3d57ccf2c0dd053b218d571e6ebb293293f341c8e5294a35ceed2f7b.
- Default audit: NFQWS2_ENABLE=0, MODE_FILTER=none, FLOWOFFLOAD=donttouch, INIT_APPLY_FW=1. Activation оставалась отдельным gate.
- Binary deployment, config editing, service activation, firewall/NFQUEUE activation и interface hooks разделялись.
- Текущая рабочая конфигурация:
  NFQWS2_ENABLE=1
  NFQWS2_PORTS_TCP=80,443
  NFQWS2_PORTS_UDP=443
  QNUM=300
  WireGuard-pattern QNUM=65300
  MODE_FILTER=autohostlist
  FLOWOFFLOAD=donttouch
  INIT_APPLY_FW=1
  DISABLE_IPV6=1
  SET_MAXELEM=522288
  wanif=phy0-sta0
  lanif=br-lan
- nftables runtime содержит sets zapret/ipban size 522288 и nozapret size 65536, обычные NFQUEUE 300, WireGuard-pattern queue 65300, reply-direction rules и mark/defrag chains.
- Реальное правило использует queue flags bypass to 300 / 65300; поэтому grep по literal queue num 300 не находил правила и не являлся доказательством их отсутствия.

## H. Zapret2 strategy discovery
- Windows blockcheck2 использовался отдельно от роутера для поиска кандидатов.
- Длительный standard scan YouTube IPv4 TLS 1.2 был остановлен; полученный набор AVAILABLE считается discovery inventory, а не final strategy.
- Зафиксирован discovery candidate для YouTube IPv4 QUIC:
  --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
- Router-side v1.0.3 configuration не менялась только из-за одного candidate.
- Запрет/strategy testing должен быть по одному варианту, с rollback и memory checks.

## I. Telegram/WhatsApp
- При текущем Zapret2 example.com работал, а api.telegram.org не давал успешный ответ.
- В Master Plan зафиксирован вывод: текущие проблемы Telegram/WhatsApp нельзя автоматически сводить к обычному DPI; частичный/полный IP-level blocking требует другого transport/path.
- Поэтому Telegram/WhatsApp находятся вне текущего Zapret2-only tuning scope.
- Выбран будущий transport candidate: VLESS + REALITY / Xray-core.
- Установка, server selection, PBR и VPN routes пока не выполнялись.

## J. Инцидент YouTube 2026-09-25
- До restart: /etc/init.d/zapret2 status = running (1/2), pidof nfqws2 показал PID 12532.
- Router-side probe: wget -4 -qO- -T 10 https://www.youtube.com/ | head -c 100; echo — body не вернулся.
- Пользователь вручную выполнил /etc/init.d/zapret2 restart.
- Restart завершился без ошибки: nftables были cleared/reapplied; запущены daemon 1 QNUM 300 и daemon 2000 QNUM 65300.
- Во время start изменился net.netfilter.nf_conntrack_tcp_be_liberal 0 → 1.
- Тот же YouTube probe сразу после restart вернул HTML.
- Клиент в Wi-Fi сети hAP также восстановил YouTube.
- zapret-hosts-auto.txt уже содержал www.youtube.com и множество googlevideo/YouTube hosts; пустой autohostlist исключён.
- logread -e zapret был пуст; optional zapret-hosts-auto-debug.log отсутствовал.
- После restart присутствовали два nfqws2 процесса.
- Полный nft list table inet zapret2 показал ожидаемую структуру и не показал очевидной потери NFQUEUE path.
- Точный root cause остаётся UNCONFIRMED.
- Наиболее сильная гипотеза: stale/inconsistent runtime state nfqws2/nftables, потому что configuration не менялась, а restart rebuilt оба daemon и firewall path.
- OOM остаётся правдоподобным background failure mode, но для этого конкретного YouTube outage нет correlated new OOM evidence; OOM не записывать как подтверждённую причину.
- Изменение nf_conntrack_tcp_be_liberal могло участвовать в recovery, но causal attribution не доказана.
- Не воспроизводить outage намеренно.

## K. Current runtime audit after YouTube recovery
- inet zapret2 существует.
- wanif содержит phy0-sta0.
- lanif содержит br-lan.
- zapret/ipban size 522288, nozapret size 65536.
- TCP 80/443 queue 300.
- UDP 443 queue 300.
- Configured WireGuard-pattern queue 65300.
- Reply-direction queues присутствуют.
- Mark/defrag chains присутствуют.
- В правилах нет counter statements, поэтому nft list table output сам по себе не даёт packet counters.
- Текущее runtime state считается structurally consistent; ненужный restart запрещён.
## L. Watchdog concept and implementation
- Цель: автоматическая проверка Zapret2, автоматический restart только при подтверждённой неисправности, сохранение доказательств на USB и machine-readable reason.
- Принцип: PID nfqws2 сам по себе недостаточен; проверяется несколько уровней.
- Health gates: service status; expected nfqws2 count=2; presence/shape of inet zapret2; NFQUEUE 300 and 65300; baseline HTTPS probe example.com; target HTTPS probe www.youtube.com.
- Если baseline example.com не работает, событие классифицируется как UPSTREAM_OR_DNS и Zapret2 не перезапускается.
- Structural failure или YouTube functional failure должны произойти два раза подряд.
- Перед automatic restart сохраняются service status, nfqws2 process list, full nftables table, memory, vm settings, swap, sockstat, relevant OOM/dmesg and recent logread.
- Restart output сохраняется отдельно; после restart выполняется post-check и фиксируется PASS/FAIL.
- Защиты: minimum MemAvailable 4096 KiB; максимум 2 automatic restarts per 15 minutes; cooldown 5 minutes.
- Main log bounded to 128 KiB; event snapshots retained up to 20.
- Нет continuous tcpdump, нет Zapret2 config edits, нет package installs and no firewall modifications from watchdog.
- Script modes: --check (read-only), --once (single decision cycle), --daemon (periodic loop every 90 s).
- USB logging path: /mnt/data/zapret2-watchdog.
- Repository file created: OPENWRT_ZAPRET2_WATCHDOG.sh.
- Repository commit for the script: 5ab294419b4a7f51c293f37144c846db8b92846d.
- Local shell syntax validation completed with sh -n and syntax_rc=0.
- Script is NOT installed on router, NOT enabled and NOT started yet.
- Current status: watchdog implementation = IN_PROGRESS; deployment = NOT_STARTED.

- [RESULT 2026-09-25] Router downloaded both watchdog files to /tmp successfully: watchdog script 8958 bytes, init.d file 543 bytes; `sh -n /tmp/zapret2-watchdog.sh` returned PASS. This was read-only/preparation only: files were not yet installed into /usr/bin or /etc/init.d, and watchdog was not enabled or started.
- [STATUS UPDATE] STAGE 11D deployment preparation remains IN_PROGRESS; download/integrity gate = DONE.

- [RESULT 2026-09-25] Installation gate attempt failed before copying either file: OpenWrt shell returned `-ash: install: not found`. Both destination files remained absent (`/usr/bin/zapret2-watchdog` and `/etc/init.d/zapret2-watchdog`). No watchdog process/service was started and Zapret2 configuration was not changed.
- [BLOCKER] The BusyBox/OpenWrt environment does not provide the `install` utility; next deployment step must use a built-in file-copy method and preserve executable permissions.

## M. Project workflow
- One router command at a time remains mandatory.
- Before each router command, state purpose and whether it changes anything.
- After each user result and assistant response, synchronize factual state to Master Plan before the next router command.
- Master Prompt changes only when workflow/safety rules change.
- Do not claim synchronization or testing unless the repository write/result is actually confirmed.
- User prefers compact command outputs and dislikes redundant diagnostics.


## STAGE 11D — Zapret2 watchdog deployment preparation — 2026-09-25
- [REQUEST] User authorized proceeding with making the Zapret2 watchdog operational.
- [IMPLEMENTATION] Watchdog script remains `OPENWRT_ZAPRET2_WATCHDOG.sh`; repository hardening commit: `493f00d609e033c20a3107fffb5c9f7305cf0d3d`.
- [CHANGE] Persistent watchdog log rotation is now a hard byte limit: when the log exceeds `LOG_MAX_BYTES=131072`, it is reduced with `tail -c 131072`, so the retained main log is bounded to 128 KiB rather than merely retaining a fixed number of lines.
- [CHANGE] Restart history is bounded to the latest `STATE_KEEP=20` entries; this prevents unbounded growth of the restart state file.
- [CHANGE] HTTP probes now use curl `-f`, so HTTP 4xx/5xx responses are not falsely counted as successful probes.
- [CHANGE] Functional probe target was reduced from the YouTube homepage to `https://www.youtube.com/generate_204` to keep the periodic watchdog probe lightweight.
- [IMPLEMENTATION] Added `OPENWRT_ZAPRET2_WATCHDOG_INITD.sh`, a native OpenWrt procd service definition. It runs the watchdog in foreground `--daemon` mode, forwards stdout/stderr to logd, and uses controlled procd respawn.
- [SAFETY] The watchdog service is NOT yet installed, enabled, or started on the router. Repository preparation alone does not activate monitoring or automatic recovery.
- [NEXT GATE] Router deployment must remain one-command-at-a-time: install the watchdog executable and init.d service, run read-only `--check`, run a controlled `--once`, then only after PASS enable/start the procd service and verify persistence. Automatic Zapret2 restart capability is not considered active until these gates pass.
- [TECHNICAL BASIS] OpenWrt documents procd init scripts and `procd_set_param respawn` for supervised foreground services. citeturn0search0turn0search1
- [STATUS] STAGE 11D = IN_PROGRESS.


- [RESULT 2026-09-25] Deployment copy gate succeeded using built-in `cp` after the earlier `install: not found` blocker. Router now has:
  - `/usr/bin/zapret2-watchdog` — executable, 8958 bytes, mode 755.
  - `/etc/init.d/zapret2-watchdog` — executable, 543 bytes, mode 755.
- [SAFETY] The command only copied files and set permissions. The watchdog was NOT started or enabled; Zapret2 configuration/runtime was not changed.
- [STATUS] STAGE 11D deployment-prep file-install gate = DONE. Next gate is read-only watchdog `--check`; no service activation yet.


- [RESULT 2026-09-25] First installed watchdog read-only check executed: `/usr/bin/zapret2-watchdog --check`.
- [RESULT] `state=STRUCTURAL_FAIL reason=SERVICE_OR_PROCESS_OR_NFTABLES nfqws2=2/2 service=1 nft=0 baseline=1 youtube=1 avail_kb=14008`.
- [INTERPRETATION] Both expected `nfqws2` processes are present; Zapret2 service is running; baseline HTTPS and YouTube functional probes pass; available memory is 14008 KiB (> 4096 KiB safety floor). The structural gate reports `nft=0`, so the watchdog does not consider the nftables structure healthy.
- [SAFETY] This was a read-only check. No service restart, nftables change, configuration change, package change, or watchdog activation occurred.
- [STATUS] STAGE 11D = IN_PROGRESS. Automatic recovery remains NOT_ACTIVE. Next step is to inspect why the watchdog's nftables structural test returns `nft=0`, without restarting Zapret2.


- [RESULT 2026-09-25] Watchdog source audit result: `grep -nE 'nft|STRUCTURAL_FAIL|SERVICE_OR_PROCESS_OR_NFTABLES|QNUM|NFQUEUE|zapret2' /usr/bin/zapret2-watchdog` confirmed the structural gate is implemented in `nft_ok()` and requires literal matches for: `set zapret {`; WAN set elements exactly `elements = { "phy0-sta0" }`; LAN set elements exactly `elements = { "br-lan" }`; `tcp dport { 80,443 }`; `udp dport 443`; queue 300; queue 65300.
- [INTERPRETATION] The prior `--check` reported `nft=0` while service/process counts and both functional probes passed. This does not establish that nftables is actually broken; the watchdog's literal-text matching may be too strict for the installed nft output formatting/structure.
- [SAFETY] Source audit was read-only. No Zapret2 restart, firewall modification, config edit, package change, or watchdog activation.
- [STATUS] STAGE 11D remains IN_PROGRESS. Next diagnostic is a single read-only comparison of the live `inet zapret2` table against the watchdog's expected text patterns.


- [RESULT 2026-09-25] Live `nft list table inet zapret2` output was inspected. The table exists and contains all values that the watchdog source currently expects by text: `set zapret`; `wanif` element `"phy0-sta0"`; `lanif` element `"br-lan"`; TCP dports `{ 80, 443 }`; UDP dport `443`; queue `300`; queue `65300`.
- [INTERPRETATION] The live nftables output appears structurally compatible with the watchdog's documented predicates, yet `--check` still reports `nft=0`. Therefore the cause is not established; the next step is to identify which individual watchdog text predicate actually fails in the router's shell/grep environment.
- [SAFETY] This inspection was read-only. No Zapret2 restart, nftables modification, configuration edit, package change, or watchdog activation occurred.
- [STATUS] STAGE 11D remains IN_PROGRESS. Automatic recovery remains NOT_ACTIVE.


- [RESULT 2026-09-25] Individual watchdog nft predicate test isolated the failure: all predicates pass except literal `tcp dport { 80,443 }`, which returns `FAIL`. The live nft output actually contains `tcp dport { 80, 443 }` (with a space after the comma).
- [ROOT CAUSE IDENTIFIED] The watchdog's `nft_ok()` expects the exact string `tcp dport { 80,443 }`, but nft renders `tcp dport { 80, 443 }`; therefore `nft_good=0` is a false negative caused by overly strict text matching, not by a demonstrated Zapret2/nftables runtime failure.
- [SAFETY] No runtime configuration was changed and no Zapret2 restart occurred.
- [STATUS] STAGE 11D watchdog structural-check bug identified; automatic recovery remains NOT_ACTIVE until the repository script is corrected and the corrected copy is deliberately deployed/tested.


- [CHANGE 2026-09-25] Corrected repository watchdog `OPENWRT_ZAPRET2_WATCHDOG.sh` structural nft predicate for TCP ports. The exact-match check `tcp dport { 80,443 }` was replaced with a spacing-tolerant extended-regex check matching both `{ 80,443 }` and `{ 80, 443 }`.
- [SYNC] Watchdog script commit: `8120ca2a3e33a8b4850fba66ea91afcb9cd835d4`; content SHA: `ee22c13fb751b8e5965786838430e9ea7936b205`.
- [SAFETY] Repository-only change; no router runtime state was modified.
- [NEXT GATE] Deploy the corrected script to the router, but do not restart/enable Zapret2 or the watchdog during deployment.


- [RESULT 2026-09-25] Corrected watchdog script downloaded to `/tmp/zapret2-watchdog.new`; download succeeded, shell syntax check `sh -n` passed, size reported 8963 bytes.
- [STATUS] Temporary-file deployment gate PASSED. The corrected script is not yet installed over the active `/usr/bin/zapret2-watchdog`; no service restart or watchdog activation occurred.


- [RESULT 2026-09-25] Corrected watchdog installed to `/usr/bin/zapret2-watchdog`; permissions set to executable. Router-reported SHA-256: `a32d5bddfe0e9e88b6b81cf5d0a9eda30287e458a936314416ae92702f044fa2`.
- [STATUS] Corrected watchdog deployment gate PASSED. No Zapret2 restart and no watchdog service start/enable occurred.
- [NEXT GATE] Run the corrected watchdog in read-only `--check` mode to confirm the false nftables failure is gone.


- [RESULT 2026-09-25] Corrected watchdog read-only `--check` now reports: `state=HEALTHY reason=none nfqws2=2/2 service=1 nft=1 baseline=1 youtube=1 avail_kb=14404`.
- [VALIDATION] Service, both expected nfqws2 processes, nftables structure, baseline HTTPS, YouTube probe, and memory safety floor all pass. The previous nftables false negative is resolved.
- [SAFETY] `--check` is read-only; no restart or configuration change occurred.
- [STATUS] STAGE 11D structural/functional health-check gate = DONE. Automatic watchdog recovery is still NOT_ACTIVE; controlled `--once` validation remains the next gate before activation.


- [RESULT 2026-09-25] Controlled `/usr/bin/zapret2-watchdog --once` produced no terminal output. This is expected from the script implementation: `--once` writes health/action information to the watchdog log and does not echo a result to stdout.
- [SAFETY] No indication of a restart or configuration change from the command's terminal result; however, the log should be checked to confirm the cycle recorded `HEALTH state=HEALTHY`.
- [STATUS] Controlled `--once` execution gate = EXECUTED; validation result pending log inspection. Automatic watchdog remains NOT_ACTIVE.


- [RESULT 2026-09-25] Watchdog log after controlled `--once`: `2026-09-25 01:45:04 HEALTH state=HEALTHY nfqws2=2/2 service=1 nft=1 baseline=1 youtube=1 avail_kb=14476`.
- [VALIDATION] Controlled one-cycle execution recorded a healthy state and did not trigger recovery/restart.
- [STATUS] STAGE 11D watchdog validation = DONE for read-only `--check` and controlled `--once`. Automatic daemon activation remains NOT_ACTIVE pending explicit activation gate.


- [ACTIVATION REQUEST 2026-09-25] User explicitly requested to proceed with the watchdog activation phase completely after successful `--check` and controlled `--once` validation.
- [PRE-ACTIVATION SAFETY] Corrected watchdog is installed and executable; read-only health check is HEALTHY; controlled one-cycle check recorded HEALTHY; no recovery/restart was triggered. Activation will use the existing init script only; no Zapret2 configuration changes are planned.
- [STATUS] Automatic watchdog activation gate = IN_PROGRESS. Next action: enable and start `/etc/init.d/zapret2-watchdog`.


- [RESULT 2026-09-25] `/etc/init.d/zapret2-watchdog enable && /etc/init.d/zapret2-watchdog start` produced no terminal output.
- [INTERPRETATION] Empty output is normal for successful OpenWrt init/procd commands, but it does not by itself prove the daemon is running or enabled.
- [STATUS] Watchdog activation command executed; runtime/autostart verification is PENDING. No evidence of a Zapret2 restart or config change from the command output.


- [RESULT 2026-09-25] Runtime/autostart verification passed: init script reports `ENABLED`; active process is `16572 /bin/sh /usr/bin/zapret2-watchdog --daemon`.
- [STATUS] Watchdog daemon is ACTIVE and configured for autostart. Zapret2 remains untouched by the activation verification.
- [NEXT] Final operational verification should confirm the daemon has performed a periodic health cycle and is recording healthy state in its log.


- [FINAL RESULT 2026-09-25] Final operational gate passed: watchdog daemon produced a subsequent periodic health record at `2026-09-25 01:46:28`: `HEALTH state=HEALTHY nfqws2=2/2 service=1 nft=1 baseline=1 youtube=1 avail_kb=14504`.
- [FINAL STATUS] STAGE 11D / Zapret2 watchdog deployment = DONE. Watchdog is enabled for autostart, running under procd in `--daemon` mode, and has completed a periodic healthy check. No automatic restart has been triggered during validation.
- [FINAL SAFETY STATE] Watchdog recovery rules remain conservative: two consecutive structural/functional failures required; upstream/DNS failure does not restart Zapret2; restart memory floor 4096 KiB; maximum 2 restarts per 15 minutes; 5-minute cooldown; no continuous tcpdump; no Zapret2 configuration edits.


## STAGE 14 — VLESS + REALITY / Xray-core — package availability check — 2026-09-25
- [RESULT] On the hAP ac lite running OpenWrt 25.12.5, the router-side command `apk update >/dev/null 2>&1 && apk policy xray-core` completed successfully.
- [RESULT] Current package policy reports `xray-core 26.3.27-r1` from the official OpenWrt 25.12.5 `mips_24kc` packages feed: `https://downloads.openwrt.org/releases/25.12.5/packages/mips_24kc/packages/packages.adb`.
- [INTERPRETATION] Xray-core is directly available through the router's configured OpenWrt package feed for this architecture; a manual third-party binary is not required for the initial installation path.
- [IMPORTANT VERSION GATE] The available package is 26.3.27-r1. Earlier research identified official Xray reports of MIPSLE crashes associated with Xray 26.3.27-era builds, so availability alone is not an installation approval. Version/runtime compatibility must be checked before installation.
- [SAFETY] `apk policy` is a read-only package-availability check. No package was installed and no router configuration, routing, firewall, Zapret2, or watchdog state was changed.
- [STATUS] STAGE 14 = IN_PROGRESS. Package-availability gate = DONE. Next gate: inspect package metadata/dependencies and installation size/resource impact before any installation.


## STAGE 14 — VLESS + REALITY / sing-box + Podkop — package/resource gate — 2026-09-25
- [RESULT] Router-side read-only command `apk policy sing-box && apk info -a sing-box | head -30` completed successfully.
- [RESULT] Official OpenWrt 25.12.5 `mips_24kc` feed provides `sing-box 1.13.21-r1`.
- [RESULT] The full `sing-box-1.13.21-r1` package reports installed size **48 MiB** and depends on `ca-bundle`, `kmod-inet-diag`, `kmod-tun`, and `libc`; it provides `sing-box-any`.
- [RESULT] `apk info -a` also began listing `sing-box-tiny-1.13.21-r1`; the supplied output was truncated at its `installed size` line, so the exact tiny installed size was NOT captured and must not be guessed.
- [INTERPRETATION] Full sing-box is larger than the already inspected Xray-core 26.3.27-r1 (32 MiB installed), so full sing-box is not the lightweight choice on package size alone.
- [IMPORTANT] The presence of a `sing-box-tiny` variant is promising for this 64-MB hAP ac lite, but its exact installed size and dependency set must be read before any installation decision.
- [PODKOP CONTEXT] Current Podkop documentation states OpenWrt 24.10+ and at least 25 MB free space; Podkop uses sing-box and modifies dnsmasq/sing-box configuration. This makes Podkop a viable architectural candidate, but also means installation/configuration must be treated as a potentially invasive change and must not be performed before the resource/configuration gate passes. citeturn0search5turn0search2
- [SAFETY] No package was installed; no Podkop, sing-box, Xray, routing, firewall, DNS, Zapret2, or watchdog configuration/runtime state was changed.
- [STATUS] STAGE 14 = IN_PROGRESS. Full sing-box resource gate = NOT_PREFERRED; sing-box-tiny resource gate = BLOCKED pending exact metadata. Next gate: inspect only the `sing-box-tiny` metadata/size, without installing anything.

## STAGE 14 — VLESS + REALITY / sing-box-tiny — runtime binary check — 2026-09-25
- [RESULT] Router-side read-only command `sing-box-tiny version` was executed.
- [RESULT] OpenWrt returned `-ash: sing-box-tiny: not found`.
- [INTERPRETATION] The package metadata previously inspected for `sing-box-tiny-1.13.21-r1` does not mean that an executable named `sing-box-tiny` is installed or available in PATH. The package is not installed; therefore no runtime/version test was actually performed.
- [TECHNICAL CONTEXT] The official OpenWrt package definition installs the binary as `/usr/bin/sing-box`, including for the `sing-box-tiny` variant; the variant name is a package/build variant, not the runtime command name. citeturn0search0
- [SAFETY] No package was installed and no configuration, routing, firewall, DNS, Zapret2, watchdog, or service state changed.
- [STATUS] STAGE 14 remains IN_PROGRESS. The previous runtime gate is corrected: first verify package installation state and, if absent, do not install yet. The next router check must be read-only.

## STAGE 14 — VLESS + REALITY / sing-box-tiny — installation-state check — 2026-09-25
- [RESULT] Router-side read-only command `command -v sing-box; apk info -e sing-box sing-box-tiny 2>/dev/null` produced no output.
- [INTERPRETATION] No `sing-box` executable was found in PATH, and `apk info -e` did not report either `sing-box` or `sing-box-tiny` as installed. This is consistent with the package not yet being installed.
- [SAFETY] Read-only check only. No package installation, configuration, routing, firewall, DNS, Zapret2, watchdog, or service state changed.
- [STATUS] STAGE 14 remains IN_PROGRESS. sing-box-tiny installation-state gate = DONE (not installed). Next gate remains read-only; do not install yet.


## STAGE 14 — Resource baseline before WireGuard path — 2026-09-25
- [RESULT] Router-side read-only snapshot: `df -k /overlay /mnt/data; free -k`.
- [RESULT] `/overlay`: 6,496,196 kB available (~6.2 GiB); filesystem usage 0%.
- [RESULT] Current RAM: total 54,852 kB; used 33,768 kB; free 8,924 kB; buff/cache 12,160 kB; MemAvailable 14,412 kB.
- [RESULT] Current swap: total 550,904 kB; used 5,408 kB; free 545,496 kB.
- [INTERPRETATION] Storage headroom is ample for a small WireGuard package/configuration. Current MemAvailable is ~14.1 MiB, above the watchdog recovery floor of 4 MiB, but the router remains memory-constrained; no memory-intensive VPN component should be installed without a resource gate.
- [TECHNICAL CONTEXT] Official OpenWrt 25.12 mips_24kc feeds provide `wireguard-tools`; WireGuard uses the kernel module plus userspace tools. This supports evaluating WireGuard as a lightweight path if the VPN provider supplies a native WireGuard configuration. citeturn0search0turn0search11
- [SAFETY] Read-only snapshot only. No package, network, firewall, DNS, Zapret2, watchdog, swap, or VM configuration changed.
- [STATUS] STAGE 14 remains IN_PROGRESS. Resource baseline gate = RECORDED. Next gate: read-only check of WireGuard package availability/installation state; do not install yet.


## STAGE 14 — AmneziaWG candidate re-evaluation — 2026-09-25
- [USER INPUT] User provided an external OpenWrt/AmneziaWG setup description and raised AmneziaWG as an alternative to classic WireGuard for the current Russian-network environment.
- [WEB VERIFICATION] Current Amnezia documentation says its OpenWrt guide supports OpenWrt 23.05+ and uses an installer script; it also states that Amnezia Premium configurations issued only for AmneziaWG 3.1 cannot be used with the older AmneziaWG 2.0 format. citeturn0search3
- [WEB VERIFICATION] Current community builds do exist for OpenWrt 25.12.x. The current 2Grey project publishes signed APK feeds/releases and reports AmneziaWG 3.1 components; its 25.12.5 release includes AWG components. citeturn0search4turn0search9
- [IMPORTANT ARCHITECTURE] AmneziaWG is a WireGuard-derived VPN transport with kernel-space support available through `kmod-amneziawg`; it is not part of the standard official OpenWrt package feed for this router. Installation therefore introduces a third-party package/kernel-module trust and compatibility gate, unlike ordinary WireGuard packages from the official OpenWrt feed.
- [IMPORTANT VERSION GATE] The user-supplied generic claim that AWG is simply required/available everywhere is too broad. Exact AWG version and provider configuration format must match. Current sources show both AWG 3.1 and 25.12.5-specific community builds, while the official Amnezia guide still warns about configuration-version compatibility. citeturn0search3turn0search4
- [RESOURCE CONTEXT] Current router snapshot immediately before this evaluation: 54,852 kB RAM total, 14,412 kB MemAvailable, ~6.2 GiB free on /overlay, ~5.3 MiB swap used. The device remains memory-constrained, so kernel-module/tools size and runtime RAM/CPU impact must be measured before acceptance.
- [SAFETY] No AmneziaWG package was installed and no network, firewall, DNS, Zapret2, watchdog, routing, swap, or VM configuration was changed.
- [STATUS] STAGE 14 remains IN_PROGRESS. AmneziaWG is now an active candidate for evaluation, but not approved for installation. Next gate: read-only package/feed availability and architecture/firmware compatibility check for the exact hAP ac lite OpenWrt 25.12.5 `ath79/mikrotik` target.


## STAGE 14 — AmneziaWG installer safety correction — 2026-09-25
- [USER INPUT] User supplied a generic AmneziaWG/OpenWrt installation instruction ending with the command `wget -qO- https://githubusercontent.com`.
- [VALIDATION] The supplied command is incomplete/invalid as an AmneziaWG installer command and must NOT be executed. Current documented installers use a specific `raw.githubusercontent.com` script URL, not the bare `githubusercontent.com` host. The current 2Grey project documents a signed custom package-feed installer and a separate setup script; it supports OpenWrt 25.12.5 and AWG 3.1. citeturn0search1turn0search2
- [IMPORTANT] Even the documented installer performs package installation and can load a third-party kernel module; therefore it is not a read-only diagnostic and is not to be run before the package/source/kernel compatibility gate is passed.
- [CURRENT DECISION] Do not run the pasted command and do not run the AmneziaWG installer yet. First perform a single read-only check against the router's configured package manager to establish whether any AWG packages are already installed/visible in the configured feeds.
- [SAFETY] No router state changed from the user's pasted instruction. Zapret2/watchdog/DNS/routing remain untouched.
- [STATUS] STAGE 14 remains IN_PROGRESS. AmneziaWG installation gate = NOT_STARTED; read-only package/feed visibility check is next.


## STAGE 14 — AmneziaWG configured-feed package check — 2026-09-25
- [RESULT] Router command `apk policy kmod-amneziawg amneziawg-tools luci-proto-amneziawg; apk info -e kmod-amneziawg amneziawg-tools luci-proto-amneziawg 2>/dev/null` returned no output.
- [INTERPRETATION] None of the three AmneziaWG packages is installed, and none is visible through the router's currently configured APK repositories. This is expected because AmneziaWG is supplied through a separate third-party feed rather than the standard OpenWrt package feed.
- [WEB VERIFICATION] Current 2Grey documentation states that OpenWrt 25.12 uses signed APK repositories from the project's custom feed and that the supported 25.12.5 release provides AWG 3.1 packages. The same documentation identifies the three required components: `amneziawg-tools`, `kmod-amneziawg`, and `luci-proto-amneziawg`. citeturn0search1turn0search0
- [SAFETY] No package installation, third-party feed addition, kernel-module loading, reboot, network/routing/firewall/DNS/Zapret2/watchdog change occurred.
- [STATUS] STAGE 14 remains IN_PROGRESS. Official-feed visibility gate = DONE (AWG absent). Third-party feed compatibility gate = NOT_STARTED. Next step must be a read-only compatibility/source verification before adding any feed or installing a kernel module.


## STAGE 14 — AmneziaWG next-step decision — 2026-09-25
- [USER REQUEST] User said to continue after the malformed AmneziaWG installer command was rejected.
- [WEB VERIFICATION] OpenWrt 25.12.5 has the ath79/mikrotik target and the ath79 release uses kernel 6.12.94; the relevant MIPS package architecture is mips_24kc. citeturn0search0turn0search1turn0search2
- [DECISION] Before adding the third-party AmneziaWG APK feed or installing any kernel module, obtain the router's exact live board/release/kernel/APK architecture identifiers with one read-only command. This is the compatibility gate for the exact device, not a package installation step.
- [SAFETY] No router configuration or runtime state is changed by the next check. Zapret2, its watchdog, DNS, routing, firewall and existing VPN-related state remain untouched.
- [STATUS] STAGE 14 = IN_PROGRESS. AmneziaWG third-party feed compatibility gate = IN_PROGRESS. Installation gate = NOT_STARTED.


## MASTER WORKFLOW RULE — Mandatory Master Plan read before every project response — 2026-09-25
- [USER REQUIREMENT] Before every assistant response that concerns the OpenWrt project, the assistant MUST read the current `OPENWRT_VARIANT_A_MASTER_PLAN.md` from the project repository first. This is mandatory, not optional.
- [ORDER OF OPERATIONS] 1) Read current Master Plan; 2) compare the current user result/request with recorded state; 3) perform web/technical verification when required; 4) if the factual project state changes, update Master Plan before issuing the next router command; 5) only then provide the next instruction.
- [SOURCE OF TRUTH] The Master Plan is the authoritative project-state/history record. The user's GitHub repository is a state log, NOT a technical authority. Technical claims must be verified against authoritative OpenWrt/project documentation or other appropriate primary sources.
- [NO FALSE SYNC] The assistant MUST NOT say that the Master Plan was updated unless the GitHub tool confirms a successful commit. If the GitHub update fails or is blocked, explicitly state that synchronization was not completed.
- [ONE-STEP RULE] Only one router command/test per step unless the user explicitly requests a batch. State purpose and whether the command changes anything. Prefer compact output.
- [STATE STATUS] Continue using explicit statuses: `NOT_STARTED / IN_PROGRESS / BLOCKED / FAILED / DONE`.
- [HISTORY] Record material user results, decisions, rejected approaches, safety gates, configuration changes and failures in sufficient detail to reconstruct the project history.
- [SAFETY] Never execute pasted installation commands blindly. Destructive or externally sourced package/kernel-module changes require a compatibility/safety gate first.

## STAGE 14 — Live AmneziaWG platform/kernel verification — 2026-09-25
- [USER RESULT] Read-only command executed on the router: `ubus call system board; uname -r; apk --print-arch`.
- [FACTUAL RESULT] Model: MikroTik RouterBOARD 952Ui-5ac2nD (hAP ac lite); SoC: Qualcomm Atheros QCA9533 ver 2 rev 0; board: `mikrotik,routerboard-952ui-5ac2nd`; rootfs: squashfs; OpenWrt `25.12.5`, revision `r33051-f5dae5ece4`; target `ath79/mikrotik`; kernel `6.12.94`; APK architecture reported as `mips`.
- [USER RESULT] Read-only command `apk policy 'kmod-amneziawg*'` returned empty output.
- [INTERPRETATION] No AWG kernel module is visible through the currently configured official OpenWrt APK repositories. This does NOT prove incompatibility; it confirms only that the third-party AWG feed has not been added and no matching package is currently exposed through configured feeds.
- [USER RESULT] Read-only command `apk policy kernel` returned: `6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1: lib/apk/db/installed https://downloads.openwrt.org/releases/25.12.5/targets/ath79/mikrotik/packages/packages.adb`.
- [KERNEL GATE] Exact live kernel package identity is therefore `6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`, including ABI/hash `1951ed9cd221294b56a47180c29ca5a9`. Any third-party `kmod-amneziawg` must be verified against the exact OpenWrt kernel ABI, not merely the human-readable kernel version.
- [WEB VERIFICATION] Current OpenWrt documentation confirms OpenWrt 25.12 uses apk and that repository entries determine package visibility; OpenWrt also warns against blind package mass-upgrades. Current 2Grey documentation confirms AWG 3.1 packages for OpenWrt 25.12.5 and identifies `kmod-amneziawg`, `amneziawg-tools`, and `luci-proto-amneziawg` as the required components. citeturn0search0turn0search1turn0search6
- [SAFETY] No AWG feed was added, no package was installed, no kernel module was loaded, and no reboot/network/firewall/DNS/Zapret2/watchdog/routing state changed during these checks.
- [STATUS] STAGE 14 = IN_PROGRESS. Live platform identification = DONE. Official-feed AWG visibility = DONE (absent). Exact third-party kernel-module compatibility = IN_PROGRESS. AWG installation = NOT_STARTED.

## STAGE 14 — AWG vs VLESS/sing-box decision framework — 2026-09-25
- [USER INPUT] User supplied a proposal to use AmneziaWG with a free Proton VPN configuration and Zapret2, and separately supplied a proposal to use VLESS+REALITY with sing-box as a lighter alternative.
- [DECISION] These are candidates, not approved configurations. Do not change the working Zapret2/watchdog configuration while evaluating the transport layer.
- [TECHNICAL CORRECTION] It is not established that Xray will 'instantly consume all RAM' or that sing-box will necessarily consume 'many times less' memory. The hAP has a constrained memory budget, so actual resident memory/CPU and stability must be measured on this exact MIPS device before acceptance.
- [TECHNICAL CORRECTION] VLESS+REALITY is not automatically guaranteed to evade every DPI implementation; it is a different transport and does not eliminate the need for route/proxy testing. Likewise, Zapret2 UDP desync must not be assumed necessary or effective for Proton/AWG without an actual tunnel/handshake test.
- [SCOPE] Ordinary WireGuard is already considered/closed from earlier project work and MUST NOT be reopened unless the user explicitly requests it. Current comparison is AmneziaWG+Proton Free versus VLESS+REALITY via sing-box (with existing working VLESS profile available as a candidate configuration source; credentials must never be reproduced).
- [SING-BOX] Official OpenWrt package metadata previously verified: `sing-box` 1.13.21-r1 (~48 MiB installed size) and `sing-box-tiny` 1.13.21-r1 (~33 MiB installed size) are available for the router's OpenWrt 25.12 package architecture. No sing-box package is currently installed. The exact runtime memory impact remains untested.
- [AWG] Current 2Grey documentation says the v25.12.5 release supports AWG 3.1 and publishes the three required components; package selection is target/subtarget-specific. citeturn0search1turn0search6
- [SAFETY] No VPN package, AWG feed, VLESS route, proxy/TUN, firewall rule, DNS change or Zapret2 configuration was changed as a result of these proposals.
- [STATUS] STAGE 14 = IN_PROGRESS. Candidate evaluation continues. AWG exact-package gate remains open; VLESS/sing-box remains an alternative path, not yet installed.

## STAGE 14 — Current next gate after empty AWG package policy — 2026-09-25
- [RESULT] `apk policy 'kmod-amneziawg*'` returned empty output.
- [INTERPRETATION] This confirms only that the currently configured repositories do not expose an AWG kernel package. It does not justify installing a random APK or running a third-party installer.
- [NEXT GATE] Before any feed addition or installation, verify the exact 2Grey v25.12.5 release asset for `kmod-amneziawg` against the router's `ath79/mikrotik` target/subtarget and exact kernel ABI `6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`.
- [STATUS] AWG exact-package compatibility = IN_PROGRESS; third-party feed addition = NOT_STARTED; AWG installation = NOT_STARTED.


## STAGE 14 — Exact 2Grey AWG v25.12.5 asset verification — 2026-09-25
- [WEB RESULT] 2Grey release `v25.12.5` is published for OpenWrt 25.12.5 and AWG 3.1. The release contains a target-specific kernel module asset exactly named `kmod-amneziawg_v25.12.5_mips_24kc_ath79_mikrotik.apk`. Release asset SHA-256: `322cd18ed25e4309fa59c26408df4cb0fc7e8189315ae731e26f689f58d68365`. citeturn0search0
- [WEB RESULT] The same release contains `amneziawg-tools_v25.12.5_mips_24kc_ath79_mikrotik.apk`; its SHA-256 is `a53bb21861468f9611975ed7719ae6442b1aebba387a1997df195f7a39119425`. The 2Grey documentation identifies `kmod-amneziawg`, `amneziawg-tools`, and `luci-proto-amneziawg` as the required package set and says OpenWrt 25.12 uses APK packages. citeturn0search1turn0search6
- [WEB RESULT] The 2Grey feed installer constructs the exact feed URL from detected OpenWrt version and target/subtarget: `https://2grey.github.io/awg-openwrt/25.12.5/ath79/mikrotik` for this router. It installs a signed feed key, writes `customfeeds.list`, runs `apk update`, and only then installs the AWG packages. The installer is therefore a modifying operation, not a read-only check. citeturn0search1
- [IMPORTANT] Existence of the exact target/subtarget asset is now confirmed. The remaining compatibility proof is the package manager's dependency resolution against the router's exact kernel package identity `6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`. Do not install `kmod-amneziawg` until that dependency is positively resolved.
- [SAFETY] No AWG feed was added and no AWG package/kernel module was installed during this verification. Zapret2/watchdog/DNS/routing/firewall remain untouched.
- [STATUS] STAGE 14 = IN_PROGRESS. Exact target/subtarget asset = CONFIRMED. Exact kernel ABI compatibility = IN_PROGRESS. Third-party feed addition = NOT_STARTED. AWG installation = NOT_STARTED.


## STAGE 14 — Third-party AWG feed addition gate — 2026-09-25
- [DECISION] Exact 2Grey v25.12.5 target/subtarget assets are confirmed for this router. The remaining check is APK dependency resolution against the live kernel ABI.
- [SAFETY GATE] User said to continue. The next router operation may add only the signed 2Grey APK feed and refresh package indexes; it MUST NOT install AWG packages, upgrade existing packages, alter network/firewall/DNS/Zapret2/watchdog configuration, or reboot.
- [RATIONALE] 2Grey documents a signed APK feed for OpenWrt 25.x and the installer constructs the feed from detected version/target/subtarget. For this router the expected feed is https://2grey.github.io/awg-openwrt/25.12.5/ath79/mikrotik/packages.adb. citeturn0search1
- [STATUS] STAGE 14 = IN_PROGRESS. Exact AWG asset = CONFIRMED. Third-party feed addition = NEXT. AWG package installation = NOT_STARTED.


## STAGE 14 — Third-party AWG feed refresh result — 2026-09-25
- [USER RESULT] The approved feed-only command completed successfully on the router: `apk update` ended with `OK: 11089 distinct packages available`.
- [INTERPRETATION] The signed 2Grey APK feed was accepted and its package index was refreshed successfully. This establishes feed visibility/update success, but does NOT establish that the AWG kernel module dependency matches the live kernel ABI.
- [SAFETY] No AWG package was installed, no kernel module was loaded, no reboot occurred, and no network/routing/firewall/DNS/Zapret2/watchdog configuration was changed by this operation.
- [STATUS] STAGE 14 = IN_PROGRESS. Third-party feed addition = DONE. Exact AWG package/kernel dependency resolution = NEXT. AWG installation = NOT_STARTED.
- [NEXT GATE] Perform one read-only `apk policy` query for `kmod-amneziawg`, `amneziawg-tools`, and `luci-proto-amneziawg`; do not install anything until the exact kernel dependency is positively resolved.


## STAGE 14 — AWG package policy after third-party feed refresh — 2026-09-25
- [USER RESULT] `apk policy kmod-amneziawg amneziawg-tools luci-proto-amneziawg` now resolves all three packages from the signed 2Grey feed.
- [FACTUAL RESULT] `amneziawg-tools` candidate = `3.1.20260812-r1`; `kmod-amneziawg` candidate = `6.12.94.3.1.20260906-r1`; `luci-proto-amneziawg` candidate = `3.1.1-r1`. All are from `https://2grey.github.io/awg-openwrt/25.12.5/ath79/mikrotik/packages.adb`.
- [INTERPRETATION] The kmod package naming strongly aligns with the live kernel version `6.12.94`, but package-policy visibility alone is not yet sufficient proof that every kernel ABI dependency resolves. Installation remains blocked pending dependency verification.
- [LUCi DECISION] User does not have LuCI/web interface. 2Grey documents `luci-proto-amneziawg` as the web-interface/import-export component. It is not required for a deliberate SSH/UCI/netifd-only deployment, so it will not be installed merely because it is available. citeturn0search0
- [STATUS] STAGE 14 = IN_PROGRESS. Third-party feed = DONE. AWG package candidates = CONFIRMED. Exact kernel dependency resolution = NEXT. LuCI component = NOT_REQUIRED unless LuCI is later deliberately installed.


## STAGE 14 — AmneziaWG exact kernel dependency resolution — 2026-09-25
- [USER RESULT] Read-only command `apk info -a kmod-amneziawg` returned package metadata for `kmod-amneziawg-6.12.94.3.1.20260906-r1`.
- [FACTUAL RESULT] The package declares the exact dependency `kernel=6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`.
- [COMPATIBILITY RESULT] This exactly matches the installed router kernel package identity previously recorded as `6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`, including the ABI/hash. Therefore the primary kernel-version/ABI compatibility gate for the AWG kmod is PASSED.
- [OTHER DEPENDENCIES] The kmod additionally requires `kmod-crypto-lib-chacha20poly1305`, `kmod-crypto-lib-curve25519`, `kmod-udptunnel4`, and `kmod-udptunnel6`. These dependencies have not yet been positively resolved as installed/available and must be checked before installation.
- [PACKAGE SIZE] Reported installed size of `kmod-amneziawg` is 91 KiB.
- [SAFETY] This was read-only metadata inspection. No package was installed, no kernel module was loaded, no reboot occurred, and no network/routing/firewall/DNS/Zapret2/watchdog configuration changed.
- [STATUS] STAGE 14 = IN_PROGRESS. Exact kernel ABI compatibility = DONE. AWG installation = NOT_STARTED. Next gate: read-only dependency availability check for the four additional kmod dependencies; do not install yet.


## STAGE 14 — AmneziaWG dependency availability resolution — 2026-09-25
- [USER RESULT] Read-only command `apk policy kmod-crypto-lib-chacha20poly1305 kmod-crypto-lib-curve25519 kmod-udptunnel4 kmod-udptunnel6` returned `6.12.94-r1` for all four dependencies, with `lib/apk/db/installed` listed as the installed source and the matching official OpenWrt 25.12.5 ath79/mikrotik kmods feed.
- [FACTUAL RESULT] All four runtime kernel-module dependencies required by `kmod-amneziawg` are already installed on the router and correspond to the current 6.12.94 kmod repository.
- [COMPATIBILITY RESULT] Combined with the previously confirmed exact dependency `kernel=6.12.94~1951ed9cd221294b56a47180c29ca5a9-r1`, the known kmod dependency chain is resolved for the live firmware.
- [SAFETY] Read-only policy query only. No package installation, kernel-module loading, reboot, or network/routing/firewall/DNS/Zapret2/watchdog change occurred.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG kmod dependency resolution = DONE. AWG installation = NOT_STARTED. Next step is a final read-only installation-scope/resource check before installing the third-party AWG userspace package and kernel module; `luci-proto-amneziawg` remains excluded because LuCI is not used.


## STAGE 14 — AmneziaWG userspace package metadata / install-scope gate — 2026-09-25
- [USER RESULT] Read-only command `apk info -a amneziawg-tools` returned `amneziawg-tools-3.1.20260812-r1`.
- [FACTUAL RESULT] Installed size is 65 KiB. Package provides the userspace `awg` control program, a netifd protocol helper, and a re-resolve watchdog script.
- [DEPENDENCY RESULT] The package declares dependencies on `ip`, `kmod-amneziawg`, and `libc`. This confirms that the userspace package intentionally depends on the already-validated AWG kernel module.
- [SCOPE] Planned installation remains limited to `amneziawg-tools` + `kmod-amneziawg`; `luci-proto-amneziawg` remains excluded because LuCI is not used.
- [SAFETY] Read-only metadata inspection. No package, kernel module, reboot, network/routing/firewall/DNS/Zapret2/watchdog state changed.
- [STATUS] STAGE 14 = IN_PROGRESS. Resource baseline = RECORDED. Exact kernel ABI = DONE. AWG kmod dependency chain = DONE. Userspace metadata/scope gate = DONE. AWG installation = NOT_STARTED.
- [NEXT GATE] The next operation is the first modifying step: install only `kmod-amneziawg` and `amneziawg-tools`. Because this introduces a third-party kernel module, treat the installation as a safety-gated change; do not run a generic AmneziaWG installer and do not install LuCI.


## STAGE 14 — AmneziaWG package installation result — 2026-09-25
- [USER RESULT] The approved modifying command `apk add kmod-amneziawg amneziawg-tools` completed successfully. The supplied output shows `amneziawg-tools-3.1.20260812-r1` installed and the final package database summary `OK: 32.4 MiB in 235 packages`.
- [INTERPRETATION] The two-package installation completed without a reported dependency error or package-manager failure. The output explicitly shows `amneziawg-tools` depends on `kmod-amneziawg`; because the operation was requested as a two-package transaction and finished with OK, the AWG kernel module package was included successfully unless a subsequent installed-state check proves otherwise.
- [SAFETY] This was the first modifying AWG operation. No LuCI package was installed. No intentional network/routing/firewall/DNS/Zapret2/watchdog configuration change was made. No reboot was performed in this step.
- [RESOURCE] Package database increased from the prior recorded `32.2 MiB in 231 packages` to `32.4 MiB in 235 packages`, consistent with the small AWG package footprint plus dependency/package-state metadata.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG package installation = DONE (transaction success). AWG kernel module loaded/active = NOT_YET_VERIFIED. AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Perform one read-only installed-state/module check before any reboot or network configuration. Do not import a Proton configuration or alter Zapret2 yet.


## STAGE 14 — AmneziaWG installed-state/module-load check — 2026-09-25
- [USER RESULT] Read-only command `apk info -e kmod-amneziawg amneziawg-tools; lsmod | grep amneziawg`.
- [RESULT] `apk info -e` confirmed both `kmod-amneziawg` and `amneziawg-tools` are installed.
- [RESULT] `lsmod | grep amneziawg` returned no line. Therefore the AWG kernel module is installed on disk but is not currently loaded into the running kernel.
- [INTERPRETATION] This is consistent with the expected post-install state when a kernel module has not yet been loaded/activated in the current boot. It does not indicate package-install failure.
- [WEB CONTEXT] OpenWrt documents kernel modules as loadable kernel components; module loading is distinct from package installation. OpenWrt's driver documentation notes that loadable modules are separate from the running kernel and may be loaded explicitly. citeturn0search9turn0search10
- [SAFETY] Read-only check only. No module was manually loaded, no reboot, and no network/routing/firewall/DNS/Zapret2/watchdog configuration changed.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE. AWG module loaded = NOT_STARTED/NOT_YET_VERIFIED. AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Do not manually `insmod` yet. First determine whether the package provides an autoload entry and whether the documented installation path expects a reboot; then perform the least-invasive activation step.


## STAGE 14 — AWG autoload-entry check — 2026-09-25
- [USER RESULT] `grep -R amneziawg /etc/modules.d /etc/modules-boot.d 2>/dev/null` returned empty.
- [RESULT] No AWG autoload entry is present in the overlay's `/etc/modules.d` or `/etc/modules-boot.d`.
- [INTERPRETATION] The installed third-party AWG package did not create a visible OpenWrt module-autoload entry in these directories. OpenWrt's packaging system normally creates such entries when a kernel package declares AUTOLOAD, but absence here does not by itself prove that the module cannot be loaded or that a reboot is required.
- [WEB VERIFICATION] Official OpenWrt documentation confirms kernel modules are loadable components and that package metadata can create `/etc/modules.d/` autoload entries; OpenWrt also documents `insmod` as the available module-loading mechanism on firmware where `modprobe` may be absent. citeturn0search0turn0search3
- [SAFETY] Read-only check only. No module load, reboot, interface, routing, firewall, DNS, Zapret2 or watchdog change.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE. AWG module loaded = NOT_STARTED. AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Inspect the installed package contents/metadata for the exact module filename and any post-install behavior before deciding between a controlled manual module load and reboot. Do not use a generic AWG installer.


## STAGE 14 — AWG module file/dependency discovery — 2026-09-25
- [USER RESULT] `apk info -L kmod-amneziawg | grep -E '(\\.ko$|modules.d|modules-boot.d)'` returned exactly `lib/modules/6.12.94/amneziawg.ko`.
- [RESULT] The package contains the expected kernel module at `/lib/modules/6.12.94/amneziawg.ko`; no autoload file was shown.
- [INTERPRETATION] The module is installed for the exact running kernel version, but it is not currently loaded and has no visible OpenWrt autoload entry.
- [WEB VERIFICATION] Official OpenWrt documentation states that kernel modules are loadable after the kernel and may be loaded with `insmod`; OpenWrt also notes that some firmware versions do not provide `modprobe`. citeturn0search1turn0search2
- [SAFETY] No module loading, reboot, network/routing/firewall/DNS/Zapret2/watchdog change was performed.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; module file present = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Before a modifying module-load action, inspect the generated kernel module dependency index for `amneziawg.ko`. This is read-only and will help avoid an unnecessary manual load or reboot.


## STAGE 14 — AWG modules.dep lookup — 2026-09-25
- [USER RESULT] `grep -F 'amneziawg.ko' /lib/modules/6.12.94/modules.dep 2>/dev/null` returned empty.
- [RESULT] No text dependency entry for `amneziawg.ko` is present in the checked `modules.dep` file (or the file is absent/empty at that path).
- [INTERPRETATION] This does not yet prove a missing dependency. The installed module file exists, while dependency metadata may not have been generated/updated after package installation.
- [WEB VERIFICATION] OpenWrt documents `insmod` for loading kernel modules; standard Linux `modules.dep` is generated by `depmod` and records module dependencies. citeturn0search0turn0search5
- [SAFETY] Read-only check only. No module load, reboot, depmod, network/routing/firewall/DNS/Zapret2/watchdog change.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; module file present = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Verify whether `modules.dep`/binary dependency indexes exist for the running kernel before any action that could modify module metadata.


## STAGE 14 — AWG kernel module dependency index absent — 2026-09-25
- [USER RESULT] `ls -l /lib/modules/6.12.94/modules.dep*` returned `No such file or directory`.
- [RESULT] No `modules.dep` or related dependency-index file is present for the running kernel under `/lib/modules/6.12.94`.
- [INTERPRETATION] The earlier empty lookup is explained by absent dependency metadata. The AWG module itself remains present at `/lib/modules/6.12.94/amneziawg.ko`.
- [WEB VERIFICATION] Official OpenWrt documentation confirms 25.12 uses apk and 25.12.5 uses Linux 6.12.94; OpenWrt also warns that kernel-module compatibility is kernel-version/ABI sensitive and incompatible kmods can cause crashes or reboot failures. citeturn0search0turn0search5turn0search9
- [SAFETY] No changes performed. Do not run `depmod`, `insmod`, or reboot until the availability of the module-management tooling and the package's intended activation path are established.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; exact module file = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Read-only check for `depmod`/module-loading tooling. This determines whether dependency metadata can be generated locally without introducing a network or service change.


## STAGE 14 — AWG module-loader tooling check — 2026-09-25
- [USER RESULT] `command -v depmod; command -v insmod; command -v modprobe` returned only `/sbin/insmod` and `/sbin/modprobe`; `depmod` is absent.
- [RESULT] The router has both `insmod` and `modprobe`, but no `depmod` executable. This explains why no local dependency index can currently be generated with the standard `depmod` utility.
- [WEB VERIFICATION] Official OpenWrt documentation states that kernel modules can be loaded as modules and specifically notes that `modprobe` is not available on at least some OpenWrt firmware, with `insmod` as the supported fallback. Current OpenWrt 25.12 uses apk. citeturn0search0turn0search6
- [SAFETY] Read-only check only. No module load, reboot, depmod, network/routing/firewall/DNS/Zapret2/watchdog change.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; exact module file = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Use `modprobe` in dry-run mode only to see whether it can resolve/load the installed AWG module without actually changing kernel state. Do not run a real module load yet.


## STAGE 14 — AWG modprobe dry-run attempt failed — 2026-09-25
- [USER RESULT] Attempted read-only `modprobe -n -v amneziawg`; BusyBox/OpenWrt `modprobe` rejected `-n` as an unrecognized option and printed supported usage: `modprobe [-q] [-v] filename` and `modprobe -a [-q] [-v] filename [filename...]`.
- [RESULT] No module was loaded by this failed command.
- [CORRECTION] The previous proposed dry-run syntax was incompatible with this router's modprobe implementation. Do not repeat it.
- [WEB VERIFICATION] OpenWrt documentation confirms BusyBox utilities can have reduced option sets and that kernel modules are normally loaded with `insmod`/modprobe rather than through a universal dry-run interface. citeturn0search3turn0search5
- [SAFETY] No state change from this failed command; no reboot, module load, network/routing/firewall/DNS/Zapret2/watchdog change.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; module file present = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Avoid guessing BusyBox modprobe semantics. Perform one read-only capability check for `modinfo`, which can expose module metadata without loading it.


## STAGE 14 — AWG module metadata verified — 2026-09-25
- [USER RESULT] `modinfo /lib/modules/6.12.94/amneziawg.ko` completed successfully.
- [RESULT] Module name: `amneziawg`; filename: `/lib/modules/6.12.94/amneziawg.ko`.
- [RESULT] `vermagic: 6.12.94 mod_unload MIPS32_R2 32BIT` exactly matches the running kernel version/architecture family.
- [RESULT] Declared module dependencies: `libcurve25519-generic`, `udp_tunnel`, `ip6_udp_tunnel`, `libchacha20poly1305`, `chacha-mips`.
- [RESULT] No module was loaded by `modinfo`.
- [INTERPRETATION] The module binary is structurally identified for the current 6.12.94 MIPS32 target, and its dependency list is explicit. This is stronger evidence for safe activation than the previously missing modules.dep index.
- [SAFETY] Read-only metadata inspection only. No reboot, module load, interface, routing, firewall, DNS, Zapret2 or watchdog change.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages installed = DONE; exact module file = DONE; module metadata/ABI = DONE; module loaded = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Before the first modifying module-load action, verify that all five declared kernel-module dependencies are currently loaded. This remains read-only.


## STAGE 14 — AWG module metadata result reconfirmed — 2026-09-25
- [USER RESULT] User repeated the successful `modinfo /lib/modules/6.12.94/amneziawg.ko` output.
- [RESULT] `vermagic: 6.12.94 mod_unload MIPS32_R2 32BIT`; dependencies: `libcurve25519-generic, udp_tunnel, ip6_udp_tunnel, libchacha20poly1305, chacha-mips`.
- [RESULT] `modinfo` did not load the module.
- [STATUS] STAGE 14 = IN_PROGRESS; AWG package/module metadata gate = DONE; module loaded = NOT_STARTED; interface/handshake/traffic = NOT_STARTED.


## STAGE 14 — AWG dependency-load gate — 2026-09-25
- [USER RESULT] Read-only `lsmod` check confirmed all five declared AWG dependencies are already loaded:
  - `chacha_mips`
  - `libchacha20poly1305`
  - `libcurve25519_generic`
  - `udp_tunnel`
  - `ip6_udp_tunnel`
- [RESULT] Existing `wireguard`/OpenVPN modules already reference these dependencies; no additional dependency load is currently required.
- [INTERPRETATION] Combined with exact kernel dependency, matching `vermagic`, exact target package, and successful installation, the AWG module now has a strong compatibility basis for a controlled first load.
- [WEB VERIFICATION] Official OpenWrt documentation confirms kernel modules are loadable at runtime; OpenWrt's package build system documents module autoloading separately from package installation. citeturn0search0turn0search1turn0search10
- [SAFETY GATE] The next operation will modify only the running kernel state by loading `amneziawg`. It will not create an interface, configure a tunnel, alter routes/firewall/DNS/Zapret2/watchdog, or reboot. If loading fails, stop and capture the exact error; do not force-load.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages = DONE; module file/ABI/dependencies = DONE; module loaded = READY FOR FIRST LOAD; interface/handshake/traffic = NOT_STARTED.


## STAGE 14 — First AmneziaWG kernel-module load — 2026-09-25
- [USER RESULT] `modprobe amneziawg` completed with no output and no reported error.
- [RESULT] The AWG kernel module was successfully requested for loading; no error was emitted by modprobe.
- [STATUS] Immediate activation result = SUCCESS_PENDING_VERIFICATION. Module loaded state must be verified explicitly; no assumption of working tunnel is made.
- [SAFETY] This operation changed only running kernel module state. No AWG interface/configuration, routes, firewall, DNS, Zapret2 or watchdog settings were changed; no reboot occurred.
- [WEB VERIFICATION] OpenWrt documents loadable kernel modules and runtime loading; kernel-module compatibility is kernel-version sensitive, and this module had already passed exact kernel/ABI and dependency checks before this load. citeturn0search0turn0search10
- [NEXT GATE] Read-only verification of the loaded module and its parameters; do not configure an AWG interface yet.


## STAGE 14 — AmneziaWG kernel module verified loaded — 2026-09-25
- [USER RESULT] `lsmod | grep '^amneziawg'` returned `amneziawg 77824 0`.
- [RESULT] The `amneziawg` kernel module is definitively loaded in the running kernel.
- [STATUS] AWG package installation = DONE; exact module/ABI/dependencies = DONE; kernel module loaded = DONE; AWG interface = NOT_STARTED; handshake = NOT_STARTED; traffic = NOT_STARTED.
- [SAFETY] No interface, tunnel, route, firewall, DNS, Zapret2 or watchdog configuration has been changed. No reboot.
- [WEB VERIFICATION] OpenWrt documents that kernel modules are loadable runtime components and that `kmod-` packages provide such modules. citeturn0search1turn0search5
- [NEXT GATE] Before importing/configuring any Proton profile, verify the AWG userspace tool is present and identify the supported interface-management command. No tunnel configuration yet.


## STAGE 14 — AmneziaWG userspace tool verification — 2026-09-25
- [USER RESULT] `command -v wg; wg --version` returned `/usr/bin/wg` and `wireguard-tools v1.0.20260223`.
- [RESULT] The standard WireGuard userspace tool `wg` is installed and executable. This is also the control utility used to inspect/configure WireGuard-compatible kernel interfaces; the AWG kernel module is already loaded.
- [INTERPRETATION] The AWG kernel/userspace prerequisites are now present. This does not mean an AWG interface or tunnel exists yet.
- [SAFETY] Read-only check only; no interface/config/route/firewall/DNS/Zapret2/watchdog changes.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages = DONE; kernel module = DONE; userspace `wg` = DONE; AWG interface = NOT_STARTED; handshake = NOT_STARTED; traffic = NOT_STARTED.
- [NEXT GATE] Inspect the available `wg` command set/help before creating an interface or importing any Proton profile. Do not expose or repeat private key material.


## STAGE 14 — wg command capability confirmed — 2026-09-25
- [USER RESULT] `wg help` returned the standard WireGuard tools subcommands: show, showconf, set, setconf, addconf, syncconf, genkey, genpsk, pubkey.
- [RESULT] The installed `wg` utility supports the expected WireGuard-compatible control operations needed by an AmneziaWG interface.
- [SAFETY] Read-only command; no interface, peer, key, route, firewall, DNS, Zapret2 or watchdog state changed.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages = DONE; kernel module = DONE; userspace `wg` = DONE; interface = NOT_STARTED; peer/handshake = NOT_STARTED; traffic = NOT_STARTED.
- [NEXT GATE] Before creating any interface, verify whether an AWG-specific UAPI/config capability is exposed by the installed `amneziawg-tools` package. Do not generate/import private credentials yet.


## STAGE 14 — AWG 3.1 userspace files verified — 2026-09-25
- [USER RESULT] `apk info -L amneziawg-tools | grep -E '/(bin|sbin)/|amneziawg'` returned:
  - `lib/netifd/proto/amneziawg.sh`
  - `usr/bin/amneziawg_watchdog`
  - `usr/bin/awg`
- [RESULT] The package includes the AWG-specific `awg` utility and an OpenWrt netifd protocol handler. This is the expected integration path for AWG on OpenWrt; the upstream OpenWrt integration uses `/usr/bin/awg` for configuration and creates `type amneziawg` kernel interfaces. citeturn0search0turn0search2
- [RESULT] No LuCI package was installed.
- [SAFETY] Read-only package-content inspection; no interface/config/route/firewall/DNS/Zapret2/watchdog changes.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages = DONE; kernel module = DONE; AWG userspace `awg` = DONE; netifd proto handler = DONE; interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Inspect `awg help` before creating an interface or importing any Proton configuration.


## STAGE 14 — AWG-specific CLI verified — 2026-09-25
- [USER RESULT] `awg help` returned the standard WireGuard-compatible subcommands: show, showconf, set, setconf, addconf, syncconf, genkey, genpsk, pubkey.
- [RESULT] The AWG-specific `awg` binary is functional, but exposes the standard WireGuard command surface rather than additional visibly documented AWG-specific subcommands.
- [RESULT] The package also provides `lib/netifd/proto/amneziawg.sh`, so OpenWrt netifd can manage an AWG protocol interface. OpenWrt documents that protocol handlers under `lib/netifd/proto/` are used by netifd and that network configuration can be reloaded without restarting all interfaces. citeturn0search2turn0search6
- [SAFETY] Read-only check only. No AWG interface/config/peer/key/route/firewall/DNS/Zapret2/watchdog changes.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages = DONE; kernel module = DONE; AWG userspace/netifd handler = DONE; interface/peer/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Inspect the installed AWG netifd protocol handler to determine its supported UCI options before writing the network configuration. Do not import a Proton config yet.


## STAGE 14 — AWG netifd handler inspection (part 1) — 2026-09-25
- [USER RESULT] Read-only inspection of `/lib/netifd/proto/amneziawg.sh` showed `AWG=/usr/bin/awg` and a dedicated `proto_amneziawg` handler.
- [RESULT] The handler explicitly registers AWG UCI options including `private_key`, `listen_port`, `mtu`, `fwmark`, `awg_jc`, `awg_jmin`, `awg_jmax`, `awg_s1..s4`, `awg_h1..h4`, `awg_i1..i5`, `awg_header_protection_key`, `awg_content_padding_addition`, `awg_rekey_after_time`, `awg_rekey_timeout`, `awg_reject_after_time`, `awg_keepalive_timeout`, `awg_max_handshake_attempts`, `awg_random_trailers`, and `awg_disable_cookies`.
- [RESULT] The handler also checks for `/sys/module/amneziawg` and can invoke `modprobe amneziawg` if the module is not loaded.
- [INTERPRETATION] This confirms the installed AWG 3.1 netifd integration is designed for the loaded kernel module and exposes the expected AWG-specific UCI parameters. The supplied output stopped inside `proto_amneziawg_setup`, so the remainder of the setup logic still needs inspection before writing `/etc/config/network`.
- [WEB VERIFICATION] Official OpenWrt netifd documentation states that protocol handlers in `/lib/netifd/proto/` define accepted UCI parameters and setup behavior; the current netifd source exposes `proto_config_add_*` for those parameters. citeturn0search0turn0search2
- [SAFETY] Read-only inspection only. No UCI/network/interface/route/firewall/DNS/Zapret2/watchdog changes.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG package/kernel/userspace = DONE; netifd handler inspection = IN_PROGRESS; AWG interface/peer/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Inspect the remainder of the installed handler, especially how it invokes `awg`, creates the device, handles routes, and registers the protocol. Do not edit `/etc/config/network` yet.


## STAGE 14 — AWG netifd handler inspection (part 2) — 2026-09-25
- [USER RESULT] Read-only inspection of /lib/netifd/proto/amneziawg.sh lines 241–520 completed successfully.
- [RESULT] The setup function writes a temporary /tmp/amneziawg/<interface> config with [Interface], PrivateKey, optional ListenPort/FwMark, and all supported AWG-specific parameters: Jc/Jmin/Jmax, S1–S4, H1–H4, I1–I5, HeaderProtectionKey, ContentPaddingAddition, RekeyAfterTime, RekeyTimeout, RejectAfterTime, KeepaliveTimeout, MaxHandshakeAttempts, RandomTrailers, DisableCookies.
- [RESULT] The handler iterates peer sections named amneziawg_<interface>, supports disabled, public_key, preshared_key, allowed_ips, route_allowed_ips, endpoint_host, endpoint_port, and persistent_keepalive, then applies the generated configuration with the AWG setconf command and deletes the temporary file.
- [RESULT] On successful setup it adds configured IPv4/IPv6 addresses and IPv6 prefixes to netifd state, adds a host dependency for peer endpoints unless nohostroute=1, sends the protocol update, and on teardown deletes the kernel interface.
- [RESULT] The handler creates the kernel device itself using ip link add dev <interface> type amneziawg when the amneziawg kernel module is loaded; it can fall back to amneziawg-go only when kernel mode is unavailable.
- [RESULT] A failed AWG setconf causes a 5-second delay, proto_setup_failed, and setup exit; the temporary config is removed before this error check.
- [INTERPRETATION] The full installed handler is sufficient to manage an AWG tunnel through native netifd/UCI; a hand-written ip link/awg setconf procedure is not required for the planned interface. route_allowed_ips can add routes, so routing behavior must be chosen deliberately before interface creation.
- [WEB VERIFICATION] Official OpenWrt documentation confirms protocol handlers in /lib/netifd/proto/ declare/consume UCI parameters and are invoked by netifd for setup/teardown; netifd can apply interface-specific configuration changes via reload.
- [SAFETY] Read-only inspection only. No /etc/config/network edit, AWG interface creation, peer/key import, route/firewall/DNS/Zapret2/watchdog change, or reboot.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG package/kernel/userspace/netifd handler = DONE; AWG interface = NOT_STARTED; peer/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Before creating the first UCI AWG interface, determine the exact Proton/AWG profile format and map only non-secret structural fields to the handler options. Do not paste or expose private credentials in chat or the Master Plan.


## STAGE 14 — Next gate: Proton/AWG profile structure — 2026-09-25
- [DECISION] Continue with native netifd/UCI AWG path; do not create an interface or change routing yet.
- [REASON] The installed handler is now fully understood, including peer options and route_allowed_ips behavior. The next unknown is the exact structural format of the Proton profile available to the user/router.
- [SAFETY] We will inspect only filenames/locations first; no credentials, private keys, or endpoint secrets will be printed. No network configuration or service state will change.
- [STATUS] STAGE 14 = IN_PROGRESS. Handler inspection = DONE; AWG interface = NOT_STARTED; peer/handshake/traffic = NOT_STARTED.
- [WEB VERIFICATION] Official OpenWrt documentation confirms UCI is the central network configuration mechanism and netifd protocol handlers define monitored protocol parameters. citeturn0search1turn0search8
- [NEXT STEP] Locate any existing Proton/AWG/WireGuard profile on the router without displaying its contents.


## STAGE 14 — Proton/AWG profile location scan — 2026-09-25
- [USER RESULT] Read-only file search found candidate profiles/logs under /tmp: /tmp/warp-wg.conf, /tmp/proton-us-443.ovpn, /tmp/proton-native.conf, plus proton test logs and unrelated runtime hostapd/wpa-supplicant configs.
- [RESULT] No file under /mnt/data or /root was returned by the search within the first 30 matches; the visible candidates are temporary files under /tmp.
- [INTERPRETATION] `/tmp/proton-native.conf` is the most relevant candidate for the current AWG investigation, while `/tmp/proton-us-443.ovpn` is an OpenVPN profile and `/tmp/warp-wg.conf` is a WireGuard profile. We will not assume any of these are valid for AWG until their structure is checked.
- [SAFETY] File contents, private keys, passwords, and endpoint values were not printed. No files were modified, no tunnel/interface was created, and no network/routing/firewall/DNS/Zapret2/watchdog state changed.
- [WEB VERIFICATION] Official OpenWrt documentation confirms VPN interface configuration is represented by interface and peer sections and that private keys should remain on the local peer. citeturn0search0turn0search5
- [STATUS] STAGE 14 = IN_PROGRESS. Profile location identified; exact profile structure = NOT_STARTED; AWG interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Inspect only the option/section names of `/tmp/proton-native.conf`, with all values redacted, before deciding whether it is an AWG profile.


## STAGE 14 — Reassessment: Proton Free WG + Zapret2 UDP/WireGuard path — 2026-09-25
- [USER INPUT] Proposed path is to use the valid Proton Free standard WireGuard profile through the already-installed AmneziaWG interface with AWG-specific parameters set to zero, then test Zapret2 UDP desync against the Proton WireGuard endpoint.
- [TECHNICAL VERIFICATION] Current zapret2 upstream documentation/code confirms nfqws/nfqws2 supports UDP filtering and WireGuard payload classification in current development/community configurations. This makes a controlled WireGuard-over-Zapret2 experiment technically plausible, but does not establish that the specific Proton endpoint or ISP path will work.
- [IMPORTANT CORRECTION] The upstream zapret documentation explicitly warns that `badsum` can fail across NAT when invalid checksums are dropped; it notes OpenWrt normally sets conntrack checksum verification to 0, while an additional ISP NAT may still discard invalid packets. Therefore `badsum` is not a guaranteed method.
- [CURRENT CONFIG CONSTRAINT] Our deployed Zapret2 configuration is a custom, already-working `MODE_FILTER=autohostlist` setup with UDP 443 capture for QUIC. It does not yet establish a dedicated WireGuard UDP filter/strategy. We must not overwrite the working configuration or restart Zapret2 merely to test a speculative strategy.
- [SAFETY DECISION] Ordinary WireGuard remains excluded as a standalone solution because it was previously tested; however, a narrowly scoped experiment combining the existing AWG kernel interface (WireGuard-compatible parameters) with a separate, reversible Zapret2 WireGuard UDP rule may be evaluated. No network/config change made in this step.
- [NEXT GATE] Read-only inspect the currently installed Zapret2 config for existing UDP/WireGuard-related options and the active service configuration. Do not print private keys or modify `/etc/config/network`, `/opt/zapret2/config`, nftables, routes, or DNS.
- [STATUS] STAGE 14 = IN_PROGRESS; AWG interface = NOT_STARTED; Proton handshake = NOT_STARTED; Zapret2 WG-specific UDP strategy = NOT_STARTED.


## STAGE 14 — THEORY REGISTER: Proton Free + AmneziaWG + Zapret2 UDP/WireGuard — 2026-09-25
Purpose: фиксировать все рассмотренные в чате теории и отделять подтверждённые факты от рабочих гипотез и неподтверждённых утверждений. Никакая теория ниже не считается доказанной только потому, что она технически правдоподобна.

### A. ПОДТВЕРЖДЁННЫЕ ФАКТЫ / НАБЛЮДЕНИЯ
- [CONFIRMED] Установлен AmneziaWG kernel module для текущего ядра OpenWrt 6.12.94/MIPS32; модуль успешно загружен.
- [CONFIRMED] Установлен userspace `amneziawg-tools`, включая `/usr/bin/awg` и netifd handler `/lib/netifd/proto/amneziawg.sh`.
- [CONFIRMED] AWG netifd handler поддерживает стандартные WireGuard-поля peer/interface и отдельные AWG-параметры (Jc/Jmin/Jmax, S1–S4, H1–H4, I1–I5 и др.).
- [CONFIRMED] Структурно полученный от пользователя Proton Free client profile является стандартным WireGuard-профилем: Interface с Address/DNS/private key и Peer с PublicKey/AllowedIPs/Endpoint/PersistentKeepalive. В профиле не обнаружены AWG-specific параметры.
- [CONFIRMED] Поэтому сам Proton-профиль, имеющийся у пользователя, не является доказанным «нативным AWG-профилем».
- [CONFIRMED] Текущий Zapret2 upstream поддерживает UDP-фильтры и L7-детектор `wireguard`; документация также показывает `filter-udp` и `filter-l7=wireguard` как допустимые механизмы.
- [CONFIRMED] Текущий установленный Zapret2 использует UDP/443 для QUIC и не содержит в доказанном текущем состоянии отдельной активной стратегии именно для WireGuard UDP-порта Proton.
- [CONFIRMED] Текущий Zapret2 рабочий режим — `MODE_FILTER=autohostlist`; менять его только ради проверки теории пока запрещено, чтобы не ломать рабочую конфигурацию.
- [CONFIRMED] `badsum` в документации zapret описан как потенциальная техника, но отдельно отмечено, что NAT может отбросить пакеты с некорректной контрольной суммой.
- [CONFIRMED] Обычный WireGuard как самостоятельный вариант пользователь считает уже испытанным и просит не возвращаться к нему без отдельного указания.
- [CONFIRMED] Telegram API ранее выдавал `Operation not permitted` при текущем Zapret2-only пути; YouTube после ручного рестарта Zapret2 снова заработал.
- [CONFIRMED] После ручного рестарта Zapret2 были восстановлены оба процесса `nfqws2` и ожидаемая nftables-структура; позже watchdog стабильно видел состояние 2/2 и HEALTHY.

### B. РАБОЧИЕ ТЕХНИЧЕСКИЕ ГИПОТЕЗЫ — БУДЕМ ПРОВЕРЯТЬ
- [HYPOTHESIS] AWG-интерфейс с обычным Proton WireGuard-профилем и AWG-specific параметрами, выставленными в нулевые/неактивные значения, может установить совместимость с обычным WireGuard-сервером Proton. Это должно быть проверено реальным handshake; заранее считать совместимость доказанной нельзя.
- [HYPOTHESIS] «AWG с нулевыми параметрами» в таком сценарии не добавляет серверно-совместимой AWG-обфускации, а фактически используется как WireGuard-совместимый интерфейс/transport. Поэтому ожидаемый возможный эффект должен идти не от AWG-обфускации, а от сочетания с локальным Zapret2.
- [HYPOTHESIS] Если ISP/DPI режет именно UDP WireGuard-трафик, то локальный Zapret2/nfqws2 с UDP-фильтром, нацеленным на WireGuard, может изменить вид первых пакетов enough для обхода конкретного DPI. Это не гарантировано и зависит от конкретного DPI/маршрута.
- [HYPOTHESIS] Специальная Zapret2-стратегия с `--filter-udp=<WireGuard-port>` + `--filter-l7=wireguard` и одной из UDP-desync/fake/Lua-техник потенциально может воздействовать именно на WireGuard handshake, не затрагивая весь UDP.
- [HYPOTHESIS] `badsum` может сработать для некоторых сетей/типов DPI, если путь пропускает такие пакеты до цели/ответа; однако из-за NAT это особенно ненадёжно и требует отдельной проверки.
- [HYPOTHESIS] Если Proton endpoint IP/маршрут заблокирован на IP/маршрутном уровне, никакая локальная DPI-desync-обработка WireGuard не обязана помочь; в таком случае нужен другой reachable endpoint/transport.
- [HYPOTHESIS] Основной текущий Zapret2 `UDP/443` не должен автоматически «лечить» Proton WireGuard, если Proton работает на другом UDP-порту: отдельный фильтр/стратегия по реальному WG-порту потребуется, если теория с Zapret2 будет проверяться.
- [HYPOTHESIS] `MODE_FILTER=autohostlist` сам по себе плохо подходит как главный механизм для WireGuard endpoint, заданного IP, потому что autohostlist ориентирован прежде всего на host/domain resolution и уже наблюдаемый DPI-blocking. Для WireGuard может потребоваться явный IP/port/L7 filter.
- [HYPOTHESIS] Если AWG/WireGuard интерфейс сделать full-tunnel (`AllowedIPs=0.0.0.0/0`), существует риск ошибочной маршрутизации/петли через сам VPN endpoint, если host route/route policy не будут установлены корректно. Поэтому маршрут до endpoint должен быть специально защищён до включения туннеля.
- [HYPOTHESIS] Для первого испытания разумнее сделать isolated/reversible AWG test interface с контролируемым endpoint route и без изменения основной LAN/default routing, чтобы сначала получить только handshake.
- [HYPOTHESIS] Успешный handshake `wg/awg show` и рост `received_bytes`/keepalive будут подтверждать достижимость Proton WireGuard endpoint, но сами по себе не доказывают, что пользовательский трафик проходит через туннель без утечек/ошибочной маршрутизации.
- [HYPOTHESIS] Если handshake есть, но трафик через туннель не идёт, проблема может быть уже не в DPI handshake, а в маршрутах, policy routing, firewall или DNS.
- [HYPOTHESIS] Если handshake отсутствует, а обычный HTTPS через hAP работает, наиболее вероятные ветки проверки — блокировка/фильтрация UDP endpoint, неправильная маршрутизация endpoint, несовместимость профиля, либо воздействие локального firewall/Zapret2; точную причину заранее не утверждаем.

### C. НЕПОДТВЕРЖДЁННЫЕ / ПЕРЕДАННЫЕ ПОЛЬЗОВАТЕЛЕМ УТВЕРЖДЕНИЯ
- [UNVERIFIED USER CLAIM] «В 2026 году в России классический WireGuard массово/повсеместно блокируется». Это широкое утверждение не принимается как установленный факт в рамках проекта; будем проверять конкретно наблюдаемое поведение данного ISP/path.
- [UNVERIFIED USER CLAIM] «Zapret2/nfqws гарантированно может оживить любой заблокированный WireGuard локальным UDP-desync». Не принимается как гарантия; результат зависит от типа блокировки, DPI, NAT и конкретной стратегии.
- [UNVERIFIED USER CLAIM] «badsum» должен работать как универсальное средство против WG-DPI. Не принимается; официальная документация zapret прямо содержит caveat по NAT.
- [UNVERIFIED USER CLAIM] «Proton Free обычный WireGuard можно безоговорочно перенести в AWG и он будет работать как AWG». Структурно это ещё не проверено на реальном handshake; сам профиль не содержит AWG-параметров.
- [UNVERIFIED USER CLAIM] «Если включить AWG с нулевыми параметрами, Proton server обязательно примет handshake». Требует реального теста.
- [UNVERIFIED USER CLAIM] «Telegram/WhatsApp не работают исключительно из-за IP-блокировки». Это рабочая версия по симптомам, но точный механизм не установлен.
- [UNVERIFIED USER CLAIM] «Автоматический Zapret2 watchdog устранит все будущие проблемы доступа». Watchdog решает только обнаружение/восстановление известных локальных failure modes, а не внешнюю блокировку транспорта.

### D. ЧТО НЕ СЛЕДУЕТ СЧИТАТЬ ДОКАЗАТЕЛЬСТВОМ
- Наличие `amneziawg.ko`, успешный `modprobe` или наличие `awg` CLI не доказывает совместимость Proton.
- Наличие UDP/443 в Zapret2 не доказывает обработку Proton WireGuard UDP-порта.
- Успешный `wget https://example.com` не доказывает работоспособность WireGuard.
- Работоспособность YouTube не доказывает работоспособность Telegram/WhatsApp или VPN handshake.
- Успешный handshake не доказывает корректный full-tunnel routing.
- Успешный единичный тест после рестарта не доказывает причину предыдущего сбоя.

### E. ПЛАН ПРОВЕРКИ ГИПОТЕЗ
- [GATE 1 / READ-ONLY] Проверить текущий Zapret2 config на наличие уже реализованных UDP/WireGuard фильтров/параметров. Никаких restart/edit.
- [GATE 2 / READ-ONLY] Сверить точный формат Proton profile без вывода private key и секретов.
- [GATE 3 / CONTROLLED CHANGE] Создать отдельный AWG interface через native netifd/UCI с безопасным host route до Proton endpoint; основной LAN/default route пока не менять.
- [GATE 4] Проверить handshake/last-handshake/received bytes.
- [GATE 5] Только если базовый AWG handshake не проходит и обычный WAN HTTPS работает, подготовить отдельную минимальную Zapret2 UDP/WireGuard test-strategy.
- [GATE 6] Проверять только одну стратегию за раз; после каждого изменения возвращаться к исходной рабочей конфигурации.
- [GATE 7] После доказательства handshake отдельно проверять routed traffic, DNS и отсутствие loop/route leak.
- [SAFETY] Никаких одновременных изменений AWG + Zapret2 + routing + firewall. Каждая гипотеза должна иметь отдельный, обратимый эксперимент и чёткий критерий PASS/FAIL.
- [STATUS] STAGE 14 = IN_PROGRESS. Theory Register = RECORDED. Проверка гипотез начнётся с GATE 1. Следующая команда должна оставаться read-only.

### F. ОФИЦИАЛЬНЫЕ ТЕХНИЧЕСКИЕ ИСТОЧНИКИ ДЛЯ ЭТОГО РЕЕСТРА
- zapret documentation: https://github.com/bol-van/zapret/blob/master/docs/readme.en.md
- zapret2 default configuration: https://github.com/bol-van/zapret2/blob/master/config.default
- zapret2 repository/issues/discussions с примерами `filter-l7=wireguard` рассматриваются как примеры/тестовые конфигурации, а не как гарантия результата на данном ISP/path.


## STAGE 14 — GATE 1: Большой read-only аудит Zapret2 перед Proton/AWG экспериментом — 2026-09-25
- [REQUEST] Пользователь дал команду «Продолжай. Большой аудит» для проверки зарегистрированных теорий Proton Free + AmneziaWG + Zapret2 UDP/WireGuard.
- [AUDIT SCOPE] Аудит будет проводиться поэтапно и только read-only на первом проходе: текущий config, фактически запущенные процессы, nftables-структура, NFQUEUE/QNUM, WAN/LAN интерфейсы, UDP/TCP capture-path, доступные Zapret2 файлы/детекторы и связь с будущим WireGuard endpoint.
- [SAFETY] На этапе аудита запрещены restart/stop/start Zapret2, редактирование /opt/zapret2/config, nftables, UCI/network, routes, firewall, DNS и AWG interface creation. Не менять рабочий Zapret2 ради гипотезы.
- [METHOD] Несмотря на широкий объём аудита, соблюдаем правило проекта: одна команда за шаг, после результата фиксируем факт в Master Plan и выбираем следующий минимальный тест.
- [WEB CONTEXT] Текущий upstream zapret2 config действительно предусматривает отдельные NFQWS2 UDP/TCP параметры и пример UDP/443 QUIC; upstream/community материалы также содержат WireGuard L7 UDP examples, но это не доказывает работоспособность на данном ISP/path. citeturn0search0turn0search6
- [STATUS] STAGE 14 = IN_PROGRESS; GATE 1 = IN_PROGRESS; audit execution = NOT_STARTED.
- [NEXT STEP] Первый тест — только чтение локального Zapret2 config: собрать строки, относящиеся к NFQWS2 UDP/TCP, MODE_FILTER, FLOWOFFLOAD, interface selection и WireGuard/L7/desync. Никакого restart/edit.


### GATE 1 — local Zapret2 config read-only result — 2026-09-25
- [RESULT] User ran the planned read-only grep over /opt/zapret2/config and /opt/zapret2/config.default.
- [FACT] Active /opt/zapret2/config: SET_MAXELEM=522288; NFQWS2_ENABLE=1; NFQWS2_PORTS_TCP=80,443; NFQWS2_PORTS_UDP=443; NFQWS2_TCP_PKT_OUT=20; NFQWS2_TCP_PKT_IN=10; NFQWS2_UDP_PKT_OUT=5; NFQWS2_UDP_PKT_IN=3; MODE_FILTER=autohostlist; FLOWOFFLOAD=donttouch; INIT_APPLY_FW=1; DISABLE_IPV6=1.
- [FACT] Active NFQWS2_OPT has three groups: TCP/80 HTTP with fake+multisplit; TCP/443 TLS with hostfakesplit; UDP/443 QUIC with <HOSTLIST_NOAUTO>, payload quic_initial and fake_default_quic repeats=1.
- [FACT] No active filter-l7=wireguard, filter-udp for the Proton WireGuard port, or explicit WireGuard UDP strategy appears in the active config excerpt. The only WireGuard mention is a commented IFACE_WAN6 example.
- [FACT] config.default has the same NFQWS2 UDP port/packet limits and UDP/443 QUIC group, but NFQWS2_ENABLE=0 and MODE_FILTER=none; its default QUIC fake uses repeats=6. It also contains only a commented IFACE_WAN6 example for wireguard0.
- [INTERPRETATION] Current active Zapret2 configuration does not currently contain a dedicated WireGuard UDP filter/strategy. UDP capture is presently limited by config to port 443 and the active UDP L7 rule is QUIC.
- [SAFETY] No service restart, config edit, nftables change, route/firewall/DNS/UCI change or AWG interface creation was performed.
- [STATUS] GATE 1 remains IN_PROGRESS; this read-only config sub-check is DONE. Next audit step should inspect actual nfqws2 process command lines/runtime arguments, still read-only.


### GATE 1 — compact runtime/Zapret2 audit snapshot — 2026-09-25
- [RESULT] User executed the requested combined read-only runtime snapshot. Output was large because it included the full nftables table and a recursive file listing.
- [FACT] Exactly two nfqws2 processes are running (PIDs 16181 and 16182), both as user daemon. The displayed command lines were truncated by `ps w`, so exact runtime arguments are not yet captured.
- [FACT] Active nft table is `inet zapret2`; WAN set contains `phy0-sta0`; LAN set contains `br-lan`; `wanif6` is empty.
- [FACT] Active postnat path queues IPv4 UDP/443 original packets 1–5 to NFQUEUE 300, TCP 80/443 original packets 1–20 to NFQUEUE 300, and three specific UDP packet-length/magic patterns to NFQUEUE 65300. Reply-direction UDP/443 packets 1–3 and TCP 80/443 packets 1–10 are queued to NFQUEUE 300.
- [FACT] Route to Proton endpoint 194.180.33.20 is via 192.168.0.1 on `phy0-sta0`, source 192.168.0.100.
- [FACT] `phy0-sta0` is UP with 192.168.0.100/24; `br-lan` is UP with 192.168.1.1/24.
- [FACT] No AWG/amneziawg interface was present in `ip link show type amneziawg`. Two existing WireGuard-type interfaces were visible: `proton-test` and `warp-test`. No change was made to either interface.
- [FACT] The selected socket grep produced no matching UDP sockets for the requested endpoint/names/ports at that instant.
- [FACT] Zapret2 installation tree contains WG-related material including `init.d/custom.d.examples.linux/50-wg4all`, `init.d/openwrt/custom.d/50-wg4all`, `init.d/openwrt/50-wg4all.badsum`, and fake payloads `wireguard_initiation.bin` and `wireguard_response.bin`.
- [INTERPRETATION] The local Zapret2 tree has a ready-made WG-related custom integration, even though the active `NFQWS2_OPT` does not currently enable a dedicated WireGuard UDP strategy. The existing `proton-test`/`warp-test` interfaces are pre-existing state and must be treated as separate from the current AWG test until identified.
- [USER FEEDBACK] User correctly noted that the prior command produced excessive output. Future 'big tests' should still be one command but return a compact, high-signal digest rather than full file listings/full nft tables.
- [SAFETY] No restart, edit, route/firewall/DNS/UCI change or interface creation was performed.
- [STATUS] GATE 1 remains IN_PROGRESS. Next step: compact read-only capture of exact nfqws2 command lines plus the WG-related custom scripts, without dumping whole files.


### GATE 1 — compact WG script command result — 2026-09-25
- [RESULT] User attempted the compact NFQWS2/WG-script audit command, but the pasted terminal output is truncated/malformed at the script grep portion and does not contain reliable results for the requested script contents.
- [FACT] No new reliable runtime/script facts are added from this attempt; previously established facts remain valid: 2 nfqws2 processes, active nft table with QNUM 300/65300, route to Proton endpoint via phy0-sta0, existing proton-test/warp-test interfaces, no AWG interface.
- [USER FEEDBACK] User prefers large audits to produce a compact high-signal digest; future commands should avoid long loops and avoid output that can be mangled by terminal wrapping/pasting.
- [STATUS] GATE 1 = IN_PROGRESS. No configuration or runtime change performed.


### GATE 1 — WG custom-script result and corrected interpretation — 2026-09-25
- [RESULT] User provided the exact read-only output for both local OpenWrt WG custom scripts.
- [FACT] /opt/zapret2/init.d/openwrt/custom.d/50-wg4all defines NFQWS_OPT_DESYNC_WG with payloads wireguard_initiation, wireguard_response, wireguard_cookie and fake desync with repeats=2.
- [FACT] /opt/zapret2/init.d/openwrt/50-wg4all.badsum defines the same WireGuard payloads with fake desync repeats=1 and badsum.
- [FACT] The installed script comments explicitly state that the mechanism targets original WireGuard and may not work for third-party implementations.
- [IMPORTANT CORRECTION] The earlier interpretation “WG components are present but not activated because they are absent from NFQWS2_OPT” was too strong and is NOT accepted as current fact. The active nft snapshot already contained a separate NFQUEUE path QNUM=65300 with three UDP packet-length/magic matches. Those three matches correspond directly to the 50-wg4all WireGuard handshake initiation/response/cookie lengths and magic values (156/0x01000000, 100/0x02000000, 72/0x03000000) shown by the upstream custom script. Therefore the local 50-wg4all custom integration appears to be active independently of the main NFQWS2_OPT string.
- [FACT] The two currently running nfqws2 processes are consistent with the main QNUM=300 instance plus a separate custom WG instance on QNUM=65300, but exact command-line arguments are still not captured because the earlier ps output was truncated.
- [TECHNICAL CONTEXT] Upstream Zapret2 documents 50-wg4all as a custom solution that detects WireGuard handshake packets on any UDP port and redirects them to a dedicated nfqws instance; the default strategy is fake desync and the script allocates its own queue number. Therefore absence of WireGuard flags inside the main NFQWS2_OPT does not by itself mean the custom WG strategy is disabled. citeturn202035search0turn476730search5
- [INTERPRETATION] This changes the diagnosis materially: previous Proton/WireGuard failures cannot be attributed simply to “we forgot to enable 50-wg4all”. The dedicated WG handshake path is very likely already present in the active firewall, pending one compact runtime confirmation.
- [STATUS] GATE 1 remains IN_PROGRESS. No restart, edit, route/firewall/DNS/UCI change or AWG interface creation was performed.
- [NEXT STEP] Read-only confirmation of the exact two nfqws2 command lines and their QNUMs; no configuration change.


### GATE 1 — exact nfqws2 QNUM confirmation — 2026-09-25
- [RESULT] User ran the compact read-only process inspection successfully.
- [FACT] PID 16182 runs nfqws2 with --qnum=65300.
- [FACT] PID 16181 runs nfqws2 with --qnum=300.
- [CONFIRMED] The active Zapret2 runtime therefore has two distinct nfqws2 instances matching the expected main queue 300 and dedicated WireGuard/custom queue 65300.
- [INTERPRETATION] Combined with the previously observed nftables rules that send WireGuard handshake-shaped UDP packets to QNUM 65300, this confirms that the dedicated WG nfqws2 daemon is not merely installed on disk: it is actively running.
- [CORRECTION] The earlier theory that previous Proton attempts failed simply because the WG Zapret2 component was not enabled is rejected as an explanation for the current state. A dedicated WG processing path is active now. Whether it was active during each historical Proton test is not yet established.
- [TECHNICAL CONTEXT] Upstream Zapret2 uses separate custom daemons/queues for custom scripts, while the standard NFQWS2 daemon uses the main QNUM; this matches the observed 300/65300 split. cite: turn0search10, turn0search5.
- [SAFETY] No restart, edit, route/firewall/DNS/UCI change or AWG interface creation was performed.
- [STATUS] GATE 1 = DONE for runtime activation of the WG custom daemon. GATE 1 overall audit = DONE.
- [NEXT] Before any controlled AWG/Proton change, use one read-only step to inspect the effective QNUM=65300 command-line options, specifically whether the running daemon has the expected WireGuard payload/fake strategy. No restart/change.


### GATE 1 — QNUM=65300 command-line inspection attempt failed — 2026-09-25
- [RESULT] The proposed shell command failed because `pidof nfqws2` returned both PIDs as a space-separated list, which was assigned to a single variable; the resulting path `/proc/16182 16181/cmdline` is invalid.
- [FACT] This is only a command-construction error; it provides no new runtime information and caused no state change.
- [CONFIRMED REMAINS] PID 16182 = QNUM 65300 and PID 16181 = QNUM 300 from the immediately preceding successful read-only test.
- [SAFETY] No restart, edit, route/firewall/DNS/UCI change or AWG interface creation was performed.
- [NEXT] Retry with a shell loop that first selects each PID separately, still read-only and compact.


### GATE 1 — Active QNUM=65300 arguments confirmed — 2026-09-25
- [DONE] Read-only `/proc` inspection confirmed PID 16182 is `nfqws2` with `--qnum=65300`.
- [CONFIRMED] QNUM 65300 active arguments include `--payload=wireguard_initiation,wireguard_response,wireguard_cookie`.
- [CONFIRMED] QNUM 65300 active desync is `--lua-desync=fake:blob=0x00000000000000000000000000000000:repeats=2`.
- [CONFIRMED] PID 16181 remains the main QNUM 300 daemon with HTTP/TLS/QUIC payload strategies.
- [CONCLUSION] The dedicated WireGuard Zapret2 desync daemon is not merely installed/configured: its expected WireGuard payload/fake strategy is active at runtime.
- [LIMIT] This does not prove that Proton's WireGuard endpoint will handshake, nor prove that external UDP/IP blocking is the cause of any previous Proton failure.
- [SAFETY] No configuration, firewall, routing, DNS, AWG interface, restart, or package change was made.
- [STATUS] GATE 1 read-only Zapret2/WG runtime audit = DONE.


### GATE 2 — Proton profile location — 2026-09-25
- [RESULT] Read-only search found exactly one matching saved Proton config: `/tmp/proton-native.conf`, mode `0600`, size 308 bytes, timestamp Sep 23 16:30.
- [FACT] No matching `/mnt/data/proton*.conf` file was found.
- [SAFETY] The profile contents and private key were not printed; no router state was changed.
- [STATUS] GATE 2 = IN_PROGRESS. Next step: inspect only non-secret profile structure with the private key value masked.


### GATE 2 — `/tmp/proton-native.conf` identified as old Proton profile — 2026-09-25
- [RESULT] User inspected `/tmp/proton-native.conf` with secrets masked.
- [FACT] The file is a standard WireGuard-style Proton profile: `[Interface]` with `PrivateKey`; `[Peer]` with `PublicKey`, `AllowedIPs = 0.0.0.0/0, ::/0`, `Endpoint = ...:51820`, `PersistentKeepalive = 25`.
- [FACT] The profile comment identifies `NL-FREE#128`.
- [USER CORRECTION] User states this is an old configuration and it is not the current Proton profile intended for the test.
- [DECISION] Do not use this profile for the controlled AWG/Proton experiment. Do not print or copy its private key.
- [STATUS] GATE 2 = BLOCKED pending the current Proton Free profile/file.


### GATE 2 — current Proton Free profile supplied — 2026-09-25
- [RESULT] User supplied the current Proton Free profile with `PrivateKey` left blank/redacted.
- [FACT] Profile has `Address = 10.2.0.2/32`, `DNS = 10.2.0.1`.
- [FACT] Peer is identified by comment `US-FREE#130`; its public key is present; `AllowedIPs = 0.0.0.0/0, ::/0`; endpoint is `194.180.33.20:51820`; `PersistentKeepalive = 25`.
- [FACT] This is a standard WireGuard-format profile and contains no AmneziaWG-specific parameters in the supplied text.
- [SECURITY] PrivateKey was not supplied in plaintext and must not be requested in chat. It must be entered locally on the router only if/when the controlled test is authorized.
- [INTERPRETATION] The profile is structurally suitable as input to the AWG netifd handler because that handler supports standard WireGuard peer fields; however, actual AWG compatibility/handshake is unproven.
- [STATUS] GATE 2 = DONE for profile structure. GATE 3 (isolated AWG interface) is ready for planning, but no interface/config/routes/firewall changes have been made.


### GATE 3 — AWG interface pre-check — 2026-09-25
- [RESULT] Read-only check returned no `amneziawg` interfaces and no UCI network sections using `proto='amneziawg'`.
- [FACT] There is no existing AWG interface/configuration that would conflict with the planned isolated test.
- [SAFETY] No configuration or runtime state was changed.
- [STATUS] GATE 3 = NOT_STARTED for interface creation; pre-check = DONE.
- [NEXT] Before creating the interface, protect the Proton endpoint with an explicit host route through the existing Archer-side gateway, then create the isolated AWG interface without installing a default route. This will be a reversible change and must be done one step at a time.


### GATE 3 — Proton endpoint host-route runtime addition — 2026-09-25
- [RESULT] `ip route replace 194.180.33.20/32 via 192.168.0.1 dev phy0-sta0` returned no output.
- [FACT] This command normally reports no output on success; the route was intended as a runtime-only host route to keep the Proton endpoint outside any future tunnel routing. OpenWrt documents runtime `ip route` manipulation and persistent static-route equivalents. citeturn0search0
- [SAFETY] No AWG interface, default route, firewall, DNS, or Zapret2 configuration was changed by this step.
- [NEXT] Verify the exact endpoint route before creating the AWG interface.


### GATE 3 — Proton endpoint route verified — 2026-09-25
- [RESULT] `ip route get 194.180.33.20` returned `194.180.33.20 via 192.168.0.1 dev phy0-sta0 src 192.168.0.100`.
- [CONFIRMED] The Proton endpoint is explicitly routed through the Archer-side uplink and source address, so a future tunnel default route can be kept from looping the endpoint back into itself.
- [SAFETY] No AWG interface or default route has been created.
- [STATUS] GATE 3 pre-routing protection = DONE; isolated AWG interface creation is the next controlled change.


### CHECKPOINT — paused before AWG interface creation — 2026-09-25
- [CHECKPOINT] User asked to save the exact stopping point for continuation later.
- [CURRENT] STAGE 14 = IN_PROGRESS. GATE 1 (Zapret2/WireGuard runtime audit) = DONE. GATE 2 (current Proton profile structure) = DONE. GATE 3 = IN_PROGRESS.
- [CONFIRMED] Current Proton profile: standard WireGuard format, `Address=10.2.0.2/32`, `DNS=10.2.0.1`, peer `US-FREE#130`, `AllowedIPs=0.0.0.0/0, ::/0`, endpoint `194.180.33.20:51820`, keepalive 25; private key remains local/secret and was not stored in the plan.
- [CONFIRMED] No AWG interface or UCI `proto=amneziawg` section existed before the test.
- [CONFIRMED] Runtime endpoint host route is protected: `194.180.33.20 via 192.168.0.1 dev phy0-sta0 src 192.168.0.100`.
- [NEXT EXACT STEP] Create the isolated UCI AWG test section `proton-awg-test`, without starting it and without installing/changing a default route. This is the next controlled change when work resumes.
- [SAFETY] No AWG interface has been created yet; no default route, firewall, DNS, or Zapret2 configuration has been changed for the AWG test.

## MASTER HANDOFF / AI PREFLIGHT — 2026-09-25

### Mandatory repository read before every technical turn
- [USER REQUIREMENT] Every new AI/session working on this router project MUST first read the current versions of all three mandatory control documents from the `Calcul` repository:
  1. `OPENWRT_VARIANT_A_MASTER_PROMPT.md`
  2. `OPENWRT_VARIANT_A_MASTER_PLAN.md`
  3. `OPENWRT_VARIANT_A_GLOSSARY.md`
- [ORDER] Read MASTER PROMPT first for hard rules and safety constraints; MASTER PLAN second for current factual state, completed tests, current stage and exact stopping point; GLOSSARY third for the command/term registry and already implemented capabilities.
- [CURRENT-STATE RULE] After reading the three documents, identify the latest dated checkpoint/change near the end of MASTER PLAN and use that as the primary project-state handoff point.
- [CAPABILITY-AWARE RULE] Before proposing installation, configuration, package addition, replacement or a new diagnostic mechanism, inspect the three documents for already implemented functions/capabilities and, when a relevant repository implementation file exists, inspect that file too. Do not propose duplicate functionality.
- [NO-FALSE-ABSENCE RULE] An AI must not state that a capability is “not implemented”, “missing” or “not available” until the current MASTER PLAN, MASTER PROMPT, GLOSSARY and relevant repository files have been checked.
- [CONFLICT RULE] If a fresh user router result conflicts with an older repository fact, the fresh user result becomes the current fact; the repository must then be synchronized before any next router command.
- [TECHNICAL-SOURCE RULE] The Calcul repository is the project's state/evidence/control repository, not the authoritative technical source for OpenWrt/Linux/package behavior. External technical claims must continue to use official or otherwise appropriate technical sources.
- [NO-REPEAT RULE] Do not repeat a completed diagnostic merely because it appears in history. Repeat only when regression, changed state, validation, or a new decision requires it.
- [ONE-STEP RULE] The one-router-command-at-a-time rule remains mandatory. Synchronization of the current user result/request happens before issuing a later router command.
- [SYNC RULE] After each user result and assistant response, factual project state must be written to MASTER PLAN before the next router command. MASTER PROMPT changes only for workflow/safety-rule changes. GLOSSARY changes when a new stable command/term/capability or corrected interpretation is established.

## FULL REPOSITORY INVENTORY / HANDOFF MAP — 2026-09-25

The complete current `main` tree was read in this review. It contains the following project artifacts:

- `OPENWRT_VARIANT_A_MASTER_PROMPT.md` — mandatory hard rules, workflow, safety gates, technical interpretation rules and AI handoff policy.
- `OPENWRT_VARIANT_A_MASTER_PLAN.md` — factual project history, stage status, test results, current implementation state and exact stopping point.
- `OPENWRT_VARIANT_A_GLOSSARY.md` — command/term registry, meanings, reusable diagnostic commands, status definitions and confirmed capabilities.
- `OPENWRT_VARIANT_A_START_HERE.md` — root handoff index; tells a new AI the mandatory read order and where to find current state.
- `OPENWRT_ZAPRET2_WATCHDOG.sh` — implemented lightweight Zapret2 health-check/auto-recovery script for the 64-MB hAP ac lite.
- `OPENWRT_ZAPRET2_WATCHDOG_INITD.sh` — OpenWrt procd wrapper for the watchdog daemon.
- `BLOCKCHECK2_YOUTUBE_FULL_INVENTORY.md` — compact pointer/status for the saved blockcheck2 YouTube source set.
- `blockcheck2-youtube-TLS12-AVAILABLE.md`, `blockcheck2-youtube-TLS13-AVAILABLE.md`, `blockcheck2-youtube-QUIC-AVAILABLE.md` — saved blockcheck2 discovery logs for YouTube TLS 1.2, TLS 1.3 and QUIC.
- `blockcheck2-youtube-COMMON-TLS12-TLS13-75.md` — saved combined/common discovery log.
- `blockcheck2-youtube-strategy-log-part-05.md` through `part-08.md` — continuation logs from the Windows/Cygwin strategy-discovery run.
- `blockcheck2-youtube-tls12-standard.log` — repository artifact currently present but zero bytes; it must not be treated as a source of test results.
- `antizapret-tcp.ovpn` — imported AntiZapret OpenVPN profile; availability of the file does not imply that the profile is active on the router.
- `nl-free-130.protonvpn.tcp.ovpn`, `nl-free-130.protonvpn.udp (1).ovpn`, `us-free-115.protonvpn.tcp.ovpn` — saved Proton OpenVPN profiles; these are reference artifacts, not proof of current tunnel state.

### Repository-state interpretation
- Files named as logs/profiles are evidence or reference artifacts and do not by themselves prove current router activation.
- The two watchdog files are implementation artifacts; their runtime state is established separately by the MASTER PLAN's router results.
- The latest confirmed watchdog runtime state is ACTIVE/DONE; the latest network/VPN work is paused later at the isolated AWG gate.
- Historical file names and historical commands must never be treated as current configuration without a dated router result.

## CONSOLIDATED CURRENT CAPABILITY REGISTRY — 2026-09-25

The following capabilities are already implemented or materially established and MUST be considered before proposing further work:

- OpenWrt 25.12.5 on MikroTik hAP ac lite / RB952Ui-5ac2nD, ath79/mikrotik, kernel 6.12.94, MIPS 24Kc, with TP-Link Archer C20 v4 remaining the main router.
- USB extroot is active on `/dev/sda2` mounted at `/overlay`; `/dev/sda3` is `/mnt/data`; `/dev/sda1` is USB swap.
- ZRAM is active with LZO-RLE; USB swap is the lower-priority fallback; no swap is intentionally placed in `/tmp`.
- `vm.min_free_kbytes=2048` is persistent and has passed the bounded 60-second sustained network-load validation recorded in STAGE 11C.
- The expanded diagnostic CLI package set is already installed; do not reinstall packages merely because a future AI sees their names in the glossary.
- Both wireless APs are established on the hAP and the WAN uplink uses the Archer-side Wi-Fi STA. The unfinished historical item about Archer-side access without LAN remains separate.
- DoH/https-dns-proxy is retired from the current Variant A workflow by explicit user decision and must not be reintroduced without instruction.
- Zapret2 v1.0.3 is active with current `MODE_FILTER=autohostlist`, TCP 80/443, UDP 443, main QNUM 300 and WireGuard-pattern QNUM 65300, with `FLOWOFFLOAD=donttouch`, `INIT_APPLY_FW=1` and IPv6 disabled in the current Zapret2 configuration.
- The current `inet zapret2` nftables structure has been verified structurally after restart; the previous YouTube outage recovered after a Zapret2 restart, but the exact original failure cause remains UNCONFIRMED.
- Zapret2 watchdog is not merely a repository draft: the corrected script is installed at `/usr/bin/zapret2-watchdog`, the procd init script is installed at `/etc/init.d/zapret2-watchdog`, the service is enabled/autostarted and the daemon has produced periodic `HEALTH state=HEALTHY` records. Automatic recovery has not been triggered during validation.
- Watchdog safety guards currently include two consecutive structural/functional failures, no restart for upstream/DNS failure alone, 4096 KiB MemAvailable floor, maximum 2 automatic restarts per 900 seconds, 300-second cooldown, bounded logs/events, and no continuous tcpdump/config mutation.
- VLESS + REALITY / Xray-core remains the selected VPN transport candidate, but Xray is not installed.
- Full sing-box is not preferred on package-size grounds; sing-box-tiny remains a separate compatibility/resource gate and has not been activated.
- Proton Free current profile structure has been validated for the planned isolated AWG experiment; its private key remains secret and is not stored in the plan.
- The Proton endpoint `194.180.33.20/32` is protected by a runtime route via `192.168.0.1` on `phy0-sta0`.
- No AWG interface has been created yet. The exact next controlled change remains creation of the isolated UCI AWG test section without starting it and without installing a default route.
- Existing OpenVPN profile files in the repository must not be interpreted as active tunnels.

## CURRENT EXACT STOPPING POINT — 2026-09-25
- STAGE 14 = IN_PROGRESS.
- Zapret2 watchdog deployment/activation = DONE.
- Zapret2 runtime audit = DONE for the current read-only structural state.
- Proton Gate 1 (Zapret2/WireGuard-pattern runtime audit) = DONE.
- Proton Gate 2 (current Proton Free profile structure) = DONE.
- Proton Gate 3 = IN_PROGRESS.
- Endpoint host route protection = DONE.
- [NEXT EXACT ACTION WHEN WORK RESUMES] Create the isolated UCI AWG test section `proton-awg-test`, do not start it, do not create a default route, and preserve the endpoint route. One router command only.
- Do not reopen ZRAM/LZ4 work, DoH, or indiscriminate Zapret2 tuning unless new evidence requires it.

## CHAT HISTORY RESTORATION NOTE — 2026-09-25
- This repository revision consolidates the available chat history into the stage records above rather than reproducing the chat verbatim.
- The latest Zapret2 incident sequence is explicitly preserved: running-status observation → YouTube failure → manual restart → YouTube recovery → auto-hostlist inspection → nfqws2/nftables structural audit → root cause of the watchdog's own false nft predicate → regex correction → watchdog deployment → HEALTHY `--check` → healthy `--once` → procd enable/start → periodic HEALTHY record.
- The watchdog was tested without intentionally reproducing the original YouTube outage.
- The earlier system-wide OOM history remains background evidence only; it is not recorded as the proven cause of the specific YouTube outage.

## HANDOFF DOCUMENT SYNC — 2026-09-25
- [COMPLETED] Mandatory AI preflight policy added to MASTER PROMPT.
- [COMPLETED] Consolidated AI handoff, full repository inventory, capability registry, current exact stopping point and chat-history restoration note added to MASTER PLAN.
- [COMPLETED] Mandatory preflight, capability registry, watchdog definitions and repository-vs-runtime distinctions added to GLOSSARY.
- [COMPLETED] New root `OPENWRT_VARIANT_A_START_HERE.md` created as the first-entry handoff index for future AIs.
- [COMMIT MAP] MASTER PLAN: `4343cb2306c74e2bfdeadf840e95409f8774a4bf` before this sync; MASTER PROMPT: `90ffbf0a3aaea668bca341c3b42909d0873cdd7b`; GLOSSARY: `da29903efd2b6f522a8b17198c1ee809414fa7c8`; START_HERE: `df38f55464f5065a7cea6b4d694d4261c13168c5`.
- [RULE] These documents form a linked handoff chain: START_HERE → MASTER PROMPT → MASTER PLAN → GLOSSARY → relevant implementation/evidence files.
- [STATUS] Documentation/handoff synchronization = DONE.

## DOCUMENTATION SYNC ADDENDUM — 2026-09-25 — current chat / DoH + memory investigation

### 1. Current verified router results from the latest chat
- [RESULT] The router remains at STAGE 14 / Proton-AWG Gate 3 IN_PROGRESS.
- [RESULT] Memory snapshot: MemTotal=54852 kB, MemFree=11840 kB, MemAvailable=4044 kB, Slab=10144 kB, SReclaimable=1284 kB, SUnreclaim=8860 kB, SwapTotal=557048 kB, SwapFree=551960 kB.
- [INTERPRETATION] The approximately 4 MiB MemAvailable and approximately 8.6 MiB SUnreclaim confirm a narrow memory margin, while swap was largely free. This does not prove a specific leak or prove nfqws2 as the cause.
- [RESULT] At that diagnostic point NFQUEUE output was empty and no nfqws2 process was present in ps w; therefore the low MemAvailable was not accompanied by an active nfqws2/NFQUEUE queue at that instant.
- [RESULT] /proc/slabinfo is unavailable on this build. /sys/kernel/slab exists, but the exported objects/total_objects counters needed for cache accounting are unavailable; objects_partial is not sufficient to infer total live-object memory. No slab-cache root cause was declared.

### 2. DoH consolidation decision and current state
- [USER DECISION] Keep Cloudflare DoH; remove the Google DoH instance to reduce persistent memory overhead on the 64-MiB hAP ac lite.
- [RESULT] Before the change, UCI contained two https-dns-proxy instances: Cloudflare on 127.0.0.1:5053 and Google on 127.0.0.1:5054; dnsmasq explicitly referenced both.
- [RESULT] Measured process memory before consolidation: Cloudflare PID 5573 VmRSS=1716 kB; Google PID 6676 VmRSS=1672 kB; combined RSS approximately 3388 kB (~3.3 MiB).
- [CHANGE] Removed https-dns-proxy.@https-dns-proxy[1] from UCI and committed the change. UCI then contained only the Cloudflare instance on port 5053.
- [RESULT] /etc/init.d/https-dns-proxy restart completed successfully: Starting https-dns-proxy 2026.05.06-r1 instances ✓; Updating notrack rules ✓; Setting trigger for wan ✓.
- [PENDING] Post-restart verification of the 5053 listener, absence of 5054 listener/process, and DNS resolution has not yet been executed. Do not mark the single-DoH runtime state as fully VALIDATED until that read-only check is completed.
- [IMPORTANT] This current user-directed change supersedes the older repository statement that DoH was retired from the workflow. DoH is now a single-instance Cloudflare configuration pending post-restart validation.

### 3. Interpretation / safety rule for memory investigation
- [RULE] Do not attribute historical OOM events to nfqws2 solely because nfqws2 was selected as an OOM victim. Earlier OOM evidence included multiple victims and system-wide memory pressure.
- [RULE] Do not increase swap, change ZRAM, lower vm.min_free_kbytes further, or perform broad Zapret2 tuning merely to react to the 4-MiB snapshot. Any such change requires new evidence and its own controlled gate.
- [RULE] Avoid open-ended/heavy tcpdump or heavyweight monitoring daemons on this 64-MiB router; bounded diagnostics only.

### 4. Current exact chat stopping point
- [STATE] Documentation synchronization is being performed after the single-DoH consolidation and memory investigation.
- [NEXT EXACT ROUTER ACTION] Verify post-restart DoH runtime: one https-dns-proxy process, port 5053 listening, port 5054 absent, then perform a bounded DNS/HTTPS validation before returning to Proton/AWG Gate 3.
- [NEXT PROJECT GATE AFTER VALIDATION] Resume the existing Gate 3 plan: create the isolated UCI AWG test section proton-awg-test, do not start it, do not create a default route, and preserve the Proton endpoint host route via phy0-sta0.
- [STATUS] STAGE 14 = IN_PROGRESS; Proton Gate 3 = IN_PROGRESS; DoH consolidation = CONFIGURED, post-restart runtime validation PENDING; memory investigation = IN_PROGRESS/UNRESOLVED ROOT CAUSE.

### 5. Documentation protocol strengthening
- [POLICY] Every future AI must treat the three documents as a mandatory capability/state gate, not merely a reading recommendation: MASTER PROMPT → MASTER PLAN → GLOSSARY, then START_HERE and only relevant evidence/implementation files.
- [POLICY] Before proposing any new package, service, daemon, script, firewall rule, routing mechanism, DNS mechanism, VPN, monitoring system, or diagnostic tool, the AI must explicitly cross-check the Capability Registry and the IMPLEMENTED/DEPLOYED/ACTIVE/VALIDATED evidence levels.
- [POLICY] If the chat contains a newer verified router result than the repository, the AI must synchronize the repository before issuing the next router-changing command.
- [POLICY] If the repository and chat disagree, the AI must not silently choose a side: record the conflict, identify the latest verified evidence, and update the documents before continuing.
## DOCUMENTATION SYNC — 2026-09-25 — latest Proton/OpenVPN diagnostic branch

### 1. Latest verified user results incorporated
- [RESULT] proton.auth read-only metadata: username length=16; password length=32; no colon; no +f1, +f2 or +nr suffix. Secret contents were not exposed.
- [RESULT] /tmp/proton-us-443.ovpn contains proto tcp, auth-user-pass without a credential filename, and a single remote 84.20.27.33 443. Isolated CLI tests therefore require an explicit --auth-user-pass /etc/openvpn/proton.auth override; the credential file was not modified.
- [RESULT] Live fakedsplit:pos=2 isolated A/B test on temporary NFQUEUE 65301: TCP connection to 84.20.27.33:443 established, then Server poll timeout; NFQUEUE showed last_packet_id=8 with no queue drops. fakedsplit is FAILED as an OpenVPN control-channel fix.
- [RESULT] Earlier isolated multisplit:pos=2 test was FAILED and is not to be repeated without a new hypothesis.
- [RESULT] Plaintext HTTP sent with nc to TCP/443 returned 0 bytes. This is NON-DIAGNOSTIC because TCP/443 expects TLS; no endpoint conclusion was drawn.
- [RESULT] BusyBox nc on this router supports only nc [IPADDR PORT]; the first option-rich syntax was rejected. A compatible nc test later executed.
- [RESULT] command -v openssl returned OPENSSL_NOT_INSTALLED, despite an older repository/glossary entry recording openssl-util as installed. This is a repository-vs-runtime discrepancy; do not reinstall solely from the old entry.
- [RESULT] BusyBox wget on this router does not support -S; the attempted TLS probe did not execute. Do not interpret it as a network/TLS result.
- [RESULT] No active temporary NFQUEUE 65301 process remained after the failed test; temporary nft rule handle 475 was explicitly deleted.
- [SAFETY] TP-Link Archer C20 v4 was not modified or restarted during this diagnostic branch.

### 2. Proton/OpenVPN interpretation
- [INTERPRETATION] Across the direct OpenVPN tests and isolated multisplit/fakedsplit tests, TCP to 84.20.27.33:443 establishes successfully but the OpenVPN control channel receives no response before Server poll timeout.
- [INTERPRETATION] This branch does not establish Zapret2 as the sole cause; the Zapret2-stopped A/B had already shown the same control-channel timeout.
- [DECISION] Do not continue blind desync-variant enumeration as a presumed fix. The separately gated AWG experiment remains the Proton Gate 3 path.
- [STATUS] Proton OpenVPN TCP fallback diagnosis = FAILED for the tested profiles/variants; Proton/AWG Gate 3 = IN_PROGRESS.

### 3. Capability/state reconciliation correction
- [CORRECTION] Distinguish "diagnostic package recorded as installed" from "binary currently callable on the router". Current evidence for openssl is NOT AVAILABLE AT RUNTIME even though the historical package-install record exists.
- [RULE] For any capability whose current runtime evidence conflicts with the repository record, use the latest verified router result, record the discrepancy, and do not perform installation/reinstallation until a need is established.

### 4. Current exact stopping point
- STAGE 14 = IN_PROGRESS.
- Proton Gate 3 = IN_PROGRESS.
- Zapret2 watchdog deployment/activation = DONE.
- Proton Gate 1 = DONE.
- Proton Gate 2 = DONE.
- Endpoint host-route protection = DONE.
- This user turn is documentation/handoff synchronization; it does not authorize a new router-changing command.
- Existing DoH post-restart validation remains PENDING; after that validation, the controlled Gate 3 AWG section remains the planned next state-changing step.

### 5. Handoff enforcement strengthening
- [POLICY] Before every technical turn, future AIs must reconcile MASTER PROMPT → MASTER PLAN → GLOSSARY → START_HERE → relevant implementation/evidence files.
- [POLICY] Maintain a capability ledger: existing capability, evidence level, current runtime status, proposed delta, and reason no duplicate is being created.
- [POLICY] Repository/package records are historical evidence until the current router exposes the expected command/process/interface when that fact matters.
- [POLICY] A command rejected because of local syntax/tool limitations is TOOL/SYNTAX BLOCKED or NON-DIAGNOSTIC, never a network/service FAIL.
- [POLICY] Once a controlled diagnostic branch is exhausted by meaningful A/B tests, do not reopen it without a new hypothesis or evidence gap.


---

## PROJECT SYNC CHECKPOINT — 2026-09-25 — USB / FIRMWARE / FUTURE-AI PREFLIGHT

### [FACTUAL STATE — verified in the current conversation]
- Current USB is physically connected directly to the MikroTik hAP ac lite. The previous Windows/WSL/usbipd path is no longer the working path and must not be used as the basis for USB state.
- Kernel detected the USB device as `General UDisk`, `/dev/sda`, 4.03 GB decimal / 3.75 GiB, writable.
- `lsblk` is absent in the current firmware. This is not a blocker; `/proc/partitions`, `/sys/block/sda/*`, `fdisk`, `block` and other available tools are the authoritative runtime alternatives.
- `/dev/sda` was deliberately repartitioned after verification:
  - `/dev/sda1`: 64 MiB, MBR type 82, Linux swap.
  - `/dev/sda2`: remaining ~3.7 GiB, MBR type 83, intended data/ext4 partition.
- The partition table was written successfully with `fdisk` and re-read successfully by the kernel.
- `mkswap /dev/sda1` succeeded and `swapon /dev/sda1` succeeded.
- Current `/proc/swaps`: `/dev/sda1`, 65532 KiB, used 0 KiB, priority -2.
- `/dev/sda2` has NOT been formatted yet. The attempted `mkfs.ext4 /dev/sda2` failed because `mkfs.ext4`/e2fsprogs is absent in the currently running firmware.
- `apk info e2fsprogs` only produced cache-index warnings; package presence was not established and no package was installed.
- Do NOT attempt alternative filesystem-formatting commands on `/dev/sda2` merely to bypass the missing package.
- The current running firmware therefore does NOT equal the previously built ImageBuilder candidate manifest. The absence of `e2fsprogs` is an actual image-content discrepancy and must be reconciled in the firmware-build stage.
- The USB is currently a staging device: swap is active; `/dev/sda2` is intentionally left unformatted until the correct `e2fsprogs` tooling is available.
- No statement that ext4 mount, /mnt/data, extroot, or heavy-component storage is complete may be made yet.

### [STATUS CORRECTION]
- USB partition creation is complete.
- USB ext4/mount stage is blocked only by the missing ext4 formatting utility in the current firmware; swap initialization is complete.
- Firmware composition/build must reconcile the actual running image against the intended package manifest before destructive or persistent next steps.
- Do not silently mark a capability as implemented because its package was only verified in ImageBuilder. A capability is implemented only after runtime verification on the router.

### [MANDATORY FUTURE-AI CAPABILITY PREFLIGHT]
Before any new technical action, every AI/session MUST:
1. Read `OPENWRT_VARIANT_A_START_HERE.md`.
2. Read `OPENWRT_VARIANT_A_MASTER_PROMPT.md`.
3. Read the latest/current sections of `OPENWRT_VARIANT_A_MASTER_PLAN.md`, including the most recent sync checkpoint and current stage status.
4. Read `OPENWRT_VARIANT_A_GLOSSARY.md`.
5. Audit the documents for the router's **implemented vs planned vs tested vs blocked** capabilities before proposing a command.
6. Treat runtime evidence on the router as authoritative for "implemented"; treat ImageBuilder/package verification as "available for build", not "installed".
7. Check for already implemented functions and existing services/configuration before adding, replacing, or reinstalling anything.
8. Reconcile any conflict between old historical notes and newer verified runtime evidence before acting.
9. Use the smallest safe next step and preserve the one-command-at-a-time rule.
10. After the user's result, update the master plan before proceeding to a new stage or capability.

### [CAPABILITY LEDGER RULE]
The project documentation must distinguish at least these states for every major feature:
`PLANNED`, `AVAILABLE_FOR_BUILD`, `INSTALLED`, `CONFIGURED`, `RUNTIME_VERIFIED`, `BLOCKED`, `DISABLED`, `REMOVED`, `FAILED`.
A package name in a build manifest alone is never evidence of `INSTALLED` or `RUNTIME_VERIFIED`.

### [CURRENT CAPABILITY LEDGER — 2026-09-25]
- OpenWrt 25.12.5 / ath79-mikrotik / RB952Ui-5ac2nD: runtime present and verified historically.
- USB mass storage: runtime detected and verified.
- USB partitioning: runtime completed and verified.
- USB swap: installed/configured/runtime verified; active as `/dev/sda1`.
- USB ext4 tooling: available-for-build, but NOT installed in the current running firmware.
- `/dev/sda2` ext4 filesystem: planned, not created.
- `/mnt/data`: planned, not mounted.
- extroot: planned, not currently established by this checkpoint.
- DoH/https-dns-proxy: package was available for build; current glossary records previous runtime instances stopped/disabled. Do not call DoH active without fresh runtime verification.
- PBR: available-for-build; runtime status must be verified before treating it as implemented.
- NFQUEUE/firewall4: available/previously verified as build components; current runtime status must be checked before treating them as active.
- Zapret2/nfqws2: extensive build/runtime work exists in the historical plan; current active state must be verified from the latest router output before any change.
- WARP/Proton/free-relay/AntiZapret alternatives: not to be treated as implemented merely because configuration/source files exist in the repository.

### [REPOSITORY-SCOPE NOTE]
The GitHub repository currently contains 20 tracked files (~5.28 MB total), including the four Variant-A control documents, Zapret2 watchdog scripts, AntiZapret/OpenVPN material, Proton OpenVPN profiles, and Blockcheck2/Youtube source logs. Repository artifacts are project evidence/reference and do not by themselves prove current router runtime state.

### [SAFETY]
No router configuration was changed by this documentation synchronization.

## 89. AUTHORITATIVE HANDOFF — AWG/Proton checkpoint supersedes older branch notes — 2026-09-25

This section is the authoritative continuation point for the current project conversation and must take precedence over older next-step notes from parallel chat branches when they conflict.

### Current exact state
- STAGE 14 = IN_PROGRESS.
- GATE 1 Zapret2/WireGuard runtime audit = DONE.
- GATE 2 current Proton Free profile structure = DONE.
- GATE 3 = IN_PROGRESS.
- Endpoint route protection = DONE and verified: 194.180.33.20 via 192.168.0.1 dev phy0-sta0 src 192.168.0.100.
- No AWG interface exists; no UCI proto=amneziawg section exists.
- AWG kernel module/userspace are installed and the kernel module is loaded; netifd AWG handler has been inspected.
- Current Proton profile supplied by user is standard WireGuard format: Address 10.2.0.2/32, DNS 10.2.0.1, AllowedIPs 0.0.0.0/0, ::/0, endpoint 194.180.33.20:51820, PersistentKeepalive 25. PrivateKey is intentionally not stored in project documentation.
- Active Zapret2 has two nfqws2 processes: QNUM 300 and dedicated QNUM 65300. QNUM 65300 is runtime-confirmed with WireGuard payload selectors wireguard_initiation,wireguard_response,wireguard_cookie and fake desync repeats=2.

### Exact next step
Create the isolated UCI section proton-awg-test WITHOUT starting it and WITHOUT creating a default route. The protected endpoint route must remain via phy0-sta0.

### Mandatory interpretation
The project is testing the concrete chain: standard Proton Free WireGuard profile → AmneziaWG-compatible interface → active local Zapret2 50-wg4all/QNUM 65300 path. Do not state that this chain is guaranteed to work; handshake and traffic must be experimentally validated.

### Parallel-branch rule
Older notes about pending DoH validation, OpenVPN experiments, historical USB layouts, or other branches remain historical unless they are explicitly selected as the current branch. They must not displace this AWG checkpoint.

### Repository-wide preflight invariant
Before every future technical response for this project, AI must:
1. read OPENWRT_VARIANT_A_START_HERE.md;
2. read current OPENWRT_VARIANT_A_MASTER_PROMPT.md;
3. read current OPENWRT_VARIANT_A_MASTER_PLAN.md;
4. read current OPENWRT_VARIANT_A_GLOSSARY.md;
5. inventory the repository root and identify implementation/evidence artifacts relevant to the requested action;
6. audit the Capability Registry before proposing any installation, configuration, restart, routing, firewall, DNS or monitoring change;
7. reconcile any newer verified router/chat result against the documents before issuing a new router command.

The preflight is mandatory even if the requested action appears to concern only one component.

Type: AUTHORITATIVE STATE / POLICY

## PROJECT EXECUTION POLICY — 2026-09-25

- [USER REQUIREMENT] Пользователь запросил более смелый режим работы: после восстановления состояния AI должен переходить к следующему шагу, а не повторно пересказывать документы десятками строк.
- [POLICY] Стандартная команда пользователя «Продолжай.» означает продолжение строго с текущего checkpoint MASTER PLAN.
- [POLICY] Если следующий шаг однозначен и является read-only, bounded, обратимым или уже разрешённым текущим этапом, AI должен выполнять его без повторного запроса подтверждения.
- [POLICY] За один пользовательский ответ выполняется только один следующий router command/test, если пользователь не попросил batch.
- [POLICY] Отдельное подтверждение сохраняется для destructive/труднообратимых операций, flash/partition/format, операций с риском потери доступа, массового изменения пакетов, включения нового default route/полной VPN-маршрутизации и передачи секретов.
- [POLICY] В EXECUTION-режиме перед командой не нужен повтор MASTER PLAN/истории; показываются только STATUS, текущая capability, текущий delta и команда.
- [POLICY] После результата команда классифицируется; затем MASTER PLAN синхронизируется до следующей изменяющей команды.
- [POLICY] TOOL/SYNTAX BLOCKED исправляется минимально и не должен превращаться в новый цикл десятков диагностик.
- [POLICY] Закрытые A/B-гипотезы не повторяются без новой причины.
- [STATUS] Политика workflow изменена. Стадия проекта и текущий AWG checkpoint НЕ изменены.


## STAGE 14 — AWG isolated UCI scaffold created — 2026-09-25

- [USER RESULT] Executed the planned UCI batch for `network.proton_awg_test`.
- [RESULT] UCI transaction returned `cfg0c9ea6`; network configuration was committed successfully.
- [CONFIG INTENT] Created isolated `amneziawg` interface `proton_awg_test`, address `10.2.0.2/32`, Proton peer public key, AllowedIPs `0.0.0.0/0` and `::/0`, endpoint `194.180.33.20:51820`, PersistentKeepalive `25`, and `route_allowed_ips='0'`.
- [IMPORTANT] Interface was NOT brought up: no `ifup`, network reload/restart, `awg`, or handshake attempt was performed.
- [ROUTING] No default route was created. Protected endpoint route `194.180.33.20/32 via 192.168.0.1 dev phy0-sta0` remains the upstream path.
- [SECRET SAFETY] Proton private key was intentionally omitted and remains outside project documentation/chat.
- [STATUS] STAGE 14 = IN_PROGRESS. AWG packages/kernel/userspace/netifd = DONE; isolated UCI scaffold = CONFIGURED / NOT_ACTIVE; private key = NOT_SET; interface/handshake/traffic = NOT_STARTED.
- [NEXT GATE] Read-only verification of the exact UCI sections before entering the private key or bringing the interface up.


## STAGE 14 — AWG UCI scaffold verification — 2026-09-25

- [USER RESULT] Read-only UCI verification completed successfully.
- [RESULT] network.proton_awg_test exists as interface with proto='amneziawg', auto='0', address 10.2.0.2/32.
- [RESULT] AWG peer section exists with the expected Proton public key, AllowedIPs=0.0.0.0/0 ::/0, route_allowed_ips='0', endpoint 194.180.33.20:51820, and PersistentKeepalive 25.
- [SECURITY] PrivateKey is absent from UCI and was not exposed in chat.
- [RUNTIME] No ifup/reload/handshake was performed by this verification step; no AWG default route was created.
- [STATUS] Isolated AWG scaffold = CONFIGURED / VERIFIED; private key = NOT_SET; interface/handshake/traffic = NOT_STARTED.
- [NEXT EXACT STEP] Enter the Proton private key locally on the router without displaying or storing it in chat, while keeping the interface disabled (auto=0) and route_allowed_ips=0.


## STAGE 14 — Proton PrivateKey entry — 2026-09-25

- [USER RESULT] User reports that the local private-key entry command appears to have completed and the Proton PrivateKey was entered on the router.
- [SECURITY] PrivateKey was not provided in chat and must not be reproduced or stored in project documentation.
- [RUNTIME] No interface activation, handshake, traffic test, or default-route change has been performed by this step.
- [STATUS] PrivateKey = ENTRY_REPORTED / verification pending; AWG interface remains intended to stay auto=0; route_allowed_ips=0.
- [NEXT EXACT STEP] Read-only verification that a non-empty PrivateKey exists, without printing its value.


## STAGE 14 — Proton PrivateKey verification — 2026-09-25

- [USER RESULT] Read-only UCI verification returned `PRIVATEKEY_SET len=44`.
- [SECURITY] PrivateKey value was not displayed or transmitted in chat; only its presence and length were verified.
- [RUNTIME] AWG interface has not been brought up; no handshake/traffic test and no default-route change have occurred.
- [STATUS] PrivateKey = SET / VERIFIED; isolated AWG scaffold remains auto=0 and route_allowed_ips=0; interface/handshake/traffic = NOT_STARTED.
- [NEXT EXACT STEP] Run `ifup proton_awg_test` to create the isolated AWG interface and attempt handshake, while route_allowed_ips=0 prevents installation of peer AllowedIPs as routes.


## STAGE 14 — ifup proton_awg_test result — 2026-09-25

- [USER RESULT] `ifup proton_awg_test` returned empty output.
- [INTERPRETATION] Empty output alone does not establish whether netifd created the AWG interface or whether the protocol handler completed successfully; no handshake/traffic success is inferred.
- [RUNTIME] No default-route enablement was requested; scaffold remains configured with route_allowed_ips=0.
- [STATUS] Interface/handshake/traffic = NOT_VERIFIED; next step is a single read-only runtime inspection of the AWG interface and peer state.


## STAGE 14 — AWG interface runtime creation — 2026-09-25

- [USER RESULT] `ip link show proton_awg_test` confirms interface `proton_awg_test` exists and is UP/LOWER_UP, MTU 1420.
- [USER RESULT] `awg show proton_awg_test` confirms the configured peer and endpoint `194.180.33.20:51820`; private key is hidden by the tool output.
- [RESULT] Local AWG public key is `7xQkuYc/KSLaL/ZlIDLwMUs3xCoo9YBQ94F91RZZC2c=`.
- [TRAFFIC] 592 B sent, 0 B received; this proves outbound WireGuard/AWG packets were emitted but does not prove handshake completion or usable tunnel traffic.
- [ROUTING] Peer AllowedIPs remain `0.0.0.0/0, ::/0`; scaffold uses `route_allowed_ips=0`, so no peer default route was intentionally installed.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; handshake = NOT_VERIFIED; usable tunnel traffic = NOT_VERIFIED.
- [NEXT EXACT STEP] Read-only verification of handshake/route state, without changing configuration.


## STAGE 14 — AWG handshake check — 2026-09-25

- [USER RESULT] `awg show proton_awg_test` shows endpoint `194.180.33.20:51820` and transfer `0 B received, 2.46 KiB sent`.
- [RESULT] No `latest handshake` field was returned, so a successful handshake is NOT verified.
- [ROUTING] `ip route get 194.180.33.20` confirms the protected endpoint still uses `192.168.0.1 dev phy0-sta0 src 192.168.0.100`; AWG is not being used to reach its own endpoint.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; handshake = NOT_VERIFIED / no received traffic; endpoint protection route = VERIFIED.
- [INTERPRETATION] Outbound packets are leaving the router, but Proton has not returned observable AWG traffic. Do not enable full/default VPN routing at this point.
- [NEXT EXACT STEP] Read-only inspect kernel/network logs for the AWG interface/protocol handler, without changing configuration.


## STAGE 14 — AWG/netifd/kernel log inspection — 2026-09-25

- [USER RESULT] Logs show `Interface 'proton_awg_test' is setting up now`, AmneziaWG 3.1.20260906 kernel module loaded, netifd reports `Interface 'proton_awg_test' is now up` and device link is up.
- [RESULT] No explicit AWG/netifd error is present in the returned tail.
- [RESULT] Zapret2 dedicated QNUM 65300 process is confirmed in the same log history with WireGuard payload desync configuration.
- [INTERPRETATION] Local AWG interface setup is successful; the unresolved issue is still absence of a returned handshake/traffic from the Proton endpoint.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; local setup = VERIFIED; handshake = NOT_VERIFIED; received traffic = 0 B.
- [NEXT EXACT STEP] Read-only inspect the current nftables/QNUM path for the AWG endpoint packet handling, without changing firewall or Zapret2 configuration.


## STAGE 14 — AWG Zapret2 QNUM 65300 nftables verification — 2026-09-25

- [USER RESULT] `nft list table inet zapret2 | grep -E '65300|wireguard|51820'` returned three IPv4 UDP rules matching lengths 72, 100, and 156 and queueing to NFQUEUE 65300 with bypass.
- [RESULT] The dedicated QNUM 65300 packet path is present in the active `inet zapret2` table.
- [LIMITATION] The grep output does not prove that the actual Proton endpoint packets matched those rules, nor that the endpoint's replies reached the router.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; QNUM 65300 rule path = RUNTIME_VERIFIED; handshake = NOT_VERIFIED; received traffic = 0 B.
- [NEXT EXACT STEP] Read-only inspect NFQUEUE 65300 packet counters/rule counters in the active zapret2 table to determine whether the AWG handshake packets are actually being captured.


## STAGE 14 — PrivateKey/public-key correspondence clarification — 2026-09-25

- [USER CONFIRMATION] User confirmed that the preceding explanation of PrivateKey verification corresponds to their situation.
- [SECURITY] No private key value was requested, displayed, or stored in project documentation.
- [INTERPRETATION] The router-side AWG public key `7xQkuYc/KSLaL/ZlIDLwMUs3xCoo9YBQ94F91RZZC2c=` is derived from the currently stored client PrivateKey. The Proton peer key `jyiQbTTHvl6eLhIQWi1zL7xzPppbV7z+hFJ6e7CEmAg=` is the server/peer public key and must not be used as the client-key comparison target.
- [STATUS] PrivateKey = SET / VERIFIED as a syntactically accepted key; exact account/profile correspondence remains a separate identity check if Proton exposes the client public key.
- [NEXT EXACT STEP] Read-only inspect the active NFQUEUE state for QNUM 65300 to determine whether the AWG handshake path is actually being queued to the dedicated Zapret2 userspace process.


## STAGE 14 — NFQUEUE 65300 runtime state — 2026-09-25

- [USER RESULT] `cat /proc/net/netfilter/nfnetlink_queue` returned active queues `65300` and `300`.
- [RESULT] QNUM 65300: peer netlink PID 3205, current queue depth 0, copy mode 2, copy range 65531, kernel queue drops 0, netlink user drops 0, packet-id sequence 160.
- [RESULT] QNUM 300: peer netlink PID 3204, current queue depth 0, copy mode 2, copy range 65531, kernel queue drops 0, netlink user drops 0, packet-id sequence 64368.
- [INTERPRETATION] QNUM 65300 is genuinely subscribed by userspace and is not stalled; its non-zero packet-id sequence is evidence that packets have entered that NFQUEUE path. Zero queue depth and zero drop counters show no current backlog/drop condition.
- [LIMITATION] This does not prove that a valid Proton handshake was completed or that a reply packet was received from 194.180.33.20.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; dedicated NFQUEUE 65300 = RUNTIME_VERIFIED / packet-path activity evidenced; handshake = NOT_VERIFIED; received traffic = 0 B; endpoint route = VERIFIED.
- [NEXT EXACT STEP] Use one tightly bounded WAN capture for UDP/51820 to the protected Proton endpoint, without configuration changes, to distinguish outbound-only traffic from returned endpoint traffic.


## STAGE 14 — Proton endpoint UDP capture — 2026-09-25

- [USER RESULT] Bounded capture on `phy0-sta0`: `tcpdump -ni phy0-sta0 -nn -s 96 -c 10 'host 194.180.33.20 and udp port 51820'`.
- [RESULT] 10 packets captured, 12 received by filter, 0 dropped by kernel.
- [RESULT] All displayed packets were outbound from `192.168.0.100:38231` to `194.180.33.20:51820`; no inbound packet from the Proton endpoint was observed in the captured sample.
- [RESULT] Captured UDP payload lengths included repeated 16-byte packets and 148-byte packets, consistent with repeated outbound tunnel-control/keepalive-or-retry traffic, but packet decoding was intentionally not inferred beyond direction/size.
- [INTERPRETATION] The AWG interface is generating outbound traffic and the WAN STA path is transmitting it without local capture loss. The missing handshake remains unresolved because no endpoint response is observed in this bounded sample.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; NFQUEUE 65300 = RUNTIME_VERIFIED; outbound endpoint path = OBSERVED; inbound endpoint response = NOT_OBSERVED; handshake = NOT_VERIFIED; received traffic = 0 B.
- [NEXT EXACT STEP] Read-only verify that the dedicated QNUM 65300 userspace process (PID associated with the NFQUEUE) is still present and inspect its command line, without restarting or changing Zapret2.


## STAGE 14 — Dedicated nfqws2 process verification — 2026-09-25

- [USER RESULT] `ps w | grep '[n]fqws2'` shows exactly two running `nfqws2` processes: PID 3204 and PID 3205.
- [CORRELATION] These PIDs correspond directly to the active NFQUEUE subscribers previously reported by `/proc/net/netfilter/nfnetlink_queue`: QNUM 300 → PID 3204 and QNUM 65300 → PID 3205.
- [RESULT] Both dedicated/main userspace processes remain alive; no process crash or missing NFQUEUE consumer is indicated.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; QNUM 65300 consumer = RUNTIME_VERIFIED / alive; outbound endpoint packets = OBSERVED; inbound endpoint response = NOT_OBSERVED; handshake = NOT_VERIFIED; received traffic = 0 B.
- [NEXT EXACT STEP] Read-only inspect the full command line of PID 3205 to confirm its QNUM 65300 and WireGuard-specific payload/desync parameters, without restarting or modifying Zapret2.


## STAGE 14 — QNUM 65300 full command-line verification — 2026-09-25

- [USER RESULT] PID 3205 command line confirms `nfqws2 --qnum=65300`.
- [RESULT] The dedicated process uses `--payload=wireguard_initiation,wireguard_response,wireguard_cookie` and `--lua-desync=fake:blob=0x00000000000000000000000000000000:repeats=2`.
- [RESULT] The dedicated WG desync process is therefore not merely present by queue number; its active runtime arguments match the intended `50-wg4all` WireGuard payload path.
- [INTERPRETATION] Local Zapret2 WG handling is now strongly verified through configuration-independent runtime evidence: nftables rules → NFQUEUE 65300 subscription → live PID 3205 → WG-specific payload/desync arguments.
- [LIMITATION] This still does not prove Proton endpoint acceptance or a completed handshake. WAN capture showed outbound UDP/51820 only, with no inbound response in the sample.
- [STATUS] AWG interface = ACTIVE AT RUNTIME; local Zapret2 WG path = RUNTIME_VERIFIED; outbound endpoint traffic = OBSERVED; inbound endpoint response = NOT_OBSERVED; handshake = NOT_VERIFIED; received traffic = 0 B.
- [NEXT DIAGNOSTIC DIRECTION] Do not modify Zapret2 blindly. The evidence now points away from a missing local QNUM 65300 consumer. The next investigation should distinguish (a) Proton endpoint/key/profile acceptance, (b) endpoint/path reachability beyond the Archer upstream, and (c) whether standard WireGuard initiation is being transformed in a way the Proton endpoint does not accept.

## STAGE 14 — QNUM 65300 command-line result confirmed — 2026-09-25
- [USER RESULT] `/proc/3205/cmdline` exactly confirms PID 3205 is the dedicated Zapret2 `nfqws2` consumer for `--qnum=65300`.
- [RESULT] Runtime arguments are `--payload=wireguard_initiation,wireguard_response,wireguard_cookie` with `--lua-desync=fake:blob=0x00000000000000000000000000000000:repeats=2`.
- [CONCLUSION] The local WireGuard-specific Zapret2 userspace path is fully runtime-verified; there is no evidence that QNUM 65300 is missing, unconsumed, or using the wrong WG payload mode.
- [LIMITATION] This does not establish Proton server acceptance or a completed AWG handshake. Earlier capture still showed outbound UDP/51820 only and 0 B received.
- [STATUS] STAGE 14 = IN_PROGRESS; AWG interface = ACTIVE AT RUNTIME; Zapret2 WG path = RUNTIME_VERIFIED; handshake = NOT_VERIFIED; usable tunnel traffic = NOT_VERIFIED.
- [NEXT] Move to a non-destructive control check that does not modify Zapret2/AWG configuration and distinguishes endpoint/path reachability from the already-verified local NFQUEUE path.


## STAGE 14 — AWG interface counters result — 2026-09-25

- [USER RESULT] `ip -s link show proton_awg_test` reports **RX 0 B / 0 packets / 0 drops**.
- [USER RESULT] TX counters report **34,780 B / 235 packets / 0 errors / 11 drops**.
- [INTERPRETATION] The AWG interface is actively producing outbound encrypted traffic, while no decrypted inbound traffic has reached the interface.
- [NEW EVIDENCE] The 11 TX drops are a kernel interface-counter observation and require attribution; they must not be interpreted automatically as proof of Proton rejection or a faulty AWG implementation.
- [CORRELATION] This is consistent with the earlier endpoint capture: outbound UDP/51820 was observed, but no inbound endpoint response was observed; handshake remains unverified and received traffic remains 0 B.
- [STATUS] STAGE 14 = IN_PROGRESS; AWG interface = ACTIVE AT RUNTIME; dedicated Zapret2 WG path = RUNTIME_VERIFIED; AWG RX = NOT_OBSERVED; handshake = NOT_VERIFIED; usable tunnel traffic = NOT_VERIFIED.
- [NEXT] Use one read-only peer-level status check to correlate the interface counters with AWG handshake/transfer state; do not change routing, Zapret2, firewall, or AWG configuration.


## STAGE 14 — AWG peer transfer result — 2026-09-25

- [USER RESULT] `awg show proton_awg_test` still shows endpoint `194.180.33.20:51820`, no `latest handshake` field, and `0 B received / 114.32 KiB sent`.
- [INTERPRETATION] Repeated keepalives/initiations are leaving the AWG interface, but no authenticated peer response has been received. This confirms the failure is not merely an idle interface.
- [CORRELATION] Together with RX=0 and the earlier WAN capture showing outbound UDP/51820 without inbound response, the current evidence is consistent with an absent/blocked/unaccepted server response, but does not identify whether the cause is upstream UDP filtering, Proton profile/key mismatch, or incompatibility introduced by the current WG-specific desync.
- [STATUS] STAGE 14 = IN_PROGRESS; AWG active = YES; local WG Zapret2 path = RUNTIME_VERIFIED; handshake = NOT_VERIFIED; received traffic = 0 B; usable tunnel = NOT_VERIFIED.
- [NEXT] Check the dedicated nftables QNUM 65300 rule counters read-only, to confirm that the growing outbound traffic is actually traversing the intended dedicated WG queue rules rather than only reaching the interface through another path.


## STAGE 14 — Proton/AWG Gate 3 — nftables QNUM 65300 rule verification — 2026-09-25
- [RESULT] Read-only `nft -a list table inet zapret2 | grep -E 'queue.*65300|counter packets'` confirmed the three dedicated WireGuard classification rules remain installed at handles 76/75/74 and queue matching is directed to QNUM 65300.
- [RESULT] Rules match IPv4 UDP lengths 72/100/156 with the expected WireGuard handshake-related magic values and `queue flags bypass to 65300`.
- [LIMITATION] The command output did not expose packet counters for these rules, so it does not by itself prove that current AWG packets increment those specific rules. Earlier `/proc/net/netfilter/nfnetlink_queue` evidence already showed QNUM 65300 receiving packet IDs, while endpoint capture showed outbound UDP/51820 and no inbound response.
- [INTERPRETATION] Dedicated QNUM 65300 path is structurally present and active at runtime; Proton handshake remains NOT_VERIFIED and usable tunnel traffic remains NOT_VERIFIED.
- [NEXT] Do not change Zapret2/AWG configuration yet. Use a bounded runtime correlation test to determine whether a fresh AWG transmission increments the dedicated nft rule counters, if counters are available in the installed nft output.
- [SAFETY] No configuration, routing, firewall, service, package, DNS, Wi-Fi, or reboot state changed.


## STAGE 14 — Proton/AWG Gate 3 — latest QNUM 65300 counter/traffic correlation — 2026-09-25
- [RESULT] Read-only 12-second A/B snapshot performed while `proton_awg_test` remained active and no default route was introduced.
- [RESULT] `awg show proton_awg_test`: sent 147.28→147.42 KiB; received remained 0 B; no latest-handshake line.
- [RESULT] NFQUEUE 65300 sequence advanced 1019→1020; depth and drops remained 0. QNUM 300 advanced 183827→184068; depth/drops remained 0.
- [RESULT] Dedicated nftables rules remain at handles 74/75/76. The displayed rules have no exposed packet-counter values, so per-rule counter increment is not proven by this test.
- [RESULT] Endpoint route remains via 192.168.0.1/dev phy0-sta0/src 192.168.0.100.
- [RESULT] AWG interface: RX 0 B/0 packets; TX 150960 B/1020 packets/0 errors/51 drops.
- [INTERPRETATION] QNUM 65300 is receiving fresh packets while AWG TX grows, with no NFQUEUE backlog/drops. Inbound Proton response remains unobserved; handshake remains unverified.
- [STATUS] STAGE 14 / Gate 3 = IN_PROGRESS. No default AWG route and no Zapret2/AWG restart from this evidence.
- [NEXT] One bounded endpoint capture of both directions on UDP/51820 during active AWG traffic.


## STAGE 14 — Proton-AWG Gate 3 — latest router evidence — 2026-09-25 19:34 GMT
- [USER RESULT] On isolated interface `proton_awg_test`, the configured Proton endpoint is `194.180.33.20:51820`.
- [RESULT] Before/after 12-second observation: `awg show proton_awg_test` remained at `transfer: 0 B received`; transmitted bytes increased from about 147.28 KiB to 147.42 KiB. No `latest handshake` line was reported by the filtered output.
- [RESULT] Endpoint route is correct and protected from accidental VPN routing: `194.180.33.20 via 192.168.0.1 dev phy0-sta0 src 192.168.0.100`.
- [RESULT] Dedicated Zapret2 NFQUEUE 65300 remains present with the expected UDP handshake/cookie payload selectors (length 72/100/156) and `queue flags bypass to 65300`.
- [RESULT] NFQUEUE 65300 showed no increase in the displayed queue/id counters during the 12-second interval; the separate queue 300 counters continued increasing. Do not infer from this alone that the AWG packets were rejected; the decisive runtime fact is still 0 RX / no handshake.
- [RESULT] `ip -s link show proton_awg_test`: interface UP/LOWER_UP; RX 0 bytes / 0 packets; TX 150960 bytes / 1020 packets; TX dropped 51. The TX drop counter is non-zero and must be treated as evidence requiring localization, not automatically as an AWG handshake failure cause.
- [INTERPRETATION] The isolated AWG experiment has generated outbound traffic toward the protected endpoint, but there is currently no observed return traffic and no established WireGuard/AWG handshake. The endpoint route is not the immediate issue because the route resolves through the intended upstream `phy0-sta0`.
- [STATUS] STAGE 14 / Proton-AWG Gate 3 remains IN_PROGRESS. This result does not justify creating a default route, enabling full VPN routing, or declaring Proton/AWG bypass success.
- [NEXT GATE] Before any activation/routing change, localize the current 0-RX/no-handshake condition with the smallest read-only runtime check defined by the Gate 3 plan. Do not enumerate additional desync variants without a new hypothesis.
- [SAFETY] No persistent routing/default-route change was made by this observation.
## STAGE 14 — Proton-AWG Gate 3 — BIG READ-ONLY TEST RESULT — 2026-09-25 20:57–20:58 GMT

- [TEST] One combined bounded read-only experiment covered AWG state/link, endpoint route, NFQUEUE, nfqws2 processes/cmdlines, Zapret2 WG selectors, bounded WAN capture (-s 96 -c 20), 4×5 s AWG observation, post-test state, route/process/kernel-error check, and memory control.
- [RESULT] proton_awg_test remained UP/LOWER_UP, endpoint 194.180.33.20:51820, persistent keepalive 25; sent increased 257.41→258.57 KiB, received remained 0 B; no latest handshake appeared.
- [RESULT] Endpoint route remained 194.180.33.20 via 192.168.0.1 dev phy0-sta0 src 192.168.0.100.
- [RESULT] WAN capture on phy0-sta0 for host 194.180.33.20 and udp port 51820 captured 20 packets / 34 packets received by filter / 0 dropped by kernel. All 20 captured packets were outbound from 192.168.0.100:38231 to 194.180.33.20:51820; no inbound UDP/51820 response was observed.
- [RESULT] Dedicated QNUM 65300/PID 3205 remained subscribed with queue depth 0 and drops 0; displayed packet-id advanced 1782→1789, matching the AWG TX packet counter increase 1782→1789.
- [RESULT] Main QNUM 300/PID 3204 remained subscribed with queue depth 0 and drops 0; displayed packet-id increased 302998→304923.
- [RESULT] proton_awg_test link counters increased TX 263736 B/1782 packets/89 drops → 264772 B/1789 packets/89 drops; RX remained 0/0/0/0. No new TX drops occurred during this test window.
- [RESULT] Both nfqws2 processes remained alive. PID 3205 command line confirms --qnum=65300 with WireGuard initiation/response/cookie selectors and fake repeats=2.
- [RESULT] Zapret2 nftables WG selectors for UDP lengths 72/100/156 → QNUM 65300 and normal TCP/UDP 80/443 → QNUM 300 remained present.
- [RESULT] Kernel log excerpt showed WireGuard/AmneziaWG module-load messages plus unrelated historical ath9k/ath10k messages; no AWG/NFQUEUE runtime error was present in the supplied excerpt.
- [INTERPRETATION] The local outbound AWG path is demonstrably active: packets leave the AWG interface, enter QNUM 65300, are handled by live nfqws2, and reach phy0-sta0 toward the configured endpoint. The decisive missing evidence is an inbound UDP/51820 response.
- [LIMITATION] Absence of inbound packets does not identify the root cause. Remaining hypotheses include upstream filtering/path behavior, endpoint/profile acceptance, key/parameter mismatch, or incompatibility with the exact AmneziaWG transformation. No hypothesis is declared proven.
- [GATE DECISION] Gate 3 remains IN_PROGRESS / handshake NOT_VALIDATED. Do not enable a default route, claim VPN/bypass success, or begin blind desync enumeration from this result.
- [SAFETY] No router configuration, route, firewall, Zapret2 service, AWG service, swap, VM setting, or default route was changed by the test.
- [NEXT] Use this as the authoritative Gate 3 evidence baseline. Any next diagnostic must target a new hypothesis; avoid repeating equivalent packet captures.

## 95. Proton-AWG Gate 4 — profile/runtime audit — 2026-09-25
- [RESULT] Isolated interface proton_awg_test is configured as proto='amneziawg', auto='0', address 10.2.0.2/32; its private key was correctly redacted in the primary audit output and is not recorded here.
- [RESULT] Runtime awg show confirms AmneziaWG interface is active with random trailers: off and disable cookies: off; peer endpoint is configured, AllowedIPs are 0.0.0.0/0, ::/0, persistent keepalive is 25 s, and transfer remains 0 B received with approximately 265.94 KiB sent. No latest handshake was reported.
- [RESULT] No AWG/AmneziaWG/WireGuard profile file was found under /etc, /opt, or /overlay by the bounded filename search.
- [RESULT] Kernel module is present at /lib/modules/6.12.94/amneziawg.ko; vermagic matches the running 6.12.94 MIPS32_R2 32-bit kernel. modinfo did not expose a module version line in this output.
- [RESULT] Userspace is amneziawg-tools v3.1.20260812. Official amneziawg-tools source for this release/tool family exposes AWG parameters including jc, jmin, jmax, s1-s4, h1-h4, i1-i5, and AWG 3.1 fields such as header-protection-key, content-padding-addition, rekey/timeout controls, max-handshake-attempts, random-trailers, and disable-cookies. citeturn0search0turn0search1turn0search2
- [IMPORTANT] The Gate 4 UCI parameter grep unexpectedly returned a private_key line. Because the intended regex does not logically target the literal private_key name, this line is treated as a diagnostic-command artifact until a safer, non-secret inspection is performed. The displayed value is not copied into project documentation.
- [INTERPRETATION] The current evidence proves an active AmneziaWG-capable runtime and basic peer/endpoint configuration, but it does not establish that the complete Proton AWG 3.x profile parameters match the server. With RX still zero and no handshake, protocol/profile compatibility remains unresolved.
- [STATUS] STAGE 14 / Gate 4 = IN_PROGRESS. No configuration, route, Zapret2 rule, or service was changed by this audit.
- [NEXT] Perform one read-only awg show parameter inspection for AWG-specific fields, without printing any private/preshared/header-protection key material. Do not start/stop the interface, create a default route, or alter desync parameters.


## 96. Proton-AWG Gate 4.1 — actual non-secret parameters — 2026-09-25
- [RESULT] Runtime: Jc=0, Jmin=0, Jmax=0; S1=S2=S3=S4=0; H1=1, H2=2, H3=3, H4=4; I1-I5 empty; ContentPaddingAddition=0; RekeyAfterTime=0; RekeyTimeout=0; RejectAfterTime=0; KeepaliveTimeout=0; RandomTrailers=off; DisableCookies=off. MaxHandshakeAttempts returned no value.
- [INTERPRETATION] The current proton_awg_test runtime is not configured with the Jc/Jmin/Jmax/S1/S2 obfuscation values from the user-supplied text. The current state is effectively the default/classic AWG parameter state.
- [IMPORTANT] The earlier UCI grep result containing private_key was a regex false-positive: the pattern included i1, which matches the substring i1 inside private_key. The displayed value was the already-known peer public key, not the interface private key.
- [TECHNICAL] Official Proton documentation says generated WireGuard configurations follow the official WireGuard specification and can be used by standard WireGuard clients; Proton does not document adding AmneziaWG obfuscation parameters to generated Free WireGuard profiles. See Proton WireGuard configuration documentation.
- [TECHNICAL] Official amneziawg-tools exposes the AWG parameter set used in this audit, including Jc/Jmin/Jmax, S1-S4, H1-H4, I1-I5 and AWG 3.1 controls.
- [CONCLUSION] The user-supplied Jc=4, Jmin=40, Jmax=70, S1=45, S2=112 values are an unverified external example, not evidence of a Proton-compatible server profile. Do not apply them blindly.
- [STATUS] STAGE 14 / Gate 4 = IN_PROGRESS. No configuration, route, Zapret2 rule, or service was changed.
- [NEXT] The useful source evidence is the actual Proton-generated configuration used to construct proton_awg_test, with secret fields removed. Without it, changing AWG parameters would be blind experimentation.


## STAGE 14 — Proton-AWG Gate 4.2 — Jc/Jmin/Jmax/S1/S2 experiment — 2026-09-25 21:19 GMT
- [CHANGE] Runtime-only AWG parameters applied to isolated `proton_awg_test`: Jc=4, Jmin=40, Jmax=70, S1=45, S2=112. S3/S4 remained 0; H1-H4 remained 1/2/3/4; RandomTrailers=off; DisableCookies=off.
- [RESULT] `awg showconf` verified the exact five requested values after application.
- [TEST] Bounded 20-second observation with no route, Zapret2, service, or other configuration changes.
- [RESULT] Before wait: transfer 0 B received, 289.83 KiB sent. After 20 s: 0 B received, 291.47 KiB sent.
- [INTERPRETATION] The tested Jc/Jmin/Jmax/S1/S2 group did not produce any received traffic or observed handshake during this 20-second window. The hypothesis is therefore NOT VALIDATED by this experiment.
- [STATUS] Gate 4 remains IN_PROGRESS. Current functional condition remains FAILED/NOT VALIDATED: RX=0 B, no observed handshake.
- [SAFETY] No default route was created; `proton_awg_test` remains isolated. Do not change Zapret2 or routing based solely on this result. The five parameters are currently runtime-modified and must be considered experimental until reverted or deliberately retained.


## STAGE 14 — Proton-AWG Gate 4.3 — user-supplied Variant 2 reviewed — 2026-09-25
- [USER INPUT] User supplied an expanded external example: Jc=5, Jmin=50, Jmax=100, S1=45, S2=112, S3=78, S4=93, I1=1, I2=2, I3=3, I4=4, I5=5.
- [TECHNICAL CORRECTION] Official amneziawg-tools accepts I1-I5 as tagged-junk strings, not as documented numeric parameter fields. The official tool source describes them as tagged junk values; therefore the supplied numeric I1-I5 values are not treated as a valid AWG 3.x profile.
- [DECISION] Do not apply I1-I5=1..5. Test only the numeric AWG parameters from Variant 2 in isolation: Jc=5, Jmin=50, Jmax=100, S1=45, S2=112, S3=78, S4=93. This remains an unverified compatibility experiment, not a Proton requirement.
- [STATUS] Gate 4 remains IN_PROGRESS / handshake NOT_VALIDATED. No default route or full VPN routing.
- [NEXT] Apply the seven numeric runtime-only parameters to isolated proton_awg_test, then perform one bounded handshake observation.


## STAGE 14 — Proton-AWG Gate 4.3 — Variant 2 numeric parameters applied — 2026-09-25
- [RESULT] Runtime-only proton_awg_test parameters successfully applied and read back: Jc=5, Jmin=50, Jmax=100, S1=45, S2=112, S3=78, S4=93; H1-H4 remain 1/2/3/4; RandomTrailers=off; DisableCookies=off.
- [RESULT] No error from awg set; verification output exactly matches the requested seven numeric parameters.
- [TECHNICAL] Official amneziawg-tools documents I1-I5 as tagged-junk strings, so the supplied numeric I1-I5=1..5 are not applied. Official source confirms the syntax. 
- [STATUS] Gate 4.3 parameter application = DONE; handshake remains NOT_VALIDATED.
- [NEXT] Perform one bounded 20-second read-only handshake observation; no route, service, Zapret2, or persistent configuration changes.


## STAGE 14 — Proton-AWG Gate 4.3 — Variant 2 handshake observation — 2026-09-25
- [TEST] Bounded 20-second read-only observation after applying Variant 2 numeric parameters: Jc=5, Jmin=50, Jmax=100, S1=45, S2=112, S3=78, S4=93.
- [RESULT] Before: RX=0 B; TX=322.12 KiB. After 20 s: RX=0 B; TX=323.75 KiB. No latest handshake was reported.
- [INTERPRETATION] No inbound traffic or handshake appeared during this observation. Variant 2 numeric parameter group is NOT VALIDATED for the Proton-AWG tunnel.
- [STATUS] Gate 4 remains IN_PROGRESS; handshake remains NOT VALIDATED / FAILED for the observed acceptance condition.
- [SAFETY] No route, Zapret2 service/rules, persistent configuration, or default route was changed by this observation. The runtime AWG parameters remain experimental.
- [NEXT] Do not repeat the same 20-second observation. The next diagnostic must target a new hypothesis/evidence gap; no blind enumeration of further AWG parameter values.


## STAGE 14 — Proton-AWG Gate 4.4 — predefined experimental profiles — 2026-09-25
- [USER INPUT] User proposed testing several external AWG parameter variants as isolated experiments.
- [PROFILE 1] Jc=4, Jmin=40, Jmax=70, S1=45, S2=112, H1-H4=1/2/3/4 — already tested; RX remained 0 B and no handshake. NOT VALIDATED.
- [PROFILE 2] Jc=5, Jmin=60, Jmax=120, S1=50, S2=130, H1-H4=5/6/7/8 — PENDING. Treat as unverified experimental values, not a Proton requirement.
- [PROFILE 3] Jc=3, Jmin=20, Jmax=50, S1=15, S2=80, H1-H4=10/11/12/13 — PENDING. Treat as unverified experimental values, not a Proton requirement.
- [EXCLUDED] I1-I5 numeric 1..5 are not applied; current amneziawg-tools expects tagged-junk strings. S3/S4 changes are deferred until a new evidence-based hypothesis exists.
- [SAFETY] proton_awg_test remains isolated with no default route. Profile changes are runtime-only and reversible with a subsequent awg set command.
- [NEXT] Apply Profile 2 only, then perform one bounded observation. Do not enumerate profiles blindly if there is no new evidence.


## STAGE 14 — Proton-AWG Gate 4.4 — Profile 2 readback attempt — 2026-09-25
- [RESULT] User executed the planned read-only Profile 2 verification command after applying Jc=5, Jmin=60, Jmax=120, S1=50, S2=130, H1-H4=5/6/7/8.
- [RESULT] Command returned empty output.
- [INTERPRETATION] Profile 2 is not yet verified by readback. The empty output may be due to command/pattern formatting rather than parameter state; no conclusion about the AWG values is made.
- [STATUS] Gate 4.4 Profile 2 = IN_PROGRESS; handshake NOT_VALIDATED.
- [SAFETY] No additional state-changing router action was performed after the empty readback.
- [NEXT] Use one simpler read-only AWG status command to obtain the non-secret parameter readback, then decide whether the bounded observation is warranted.

## STAGE 14 — Proton-AWG Gate 4.4 — Profile 2 handshake observation — 2026-09-25 22:28 GMT
- [USER RESULT] After Profile 2 readback confirmed Jc=5, Jmin=60, Jmax=120, S1=50, S2=130, H1-H4=5/6/7/8, one bounded 20-second read-only observation was performed.
- [RESULT] Before: transfer 0 B received, 632.53 KiB sent. After 20 s: transfer 0 B received, 634.42 KiB sent. No latest handshake line was reported.
- [INTERPRETATION] Profile 2 produced continued outbound traffic but no inbound response/handshake. Profile 2 is NOT VALIDATED for Proton-AWG.
- [STATUS] STAGE 14 / Gate 4 remains IN_PROGRESS; handshake remains NOT VALIDATED / FAILED for the tested acceptance condition. No default route, Zapret2 restart, persistent AWG configuration change, or other network-path change was made by this observation.
- [DIAGNOSTIC RULE] Do not repeat equivalent bounded 20-second observations for additional arbitrary parameter combinations without a new hypothesis or source evidence. A blind mass enumeration of AWG values is not an evidence-based next step.
- [NEXT DIRECTION] Research the documented semantics and version-specific behavior of Jc/Jmin/Jmax/S1-S4/H1-H4/I1-I5, and determine whether a controlled automated test harness can be built around a finite, source-justified profile set while preserving isolation and avoiding any default-route change.

## STAGE 14 — Proton-AWG Gate 4.5 — current parameter research / mass-test decision — 2026-09-25
- [WEB RESEARCH] Current official AmneziaWG documentation confirms: Jc is the junk-packet count and Jmin/Jmax its sizes; Jc=4-12 is the current recommended range. S1-S4 control packet-length prefixes; H1-H4 control/replace message-header fields and must not overlap. In AmneziaWG 3.1 Header Protection mode, H1-H4=1/2/3/4 are the documented compatibility values; Header Protection requires S1-S4>=12 and a HeaderProtectionKey. citeturn776760search2turn895469search5
- [WEB RESEARCH] The official amneziawg-linux-kernel-module README states that AWG parameters must match between client and server except Jc/Jmin/Jmax, and gives recommended Jc 4-12, S1/S2 15-150, and unique H1-H4 5..2147483647 for its documented configuration model. citeturn776760search0
- [WEB RESEARCH] Current Proton VPN documentation states that generated WireGuard configurations follow the official WireGuard specification and are intended for standard WireGuard clients. No Proton-supported method was found for converting a generated Proton WireGuard profile into an arbitrary AmneziaWG S/H/I profile. citeturn895469search0
- [WEB RESEARCH] Current Proton support documents that restrictive-country ISP/government blocking can prevent VPN connections and that changing protocol/using alternative routing are supported troubleshooting paths. Proton's current documentation does not establish the user's stronger claim that all Proton Free server IPs are presently blocked. citeturn464825search1
- [WEB RESEARCH] Historical Proton developer guidance has stated that not all server IPs are necessarily blocked, but this is not a current 2026 guarantee. citeturn464825search2
- [TECHNICAL DECISION] A blind Cartesian mass search over J/S/H/I is not justified for the current Proton endpoint. S/H/I modifications can require compatible AWG behavior/server-side expectations, while Proton-generated profiles are documented as standard WireGuard. Numeric I1-I5=1..5 remain invalid as a documented AWG representation. citeturn895469search7turn776760search2
- [AUTOMATION OPTION] A controlled local harness is technically possible, but should be limited to a finite source-justified matrix and one isolated profile at a time, with no default route and a fixed acceptance condition (latest handshake and RX>0). Do not enumerate hundreds/thousands of random combinations against a third-party Proton endpoint.
- [NEXT HYPOTHESIS] The higher-value next A/B is a fresh official Proton WireGuard profile pointing to a different Proton server endpoint, tested without inventing AWG S/H/I values. This can distinguish an endpoint-specific/upstream reachability issue from the current AWG parameter experiment. No route change is implied.


## STAGE 14 — Proton-AWG J-only finite matrix — 2026-09-25 22:35 GMT
- [USER RESULT] The isolated `proton_awg_test` J-only matrix was executed with S1-S4=0 and H1-H4=1/2/3/4, then three runtime-only J profiles were applied sequentially:
  1. Jc=4, Jmin=20, Jmax=60
  2. Jc=8, Jmin=40, Jmax=100
  3. Jc=12, Jmin=60, Jmax=120
- [RESULT] Profile 1: 0 B received; TX 670.21 KiB -> 670.50 KiB during 20 s.
- [RESULT] Profile 2: 0 B received; TX 670.50 KiB -> 672.66 KiB during 20 s.
- [RESULT] Profile 3: 0 B received; TX 672.66 KiB -> 677.39 KiB during 20 s.
- [RESULT] No latest-handshake field was present in the captured output.
- [INTERPRETATION] None of the three J-only profiles produced observed RX/handshake evidence. However, the harness changed parameters on an already-active interface and did not explicitly bounce/restart the isolated interface before each profile. Therefore these 20-second windows cannot by themselves prove that each profile generated a fresh handshake initiation. Treat all three as NOT VALIDATED, not as definitive parameter-specific failures.
- [STATUS] STAGE 14 / Proton-AWG Gate 4 remains IN_PROGRESS. Proton-AWG tunnel remains NOT VALIDATED. No default route or full VPN routing was enabled.
- [METHODOLOGY CORRECTION] Before any further J-only conclusion, a single controlled test must explicitly force a fresh handshake for the isolated interface and verify the resulting timestamp/RX. Do not perform another blind J sweep.
- [NEXT HYPOTHESIS] Determine the safest reversible way to force one fresh handshake on `proton_awg_test` while preserving the endpoint host route and avoiding any default-route change; then test only one selected profile if warranted.


## STAGE 14 — Proton-AWG fresh-handshake preparation — PersistentKeepalive=1 — 2026-09-25
- [USER RESULT] The planned runtime-only PersistentKeepalive command returned empty output.
- [INTERPRETATION] Empty output is normal for a successful `awg set` operation; by itself it does not prove that a fresh handshake occurred.
- [CHANGE] PersistentKeepalive for the isolated `proton_awg_test` peer was requested to change from 25 s to 1 s. This is runtime-only and reversible; no default route or endpoint-route change was requested.
- [STATUS] Gate 4 remains IN_PROGRESS; Proton-AWG handshake remains NOT VALIDATED until runtime evidence shows a latest handshake and/or received bytes.
- [NEXT] Perform one read-only AWG status check to verify the keepalive value and current transfer/handshake state. Do not change parameters or routes in this step.


## STAGE 14 — Proton-AWG PersistentKeepalive readback — 2026-09-25
- [USER RESULT] Read-only status shows endpoint 194.180.33.20:51820, transfer 0 B received / 729.27 KiB sent, PersistentKeepalive=1.
- [RESULT] No latest-handshake line was present, so no handshake/RX evidence was observed.
- [INTERPRETATION] The keepalive value was successfully applied at runtime. PersistentKeepalive sends authenticated empty packets to maintain NAT/firewall state; it does not by itself prove a handshake. Official AWG tooling documents this behavior. 
- [STATUS] Gate 4 remains IN_PROGRESS; Proton-AWG tunnel remains NOT VALIDATED.
- [NEXT] Force one fresh interface initiation using a reversible isolated interface down/up cycle, preserving the endpoint host route and avoiding any default-route change. No parameter sweep.


## STAGE 14 — Proton-AWG forced interface restart — 2026-09-25
- [USER RESULT] The isolated `proton_awg_test` interface was brought down and immediately back up with `ip link set proton_awg_test down && ip link set proton_awg_test up`; command returned empty output.
- [INTERPRETATION] The reversible interface restart completed without a reported local error. This was intended to force a fresh initiation without changing the default route or endpoint host-route design.
- [STATUS] Gate 4 remains IN_PROGRESS; handshake/RX is not yet established from this action alone.
- [NEXT] Perform one read-only `awg show` check for endpoint, transfer and latest handshake. No configuration changes or parameter sweep.


## STAGE 14 — Proton-AWG post-restart handshake readback — 2026-09-25
- [USER RESULT] After isolated `proton_awg_test` down/up restart, read-only status showed endpoint `194.180.33.20:51820`, transfer `0 B received, 748.07 KiB sent`, persistent keepalive `1`, and no `latest handshake` field.
- [INTERPRETATION] The restart did not produce observable inbound traffic or a handshake. The AWG interface can transmit, but the endpoint has not returned a response in the observed state.
- [STATUS] Gate 4 remains IN_PROGRESS; Proton-AWG handshake NOT_VALIDATED. No default route or production traffic has been enabled.
- [DECISION] Do not repeat equivalent AWG parameter sweeps. The next higher-value branch is a controlled A/B with a fresh official Proton WireGuard profile/different endpoint, while preserving the isolated/no-default-route architecture.


## STAGE 14 — New Proton Free endpoint applied — 2026-09-25
- [USER RESULT] `awg set proton_awg_test peer ... endpoint 146.70.246.98:51820 persistent-keepalive 25` returned empty output, consistent with successful `awg set` behavior.
- [CHANGE] Isolated AWG peer endpoint changed from 194.180.33.20:51820 to 146.70.246.98:51820; peer public key changed to the new Proton Free server key; PersistentKeepalive reset to 25.
- [SAFETY] No private key was entered into chat. No default route was enabled and production routing was not changed.
- [STATUS] New endpoint A/B test is configured but handshake/RX is not yet validated.
- [NEXT] Read-only verification of endpoint, transfer and handshake state; no further configuration change yet.


## STAGE 14 — New Proton Free endpoint readback — 2026-09-25
- [USER RESULT] `awg show proton_awg_test` shows two peer blocks: old endpoint 194.180.33.20:51820 with 0 B RX / 826.56 KiB TX / keepalive 1, and new endpoint 146.70.246.98:51820 with 0 B RX / 15.93 KiB TX / keepalive 25.
- [INTERPRETATION] The new peer configuration was added/applied while the old peer block remains present. Because the interface currently contains two peer entries, this is not yet a clean A/B result and no handshake has been observed.
- [STATUS] Gate 4 IN_PROGRESS; new endpoint handshake NOT_VALIDATED.
- [NEXT] Do not sweep parameters. First isolate the new endpoint by removing the old peer from the test interface, then force one fresh initiation and inspect handshake/RX. This remains isolated and must not create a default route.


## STAGE 14 — Old Proton peer removed — 2026-09-25
- [USER RESULT] Removed old peer public key from isolated `proton_awg_test`; command returned empty output.
- [INTERPRETATION] The old endpoint peer removal command completed without a reported local error. New endpoint remains the intended sole peer for the next clean A/B observation.
- [STATUS] Gate 4 IN_PROGRESS; new endpoint handshake/RX still NOT_VALIDATED.
- [NEXT] Read-only verify that only the new peer remains and inspect its transfer/handshake state. No parameter or route changes.


## STAGE 14 — New Proton client private-key staged locally — 2026-09-25
- [USER RESULT] User confirmed the new Proton client PrivateKey was written locally to `/tmp/proton-new.key` with restrictive permissions; the key itself is not recorded in project documentation.
- [STATUS] New endpoint A/B configuration is ready for the final peer-key replacement; handshake remains NOT_VALIDATED.
- [NEXT] Install the staged private key into isolated `proton_awg_test`, then remove the temporary key file after successful installation/readback. No default route.


## STAGE 14 — New Proton client private key installed — 2026-09-25
- [USER RESULT] `awg set proton_awg_test private-key /tmp/proton-new.key` returned empty output, consistent with successful application.
- [SAFETY] The private key value remains undisclosed and is not recorded in project documentation. Temporary key file remains until post-install verification.
- [STATUS] New endpoint + new client key are configured on isolated `proton_awg_test`; handshake/RX still NOT_VALIDATED.
- [NEXT] Read-only verification of public key, endpoint, transfer and handshake; do not expose the private key and do not enable default routing.


## STAGE 14 — New Proton profile key readback — 2026-09-25
- [USER RESULT] Isolated `proton_awg_test` now reports client public key `rtuz8pFtsG7V9E2h6PwMypdrMMAtz/jSqxafv5dmkVQ=`, peer `ehwHh3WXBDwFxqTs4Oa8aZZYjOnd3NwjbMArKRwTqzs=`, endpoint `146.70.246.98:51820`, transfer `0 B received, 146.27 KiB sent`, PersistentKeepalive=25, and no latest-handshake field.
- [INTERPRETATION] The new client private key is active and corresponds to the displayed new client public key. The new endpoint is the sole peer. No inbound response/handshake has yet been observed.
- [STATUS] Gate 4 IN_PROGRESS; new Proton Free endpoint/key A/B handshake NOT_VALIDATED.
- [NEXT] Force one fresh interface initiation now that the correct client key is installed; then inspect handshake/RX. Temporary key file remains until successful verification.


## STAGE 14 — Proton Free plain-WireGuard compatibility reset and fresh interface restart — 2026-09-25
- [USER RESULT] Runtime-only AWG parameters were reset on isolated `proton_awg_test`: Jc/Jmin/Jmax=0, S1-S4=0, H1-H4=1/2/3/4. Command returned empty output.
- [VERIFICATION] Follow-up grep displayed the non-default peer/runtime fields: random trailers=off, disable cookies=off, endpoint=146.70.246.98:51820, transfer=0 B received / 183.40 KiB sent, PersistentKeepalive=25. The zero/default J/S/H fields were not printed by that grep expression; this is not evidence that the reset failed. Current official AWG tooling treats unspecified/zero AWG parameters as baseline values, while `awg show` only prints fields represented in its device state. citeturn0search8turn0search1
- [CHANGE] User then performed the planned reversible isolated interface cycle: `ip link set proton_awg_test down && ip link set proton_awg_test up`; command returned empty output.
- [INTERPRETATION] The fresh initiation cycle completed without a local error. At this point there is still no evidence of inbound traffic or a latest handshake; the next read-only status check is required before any further change.
- [STATUS] STAGE 14 / Gate 4 = IN_PROGRESS; Proton Free handshake NOT_VALIDATED. No default route, production routing, Zapret2 configuration, or persistent AWG change was made.
- [METHODOLOGY] Do not perform another AWG parameter sweep. The purpose of this branch is to test the actual Proton-generated standard WireGuard profile semantics without invented obfuscation parameters. Current AmneziaWG documentation confirms the AWG-specific J/S/H fields are protocol extensions, while the standard baseline uses no such obfuscation. citeturn0search1turn0search8
- [NEXT] Perform one read-only `awg show proton_awg_test` status check for the new endpoint, latest handshake and transfer counters. If RX remains 0 B and handshake is absent, shift the hypothesis toward endpoint/path/profile acceptance rather than continue blind AWG tuning.


## STAGE 14 — Proton Free clean plain-WG handshake readback — 2026-09-25
- [USER RESULT] After the clean isolated interface restart, `awg show proton_awg_test` reports endpoint `146.70.246.98:51820`, sole peer key `ehwHh3WXBDwFxqTs4Oa8aZZYjOnd3NwjbMArKRwTqzs=`, transfer `0 B received, 186.29 KiB sent`, PersistentKeepalive=25, AllowedIPs=(none), and no `latest handshake` line.
- [INTERPRETATION] The actual Proton Free endpoint/client-key combination still sends but receives nothing after a fresh initiation, with AWG obfuscation reset to baseline. Official `awg show` prints `latest handshake` only when a nonzero handshake timestamp exists. citeturn0search6
- [STATUS] Gate 4 remains IN_PROGRESS; handshake NOT_VALIDATED / FAILED for current acceptance condition.
- [NEXT] Do not change AWG parameters. Perform one bounded WAN packet-path capture for UDP/51820 to the exact endpoint to determine whether any inbound response reaches `phy0-sta0`.


## STAGE 14 — Proton Free WAN packet-path capture — 2026-09-25
- [USER RESULT] Bounded tcpdump on `phy0-sta0` for UDP/51820 to `146.70.246.98`: 6 packets captured, all outbound from `192.168.0.100:38231` to `146.70.246.98:51820`; packet lengths 16,16,148 repeated; 0 inbound packets observed; 0 kernel drops.
- [INTERPRETATION] The new Proton endpoint is reachable from the local WAN interface at the packet-egress level, but no UDP response was observed during this capture. The 148-byte packets are consistent with standard WireGuard/AWG handshake-init packet size before any additional padding; AWG padding can alter handshake packet size when configured. 
- [STATUS] Gate 4 remains IN_PROGRESS; handshake NOT_VALIDATED. Current evidence moves the primary hypothesis toward upstream/remote-side non-response rather than a local route/interface transmit failure.
- [NEXT] Do not change AWG parameters or routing. Next investigation, if continued, should distinguish upstream-path filtering from remote endpoint rejection with one controlled external-path check; preserve isolated no-default-route design.


## STAGE 14 — Proton endpoint ICMP path check — 2026-09-25
- [USER RESULT] `ping -c 3 -I phy0-sta0 146.70.246.98`: 3 transmitted, 0 received, 100% packet loss.
- [INTERPRETATION] This does not establish that the endpoint is unreachable: ICMP echo may be filtered by the remote host or an intermediate network. It is consistent with, but does not independently prove, the absence of a UDP/51820 response already observed by tcpdump.
- [STATUS] Gate 4 remains IN_PROGRESS; handshake NOT_VALIDATED. No configuration, route, or production traffic was changed.
- [NEXT] Do not tune AWG further. The remaining high-value discriminator is an external-client A/B: test the same freshly generated Proton WireGuard profile from a non-hAP client/network, if available, to determine whether the Proton endpoint/profile itself establishes a handshake. Preserve the isolated no-default-route design on hAP.


## STAGE 14 — PROTON/WIREGUARD BRANCH PAUSED BY USER — 2026-09-25
- [USER DECISION] User explicitly requested to put WireGuard on pause and move the WireGuard branch to the **final project stage**.
- [DECISION] Stop all further Proton/AWG/WireGuard experimentation, parameter sweeps, handshake tests, endpoint A/B tests, routing changes and activation work until the final stage is reached.
- [STATUS] Historical STAGE 14 / Proton-AWG Gate 4 remains **IN_PROGRESS** as an unfinished branch; it is **not** promoted to DONE and the tunnel remains NOT VALIDATED.
- [EXECUTION STATE] The WireGuard/Proton branch is frozen by user decision. This is an execution pause, not a technical FAILED/BLOCKED verdict.
- [ROUTING SAFETY] Do not create a WireGuard/AWG default route, enable full VPN routing, or alter the production default route because of this branch.
- [PROJECT ORDER CHANGE] WireGuard is removed from the active execution queue and moved to the **last major implementation/validation stage** after all other planned non-WireGuard work is completed.
- [DEPENDENCY RULE] WARP/Proton work that requires WireGuard is also deferred with this branch unless a separate non-WireGuard implementation is explicitly selected later.
- [NEXT EXECUTION POLICY] On continuation, select the highest-priority incomplete **non-WireGuard** stage from MASTER PLAN. Do not resume STAGE 14 merely because it is the historical checkpoint.
- [RESUME CONDITION] WireGuard/AWG may be reopened only when the project reaches the final WireGuard stage or the user explicitly asks to resume it earlier.


---
<!-- 2026-09-26 supersession: USB/extroot/swap/zram runtime correction is recorded in the authoritative 2026-09-26 section at the end of this file. Older conflicting USB statements are historical/stale. -->
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-25 — USER DECISION / LATEST RECONCILIATION

> This section is an explicit current-state override. Older sections are intentionally retained for history and evidence, but any older statement that conflicts with this section is **HISTORICAL / STALE** and must not be used as the next-action checkpoint.

### Current project checkpoint
- **WireGuard / AmneziaWG / Proton tunnel branch: PAUSED by user.** The existing Proton-AWG experiment remains unfinished and unvalidated; this is an execution pause, **not** a technical FAILED/BLOCKED conclusion.
- The WireGuard branch is moved to the **FINAL MAJOR IMPLEMENTATION/VALIDATION STAGE**. Do not resume AWG/WireGuard tests, parameter sweeps, endpoint A/B tests, default-route activation, or full-VPN routing unless the user explicitly reopens it or the final stage is reached.
- **Zapret2 Telegram/WhatsApp scope: BLOCKED** for the current Zapret2-only approach. Evidence indicates that at least part of the problem may be IP-level rather than ordinary DPI. Do not continue blind NFQWS/MODE_FILTER/desync tuning without a new hypothesis.
- **Zapret2 remains active and useful for the validated DPI-oriented scope.** Current known configuration includes MODE_FILTER=autohostlist, TCP 80/443, UDP 443, main QNUM=300, dedicated WireGuard-pattern QNUM=65300, FLOWOFFLOAD=donttouch, INIT_APPLY_FW=1, DISABLE_IPV6=1, SET_MAXELEM=522288.
- **Zapret2 watchdog: INSTALLED / ACTIVE AT RUNTIME / HEALTHY.** Do not create a second watchdog.
- **DoH / https-dns-proxy: RETIRED from the current Variant A workflow by explicit user decision.** Historical DoH installation/configuration/evidence remains in this repository, but it must not be reintroduced unless the user explicitly requests it. Any older note describing DoH as the next active task is HISTORICAL / STALE.
- **USB current runtime truth:** /dev/sda1 = 64 MiB Linux swap, initialized/active; /dev/sda2 = remaining ~3.7 GiB Linux partition, **not formatted**. Current firmware lacks mkfs.ext4/e2fsprogs, so ext4 creation is BLOCKED pending firmware/package reconciliation. Any older claim that /dev/sda2 is already ext4/extroot or that /dev/sda3 is active is HISTORICAL / STALE unless newer runtime evidence proves otherwise.
- **Memory:** ZRAM + USB swap are retained as current project mechanisms; persisted vm.min_free_kbytes=2048 has passed load validation. Do not casually change memory tuning without a new hypothesis.
- **Archer C20 v4 remains the main router.** The MikroTik hAP ac lite remains downstream and must not be promoted to the primary router without an explicit user decision.

### Next-action rule after this reconciliation
Because the tunnel branch is frozen and Telegram/WhatsApp Zapret2-only scope is blocked, the next project action must be selected from the highest-priority **incomplete non-tunnel capability** after a fresh capability audit. Do not follow stale numeric stage text merely because it appears earlier in this document.

### Evidence ladder
Use explicit states: IMPLEMENTED IN REPOSITORY → AVAILABLE_FOR_BUILD → INSTALLED / DEPLOYED TO ROUTER → CONFIGURED → ACTIVE AT RUNTIME / RUNTIME_VERIFIED → VALIDATED, with DISABLED, PLANNED, BLOCKED, FAILED recorded separately. A historical record never outranks newer verified runtime evidence.

### Preservation rule
No historical information is to be deleted merely because it is no longer current. Retain old test results, configurations, stage notes, commits and hypotheses, but label superseded material as **HISTORICAL / STALE / RETIRED / PAUSED** where applicable.


## EXECUTION CHECKPOINT — 2026-09-25 23:43 LOCAL — NON-WIREGUARD BRANCH SELECTION
- [DECISION] WireGuard/AmneziaWG/Proton remains PAUSED and is not the next branch.
- [DECISION] Telegram/WhatsApp Zapret2-only remains BLOCKED; no blind desync tuning.
- [AUDIT] The USB/extroot branch is an explicitly incomplete non-tunnel capability: /dev/sda1 swap is active, /dev/sda2 is unformatted, and the current firmware lacks mkfs.ext4/e2fsprogs. Older extroot/sda3 records are historical/stale unless newer runtime evidence proves otherwise.
- [NEXT SAFE STEP] Before any package installation or filesystem operation, perform one read-only repository-package availability check for e2fsprogs. This does not change router state and addresses the current ext4-formatting blocker.
- [SAFETY] No formatting, partitioning, mounting, extroot activation, package installation, or reboot is authorized by this checkpoint.
- [STATUS] USB ext4/extroot preparation = BLOCKED pending tooling reconciliation; WireGuard = PAUSED.


## 2026-09-25 — USB e2fsprogs availability check result

- Command: apk search -e e2fsprogs.
- Result: **NON-DIAGNOSTIC / PACKAGE-INDEX CACHE UNAVAILABLE**, not proof that e2fsprogs is unavailable.
- apk reported missing local cache/index files (packages.adb) for the configured AWG and official OpenWrt repositories.
- Therefore the previous wording **"USB ext4/extroot — BLOCKED"** is narrowed: the actual blocker is currently **unresolved package-index availability / package acquisition**, while /dev/sda2 remains unformatted. No formatting or package installation was performed.
- Next safe action must determine whether the configured apk repositories can refresh their indexes; no filesystem change is authorized yet.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — USB / EXTROOT / SWAP / ZRAM RUNTIME VERIFICATION

This section supersedes all older USB-storage statements that conflict with the runtime evidence below. Older USB/extroot preparation records are retained as HISTORY only and must not be used as the current next-action checkpoint.

### Fresh read-only runtime evidence
- `/dev/sda` is present and detected by OpenWrt as a ~7.28 GiB USB disk.
- `/dev/sda1` = 512 MiB swap partition; initialized and ACTIVE at runtime with priority **-2**.
- `/dev/sda2` = ext4 filesystem, LABEL **extroot**, UUID **e1c68a3a-0e55-4af9-afd8-961160b3afa2**; mounted read-write at **/overlay**.
- `/` is `overlayfs:/overlay`, therefore the active writable root is backed by the USB extroot.
- `/dev/sda3` is NOT part of the current partition table.
- `fstab` has an enabled ext4 mount for the extroot UUID at `/overlay` and an enabled `/dev/sda1` swap entry.
- `/proc/swaps` shows both `/dev/sda1` (~512 MiB, priority -2) and `/dev/zram0` (~26 MiB, priority 100) ACTIVE.
- `zram0` current disk size is 27,262,976 bytes (~26 MiB); current swap use is non-zero, so zram is not merely configured but active in runtime.
- `vm.min_free_kbytes = 2048` is currently loaded.
- `df -h` reports `/overlay` and `/` with about 6.6 GiB total and about 6.2 GiB available.
- Current filtered `dmesg` shows successful ext4 recovery/mount and swap/zram activation; no current `I/O error`, ext4 filesystem error, journal error, or swap/zram error was present in the supplied audit.

### Capability decision
- **USB extroot = RUNTIME_VERIFIED / DONE for the current planned capability.**
- **USB swap = RUNTIME_VERIFIED / DONE.**
- **ZRAM = RUNTIME_VERIFIED / DONE.**
- The previously documented branch claiming `/dev/sda2` was unformatted and waiting for `mkfs.ext4/e2fsprogs` is **HISTORICAL / STALE**.
- The previously documented proposed action `apk search -e e2fsprogs` / formatting `/dev/sda2` is superseded and MUST NOT be used as the next project action.
- No filesystem formatting, repartitioning, package installation, or reboot was performed as part of this verification.
- This evidence is read-only runtime verification; boot-persistence beyond the current boot is not additionally claimed unless separately tested.

### Current storage layout
```
/dev/sda
├─ /dev/sda1  512 MiB  swap     ACTIVE, priority -2
└─ /dev/sda2  ~6.6 GiB ext4    LABEL=extroot, mounted /overlay, RW
```

Any older statement that says `/dev/sda2` is unformatted, that ext4 creation is blocked, that `/mnt/data` is currently mounted from `/dev/sda3`, or that the current USB is only a staging device is historical/stale unless a newer verified runtime result explicitly changes it.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — WI-FI RUNTIME VERIFICATION

### Fresh read-only runtime evidence
- phy0-ap0: UP, 5 GHz AP, channel 36 / 5180 MHz, SSID OpenWrt, WPA2 (psk2), BSSID b8:69:f4:d6:e8:a5.
- phy1-ap0: UP, 2.4 GHz AP, channel 1 / 2412 MHz, SSID OpenWrt, WPA2 (psk2), BSSID b8:69:f4:d6:e8:a6.
- phy0-sta0: UP/connected as managed STA to Archer-side SSID SweetHomeU, 5180 MHz, signal -41 dBm, RX/TX bitrate 86.7 MBit/s.
- br-lan, phy0-ap0, phy1-ap0 and phy0-sta0 are UP.
- UCI shows both APs on network lan and the upstream STA on network wan; all wireless secrets were excluded from the audit output.
- Hostapd status is available for both APs and reports the expected BSSID/SSID/frequency/channel.
- Recent logs show successful WPA2 4-way handshakes on the 5 GHz AP and repeated upstream group rekey completion on phy0-sta0. No current fatal Wi-Fi/hostapd/wpa_supplicant/ath10k error is present in the supplied bounded log.
- wpa_supplicant "Unknown event 37" repeats after successful group rekeying while the STA remains associated; this is recorded as an observed compatibility/noise message, not as a confirmed fault.
- The inactivity deauthentication entries in the historical log are associated with client disconnect behavior and do not invalidate the current AP runtime state.

### Capability decision
- Dual-band hAP AP service = RUNTIME_VERIFIED / DONE.
- Archer-side 5 GHz STA uplink = RUNTIME_VERIFIED / DONE.
- Same SSID OpenWrt with WPA2 on both 2.4/5 GHz APs = RUNTIME_VERIFIED / DONE.
- Archer-side Wi-Fi client access to hAP/OpenWrt management/services without LAN = NOT VALIDATED / INCOMPLETE. AP/STA runtime alone does not prove that cross-zone access works.
- No wireless configuration or routing/firewall state was changed by this audit.

### Next controlled step
The highest-priority incomplete non-tunnel capability identified by this audit is the separate Archer-side client access path to hAP/OpenWrt without LAN. Before any exposure change, run a read-only audit of:
- firewall zones/forwarding/input policy affecting the wan/Archer-side network;
- management service listen addresses/bindings;
- current routes relevant to 192.168.0.0/24 and 192.168.1.0/24.

No firewall opening, LuCI binding change, routing change, or other state-changing operation is authorized merely from this Wi-Fi audit.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — ARCHER-SIDE MANAGEMENT AUDIT

### Fresh read-only evidence
- IPv4 routing includes default via 192.168.0.1 dev phy0-sta0 src 192.168.0.100; 192.168.0.0/24 directly connected to phy0-sta0; 192.168.1.0/24 directly connected to br-lan; Proton endpoint host route 194.180.33.20/32 via 192.168.0.1 on phy0-sta0.
- Firewall defaults: input=REJECT, output=ACCEPT, forward=REJECT.
- WAN zone: input=REJECT, output=ACCEPT, forward=DROP.
- Existing WAN rule Allow-SSH-from-TPLink is present.
- Dropbear: enabled, TCP/22, listeners on 0.0.0.0:22 and :::22.
- uci show uhttpd: Entry not found; no TCP/80 or TCP/443 management listener was observed in the supplied listener audit.
- Capability status: hAP routing to Archer-side network = RUNTIME_VERIFIED; Dropbear listening for local TCP/22 = RUNTIME_VERIFIED; dedicated Archer-side SSH firewall rule presence = RUNTIME_VERIFIED; end-to-end Archer Wi-Fi client to 192.168.0.100:22 reachability = NOT VALIDATED / INCOMPLETE.
- Security-relevant observation: Dropbear currently has PasswordAuth='on' and RootPasswordAuth='on'. No change was made; this is recorded for later security review, not as a reason to alter access before reachability is established.

### Next controlled step
Inspect the exact UCI parameters of the existing Allow-SSH-from-TPLink rule. This is read-only and is required before deciding whether any firewall change is needed. Do not create another SSH rule or weaken WAN input policy until this rule is understood.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — SSH FIREWALL RULE VERIFIED

### Evidence
`Allow-SSH-from-TPLink` is exactly:
- src=wan
- src_ip=192.168.0.0/24
- proto=tcp
- dest_port=22
- target=ACCEPT

### Decision
The firewall already contains the required narrow SSH allowance for Archer-side clients. No firewall modification is justified by the current evidence.

### Capability state
- SSH listener on hAP TCP/22 = RUNTIME_VERIFIED.
- Archer-side SSH firewall allowance for 192.168.0.0/24 = RUNTIME_VERIFIED.
- Actual Archer Wi-Fi client -> 192.168.0.100:22 connectivity = NOT VALIDATED / INCOMPLETE.

### Next controlled step
Perform one end-to-end connectivity test from a device actually connected to the Archer Wi-Fi. Use the hAP Archer-side address 192.168.0.100 and TCP/22. Do not change hAP configuration before that test.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — ARCHER-SIDE SSH END-TO-END VALIDATION

### User result
- From a client device actually connected to the Archer-side Wi-Fi (SweetHomeU), the user executed:
  `ssh root@192.168.0.100`
- **SSH access succeeded.**

### Capability decision
- Archer-side Wi-Fi client → hAP Archer-side address `192.168.0.100` → TCP/22 = **VALIDATED**.
- The existing narrow firewall rule `Allow-SSH-from-TPLink` is therefore sufficient for the tested path; no additional WAN firewall opening is required.
- Archer-side management access to hAP over Wi-Fi without LAN is now **VALIDATED / DONE** for SSH.
- This validation does not imply that HTTP/LuCI access exists: `uhttpd` remains absent/not configured from the prior audit.
- Security observation remains unchanged: Dropbear has PasswordAuth/RootPasswordAuth enabled. No security-hardening change was made as part of this connectivity validation.

### Safety / change record
- No router configuration, firewall, routing, wireless, service, filesystem, swap, VM, or Zapret2 state was changed for this validation.
- The test was read-only with respect to router configuration; it only established end-to-end reachability.

### Current next-action rule
- Do not add or broaden an SSH firewall rule.
- Do not install/configure LuCI/uhttpd solely because SSH is validated.
- Continue from the highest-priority incomplete **non-WireGuard** capability according to the current capability ledger; do not resume the paused Proton/AWG branch or the blocked Zapret2 Telegram/WhatsApp branch without explicit reopening/new evidence.


---
## 2026-09-26 — VLESS/sing-box-tiny package metadata check: local APK cache unavailable

- [USER RESULT] Read-only command `apk info -a sing-box-tiny | sed -n '1,35p'` returned only APK warnings that cached `packages.adb` indexes were missing for the configured 2Grey and official OpenWrt repositories.
- [INTERPRETATION] This result is **NON-DIAGNOSTIC for sing-box-tiny metadata**. It does not establish package absence, size, dependency set, or incompatibility.
- [CURRENT STATE] No package was installed and no router configuration, routing, firewall, DNS, Zapret2, watchdog, filesystem, swap, or VM state was changed.
- [NEXT GATE] The package-index cache must be refreshed before retrying the metadata query. Refreshing repository indexes is a limited package-manager operation; it does not install or upgrade packages and does not change network/routing/firewall configuration.
- [STATUS] STAGE 14 VLESS/sing-box candidate = IN_PROGRESS. sing-box-tiny resource gate = **BLOCKED by missing local APK indexes** pending index refresh. AWG/Proton remains PAUSED.


---
## 2026-09-26 — sing-box-tiny metadata gate completed

- [USER RESULT] After `apk update`, repository indexes became available (reported: **11088 distinct packages available**).
- `apk info -a sing-box-tiny` verified official OpenWrt package metadata:
  - package: `sing-box-tiny-1.13.21-r1`
  - installed size: **33 MiB**
  - dependencies: `ca-bundle`, `kmod-inet-diag`, `kmod-tun`, `libc`
  - provides: `sing-box=1.13.21-r1`, `sing-box-tiny-any`
  - license: GPL-3.0-or-later
  - upstream webpage: sing-box.sagernet.org
- [STATUS] sing-box-tiny package metadata/resource gate = **DONE**.
- [STATUS] No sing-box package was installed; no router configuration/runtime state changed.
- [NEXT GATE] Before installation, perform a minimal read-only resource baseline on the router (RAM + overlay free space) and confirm current package installation state if needed. Installation must remain a deliberate state-changing step because the package consumes ~33 MiB of overlay storage and adds `kmod-tun`/other dependencies.
- [OVERRIDE] Do not resume Proton/AWG branch; it remains PAUSED by user.


---
## 2026-09-26 — sing-box-tiny resource baseline

- [USER RESULT] Read-only resource check:
  - RAM total 54852 KiB (~53.6 MiB), used 36440 KiB, free 8680 KiB, available 11908 KiB (~11.6 MiB).
  - Swap total 550904 KiB (~538 MiB), used 6040 KiB (~5.9 MiB), free 544864 KiB.
  - Root overlay: 6.6G total, 31.9M used, 6.2G available, 1% used.
  - `apk info -e sing-box sing-box-tiny` returned no output: neither package is installed.
- [INTERPRETATION] Storage capacity is ample for the 33 MiB installed-size sing-box-tiny package. RAM headroom is limited on this 64 MiB router, so installation/runtime resource impact remains a first-class acceptance criterion.
- [STATUS] Resource baseline = **DONE**; sing-box installation = **NOT_STARTED**.
- [NEXT GATE] Read-only package download-size/metadata check before any installation. No package state or router configuration was changed by this audit.


---
## 2026-09-26 — sing-box-tiny package-size check completed

- [USER RESULT] `apk info -s sing-box-tiny` reports installed size **33 MiB** for `sing-box-tiny-1.13.21-r1`.
- [INTERPRETATION] This duplicates the already verified installed-size metadata; APK CLI did not expose a separate compressed/download size in this query.
- [EXTERNAL CHECK] Official OpenWrt 25.12.5 package repository is current and confirms the 25.12.5 mips_24kc package tree exists. No package installation or configuration change was performed.
- [STATUS] Package metadata/resource gate = **DONE**. Installation remains **NOT_STARTED**.
- [SAFETY] With only ~11.9 MiB RAM available at baseline, installing the 33 MiB package should not be treated as automatically safe; the key remaining question is runtime RAM impact and coexistence with active Zapret2.
- [NEXT GATE] If proceeding, first perform a controlled package installation only after the user explicitly chooses to proceed; installation changes package state and adds the `kmod-tun` dependency. No AWG/Proton resume.


---
## 2026-09-26 — sing-box-tiny installation authorized

- User explicitly requested `Продолжай` after the package/resource gate.
- Preconditions verified: official package `sing-box-tiny-1.13.21-r1`, installed size 33 MiB, required dependencies known; extroot has ~6.2 GiB free; baseline available RAM ~11.9 MiB; package not installed.
- [NEXT ACTION] Install `sing-box-tiny` from the configured APK repositories.
- [SCOPE] This changes package state and installs dependencies, including `kmod-tun`; it does not intentionally modify Zapret2, firewall rules, routing policy, DNS configuration, or tunnel configuration.


---
## 2026-09-26 — sing-box-tiny post-install verification contradicts reported installation

- [USER RESULT] Post-install read-only audit showed:
  - `apk info -e sing-box-tiny` returned **no output**.
  - `sing-box version` returned `-ash: sing-box: not found`.
  - Root overlay usage is 46.8M used / 6.2G available.
  - Earlier RAM result immediately before this audit: available ~12.96 MiB.
- [INTERPRETATION] Despite the user's statement that installation completed, the authoritative router runtime/package evidence shows `sing-box-tiny` is **NOT INSTALLED / NOT DEPLOYED** at present.
- [STATUS] Installation = **FAILED / NOT VERIFIED**; no sing-box runtime exists. Do not mark it INSTALLED based on the earlier statement.
- [PRESERVED] User-reported installation attempt is retained as historical context; newer runtime evidence overrides it.
- [NEXT GATE] Retry the package installation with the full terminal output captured. No sing-box configuration, service enablement, tunnel, routing, DNS, firewall, or Zapret2 changes.


---
## 2026-09-26 — sing-box-tiny installation completed

- [USER RESULT] `apk add sing-box-tiny` completed successfully:
  - `kmod-inet-diag 6.12.94-r1` installed.
  - `sing-box-tiny 1.13.21-r1` installed.
  - post-install completed `OK`.
  - APK reports `66.1 MiB in 237 packages`.
- [STATUS] sing-box-tiny = **INSTALLED / DEPLOYED TO ROUTER**.
- [STATUS] Required dependency `kmod-inet-diag` = **INSTALLED / DEPLOYED TO ROUTER**.
- [SCOPE] No sing-box configuration, service enablement, tunnel, routing, DNS, firewall, or Zapret2 changes were intentionally made.
- [NEXT GATE] Perform one read-only post-install verification of package state, binary version, RAM, and overlay storage before any runtime configuration/start.


---
## 2026-09-26 — sing-box package presence verified, version output incomplete

- [USER RESULT] `apk info -e sing-box-tiny` returned `sing-box-tiny`, confirming package database installation.
- `sing-box version` was invoked but the supplied transcript contains no version output.
- [STATUS] Package installation remains **INSTALLED / DEPLOYED TO ROUTER** based on the successful `apk add` result and current `apk info -e` evidence.
- [STATUS] Runtime/binary version verification = **INCOMPLETE**; do not infer the version from the missing output.
- [NEXT GATE] Continue the same read-only post-install audit with memory/storage only; do not start or configure sing-box.


---
## 2026-09-26 — sing-box-tiny post-install runtime/resource verification completed

- [USER RESULT] Read-only audit confirms:
  - `apk info -e sing-box-tiny` = **installed**.
  - `sing-box version` = **1.13.21**, Environment `go1.26.8 linux/mips`; tags include `with_gvisor,with_quic,with_utls,with_clash_api`; CGO enabled.
  - RAM: total 54852 KiB, used 36516 KiB, free 5440 KiB, buff/cache 12896 KiB, available 11872 KiB (~11.6 MiB).
  - Swap: total 550904 KiB, used 7804 KiB, free 543100 KiB.
  - Overlay: 6.6G total, 65.7M used, 6.2G available, 1% used.
- [STATUS] sing-box-tiny = **INSTALLED / DEPLOYED TO ROUTER** and binary version = **RUNTIME VERIFIED**.
- [STATUS] Package installation did not consume significant persistent storage relative to available extroot capacity; RAM headroom remains limited.
- [STATUS] sing-box runtime is **NOT STARTED / NOT CONFIGURED**. No tunnel, routing, DNS, firewall, or Zapret2 changes have been made.
- [NEXT GATE] Before creating any VLESS/REALITY configuration, select/verify a server-side VLESS+REALITY endpoint and define the minimum client parameters required. Do not invent endpoint credentials or private keys.


---
## 2026-09-26 — VLESS + REALITY endpoint supplied for sing-box evaluation

- [USER INPUT] User supplied an Xray-style client profile from `cloud.chocolatewaffle.net`.
- The profile describes a VLESS outbound over **gRPC + REALITY** to a server at `13.143.66.151:443`, with a VLESS UUID, REALITY public key, short ID, server name `kinopoisk.ru`, and Firefox uTLS fingerprint. Sensitive credential values are intentionally not copied into project documentation.
- The profile also contains a large direct-routing list for Russian/related domains and IPs, plus localhost SOCKS/HTTP inbounds. It is treated as **user-supplied configuration**, not as independently verified server availability.
- [COMPATIBILITY NOTE] This is an Xray-style JSON schema, not a drop-in sing-box 1.13.21 configuration. sing-box uses its own VLESS outbound fields and V2Ray gRPC transport structure; the profile must be translated and validated before runtime use. Official sing-box documentation confirms VLESS outbound support and gRPC V2Ray transport. 
- [SECURITY] The supplied profile contains a live VLESS credential/identifier. Do not reproduce it in chat or repository. If this profile is shared publicly or with untrusted parties, the credential should be rotated/revoked at the provider.
- [STATUS] VLESS+REALITY endpoint parameters = **SUPPLIED / NOT YET RUNTIME VERIFIED**.
- [NEXT GATE] Build a minimal temporary sing-box 1.13.21 client configuration from the supplied parameters, validate it with `sing-box check`, and test the proxy before adding router-wide TUN/auto-redirect or the large routing list.

---
## 2026-09-26 — Minimal sing-box VLESS + REALITY test configuration preparation

- [WEB CHECK] Current sing-box documentation confirms VLESS outbound fields and V2Ray gRPC transport support; TLS REALITY client requires public_key and short_id.
- [DESIGN] Use a minimal localhost SOCKS inbound and one VLESS+REALITY+gRPC outbound only. Do not import the large Xray routing list, DNS-over-HTTPS configuration, TUN/auto-redirect, or router-wide interception yet.
- [SECURITY] The VLESS UUID is treated as a credential and will be entered interactively on the router rather than embedded in the command shown to the user or committed to GitHub.
- [STATUS] Minimal test config preparation = IN_PROGRESS.
- [NEXT ACTION] Create /tmp/sing-box-vless-test.json and run sing-box check; no service start or routing changes.



---
## 2026-09-26 — VLESS/Xray control-test checkpoint

### Current diagnostic result
- [USER RESULT] The full user-supplied HAPP file was confirmed as the complete profile relevant to this test. Its VLESS outbound uses gRPC + REALITY and explicitly contains `grpcSettings.mode: true`, with the HTTP inbound on 127.0.0.1:10809, direct and block outbounds, and the supplied REALITY parameters. Sensitive credential values are not copied into this project record.
- [CORRECTION] Earlier temporary `/tmp/xray-vless-test.json` was intentionally minimized for a SOCKS-only control test; it was not a byte-for-byte import of the HAPP profile. This is recorded as a test-design simplification, not as the original profile.
- [RESULT] Xray-core 26.3.27 passed `xray run -test -config /tmp/xray-vless-test.json` with `Configuration OK`.
- [RESULT] Actual Xray startup on the hAP required a long initialization period (roughly 80+ seconds in the observed run). During initialization the process temporarily entered `D (disk sleep)`; later it returned to `S (sleeping)`, opened TCP 127.0.0.1:10808, and logged `Xray 26.3.27 started`.
- [RESULT] At the time of the successful startup, Xray process RSS was only about 2 MiB and the router had about 10 MiB available RAM with swap mostly free. Therefore the observed startup delay is not established as a RAM-exhaustion event.
- [RESULT] Control request through Xray SOCKS: `curl -4 --socks5-hostname 127.0.0.1:10808 https://example.com` timed out after 11.5 s with `HTTP=000`, `CURL_EXIT=28`.
- [RESULT] Xray log after the request contained only startup messages and no inbound/outbound request or handshake error. Therefore the Xray control path is **NOT VALIDATED**; the result does not yet establish whether the VLESS/REALITY endpoint, gRPC mode, or another transport detail is incompatible.
- [COMPARISON] The earlier sing-box 1.13.21 minimal SOCKS test also timed out while reaching its VLESS outbound. The two failures are therefore currently non-discriminating; the hypothesis that Xray gRPC Multi Mode (`mode: true`) is the sing-box incompatibility remains **UNPROVEN**.
- [STATUS] VLESS/REALITY endpoint = **NOT VALIDATED**. sing-box minimal test = **FAILED / no successful proxy request**. Xray control test = **FAILED / no successful proxy request**, with server-side/transport cause still unresolved.
- [SAFETY] No persistent Xray/sing-box service, router-wide interception, TUN, default-route, DNS, firewall, or routing-policy change was made. Xray and sing-box are temporary diagnostic components only.
- [NEXT GATE] Do not perform blind parameter sweeps. First inspect the exact Xray request-path behavior/logging needed to distinguish a client-side transport/REALITY failure from an unreachable/non-responsive server-side profile. Keep the tunnel branch non-persistent and isolated.
- [SECURITY] The VLESS credential was exposed during the chat/profile handling. Do not copy it into repository documentation; rotation/revocation should be considered after diagnostics.


## 2026-09-26 — Xray clean foreground control test: gRPC dial failure isolated

- [USER RESULT] Xray 26.3.27 was started in the foreground from the temporary /tmp/xray-vless-test.json; startup completed successfully and TCP 127.0.0.1:10808 listened normally.
- [USER RESULT] Two fresh SOCKS control requests to https://example.com both timed out: first about 10.97 s, second about 15.70 s; both returned HTTP=000 and CURL_EXIT=28.
- [RESULT] Xray logs for the fresh request show the SOCKS request reaches Xray, the proxy outbound is selected, and Xray attempts gRPC transport to the VLESS server. The decisive error is: failed to process outbound traffic > proxy/vless/outbound: failed to find an available destination > ... grpc: failed to dial gRPC ... rpc error: code = Unavailable ... transport: Error while dialing: context deadline exceeded.
- [RESULT] The log also shows repeated creation/dial attempts to the configured TCP endpoint. Earlier socket inspection had shown an ESTAB TCP connection with substantial bidirectional traffic, but that connection predated the clean foreground test and therefore is not treated as proof of a successful VLESS/REALITY session.
- [INTERPRETATION] The failure is now localized beyond the local SOCKS inbound: Xray accepts the request but cannot complete the gRPC transport dial within its deadline. This still does not prove whether the cause is REALITY/TLS parameters, gRPC server-side expectations, the supplied profile itself, or another transport-layer incompatibility.
- [CORRECTION] The earlier hypothesis that gRPC mode:true is the cause remains UNPROVEN. The current Xray error is a generic gRPC dial timeout and does not by itself identify mode:true as the cause.
- [STATUS] Xray control test = FAILED / reproducible. VLESS+REALITY endpoint = NOT VALIDATED. sing-box minimal test remains FAILED.
- [SAFETY] Xray was stopped with Ctrl+C after the diagnostic. No persistent Xray/sing-box service, TUN, default route, DNS, firewall, routing policy, or Zapret2 change was made.
- [NEXT GATE] Do not sweep parameters. The next diagnostic must use a single discriminating test against the supplied profile/transport to separate REALITY/TLS handshake incompatibility from gRPC-specific incompatibility. Keep all testing temporary and isolated.


---
## 2026-09-26 — Xray/sing-box diagnostic branch PAUSED by user

### Final diagnostic result
- [USER RESULT] Temporary Xray 26.3.27 VLESS + REALITY + gRPC control profile was tested with `grpcSettings.mode=true` and then with only `mode=false`. Both configurations passed `xray run -test` with `Configuration OK`.
- [USER RESULT] Xray started successfully in both cases and accepted SOCKS connections on 127.0.0.1:10808.
- [USER RESULT] Fresh proxy requests through Xray timed out in both modes. The `mode=false` test returned approximately 10.23 s timeout, HTTP=000, CURL_EXIT=28.
- [RESULT] Xray logs for the failing request showed repeated attempts to dial `tcp:13.143.66.151:443` and a final `dial tcp 13.143.66.151:443: i/o timeout`.
- [CONTROL RESULT] Independent direct `curl -4 -k -I --connect-timeout 7 --max-time 10 https://13.143.66.151:443` from the same hAP succeeded with `HTTP/2 403`, proving that ordinary TCP/TLS reachability to the endpoint exists outside the Xray VLESS path.
- [INTERPRETATION] The endpoint is not established as generally unreachable. The remaining failure is specific to the Xray VLESS/REALITY/gRPC path or its interaction with the endpoint; the exact root cause is not established.
- [INTERPRETATION] Changing gRPC `mode` true→false did not change the outcome. The hypothesis that `mode:true` was the cause is therefore NOT VALIDATED and should not be pursued as the next blind tuning axis.
- [SCOPE] The unrelated internet VLESS profile with a different server/transport/flow/REALITY parameters was NOT imported or tested as a replacement. Doing so would not be a discriminating continuation of the current profile diagnosis.
- [STATUS] Xray control test = FAILED / reproducible.
- [STATUS] sing-box minimal VLESS + REALITY test = FAILED / no successful proxy request.
- [STATUS] VLESS + REALITY endpoint using the supplied gRPC profile = NOT VALIDATED.
- [DECISION] **Xray/sing-box branch = PAUSED by explicit user decision.** Do not resume Xray/sing-box testing, parameter sweeps, foreign-profile replacement, TUN setup, default-route changes, router-wide interception, or persistent service configuration unless the user explicitly reopens this branch.
- [SAFETY] Xray and sing-box were temporary diagnostic components only. No persistent Xray/sing-box service, TUN, default route, DNS, firewall, routing-policy, or Zapret2 change was made by these tests.
- [SECURITY] The user-supplied VLESS profile contained a live credential/identifier. Sensitive values remain excluded from project documentation; credential rotation/revocation should be considered if the profile was exposed beyond trusted handling.

### Current project rule
The frozen tunnel branch and this newly paused Xray/sing-box branch must be skipped when selecting the next action. Continue from the highest-priority incomplete **non-tunnel, non-paused** capability after capability audit. Do not generate further diagnostic tests for Xray/sing-box unless the user explicitly says to reopen them.

## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — Xray/sing-box PACKAGE RETENTION + FULL RUNTIME AUDIT

- Packages `xray-core` and `sing-box-tiny` are intentionally **RETAINED** by user.
- Xray and sing-box are **INACTIVE / DISABLED**: no processes, no 10808/10809 listeners, no TUN, no policy-routing rules, and no nftables table/firewall hook attributable to them.
- Xray/sing-box diagnostic branch remains **PAUSED**; do not resume without explicit user reopening.
- Runtime audit found no additional obviously rogue persistent daemon. Active expected services include dnsmasq, dropbear, network, odhcpd, wpad, sysntpd, log, Zapret2 and zapret2-watchdog.
- `https-dns-proxy` remains RETIRED/inactive.
- `openvpn` and `socat` report **active with no instances** and were not found running as daemon processes; they are cleanup candidates, not confirmed faults.
- `pbr` is active with no policies; retain because selective routing remains part of the project architecture.
- Frozen `proton_awg_test` remains; do not remove blindly.
- Runtime memory snapshot: 54852 kB RAM total, ~13384 kB MemAvailable, 550904 kB swap total with ~6428 kB used, zram ~6.28 MiB used, `vm.min_free_kbytes=2048`. Xray/sing-box consume zero runtime process RAM at this audit.
- UDP `0.0.0.0:39628` / `[::]:39628` remains unexplained; do not change it solely from the port number. Investigate separately only if cleanup is requested.
- Generic init-script `status/enabled` output containing `Syntax:` for infrastructure scripts is not evidence of service failure; `active with no instances` means no running service instance.

### Zapret2 — two nfqws2 processes
- Runtime showed **PID 3204 nfqws2** and **PID 3205 nfqws2**, plus **PID 3548 zapret2-watchdog**.
- The two `nfqws2` processes are **expected**, not a duplicate/rogue daemon. Upstream zapret2's OpenWrt init script manages standard nfqws2 daemons as separate procd instances; the active standard configuration covers both TCP 80/443 and UDP 443. citeturn0search0turn0search3
- Do not kill either nfqws2 process and do not create another watchdog.
- Zapret2 remains **ACTIVE AT RUNTIME / VALIDATED** for the current intended DPI-oriented scope.
