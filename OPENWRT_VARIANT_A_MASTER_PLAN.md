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

## CHANGELOG — 2026-09-21 — post-reboot audit step 17
[RESULT] User supplied read-only output of `/etc/init.d/dnsmasq status`.
[CONFIRMED] dnsmasq service status is `running` after the power-loss reboot.
[NO CHANGE] The command was read-only; no service, DNS configuration, network, firewall, or filesystem state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Await user instruction before issuing the next router command.

## CHANGELOG — 2026-09-21 — post-reboot audit step 18
[RESULT] User supplied read-only output of `/etc/init.d/network status`.
[CONFIRMED] The `network` init script did not return a runtime state; instead it printed its generic command syntax and available commands.
[IMPORTANT] Therefore `network` running state is NOT CONFIRMED by this command. The command was non-destructive, but it was not an effective runtime-status check for this service on the current system.
[NO CHANGE] No service, network, firewall, DNS, or filesystem state was changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Use the service's dedicated read-only `running` query: `/etc/init.d/network running`.
