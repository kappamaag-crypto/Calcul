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

## CHANGELOG — 2026-09-21 — post-reboot audit step 10
[RESULT] Read-only command `ps w | grep '[h]ttps-dns-proxy'` showed two distinct configured instances:
- PID 3227, user `nobody`: `/usr/sbin/https-dns-proxy -r https://cloudflare-dns.com/dns-query -p 5053 -b 1.1.1.1,1.0.0.1,2606:4700:47`
- PID 3228, user `nobody`: `/usr/sbin/https-dns-proxy -r https://dns.google/dns-query -p 5054 -b 8.8.8.8,8.8.4.4,2001:4860:4860::8888`
[CONFIRMED] The two processes are intentional separate DoH endpoints/configurations, not duplicate identical command lines: Cloudflare DoH listens on local port 5053 and Google DoH listens on local port 5054.
[IMPORTANT] This explains why two processes are present, but does not establish that either is currently used by dnsmasq or required by the current DNS architecture.
[IMPORTANT] Earlier OOM evidence remains relevant: two processes consume memory simultaneously, and a prior OOM snapshot showed two https-dns-proxy processes. This is a confirmed memory-footprint condition, not proof of sole causation.
[NO CHANGE] The command was read-only; no service was started, stopped, restarted, or reconfigured.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Verify the effective dnsmasq DNS forwarding configuration with one read-only UCI query before deciding whether the running DoH instances are actually in the active DNS path.

## CHANGELOG — 2026-09-21 — post-reboot audit step 11
[USER INPUT] User proposed that `https-dns-proxy` may be auto-started through Procd/hotplug and suggested disabling it via UCI plus `/etc/init.d/https-dns-proxy stop/disable`, with `cat /etc/config/https-dns-proxy` as a diagnostic.
[IMPORTANT] During the current post-reboot audit, no service/configuration changes are to be performed yet. Therefore the proposed stop/disable/UCI commands are not executed at this stage.
[FACTUAL CORRECTION] The presence of an `S20https-dns-proxy` rc.d start link and the observed `running` status already establish an enabled boot-time init-script path; Procd is involved in OpenWrt service supervision, but the exact package configuration schema must be inspected before assuming that `uci set https-dns-proxy.config.enabled='0'` is valid.
[CONFIRMED] Two separate https-dns-proxy processes are currently running: Cloudflare DoH on local port 5053 and Google DoH on local port 5054.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Inspect `/etc/config/https-dns-proxy` read-only to determine the package's actual UCI configuration and how those two instances are defined.

## CHANGELOG — 2026-09-21 — post-reboot audit step 12
[RESULT] User supplied two read-only configuration outputs.
[CONFIRMED] Effective dnsmasq configuration has `noresolv='1'` and explicitly lists local DoH endpoints `127.0.0.1#5053` and `127.0.0.1#5054`. It also contains canary exclusions and a configured backup DNS `192.168.0.1` through `doh_backup_server`.
[CONFIRMED] dnsmasq also has `doh_server='127.0.0.1#5053' '127.0.0.1#5054'`.
[CONFIRMED] `/etc/config/https-dns-proxy` contains main section `config main 'config'` with `dnsmasq_config_update '*'`, `force_dns='1'`, LAN force-DNS ports 53/853, `notrack_dns='1'`, and listen address 127.0.0.1.
[CONFIRMED] Two explicit `https-dns-proxy` instance sections exist: Cloudflare DoH on port 5053 with bootstrap DNS 1.1.1.1/1.0.0.1 plus IPv6; Google DoH on port 5054 with bootstrap DNS 8.8.8.8/8.8.4.4 plus IPv6.
[CONCLUSION] The two running processes are intentionally defined by the package configuration and are actively referenced by dnsmasq. Therefore the earlier assumption that https-dns-proxy was unused is no longer correct for the current configuration.
[IMPORTANT] This configuration also explains why the service automatically returns after reboot: it is configured and enabled, and its instances are integrated with dnsmasq/force-DNS behavior. Whether to disable it remains a deliberate architecture decision because doing so requires restoring the intended direct-upstream DNS path first.
[NO CHANGE] The commands were read-only; no service or configuration state was changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Before changing DNS or stopping the proxy, perform one read-only inspection of the https-dns-proxy init script's enable/config handling to determine the supported disable mechanism; do not modify anything yet.

