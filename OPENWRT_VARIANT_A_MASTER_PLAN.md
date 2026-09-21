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

## CHANGELOG — 2026-09-21 — post-reboot audit final consolidated check
[RESULT] User supplied the final consolidated read-only audit: `ps w`, `ubus call network.interface dump`, `swapon -s`, and `df -h`.
[CONFIRMED PROCESSES] procd, logd, dropbear, wpa_supplicant, hostapd, netifd, odhcpd, ntpd, udhcpc, dnsmasq, and two https-dns-proxy instances are running. Two https-dns-proxy instances are the configured Cloudflare listener on 5053 and Google listener on 5054.
[CONFIRMED NETWORK] lan is up on br-lan at 192.168.1.1/24; wan is up on phy0-sta0 at 192.168.0.55/24 with default route via 192.168.0.1; wan6 is down with no DHCPv6 address.
[CONFIRMED SWAP] /dev/sda1 524284 kB, used 0, priority -2; /dev/zram0 26620 kB, used 1748 kB, priority 100.
[CONFIRMED STORAGE] /dev/sda2 6.6G mounted at /overlay with 13.5M used and 6.2G available; overlay root is 6.6G with 0% reported use; /tmp is 26.8M with 276K used; no swap is in /tmp.
[IMPORTANT] This final consolidated check provides sufficient factual evidence for the post-reboot audit: core runtime processes, network interfaces, swap, extroot storage, and temporary filesystem are operational after the power-loss reboot.
[NOTED] Init-script `running` checks were not a reliable universal method on this build; the final process and ubus evidence is used instead.
[NO CHANGE] The final audit commands were read-only and made no service/configuration changes.
[STATUS] Post-reboot audit — DONE.
[NEXT] Zapret2/NFQWS2 must be separately re-validated after reboot. Do not change Zapret2 configuration during this audit record; next stage starts only after this audit is recorded.
