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


## CHANGELOG — 2026-09-21 — post-reboot audit step 5
[RESULT] Read-only command `ls -l /etc/rc.d/` completed successfully after power-loss reboot.
[CONFIRMED] Boot-time start links (S*) are present for core services including fstab, zram, dnsmasq, dropbear, firewall, wpad, network, odhcpd, cron, sysntpd and others.
[CONFIRMED] `S15zram` is enabled at boot; therefore ZRAM initialization is configured for automatic startup.
[IMPORTANT] `S20https-dns-proxy` is present, so the service has an enabled boot-time start link despite the earlier `/etc/init.d/https-dns-proxy enabled` command producing no output. This discrepancy must be resolved by a targeted read-only check before any service change.
[CONFIRMED] `S20pbr` is present, so PBR is configured for boot-time start. This does not mean active policies are enabled or that PBR is currently affecting traffic.
[CONFIRMED] `S20network`, `S19dnsmasq`, `S19firewall`, `S19wpad` and `S11fstab` have boot-time start links.
[NO CHANGE] The command was read-only; no service, configuration, network, or filesystem state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Perform one read-only targeted status check of the currently running key services, starting with `https-dns-proxy`, `pbr`, `dnsmasq`, `network`, `firewall`, `wpad`, and `zram`; do not start/stop/restart anything during the audit.


## CHANGELOG — 2026-09-21 — post-reboot audit step 6
[RESULT] User supplied output for the combined init-script status command. The terminal output shown is only `running`.
[IMPORTANT] The command line displayed by the terminal wraps `/etc/init.d/network status` across the visual line break, but the supplied result contains only one visible status line. Therefore the result cannot be safely attributed to all seven services individually.
[CONFIRMED] At least one of the queried init scripts returned `running`.
[NOT CONFIRMED] Individual runtime states of https-dns-proxy, pbr, dnsmasq, network, firewall, wpad, and zram are not established from this combined output; no assumption is made from missing output.
[NO CHANGE] The status command was read-only; no service was started, stopped, or restarted.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Use one targeted read-only command for the important discrepancy: inspect the actual https-dns-proxy boot link and process/service state separately, without changing it. This will resolve whether the enabled S20 link actually corresponds to an active service after reboot.


## CHANGELOG — 2026-09-21 — post-reboot audit step 7
[RESULT] User supplied the combined read-only init-script status command:
`/etc/init.d/https-dns-proxy status; /etc/init.d/pbr status; /etc/init.d/dnsmasq status; /etc/init.d/network status; /etc/init.d/firewall status; /etc/init.d/wpad status; /etc/init.d/zram status`.
[CONFIRMED] `pbr status` produced its environment/table report and showed no configured policies, no marking chains, no nft sets, and only the main IPv4 routing table/rules. Uplink is `wan/phy0-sta0/192.168.0.1`.
[CONFIRMED] `dnsmasq status` produced version/configuration information: dnsmasq 2.93, IPv6 enabled, DHCP/DHCPv6 disabled in this build.
[CONFIRMED] `zram status` completed successfully and reports zram0 size 26 MiB, lzo-rle compression, original data 1.53 MiB, compressed data 0.43 MiB, memory used 2.02 MiB, maximum ever used 2.92 MiB.
[CONFIRMED] Multiple init scripts returned `running`, and wpad returned `active with no instances`; however the combined command output does not preserve a reliable one-to-one mapping of each visible `running` line to each preceding command.
[IMPORTANT] This result still does not safely establish the individual runtime state of `https-dns-proxy`, `network`, `firewall`, or `zram` from the combined output alone. The earlier `S20https-dns-proxy` boot link discrepancy therefore remains unresolved.
[NO CHANGE] The command was read-only; no service was started, stopped, or restarted.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Run one targeted read-only command for `https-dns-proxy` status only; do not change the service.

## CHANGELOG — 2026-09-21 — post-reboot audit step 8
[RESULT] Read-only command `/etc/init.d/https-dns-proxy status` returned `running`.
[CONFIRMED] `https-dns-proxy` is running after the power-loss reboot.
[CONFIRMED] This resolves the earlier runtime-state ambiguity for this service: the `S20https-dns-proxy` boot link corresponds to an active service after reboot.
[IMPORTANT] This does not by itself prove whether one or multiple https-dns-proxy instances/processes are running, nor whether the service is needed for the current DNS architecture.
[NO CHANGE] The command was read-only; no service was started, stopped, restarted, or reconfigured.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Inspect the https-dns-proxy process count/PIDs with one read-only process listing; do not stop or restart the service yet.

## CHANGELOG — 2026-09-21 — post-reboot audit step 9
[RESULT] Read-only command `pgrep -a https-dns-proxy` returned two processes: PID 3227 and PID 3228, both `/usr/sbin/https-dns-proxy`.
[CONFIRMED] Two `https-dns-proxy` processes are currently running after reboot.
[IMPORTANT] This matches the earlier OOM evidence where two https-dns-proxy processes were present. It confirms the duplicate-process condition exists again, but does not by itself prove that these processes caused the OOM; prior records already distinguish correlation from causation.
[IMPORTANT] Current DNS architecture was previously configured to use TP-Link 192.168.0.1 directly, with dnsmasq `noresolv=1` and `server=192.168.0.1`; therefore the necessity of these two processes remains unestablished and should be evaluated after the audit, not assumed.
[NO CHANGE] The command was read-only; no service was started, stopped, restarted, or reconfigured.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Inspect the service process command lines/configuration relationship with one read-only command to determine how the two processes were launched; do not stop or restart the service yet.