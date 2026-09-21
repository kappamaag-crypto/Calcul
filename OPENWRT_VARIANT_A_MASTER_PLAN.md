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
STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation)
STAGE 12–30 — NOT_STARTED

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

## CHANGELOG — 2026-09-21 — official zapret2 Windows workflow clarified
[WEB VERIFICATION] Official bol-van/zapret2 source contains blockcheck2.sh and supports CYGWIN: under CYGWIN the script selects WINWS2/winws2 and Windivert. Official zapret2 documentation states that blockcheck requires Cygwin on Windows and cannot be run through WSL. The author's zapret-win-bundle is an official convenience distribution containing Cygwin, blockcheck/blockcheck2 and winws2.exe.
[IMPORTANT CORRECTION] The technical source/project remains official bol-van/zapret2. zapret-win-bundle is only the Windows distribution used to run the official tooling conveniently; it does not replace the router-side zapret2 source.
[WORKFLOW] Windows PC → official author bundle/environment → blockcheck2 → candidate strategy → compatibility review → router transfer only after separate validation.
[STATUS] STAGE 11 — IN_PROGRESS.

## CHANGELOG — 2026-09-21 — Windows blockcheck2 preparation started
[DECISION] Prepare the Windows PC before downloading/running blockcheck2. First verify Windows architecture/version because the official author's current bundle supports Windows x64/ARM64, and the exact preparation differs by architecture.
[SAFETY] No router command or configuration change is required for this preparation step. Do not install Cygwin separately if the official bundle will be used; the bundle already includes a minimal Cygwin environment.
[CURRENT ROUTER STATE] nfqws2 remains active on the MikroTik. Google works; YouTube/Telegram/WhatsApp remain non-working. No router strategy change has been made.
[RESULT] Windows read-only PowerShell check returned: Microsoft Windows 11 Pro, version 10.0.26200, OSArchitecture 64-разрядная. This establishes Windows x64 for the next preparation decision.
[STATUS] STAGE 11 — IN_PROGRESS.
[NEXT] Use the official bol-van/zapret-win-bundle Windows x64 path. No router changes are part of this synchronization step.


## CHANGELOG — 2026-09-21 — Zapret2 strategy-selection plan
[DECISION] Strategy selection will be performed on the Windows 11 x64 PC using the official `blockcheck2` tooling from the same `bol-van/zapret2` project. The router already has official Zapret2 v1.0.3 installed and running as `/opt/zapret2/nfq2/nfqws2`; no second Zapret project is being installed.
[PLAN]
1. Keep the router's current working configuration unchanged during strategy discovery.
2. On Windows, prepare the official `zapret-win-bundle` (minimal Cygwin + blockcheck2/winws2) for x64.
3. Select a small, representative domain set matching the currently failing services; begin with controlled individual tests, not parallel hammering.
4. Run blockcheck2 in batch mode with an explicit log, conservative timeouts, and `PARALLEL=0/1` only as appropriate; do not use parallel scanning by default.
5. First establish DNS/IP reachability results, then run the standard HTTP/HTTPS/QUIC strategy tests supported by the tool.
6. If comparing several domains, use `SCANLEVEL=force` when we need reliable COMMON/COVERAGE conclusions; otherwise treat skipped tests as non-exhaustive.
7. Record only strategies that produce reproducible PASS results, together with protocol, domain, IP version, and exact generated parameters.
8. Do not immediately copy the first successful strategy to the router. Review compatibility with the existing NFQWS2 config, hostlist/autohostlist behavior, memory budget, and current TCP/UDP scope first.
9. Transfer one validated strategy change to the already-installed router-side Zapret2, then test the affected service(s) and router resource usage before any additional change.
10. After each router-side strategy change, retain a rollback value and compare against the current known-good configuration.
[SAFETY] No curl installation on the router is required for the PC-based workflow. Do not run full blockcheck2 on the low-RAM router while its current nfqws2 configuration is active unless a separate decision gate authorizes it.
[STATUS] STAGE 11 — IN_PROGRESS (strategy discovery on PC).
[NEXT USER STEP] Prepare the Windows official bundle only; no router command in this turn.


## CHANGELOG — 2026-09-21 — Windows blockcheck2 launch procedure prepared
[VERIFIED] Official author documentation recommends the official `zapret-win-bundle`; it contains minimal Cygwin and `blockcheck\\blockcheck2.cmd`, which is the Windows Zapret2-based DPI strategy analyzer. Windows x64 is supported; WSL is not the required environment.
[LAUNCH PROCEDURE] On the Windows 11 x64 PC: download the official bundle master ZIP; extract it to a simple ASCII path such as `C:\\zapret-win-bundle`; ensure no other DPI-bypass/Zapret software is running on the PC; open the bundle's `_CMD_ADMIN.cmd` as administrator; launch `blockcheck\\blockcheck2.cmd`. Do not launch `preset*.cmd` or install a Windows service. The purpose is strategy discovery only.
[TEST POLICY] First run the interactive blockcheck2 flow and allow its DNS/reachability checks. Use the currently failing services as test domains. Do not enable aggressive parallel testing. Save the generated log and exact successful strategy parameters. If a multi-domain COMMON/COVERAGE comparison is required, rerun with `SCANLEVEL=force`.
[TRANSFER GATE] No router-side strategy is changed until a candidate result is recorded, reviewed against the existing v1.0.3 nfqws2 configuration, and then transferred as a single controlled change with rollback and resource checks.
[STATUS] STAGE 11 — IN_PROGRESS.


## CHANGELOG — 2026-09-21 — [SYNC] force scan stopped / faster re-scan decision
- [OBSERVED] Windows official `blockcheck2` remained for hours in the `youtube.com` IPv4 HTTPS TLS 1.2 force scan and produced multiple `AVAILABLE` candidates plus many `UNAVAILABLE code=28` results.
- [DECISION] Do not continue the current exhaustive force scan indefinitely. The user may stop it with Ctrl+C; this does not alter the router-side Zapret2 configuration.
- [NEXT] For the next Windows pass, use a shorter scan level rather than `force`. Prefer `standard` as the balanced official investigation mode; `quick` is reserved for the fastest first-working candidate and is less suitable for comparing multiple candidate strategies. Keep router-side Zapret2 v1.0.3 unchanged until cross-domain evidence is obtained.
- [SAFETY] Before the next actual scan, the Windows PC must bypass the MikroTik's active nfqws2 path and connect directly to the TP-Link Archer C20 v4, so the current router-side Zapret2 does not contaminate strategy discovery.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery).
