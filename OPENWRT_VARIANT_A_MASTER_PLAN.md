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

## CHANGELOG — 2026-09-21 — post-reboot audit step 21
[RESULT] User supplied grouped read-only `/etc/init.d/<service> running` checks for firewall, wpad, zram, dropbear, odhcpd, cron, sysntpd, fstab, packet_steering, pbr.
[CONFIRMED] Empty output was returned for firewall, wpad, dropbear, odhcpd, cron, sysntpd, packet_steering, and pbr; this grouped `running` query therefore does not provide positive runtime-state confirmation for those services on this system.
[CONFIRMED] The `zram` init script does not implement the `running` command and returned its command syntax instead.
[CONFIRMED] The `fstab` init script does not implement the `running` command and returned its command syntax instead.
[IMPORTANT] No service state was changed. The result shows that this init-script `running` method is not a reliable universal runtime test on this OpenWrt build.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Use a single consolidated read-only process/service-state inspection that does not depend on init-script `running` support, while avoiding large log pipelines.
