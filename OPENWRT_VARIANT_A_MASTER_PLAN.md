## STAGE 11A — Process/socket/PSI memory pressure check — 2026-09-24
- [RESULT] BusyBox/procps `ps -w` is available, but its displayed columns are PID/USER/VSZ/STAT/COMMAND; this invocation does not provide RSS, so it does not identify the largest resident-memory process.
- [RESULT] `/proc/net/sockstat`: sockets used=103; TCP inuse=7, orphan=0, TIME_WAIT=0, alloc=13, mem=0; UDP inuse=8, mem=0; RAW inuse=1; FRAG inuse=0, memory=0.
- [INTERPRETATION] Current socket accounting shows no reported socket memory pressure; network socket buffers are not established as the source of the OOM events.
- [RESULT] `/proc/pressure/memory` is unavailable; PSI cannot be used on this build to quantify memory stalls.
- [SOURCE CONTEXT] Linux documents `/proc/PID/status` and its VmRSS/RssAnon/RssFile/RssShmem fields as process memory information, while `/proc/net/sockstat` exposes network memory state. The absence of PSI here is a build/interface limitation.
- [STATUS] STAGE 11A remains IN_PROGRESS; next localization step should read per-process VmRSS directly from `/proc/*/status` without heavy sorting/enumeration.
- [SAFETY] No configuration, service, routing, firewall, Wi-Fi, swap, VM, or Zapret2 state changed.


## STAGE 11B — Memory/zone current snapshot — 2026-09-24
- [RESULT] Current snapshot: MemFree=15324 kB, MemAvailable=7216 kB, Buffers=1928 kB, Cached=5140 kB, AnonPages=3104 kB, KReclaimable=1400 kB, Slab=9212 kB, SReclaimable=1400 kB, SUnreclaim=7812 kB.
- [RESULT] Compared with the immediately preceding snapshot, MemAvailable increased from ~6160 kB to 7216 kB, while SUnreclaim remained 7812 kB; this does not show continued growth of unreclaimable slab in the sampled interval.
- [RESULT] Normal-zone snapshot: pages free=3802, min=2048, low=2560, high=3072, managed=13713. Free pages are currently above the high watermark.
- [INTERPRETATION] The router is currently outside the low/min watermark danger region, but the available-memory margin remains small on a 64 MB-class device. Current data does not establish a steadily growing kernel-memory leak.
- [SOURCE CONTEXT] Linux documents MemAvailable as an estimate of memory available for new applications and SUnreclaim as slab memory that cannot be reclaimed under memory pressure; zone watermarks are used by the VM when managing free pages.
- [STATUS] STAGE 11B = IN_PROGRESS; next step is a lightweight idle trend sample of MemAvailable and SUnreclaim to distinguish a stable fixed overhead from ongoing accumulation.
- [SAFETY] No configuration, service, routing, firewall, Wi-Fi, swap, VM, or Zapret2 state changed.
