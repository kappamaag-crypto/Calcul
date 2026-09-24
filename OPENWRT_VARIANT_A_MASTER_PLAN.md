## STAGE 11A — Process/socket/PSI memory pressure check — 2026-09-24
- [RESULT] BusyBox/procps `ps -w` is available, but its displayed columns are PID/USER/VSZ/STAT/COMMAND; this invocation does not provide RSS, so it does not identify the largest resident-memory process.
- [RESULT] `/proc/net/sockstat`: sockets used=103; TCP inuse=7, orphan=0, TIME_WAIT=0, alloc=13, mem=0; UDP inuse=8, mem=0; RAW inuse=1; FRAG inuse=0, memory=0.
- [INTERPRETATION] Current socket accounting shows no reported socket memory pressure; network socket buffers are not established as the source of the OOM events.
- [RESULT] `/proc/pressure/memory` is unavailable; PSI cannot be used on this build to quantify memory stalls.
- [SOURCE CONTEXT] Linux documents `/proc/PID/status` and its VmRSS/RssAnon/RssFile/RssShmem fields as process memory information, while `/proc/net/sockstat` exposes network memory state. The absence of PSI here is a build/interface limitation.
- [STATUS] STAGE 11A remains IN_PROGRESS; next localization step should read per-process VmRSS directly from `/proc/*/status` without heavy sorting/enumeration.
- [SAFETY] No configuration, service, routing, firewall, Wi-Fi, swap, VM, or Zapret2 state changed.
