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
[STATUS] STAGE 11 — IN_PROGRESS.
[NEXT] On the Windows PC, perform one read-only PowerShell check of OS architecture/version. After its result, choose the exact official bundle preparation path.