## CHANGELOG — 2026-09-21 — post-reboot audit step 13
[RESULT] Read-only inspection of `/etc/init.d/https-dns-proxy` (lines 1–240) completed.
[CONFIRMED] The package init script uses `USE_PROCD=1` with `START=20` and `STOP=15`; therefore service supervision/instance lifecycle is implemented through Procd.
[CONFIRMED] The script defines package-wide UCI variables including `dnsmasq_config_update`, `force_dns`, `notrack_dns`, source interfaces, listen address, user/group and other runtime options.
[IMPORTANT] The inspected portion does not show a generic `config.enabled` flag or establish that `uci set https-dns-proxy.config.enabled='0'` is a supported disable mechanism. Do not execute that unverified UCI change.
[CONFIRMED] The current configuration therefore should be changed only using mechanisms actually implemented by this package/init script, after the audit establishes the desired DNS architecture.
[NO CHANGE] Inspection was read-only; no service or configuration state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Inspect the remaining relevant part of the init script for the `start_service`/Procd logic and any boot/config enable conditions with one read-only targeted command; do not modify anything yet.

## CHANGELOG — 2026-09-21 — post-reboot audit step 14
[RESULT] Read-only grep of `/etc/init.d/https-dns-proxy` located the service startup/configuration logic.
[CONFIRMED] `start_service()` loads package config and runs `config_foreach start_instance "$packageName" "$param"`, so every `config https-dns-proxy` section becomes a Procd-managed instance.
[CONFIRMED] `start_instance()` reads each section's `resolver_url` and `listen_port`, then calls `procd_open_instance`, sets the command, and enables `procd_set_param respawn`.
[CONFIRMED] With `dnsmasq_config_update='*'`, the script loads the DHCP config and appends each proxy listener to all dnsmasq instances; it also updates forced-DNS ports.
[CONFIRMED] The script has config-change and interface triggers that can reload/restart the service, so Procd/triggers explain automatic lifecycle management.
[IMPORTANT] No generic UCI `enabled` option is shown in the located startup logic. The earlier proposed `uci set https-dns-proxy.config.enabled='0'` remains unverified and must not be used.
[IMPORTANT] The current two-instance behavior is now fully explained by the two `config https-dns-proxy` sections plus `config_foreach`; they are intentionally supervised by Procd with respawn.
[NO CHANGE] The command was read-only; no service/configuration state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Inspect the exact `start_service()` and `start_instance()` code block around lines 285–405 with one read-only command, to document the lifecycle precisely before any change.

## CHANGELOG — 2026-09-21 — post-reboot audit step 15
[RESULT] User supplied read-only output of `sed -n '285,405p' /etc/init.d/https-dns-proxy`.
[CONFIRMED] `start_instance()` reads each configured instance's `resolver_url`, `listen_addr`, `listen_port`, bootstrap DNS and other parameters, then constructs the proxy command through `append_parm`/related helpers.
[CONFIRMED] When `dnsmasq_config_update='*'`, each configured proxy listener is added to the dnsmasq configuration via `dnsmasq_doh_server`; forced-DNS port handling is also configured.
[CONFIRMED] Each instance is created with `procd_open_instance`, `procd_set_param command $PROG $PROG_param`, stdout/stderr enabled, and `procd_set_param respawn`. Therefore Procd explicitly supervises and respawns each configured proxy instance.
[CONFIRMED] `start_service()` initializes the instance port at 5053, loads package configuration, then executes `config_foreach start_instance "$packageName" "$param"`. The script increments `port` after each successful instance, explaining the observed sequence 5053, 5054 for the two configured instances.
[CONFIRMED] If `force_dns` is enabled, the script creates firewall redirect/rule data for configured source interfaces and DNS ports; with the current configuration this supports forced DNS handling for LAN on ports 53/853.
[IMPORTANT] The observed two-process state is therefore fully explained by the package's two configuration sections plus Procd's per-instance supervision; it is not evidence of accidental duplicate process startup.
[NO CHANGE] The command was read-only; no service, configuration, network, or firewall state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Await user instruction before issuing the next router command; the current step has been fully documented and synchronized.

## CHANGELOG — 2026-09-21 — post-reboot audit step 16
[RESULT] User supplied read-only output of `/etc/init.d/pbr status`.
[CONFIRMED] PBR version is `1.2.2-r20` on OpenWrt 25.12.5 r33051-f5dae5ece4.
[CONFIRMED] IPv4 uplink is `wan/phy0-sta0`, gateway `192.168.0.1`; current main IPv4 source address is `192.168.0.55`.
[CONFIRMED] PBR reports empty policy, marking-chain, and nft-set sections; no active PBR policy/marking configuration is shown.
[CONFIRMED] Main IPv4 routing table contains:
- default via `192.168.0.1` dev `phy0-sta0`, source `192.168.0.55`;
- `192.168.0.0/24` via `phy0-sta0`;
- `192.168.1.0/24` via `br-lan`.
[CONFIRMED] Main IPv4 rule is only `32766: from all lookup main` in the supplied output.
[CONFIRMED] dnsmasq version shown by PBR is 2.93 with IPv6 support; compiled options shown include `no-DHCP` and `no-DHCPv6`.
[NO CHANGE] The command was read-only; no service, routing, firewall, or configuration state changed.
[STATUS] Post-reboot audit remains IN_PROGRESS.
[NEXT] Await user instruction before issuing the next router command.
