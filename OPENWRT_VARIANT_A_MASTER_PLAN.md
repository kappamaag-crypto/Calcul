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
STAGE 11 — DONE
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

## CHANGELOG — 2026-09-21 — post-reboot audit step 4
[RESULT] Read-only command `/bin/df -h` completed successfully after power-loss reboot.
[CONFIRMED] `/dev/root` is 6.0M, 100% used, mounted read-only at `/rom`; this is the expected squashfs firmware layer and is not the writable root.
[CONFIRMED] `tmpfs` at `/tmp` is 26.8M total, 276K used, 26.5M available (1%).
[CONFIRMED] `/dev/sda2` is 6.6G, 13.5M used, 6.2G available, mounted at `/overlay`.
[CONFIRMED] `overlayfs:/overlay` is 6.6G, 13.5M used, 6.2G available, mounted at `/`.
[CONFIRMED] `/dev/sda2` remains the active USB-backed extroot after reboot.
[CONFIRMED] `/dev` tmpfs is 512K and empty.
[FACT] Storage capacity/usage is healthy; no space pressure is indicated by this result.
[NO CHANGE] The command was read-only; no filesystem, service, or configuration state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Continue the audit with one read-only inspection of enabled boot-time init scripts; do not start/stop/restart any service in the audit step.
