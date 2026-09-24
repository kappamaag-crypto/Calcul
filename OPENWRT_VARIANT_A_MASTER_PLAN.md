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
