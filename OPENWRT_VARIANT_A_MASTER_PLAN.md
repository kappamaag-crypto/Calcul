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

## CHANGELOG — 2026-09-21 — post-reboot audit step 20
[RESULT] User supplied read-only output of `ubus call network.interface dump`.
[CONFIRMED] `lan` is up=true, available=true, autostart=true, device/l3_device `br-lan`, IPv4 192.168.1.1/24.
[CONFIRMED] `loopback` is up=true, available=true, autostart=true, device `lo`, IPv4 127.0.0.1/8.
[CONFIRMED] `wan` is up=true, available=true, autostart=true, device/l3_device `phy0-sta0`, DHCP, IPv4 192.168.0.55/24, default route via 192.168.0.1, DHCP server 192.168.0.1, lease 7200 seconds.
[CONFIRMED] `wan6` is up=false, pending=false, available=true, autostart=true, DHCPv6 on `eth1`; no IPv6 address/route was assigned.
[IMPORTANT] This directly confirms that the network interfaces are operational after reboot even though `/etc/init.d/network running` returned empty output.
[NO CHANGE] The command was read-only; no network, service, DNS, firewall, or filesystem state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Continue with grouped read-only service checks to accelerate the audit; no configuration changes or service restarts.
