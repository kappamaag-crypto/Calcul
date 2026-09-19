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
STAGE 7–30 — NOT_STARTED

## STAGE 4 — Clean base verification
STATUS: IN_PROGRESS

Цель: подтвердить, что после clean flash текущая база действительно чистая и старый extroot не был автоматически восстановлен.

### Последний фактический результат — 2026-09-18
Выполнена read-only команда:
`ssh root@192.168.1.1 "echo '--- MOUNTS ---'; mount; echo '--- DF ---'; df -h"`

PASS:
- команда завершилась штатно; прежнее длительное ожидание не повторилось;
- `/dev/root` смонтирован как SquashFS на `/rom`, read-only;
- `/dev/sda2` смонтирован на `/overlay` как ext4;
- `overlayfs:/overlay` смонтирован на `/`;
- `/dev/sda3` смонтирован на `/mnt/data`;
- `/dev/sda1` в текущем выводе mount/df не смонтирован как файловая система, что ожидаемо для swap и само по себе не подтверждает его активность;
- df: `/dev/sda2` = 5.6G, 7.6M used, 5.2G available;
- df: `/dev/sda3` = 1017.6M, 360K used, 947.8M available;
- df: `/dev/root` = 6.0M, 100% /rom;
- df: overlay root = 5.6G, 7.6M used, 5.2G available.

Критически важно:
- фактически `/dev/sda2` сейчас является active `/overlay`.
- Это означает, что clean flash сам по себе НЕ отделил старый extroot: старый USB-раздел был автоматически подхвачен/использован как overlay.
- Это не является FAIL STAGE 3: STAGE 3 уже закрыт по критерию чистого firmware flash. Это теперь задача STAGE 4/8 — намеренно отделить старый extroot и создать новый контролируемый extroot.
- Никаких изменений состояния эта команда не выполняла.

### Безопасность
Никакого форматирования, repartitioning, unmount, fstab-изменения или удаления данных этой командой не выполнялось.
Следующий шаг должен быть только read-only и только после подтверждения пользователем текущего результата.

## Architecture
TP-Link Archer C20 v4 остаётся главным маршрутизатором.
MikroTik hAP ac lite работает downstream через Wi-Fi STA.
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.

## Destructive-operation policy
Без явного отдельного подтверждения пользователя запрещены:
- mkfs
- fdisk/parted/wipefs
- destructive dd
- удаление/переразметка /dev/sda1, /dev/sda2, /dev/sda3
- форматирование USB
- отключение/удаление старого extroot с риском потери данных
- flash без подтверждённой image/checksum.

## Historical confirmed facts
- OpenWrt 25.12.5 r33051-f5dae5ece4
- target ath79/mikrotik
- kernel 6.12.94
- model MikroTik RouterBOARD 952Ui-5ac2nD (hAP ac lite)
- rootfs_type squashfs
- STAGE 3 clean flash completed and verified.
- Pre-flash USB layout: sda1 swap, sda2 old extroot, sda3 /mnt/data.
- Pre-flash old system had sda2 active as /overlay.
- Target architecture intentionally requires a newly controlled extroot rather than inheriting the old one.

## One-step-at-a-time rule
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянием. Следующий router command выдаётся только после фактического результата предыдущего.

## CHANGELOG — 2026-09-18 — [SYNC] current mount/df PASS
- [PASS] Read-only `mount; df -h` command completed successfully.
- [CONFIRMED] Current root is overlayfs backed by `/dev/sda2` mounted at `/overlay`.
- [CONFIRMED] Current `/dev/sda3` is mounted at `/mnt/data`.
- [CONFIRMED] `/dev/sda2` has 5.6G filesystem size, 7.6M used, 5.2G available.
- [CONFIRMED] `/dev/sda3` has 1017.6M filesystem size, 360K used, 947.8M available.
- [CONFIRMED] `/dev/sda1` does not appear in mount/df output; no conclusion about swap activation is made from this command alone.
- [IMPORTANT] The old extroot is active again after the clean flash. This is now a concrete STAGE 4 finding and must be resolved deliberately before proceeding to later stages.
- [CONFIRMED] No filesystem, configuration, partition, or service state was changed by the command.
- [CHANGED] STAGE 4 remains IN_PROGRESS.
- [NEXT] Before any destructive storage operation, perform a single read-only check of current swap/fstab/block state to determine how sda2 was inherited and whether sda1 is active. No formatting or repartitioning yet.


## CHANGELOG — 2026-09-18 — [SYNC] post-flash USB extroot inheritance confirmed
- [PASS] Read-only `mount; df -h` command completed successfully.
- [CONFIRMED] Current root is overlayfs backed by `/dev/sda2` mounted at `/overlay`.
- [CONFIRMED] `/dev/sda3` is mounted at `/mnt/data`.
- [CONFIRMED] `/dev/sda1` does not appear in mount/df output; swap activation was not determined by this command.
- [IMPORTANT] The old `/dev/sda2` is active again as `/overlay` after clean flash. Clean flash therefore did not physically detach the old extroot; the external filesystem was detected and mounted during boot.
- [CHANGED] STAGE 4 remains IN_PROGRESS. The clean-base criterion requiring the old `/dev/sda2` to be inactive is not yet satisfied.
- [SAFETY] No unmount, formatting, repartitioning, fstab modification, package installation, or other state-changing operation was performed.
- [NEXT] One read-only command will inspect `/etc/config/fstab`, `/proc/swaps` and `/sbin/block info` to determine the automatic mount mechanism and current swap state before any storage operation.


## CHANGELOG — 2026-09-19 — [SYNC] automatic extroot mechanism identified
- [PASS] Read-only command collected current `/etc/config/fstab`, `/proc/swaps` and `/sbin/block info`.
- [CONFIRMED] `/etc/config/fstab` has `auto_mount '1'` globally.
- [CONFIRMED] The explicit `/overlay` fstab entry for UUID `244b7bbc-add1-46cd-bc1a-0143cfca5d6c` is `enabled '0'`, yet `/dev/sda2` with exactly that UUID is currently mounted at `/overlay`.
- [CONFIRMED] Therefore the current automatic mounting of the old extroot is not explained by that disabled explicit mount entry alone; the boot-time root/fstools/extroot discovery mechanism is using the detected ext4 filesystem/UUID.
- [CONFIRMED] `/dev/sda1` is active swap: 524284 kB total, 4348 kB used, priority -2.
- [CONFIRMED] `/dev/sda2`: ext4, UUID `244b7bbc-add1-46cd-bc1a-0143cfca5d6c`, label `extroot`, mounted `/overlay`.
- [CONFIRMED] `/dev/sda3`: ext4, UUID `635bc144-d79a-4e6d-a315-0e1655eb995c`, label `data`, mounted `/mnt/data`.
- [CONFIRMED] No filesystem, configuration, partition or service state was changed.
- [CHANGED] STAGE 4 remains IN_PROGRESS because the old `/dev/sda2` is still active as `/overlay`.
- [SAFETY] Do not format/repartition USB or modify fstab yet. The next step must establish the exact boot-time extroot mechanism using read-only evidence before any state-changing operation.


## CHANGELOG — 2026-09-19 — [NEXT] boot-time extroot mechanism inspection
- [STARTED] Следующий шаг STAGE 4 выбран как read-only inspection boot-time root/extroot mechanism.
- [RULE] До получения этого результата не выполнять unmount, изменение fstab, mkfs, wipefs, repartitioning или иные операции с USB.

- [PASS] Read-only inspection found /sbin/mount_root (4117 bytes), /lib/preinit/80_mount_root, libfstools.so, and installed block-mount/fstools package metadata.
- [CONFIRMED] Kernel cmdline is console=ttyS0,115200n8 rootfstype=squashfs,jffs2; it contains no explicit external overlay device.
- [CONFIRMED] No /etc file matching *extroot* or *fstool* was found by the search.
- [NEXT] Exact selection logic must be read from /lib/preinit/80_mount_root and /sbin/mount_root; no state-changing operation is authorized yet.

- [PASS] Read-only inspection confirmed `/lib/preinit/80_mount_root` calls `mount_root start ...`; `/sbin/mount_root` is an ELF binary, so the actual root/overlay selection logic is inside the fstools binary/library path rather than the shell preinit script.
- [CONFIRMED] `80_mount_root` does not itself reference `/dev/sda2`, an extroot UUID, or a dedicated `/etc/extroot*` configuration.
- [CONFIRMED] No configuration restore was triggered by this command; the inspected script only restores `/sysupgrade.tgz` or `/tmp/sysupgrade.tar` if present.
- [NEXT] Continue read-only analysis of the installed fstools/block-mount implementation to identify why the old extroot partition is auto-selected. No USB/filesystem changes authorized.

- [PASS] `fstools` package contains `/lib/libfstools.so` and `/sbin/mount_root`; `block-mount` contains `/etc/hotplug.d/block/10-mount`, `/etc/init.d/fstab`, `/sbin/block`, and blkid support.
- [CONFIRMED] `strings /sbin/mount_root` explicitly exposes `mount_extroot`, `fstools_overlay_name`, `mount_overlay`, `switched to extroot`, `/overlay`, and `no usable overlay filesystem found, using tmpfs overlay`.
- [CONFIRMED] This establishes that the active `/dev/sda2` extroot selection is implemented by fstools' built-in extroot logic, not by the disabled `/overlay` UCI mount entry.
- [NEXT] Determine the exact extroot acceptance criterion read-only (likely filesystem label/UUID or block discovery) before any repartitioning/formatting.

- [PASS] `libfstools.so` confirms dedicated extroot implementation: `mount_extroot`, `/tmp/extroot`, `/tmp/extroot/mnt`, `/tmp/extroot/overlay`, `switching to extroot`, `switched to extroot`, and overlay discovery strings.
- [CONFIRMED] `/etc/init.d/fstab` only runs `/sbin/block mount` at boot; `/etc/hotplug.d/block/10-mount` only invokes `/sbin/block hotplug` on add/remove events. These do not explain preinit extroot selection.
- [CONFIRMED] The automatic `/dev/sda2` selection is therefore in fstools preinit root selection, not the disabled UCI `/overlay` mount entry.
- [NEXT] Determine the exact extroot discovery condition from the available fstools source/debug metadata without changing storage or installing packages.

- [PASS] Package metadata identifies installed `fstools-2026.05.23~16718b6e-r1`; `readelf` returned no matching symbols because the binaries are stripped or otherwise expose no relevant dynamic symbols.
- [CONFIRMED] Official OpenWrt fstools source shows `mount_root` calls `mount_extroot()` before normal `rootfs_data` overlay handling; the current fstools build also contains a dedicated `libfstools/extroot.c` component. This matches the router's observed `switched to extroot` strings. citeturn0search6turn0search1
- [CONFIRMED] The previous conclusion is strengthened: the old `/dev/sda2` was selected by fstools extroot logic during preinit, not by the disabled UCI mount entry.
- [NEXT] The remaining task is to identify the exact extroot discovery/configuration condition used by the installed 2026.05.23 fstools. Prefer official source matching this package revision; no router state change or package installation.

- [CONFIRMED] Official fstools source shows extroot entries are created only from enabled mount sections; a disabled `enabled='0'` entry is skipped by `mount_add()`. The `/overlay` target itself marks a mount as extroot+overlay. citeturn1search0
- [CONFIRMED] `mount_root` calls `mount_extroot("")` before normal `rootfs_data` overlay handling. citeturn0search1
- [IMPORTANT DISCREPANCY] The current runtime UCI shows the `/overlay` entry disabled, while `/dev/sda2` is already mounted as `/overlay`. Therefore we will not perform more diagnostic probing merely to chase the historical boot path. The practical next operation is the planned USB extroot reset/repartition, which will remove the old extroot filesystem and its configuration source.
- [BLOCKED] Destructive USB reset requires explicit confirmation immediately before execution, per master-plan safety rule. No destructive command issued in this turn.

- [AUTHORIZED] User explicitly authorized complete repartitioning and formatting of USB `/dev/sda`; old data are declared unnecessary.
- [NEXT] Begin destructive USB stage with a final read-only identity/partition check before any write operation. No destructive command has been issued yet.


SYNC 2026-09-19: Final read-only USB check PASS. User authorization for full `/dev/sda` repartition/format confirmed. STAGE 4 is IN_PROGRESS. Next command is the first preparation step; no destructive write has yet been issued.

SYNC 2026-09-19: `swapoff /dev/sda1` completed with empty output; USB swap is deactivated. No other state change performed.

SYNC 2026-09-19: `umount /mnt/data` completed with empty output; `/mnt/data` is detached. No formatting/repartitioning yet.

SYNC 2026-09-19: Set fstab global `auto_mount='0'`, committed, and rebooted. Router reboot confirmed by user. USB swap was already off and `/mnt/data` unmounted.

SYNC 2026-09-19: After reboot, `auto_mount=0` did not prevent fstools extroot selection: `/dev/sda2` remains `/overlay`, `/dev/sda3` remains `/mnt/data`, and `/dev/sda1` is active swap. Therefore USB cannot be destructively repartitioned while connected; next safe path is clean shutdown, physical USB removal, boot from internal flash, then reconnect USB only after confirming internal overlay.

SYNC 2026-09-19: Router rebooted/power cycle occurred. SSH reports changed ED25519 host key for 192.168.1.1 (new fingerprint SHA256:ffcy+GxkVzRuj+9unvWg4a30g14N99UkG9KxWf+fuF8), indicating a host-key change after boot. USB physical removal has not yet been confirmed; no router command issued after the warning.

SYNC 2026-09-19: User confirmed USB physically disconnected after reboot. SSH host-key warning remains unresolved intentionally; no host-key bypass performed.

SYNC 2026-09-19: Old SSH known_hosts entry for 192.168.1.1 removed successfully. USB remains physically disconnected. Next step is one SSH read-only verification of internal rootfs.

SYNC 2026-09-19: PASS — router is booted from internal flash: `/dev/mtdblock9` is `/overlay` (jffs2), `/dev/sda` is absent, `/mnt/data` absent, OpenWrt 25.12.5 confirmed. `auto_mount` is 1 after boot, which is acceptable because USB is disconnected.

SYNC 2026-09-19: USB physically reconnected after clean internal-flash boot. Awaiting read-only verification that it is present but not mounted as `/overlay` before destructive repartitioning.

SYNC 2026-09-19: USB is present but inactive except `/dev/sda1` auto-activated as swap (0 KiB used). Internal `/overlay` remains `/dev/mtdblock9`. Before repartitioning, swap must be disabled again; no destructive command yet.

SYNC 2026-09-19: `swapoff /dev/sda1` completed successfully; USB has no active swap/mounts and internal overlay remains active. Destructive repartitioning can now proceed one command at a time.

SYNC 2026-09-19: `fdisk /dev/sda` opened successfully. Interactive prompt reached; no partition-table write has been issued yet. User authorization for complete repartitioning remains active.

SYNC 2026-09-19: In `fdisk`, `g` created a new GPT disklabel in memory only (GUID 23EC0E2C-930D-4F10-BC0C-03B34BA15139). No write to USB yet. Target scheme from master prompt: extroot + USB swap + optional `/mnt/data`; exact sizes are to be selected from actual ~7.3 GiB USB.

SYNC 2026-09-19: User exited fdisk without writing the staged GPT; no disk changes from that fdisk session. User requested full commands instead of interactive sub-steps. Continue with one complete logical operation per command.

SYNC 2026-09-19: Clarified purpose of optional /mnt/data: separate persistent data area for large/downloaded/generated/configuration data, keeping extroot (/overlay) focused on installed packages and system state. No partitioning change performed.

SYNC 2026-09-19: Clarified ZRAM timing/state: ZRAM is not a future Stage 4 installation; prior verified project state records /dev/zram0 at 32 MiB, lzo-rle, activated with mkswap/swapon. STAGE 4 is focused on rebuilding USB layout/extroot and preserving the clean architecture: extroot + ZRAM + USB swap. /tmp remains RAM-backed and must be monitored; no plan to move /tmp into ZRAM.

SYNC 2026-09-19: USB repartitioning was written successfully: GPT GUID 742D1342-481B-400A-9CB4-FCDA05D9F8B6; sda1 512 MiB and sda2 6.8 GiB. IMPORTANT: scripted type selection did not set sda1 to Linux swap; fdisk changed it to EFI System, and the extra '19' was reported as unknown. sda1 still contains a swap signature; sda2 still contains an ext4 signature. STAGE 4 remains IN_PROGRESS. Next action must correct sda1 GPT type to Linux swap before formatting/extroot.

SYNC 2026-09-19: Read-only fdisk verification PASS. /dev/sda is GPT, sda1 512 MiB Linux swap (sectors 2048-1050623), sda2 6.8 GiB Linux filesystem (sectors 1050624-15259647), no sda3. USB layout matches target. STAGE 4 remains IN_PROGRESS; formatting has not yet been performed.

SYNC 2026-09-19: STAGE 4 formatting attempt FAILED/blocked at mkswap /dev/sda1: 'write error: Text file busy'. Because of &&, mkfs.ext4 on sda2 did NOT run. Likely sda1 is currently active/in use despite earlier swapoff. No further destructive formatting command until active use is identified/cleared.

SYNC 2026-09-19: `swapoff /dev/sda1` completed with empty output, indicating the active USB swap was disabled successfully. STAGE 4 remains IN_PROGRESS; sda1/sda2 are not yet formatted.

SYNC 2026-09-19: USB formatting PASS. `mkswap /dev/sda1` completed; `/dev/sda2` formatted ext4 with label `extroot`, UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2`. STAGE 4 remains IN_PROGRESS. No extroot mount/copy/fstab change has been performed yet.

SYNC 2026-09-19: Pre-extroot overlay baseline PASS. `/overlay` is internal `/dev/mtdblock9`, jffs2, rw,noatime; size 7.0M, used 372K, available 6.6M. `du -sh /overlay` = 35.5K. USB extroot is not mounted yet. Next step is controlled copy of overlay to sda2.

SYNC 2026-09-19: sda2 temporary mount PASS: `mount /dev/sda2 /mnt/extroot` completed with empty output. No fstab/extroot activation change yet.

SYNC 2026-09-19: Overlay copy PASS: `cp -a /overlay/. /mnt/extroot/` completed with empty output. Current internal overlay remains active; copied content is staged on sda2.

SYNC 2026-09-19: extroot staging verification PASS. `/dev/sda2` mounted at `/mnt/extroot`, 6.6G filesystem, 6.2G available; copied overlay content present (`upper`, `work`, fstab backup files, .fs_state). No fstab activation change yet.

SYNC 2026-09-19: Current /etc/config/fstab reviewed. It still contains stale old USB data UUID `fa23e979-...` for /mnt/data and stale old extroot UUID `244b7bbc-...`. New sda2 extroot UUID is `e1c68a3a-0e55-4af9-afd8-961160b3afa2`; sda1 swap entry points to /dev/sda1 and is enabled. Next step must replace extroot UUID and remove obsolete /mnt/data mount entry before activation.

SYNC 2026-09-19: fstab edit PASS. Backup `/etc/config/fstab.before-extroot-final` created; obsolete /mnt/data mount entry removed; extroot UUID set to `e1c68a3a-0e55-4af9-afd8-961160b3afa2`; config committed. Extroot is not activated/rebooted yet.

SYNC 2026-09-19: fstab read-only verification PASS. Active config contains only USB swap `/dev/sda1` and enabled extroot `/overlay` using UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2`; obsolete `/mnt/data` entry absent. No reboot/activation yet.

SYNC 2026-09-19: Router rebooted by user and SSH access restored. Extroot activation has been attempted; mount-source verification is still pending. Do not mark activation DONE until `/overlay` is confirmed on `/dev/sda2`.

SYNC 2026-09-19: STAGE 4 extroot activation VERIFIED PASS. After reboot, `df -h /overlay` reports `/dev/sda2` mounted on `/overlay`, size 6.6G, 1.9M used, 6.2G available. USB extroot is active. USB swap configuration remains enabled; ZRAM preservation remains part of the plan.

SYNC 2026-09-19: STAGE 4 CLOSED DONE. Verified after reboot: `/overlay` is `/dev/sda2` ext4, 6.6G total, 6.2G available. USB extroot active. STAGE 5 started: minimal network verification. No network state changed yet; next command is read-only inspection of current network configuration and IPv4 routing.


SYNC 2026-09-19: STAGE 5 step 5.1 read-only network inspection PASS partially. LAN is correct: br-lan 192.168.1.1/24 with eth0.1 VLAN bridge. WAN remains configured as DHCP on eth1, WAN6 as DHCPv6 on eth1, but `ip -4 addr` shows no IPv4 address on eth1 and `ip -4 route` has no default route. Therefore Internet/WAN is not currently operational. No configuration was changed. Next step: read-only inspect link/interface state and DHCP client state for WAN to determine whether eth1 has carrier and whether DHCP is running.


## CURRENT AUTHORITATIVE STATE — SYNC 2026-09-19

This block is authoritative over older historical changelog entries above.

- Main router: TP-Link Archer C20 v4; MikroTik hAP ac lite remains downstream.
- OpenWrt: 25.12.5 r33051-f5dae5ece4; target ath79/mikrotik; apk-tools 3.0.5; mips_24kc.
- Network path: TP-Link Wi-Fi → MikroTik Wi-Fi STA → MikroTik LAN/Wi-Fi → laptop.
- WAN STA: phy0-sta0, SSID SweetHomeU, associated, WAN DHCP 192.168.0.111/24, gateway 192.168.0.1.
- LAN: br-lan 192.168.1.1/24; DHCP client EFFA received 192.168.1.146.
- Laptop Ethernet: 192.168.1.146, gateway 192.168.1.1. Ethernet-sourced ping to 1.1.1.1 PASS; nslookup openwrt.org via 192.168.1.1 PASS.
- USB: sda1 512 MiB swap; sda2 ~6.8 GiB ext4 extroot; /overlay is active on /dev/sda2; no sda3 and no /mnt/data target.
- ZRAM: previously verified /dev/zram0 32 MiB, lzo-rle, activated. /tmp remains RAM-backed.
- STAGE 0–5: DONE. STAGE 6: IN_PROGRESS. STAGE 7–30: NOT_STARTED.
- STAGE 6 next operation is read-only inspection of wireless AP configuration/state. No router configuration change has been made by this sync.

SYNC 2026-09-19: Corrected repository artifact identification. The canonical master plan is OPENWRT_VARIANT_A_MASTER_PLAN.md; the canonical master prompt is OPENWRT_VARIANT_A_MASTER_PROMPT.md. Both are required to remain synchronized with factual project state after each turn.


SYNC 2026-09-19: STAGE 6 wireless AP configuration inspection PASS. Both default AP interfaces `default_radio0` and `default_radio1` are configured on LAN with SSID `OpenWrt`, mode `ap`, encryption `none`, but both have `disabled='1'`. The WAN STA interface remains on `radio0`, network `wan`, mode `sta`, SSID `SweetHomeU`, encryption `psk2`, `disabled='0'`. No configuration was changed. STAGE 6 remains IN_PROGRESS; next step is a single controlled read-only/runtime check before enabling AP.


SYNC 2026-09-19: STAGE 6 runtime Wi-Fi inspection PASS. `iw dev` shows only `phy#0` with interface `phy0-sta0`, type `managed`, channel 36 (5180 MHz), width 80 MHz, TX power 23 dBm. No AP interface is currently active. No configuration changed. STAGE 6 remains IN_PROGRESS. This confirms the existing WAN STA occupies radio0; the next action must account for this before enabling any AP interface.


SYNC 2026-09-19: STAGE 6 `iw phy` PASS. Only `Wiphy phy0` is present. It supports managed and AP modes and valid simultaneous STA/AP combinations on one channel, but no `phy1` is exposed by the kernel. Therefore the configured `radio1` AP has no currently exposed physical radio. No configuration changed. STAGE 6 remains IN_PROGRESS; next step must inspect the wireless radio configuration (`radio0`/`radio1`) read-only before deciding how to restore AP safely.


SYNC 2026-09-19: STAGE 6 radio configuration inspection PASS. `radio0` is mac80211 5 GHz at channel 36/VHT80, path `pci0000:00/0000:00:00.0`. `radio1` is configured as mac80211 2.4 GHz channel 1/HT20, path `platform/ahb/18100000.wmac`. However, runtime `iw phy` exposes only `phy0`; `phy1` is absent. No configuration changed. STAGE 6 remains IN_PROGRESS. Before enabling AP, the next step must perform a read-only driver/kernel log check to determine why configured radio1 is not exposed.


SYNC 2026-09-19: STAGE 6 kernel log changes the diagnosis: `ath9k 18100000.wmac` initially reports missing `ath9k-eeprom-ahb-18100000.wmac.bin` (error -2) and sysfs fallback, but then successfully registers `ieee80211 phy1` with `Atheros AR9531 Rev:2`, IRQ 13. Therefore radio1 hardware/driver is actually registered as phy1; previous `iw dev` showed no interface for it, not absence of the PHY itself. No configuration changed. STAGE 6 remains IN_PROGRESS. Next step is read-only inspection of `phy1` capabilities/state to determine why no AP interface exists.


SYNC 2026-09-19: STAGE 6 `phy1` capability check PASS. `iw phy phy1 info` confirms Wiphy phy1, Band 1, and supported interface mode `AP`. Thus the 2.4 GHz AR9531 radio is registered and AP-capable. No configuration changed. STAGE 6 remains IN_PROGRESS. Next step is read-only inspection of existing runtime wireless interfaces/config generation before enabling AP.


SYNC 2026-09-19: STAGE 6 runtime interface check: `iw dev` still shows only `phy0-sta0` (managed, channel 36/5180 MHz, VHT80). No interface exists on `phy1`, so the 2.4 GHz AP is not currently instantiated despite phy1 being AP-capable. No configuration changed. STAGE 6 remains IN_PROGRESS.


SYNC 2026-09-19: User requested shorter command outputs for easier AI insertion. STAGE 6: `ubus call network.wireless status` for radio1 shows `up=true`, `pending=false`, `autostart=true`, `disabled=false`, `retry_setup_failed=false`, correct mac80211 2.4 GHz config (`channel 1`, `HT20`, path `platform/ahb/18100000.wmac`), but `interfaces=[]`. Therefore radio1 is operational at radio level but netifd has instantiated no wireless interface. No configuration changed. STAGE 6 remains IN_PROGRESS.


SYNC 2026-09-19: STAGE 6: `wireless.default_radio1` is correctly configured as AP on `radio1`, network `lan`, SSID `OpenWrt`, but explicitly has `disabled='1'`. This explains why `radio1` has `interfaces=[]`; no configuration has been changed yet. User requested concise command outputs.


SYNC 2026-09-19: STAGE 6 AP restoration PASS: after enabling `wireless.default_radio1`, `iw dev` shows `phy1-ap0`, SSID `OpenWrt`, type `AP`; existing `phy0-sta0` remains managed on 5 GHz. Thus 2.4 GHz AP is instantiated without disrupting the 5 GHz WAN STA. STAGE 6 remains IN_PROGRESS because client association/Internet through the restored AP and 5 GHz AP coexistence are not yet verified.


SYNC 2026-09-19: STAGE 6 AP restoration progress: after enabling `wireless.default_radio1`, `iw dev` confirms `phy1-ap0`, SSID `OpenWrt`, type `AP`; `phy0-sta0` remains `managed`. Thus 2.4 GHz AP is successfully instantiated without disturbing the 5 GHz WAN STA. STAGE 6 remains IN_PROGRESS because client association/IP verification and 5 GHz AP coexistence still need verification. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6: `ubus` confirms `default_radio1` is active with `disabled=false`, `ifname=phy1-ap0`, mode AP, SSID OpenWrt, network LAN. `stations=[]` currently, so no client association yet. Note: this status object does not expose an `up` field; do not infer `up=true` from its absence. Next verification should check interface/link state directly. User requests concise outputs.


SYNC 2026-09-19: STAGE 6: `ip link show phy1-ap0` confirms `<BROADCAST,MULTICAST,UP,LOWER_UP>` and `master br-lan state UP`. Therefore the 2.4 GHz AP interface is operational and bridged to LAN. No configuration change in this step. STAGE 6 remains IN_PROGRESS pending wireless client verification and 5 GHz AP decision/testing. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6 client verification PASS for 2.4 GHz AP: phone is associated to `phy1-ap0` (MAC 12:ef:83:1c:01:e9), signal -33 dBm, TX/RX 144.4 MBit/s MCS 15 short GI. This proves the OpenWrt 2.4 GHz AP is usable at the Wi-Fi association layer. STAGE 6 remains IN_PROGRESS because LAN/IP reachability from the Wi-Fi client and the requested 5 GHz AP coexistence still require verification. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6 LAN/DHCP verification PASS: phone MAC 12:ef:83:1c:01:e9 received DHCP lease `192.168.1.222` with hostname `POCO-F5-Pro` from `/tmp/dhcp.leases`. Therefore 2.4 GHz AP association and LAN DHCP are verified. STAGE 6 remains IN_PROGRESS pending end-to-end client connectivity check and 5 GHz AP coexistence testing. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6 end-to-end 2.4 GHz client connectivity PASS. User confirmed phone has working Internet through the MikroTik AP. Verified chain: phone associated to `phy1-ap0` at -33 dBm / 144.4 Mbit/s TX/RX; DHCP lease `192.168.1.222`; Internet works. 2.4 GHz AP path is operational end-to-end. STAGE 6 remains IN_PROGRESS because 5 GHz AP coexistence with the existing 5 GHz STA has not yet been tested. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6: `wireless.default_radio0` is configured as AP on 5 GHz `radio0`, network LAN, SSID OpenWrt, but `disabled='1'`. The same `radio0` currently carries the working 5 GHz STA `phy0-sta0`. No configuration changed. 2.4 GHz AP remains end-to-end operational. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6: `phy0` valid interface combinations explicitly allow `managed` and `AP` concurrently, with `#channels <= 1` and `STA/AP BI must match`; therefore the existing 5 GHz STA and a 5 GHz AP can coexist on the same radio, subject to matching channel/parameters. No configuration changed. Next step is controlled activation of `default_radio0` AP. User requests concise command outputs.


SYNC 2026-09-19: STAGE 6: 5 GHz AP coexistence PASS at radio level. `phy0-ap0` is active on channel 36 (5180 MHz), width 80 MHz, center1 5210 MHz, matching the existing `phy0-sta0` channel. `phy0` now has both AP and managed interfaces; `phy1-ap0` remains active on 2.4 GHz. User is considering fixing TP-Link 5 GHz channel instead of Auto, but no TP-Link change has been made. STAGE 6 remains IN_PROGRESS pending client verification on 5 GHz and final stage criteria.


SYNC 2026-09-19: STAGE 6: after changing `radio0` AP SSID to `OpenWrt-5G`, `netifd` reports the configured SSID correctly, but `ip link` shows `phy0-ap0` as `UP` with `NO-CARRIER` and `state DOWN`. `phy0-sta0` remains present. No further configuration change in this step. 2.4 GHz AP remains operational. This indicates the 5 GHz AP interface exists but is not currently carrying an associated client; visibility/startup still needs diagnosis. User requests concise outputs.

SYNC 2026-09-19: STAGE 6 diagnostic: hostapd reloads phy0 and reloads BSS `phy0-ap0`, then netifd reports `phy0-ap0` link down and kernel reports br-lan port disabled; wifi-scripts prepares the interface with MAC b8:69:f4:d6:e8:a5. No explicit hostapd failure is shown in the captured last 10 lines. 5 GHz AP remains unresolved; 2.4 GHz AP remains operational.

SYNC 2026-09-19: STAGE 6: `ubus call network.wireless status` confirms `radio0` BSS `default_radio0` is configured as AP, enabled, network `lan`, SSID `OpenWrt-5G`, ifname `phy0-ap0`, with zero associated stations. This confirms netifd configuration exists; 5 GHz AP client visibility/operational state remains unresolved. No configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-ap0 info` confirms the interface exists as `type AP`, wiphy 0, txpower 23 dBm, MAC ba:69:f4:d6:e8:a5. The output does not expose SSID or channel and does not establish that the AP is beaconing. No configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev | grep -A8 -B1 'phy0-ap0'` again confirms `phy0-ap0` exists as AP on phy0 with txpower 23 dBm, but `iw dev` exposes no SSID or channel for this AP. This supports that the BSS is configured in netifd but is not fully operational/beaconing. No configuration change.

SYNC 2026-09-19: STAGE 6: `/var/run/hostapd-phy0.conf` contains a complete 5 GHz AP config: `hw_mode=a`, `channel=36`, 802.11n/ac enabled, VHT80 (`vht_oper_chwidth=1`, center segment 42), `interface=phy0-ap0`, `ssid2="OpenWrt-5G"`. Therefore the hostapd config itself has the expected channel/interface/SSID parameters. No configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-sta0 link` confirms the 5 GHz STA is connected to TP-Link BSSID d8:0d:17:e0:73:a8, SSID `SweetHomeU`, frequency 5180 MHz (channel 36), VHT80, signal -46 dBm, RX/TX 433.3 MBit/s. Thus the STA side is healthy and matches the AP hostapd channel 36/VHT80 configuration. 5 GHz AP still has no verified beacon/client; no configuration change.

SYNC 2026-09-19: STAGE 6: dmesg shows `phy0-ap0` entered forwarding state after the STA re-associated, proving the AP interface can become operational concurrently with the STA. Later it entered disabled state at kernel time 3966. During STA reassociation, ath10k reports `pdev param 0 not supported by firmware` and `failed to enable peer stats info: -122`; despite these messages, `phy0-sta0` became associated and `phy0-ap0` entered forwarding. Root cause is not yet established. No configuration change.

SYNC 2026-09-19: STAGE 6: current `phy0-ap0` remains `<NO-CARRIER,...,UP>` with `state DOWN`. Combined with dmesg evidence, the 5 GHz AP has successfully entered forwarding during STA operation but later lost carrier/was disabled. No configuration change.

SYNC 2026-09-19: STAGE 6 root-cause evidence: at 06:22:18 `phy0-sta0` associated and `phy0-ap0` entered forwarding/link-up. At 06:25:52 `radio0` wifi-scripts reports `command failed: Not supported (-122)`. At 06:25:55 hostapd reloads `phy0-ap0`, immediately followed by netifd `phy0-ap0 link is down` and bridge port disabled. At 06:25:56 wifi-scripts reconfigures phy0 and prepares both AP/STA interfaces. This strongly localizes the failure to a radio0 wifi-scripts/driver operation returning -122 during reload; no configuration change yet.

SYNC 2026-09-19: STAGE 6: broader log context confirms every observed `radio0` wifi-scripts start returns `command failed: Not supported (-122)`, including before the 06:25:55 AP link-down event. The sequence is wifi-scripts start -> -122 -> wpa_supplicant/hostapd reconfiguration -> AP link down/restart. A kernel `set-coverage-class` message appears in an older 2026-09-17 occurrence, but current logs do not identify the exact failing operation. No configuration change.

SYNC 2026-09-19: STAGE 6: `uci show wireless.radio0` is minimal and expected: mac80211, ath10k PCI path, band 5g, channel 36, HT mode VHT80. No explicit unsupported radio option is present in this UCI device config. No configuration change.

SYNC 2026-09-19: STAGE 6: `phy0` 5 GHz frequency list confirms channels 36/40/44/48 are available at 23 dBm; channel 36 (5180 MHz) is not disabled. Therefore the current channel is supported by the radio. No configuration change.

SYNC 2026-09-19: STAGE 6: ath10k firmware loads successfully: QCA9887 hw1.0, firmware `10.1-ct-87-__fW-022-d8dab8e8`, API 2, board_file loaded, WMI initialized. There is a separate ath9k EEPROM firmware load warning for the 2.4 GHz radio (`-2`), but 2.4 GHz AP is already operational and this is not evidence for the radio0 failure. No configuration change.

SYNC 2026-09-19: STAGE 6: kernel is 6.12.94; installed ath10k packages are `ath10k-board-qca9887`, `ath10k-firmware-qca9887-ct`, and `kmod-ath10k-ct-smallbuffers`. This confirms the CT ath10k stack is intentionally installed. `apk info` emitted repository cache-missing warnings because package indexes are not locally cached; this is a known package-manager state and does not by itself indicate version mismatch. No package changes.

SYNC 2026-09-19: STAGE 6: `kmod-ath10k-ct-smallbuffers-6.12.94.2025.12.01~bb84e159-r1` is installed, explicitly matching kernel 6.12.94. Description confirms CT ath10k driver with small buffers for low-RAM devices. Repository cache warnings remain unchanged; no package changes.

SYNC 2026-09-19: STAGE 6: `phy0-ap0` exists as type AP, while `phy0-sta0` is connected to `SweetHomeU` at 5180 MHz (channel 36), signal -37 dBm, VHT80. Thus the 5 GHz STA is healthy and the AP interface exists; this does not yet prove the AP is beaconing/visible because `phy0-ap0` output lacks channel/SSID details and earlier link state was DOWN. No configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-ap0 link` reports `Not connected`; `phy0-ap0` is type AP but its `info` output exposes neither channel nor SSID. This confirms the 5 GHz AP interface exists but is not currently operating/beaconing normally. The 5 GHz STA remains healthy. No configuration change.

SYNC 2026-09-19: STAGE 6: logs show `phy0-sta0` associates successfully, and `phy0-ap0` initially entered forwarding state, then after wireless reload at 06:25:55 it went down. `radio0` subsequently logs `wifi-scripts: Configuring ...` and prepares both AP and STA, but no explicit hostapd failure is logged. The ath10k warnings `pdev param 0 not supported by firmware` and `failed to enable peer stats info: -122` occur during STA association and do not by themselves explain AP startup failure. No configuration change.

SYNC 2026-09-19: STAGE 6: generated `/var/run/hostapd-phy0.conf` is internally consistent: hw_mode=a, channel=36, ieee80211n/ac enabled, VHT80 (`vht_oper_chwidth=1`, center segment 42), interface `phy0-ap0`, SSID `OpenWrt-5G`. Therefore the generated hostapd configuration itself does not show a missing channel/SSID or obvious VHT mismatch. No configuration change.

SYNC 2026-09-19: STAGE 6: kernel explicitly reports a valid interface combination allowing managed + AP concurrently with `#channels <= 1` and STA/AP beacon interval matching. `phy0-ap0` remains type AP. Thus driver capability for the required STA+AP arrangement is confirmed; no configuration change.

SYNC 2026-09-19: STAGE 6: `ubus call hostapd.phy0 get_status` returned `Command failed: Not found`. This means the expected hostapd ubus object/method is not exposed in the current runtime; it does not by itself identify the 5 GHz AP failure. No configuration change.

SYNC 2026-09-19: STAGE 6: UBUS lists `hostapd`, `hostapd-auth`, `hostapd.phy0-ap0`, and `hostapd.phy1-ap0`. Therefore the correct 5 GHz hostapd object is `hostapd.phy0-ap0`; the previous `hostapd.phy0 get_status` target was incorrect. No configuration change.

SYNC 2026-09-19: STAGE 6: `hostapd.phy0-ap0 get_status` reports ENABLED, SSID `OpenWrt-5G`, 5180 MHz/channel 36, BSSID ba:69:f4:d6:e8:a5, DFS CAC inactive. `iw reg get` reports regulatory domain US: DFS-FCC globally and on phy0/phy1. Channel 36 (5150-5250 MHz) is permitted at 23 dBm and is not marked DFS. Therefore current 5 GHz visibility issue is not explained by DFS waiting or an absent firmware package. Country code is set to US and has not yet been compared with the intended operating country/configuration; no change made.

SYNC 2026-09-19: STAGE 6: `uci show wireless | grep -E 'country|country3'` returned no output. Thus no `country`/`country3` is explicitly configured in `/etc/config/wireless`; the current US regulatory domain is coming from another source/default/driver state. No configuration change.

SYNC 2026-09-19: STAGE 6: regulatory domain remains `US: DFS-FCC`; wireless UCI explicitly sets only radio0 channel 36/VHT80 and radio1 channel 1/HT20, with no country option. Thus current US domain is not configured in `/etc/config/wireless`, and both selected channels are permitted under it. No configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-ap0 station dump` returned no stations and `iw dev phy0-ap0 info | grep ...` still shows only `type AP`, with no channel. Combined with hostapd reporting ENABLED/channel 36, this indicates a discrepancy between hostapd state and kernel-visible AP channel state. No configuration change.

SYNC 2026-09-19: STAGE 6: `phy0` hardware capabilities confirmed again: Band 2 has VHT capabilities and channels 36/40/44/48 (5180/5200/5220/5240 MHz) at 23 dBm. Thus channel 36 and VHT are supported by the radio. The remaining issue is specifically activation/beaconing of `phy0-ap0`, not channel hardware capability. No configuration change.

SYNC 2026-09-19: STAGE 6: `phy0-ap0` is administratively UP but has `NO-CARRIER` and `state DOWN`; it is bridged to `br-lan`. `iw dev` confirms type AP and txpower 23 dBm. Therefore the remaining failure is that the 5 GHz AP interface is not attaining carrier/operational link despite hostapd reporting ENABLED. No configuration change.

SYNC 2026-09-19: STAGE 6: dmesg shows `phy0-ap0` successfully entered allmulticast/promiscuous mode and `br-lan` forwarding at 3439/3749, but later `br-lan` port 3 entered disabled state at 3966. No explicit ath10k AP-start failure appears; `pdev param 0 not supported` and peer-stats `-122` occur around STA association/firmware init. This indicates AP did become operational previously and was subsequently disabled, suggesting a runtime/reload interaction rather than missing capability. No configuration change.

SYNC 2026-09-19: STAGE 6: process check confirms one supervised hostapd instance (`/usr/sbin/hostapd -s -g /var/run/hostapd/global`, PID 1735) and one wpa_supplicant instance (`/usr/sbin/wpa_supplicant -n -s -g /var/run/wpa_supplicant/global`, PID 1731), both inside ujail supervisors. No duplicate instances observed. No configuration change.

SYNC 2026-09-19: STAGE 6: `ubus call hostapd.phy0-ap0 get_status` reports hostapd status ENABLED, BSSID ba:69:f4:d6:e8:a5, SSID OpenWrt-5G, frequency 5180 MHz, channel 36, DFS CAC inactive. Therefore hostapd considers the 5 GHz AP operational while prior kernel state showed phy0-ap0 NO-CARRIER/state DOWN; this confirms a hostapd/kernel interface-state discrepancy. No configuration change.

SYNC 2026-09-19: STAGE 6: `ip link show phy0-ap0` confirms current kernel state is `<NO-CARRIER,...,UP>` with `state DOWN`, while hostapd simultaneously reports ENABLED on channel 36/5180 MHz. This is a confirmed hostapd-vs-kernel interface-state discrepancy. No configuration change.

SYNC 2026-09-19: STAGE 6: user changed `wireless.radio0.htmode` from VHT80 to VHT40 with `uci set`; `uci get` confirms pending UCI value `VHT40`. The change has not yet been committed or reloaded, so runtime radio state remains unchanged at this point. This is a diagnostic test for the 5 GHz AP issue. No reload yet.

SYNC 2026-09-19: STAGE 6: `uci commit wireless` completed with empty output, indicating the VHT40 configuration was committed successfully. No Wi-Fi reload has been performed yet; runtime state remains unchanged until the next controlled apply step.

SYNC 2026-09-19: STAGE 6: `wifi reload` completed with empty output after committing VHT40. This means the reload command itself returned no textual error; runtime verification is still required. Next check will verify STA association and AP kernel state. No further configuration change.

SYNC 2026-09-19: STAGE 6: after applying VHT40, 5 GHz STA remains connected to SweetHomeU at 5180 MHz with 40 MHz width, signal -29 dBm, RX 200 Mbit/s VHT-MCS9 and TX 180 Mbit/s VHT-MCS8. Crucially, `phy0-ap0` is now `<BROADCAST,MULTICAST,UP,LOWER_UP>` with `state UP`; the OpenWrt-5G SSID became visible to the client. This is strong evidence that VHT80 was involved in the failure condition, while VHT40 currently provides a working STA+AP state. No further configuration change.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-ap0 station dump` confirms a real client is associated to the 5 GHz AP: authorized/associated yes, signal -37 dBm, TX 180 Mbit/s VHT-MCS8 40MHz, RX 200 Mbit/s VHT-MCS9 40MHz, tx failed 0, connected 74 s. VHT40 therefore provides a functioning 5 GHz STA+AP path with an active client. User supplied external claims about 64 MB RAM/OOM, peer-stats disabling via `skip_inactivity_poll`, and replacing firmware with CT were reviewed against established project state: CT firmware is already installed (`ath10k-firmware-qca9887-ct`), and current logs do not show an OOM kill or hostapd crash. The `-122` peer-stats message alone does not establish RAM exhaustion or causality. No unverified workaround was applied.

SYNC 2026-09-19: STAGE 6: memory/OOM check after VHT40 operation: RAM total 54852 kB, used 31400 kB, free 14936 kB, buff/cache 8516 kB, available 6856 kB; swap total 524284 kB, used 4416 kB. `dmesg` search for OOM/out-of-memory/oom-kill/oom_reaper/killed process returned no lines. Therefore there is no evidence of a kernel OOM event causing the prior VHT80 AP failure. The VHT40 working state remains confirmed; the cause of the VHT80 failure is not yet proven to be RAM exhaustion.

SYNC 2026-09-19: STAGE 6: VHT40 runtime log now reveals an ath10k-ct kernel WARNING at `mac.c:9941` with a stack trace, followed by the recurring peer-stats `-122`. Despite the warning, `phy0-ap0` entered forwarding at 6418 and again at 6528, confirming AP startup under VHT40. The AP later entered disabled state at 6506, then was brought up again at 6528. This is the first concrete kernel warning in the evidence and warrants inspection of the surrounding log lines before attributing the failure to VHT80, RAM, or peer stats. No configuration change.

SYNC 2026-09-19: STAGE 6: `/proc/kallsyms` is unavailable on this OpenWrt build (`No such file or directory`), so runtime address-to-symbol resolution via kallsyms cannot be used. No configuration change.

SYNC 2026-09-19: STAGE 6: no System.map/Module.symvers files were found. User supplied hypotheses about the ath10k-ct warning and proposed disabling 802.11w or replacing CT with upstream. We do not treat the asserted warning semantics, hostapd causality, or RAM explanation as established: current evidence only proves an ath10k-ct warning at mac.c:9916/9941, recurring peer-stats -122, and a working VHT40 AP. Existing generated hostapd config already showed `ieee80211w=0`, and the STA/AP test uses WPA2-PSK, so changing MFP blindly is not justified. Firmware replacement is also not justified and would be higher-risk. No configuration change.

SYNC 2026-09-19: STAGE 6: `uci show wireless | grep -A12 -B2 "OpenWrt-5G"` confirms the 5 GHz AP `wireless.default_radio0` is on LAN, mode AP, SSID `OpenWrt-5G`, enabled, but its encryption is currently explicitly `none`. This is consistent with the client association test but means the diagnostic 5 GHz AP is currently open/unsecured. The output did not include the STA section because the grep context ended before it; no configuration change was made in this step.

SYNC 2026-09-19: STAGE 6: `uci show wireless | grep -A8 -B2 "wireless.@wifi-iface"` confirms the third wifi-iface is the 5 GHz STA on `radio0`, network `wan`, mode `sta`, SSID `SweetHomeU`, encryption `psk2`, enabled. Its key is present in UCI output; no value is copied into the master documents. Together with the previous result, the 5 GHz radio0 is configured for concurrent STA + open AP `OpenWrt-5G`; no configuration change was made.

SYNC 2026-09-19: STAGE 6: `ubus call hostapd.phy0-ap0 get_status` confirms the 5 GHz AP is actually ENABLED via nl80211 on phy0, BSSID `ba:69:f4:d6:e8:a5`, SSID `OpenWrt-5G`, 5180 MHz/channel 36, with DFS CAC inactive. Reported airtime utilization is 6%. No configuration change was made.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-sta0 link` PASS. The 5 GHz STA is connected to `SweetHomeU` at 5180 MHz with signal -29 dBm; RX 200.0 Mbit/s and TX 180.0 Mbit/s, both VHT40, NSS1. This confirms the upstream STA remains operational concurrently with the verified `OpenWrt-5G` AP on the same phy0. No configuration change was made.

SYNC 2026-09-19: STAGE 6: `iw dev phy0-ap0 station dump` PASS. Client `f6:b6:58:3f:b7:fe` is authorized/authenticated/associated on `phy0-ap0`; signal -33 dBm (avg -38 dBm); TX 180.0 Mbit/s VHT-MCS8 40MHz and RX 200.0 Mbit/s VHT-MCS9 40MHz; tx failed 0, rx drop misc 0; connected time 654 s. This confirms stable 5 GHz AP client association and traffic at VHT40. MFP is `no`, consistent with the AP's current open diagnostic network. No configuration change was made.

SYNC 2026-09-19: STAGE 6: dmesg check shows no OOM/out-of-memory/killed-process messages. It does show the known ath10k-ct warnings at mac.c:9916/9941 and peer-stats `-122`, plus normal bridge/AP state transitions. The AP re-entered forwarding state at 6528.440292. Current evidence still does not establish RAM/OOM causality; VHT40 remains operational. No configuration change was made.

SYNC 2026-09-19: STAGE 6: dmesg context materially narrows the timing of the ath10k-ct warnings. Immediately before mac.c:9916/9941, `phy0-sta0` authenticates/associates to SweetHomeU and logs `AP ... changed bandwidth in assoc response, new used config is 5180.000 MHz, width 2 (5190.000/0 MHz)`. The warnings occur ~12 ms later, followed by `pdev param 0 not supported by firmware`, peer-stats `-122`, then `phy0-sta0: associated`. No OOM event is present. The AP later enters forwarding. Because the trace is from ath10k-ct-smallbuffers and occurs during STA association/bandwidth configuration, this is a stronger correlation with bandwidth negotiation than the previous evidence, but it does not yet prove causality or identify the exact source-level assertion. No configuration change was made.

SYNC 2026-09-19: STAGE 6: `iw phy phy0 info | grep -A25 -B5 "VHT Capabilities"` confirms phy0 VHT capabilities: 1 spatial stream, MCS 0-9, no 160/80+80 support, while short GI 80 MHz capability is advertised. Crucially, `Supported Channel Width: neither 160 nor 80+80` does not mean VHT80 is unsupported; the output does not list an 80 MHz channel-width capability in that line. Current VHT40 operation remains verified. No configuration change was made.

SYNC 2026-09-19: STAGE 6: Current VHT40 consistency check PASS. UCI reports `wireless.radio0.htmode=VHT40`; `phy0-sta0` is connected to SweetHomeU at 5180 MHz, signal -31 dBm, RX 200.0 Mbit/s VHT-MCS9 40MHz, TX 180.0 Mbit/s VHT-MCS8 40MHz; hostapd.phy0-ap0 reports ENABLED, SSID OpenWrt-5G, channel 36, freq 5180, DFS inactive. No configuration change was made.

SYNC 2026-09-19: User explicitly confirms VHT80 is not required. Requirement for STAGE 6 is VHT40 as the intended stable 5 GHz mode; ISP Internet speed is <=100 Mbit/s. Current VHT40 STA+AP operation is verified and stable in measured checks. VHT80 investigation is therefore not required for the project goal. No configuration change made.

SYNC 2026-09-19: User confirms target LAN Wi-Fi design is one logical home WLAN across 2.4 GHz and 5 GHz APs, with temporary password `12345678` for the OpenWrt APs. Current UCI confirms 5 GHz AP `OpenWrt-5G` and 2.4 GHz AP `OpenWrt` are separate SSIDs and both currently open (`encryption='none'`); 5 GHz STA remains on `SweetHomeU`, VHT40. No configuration change made in this step.

SYNC 2026-09-19: 5 GHz AP UCI change command completed with empty output, indicating no command error: `wireless.default_radio0.ssid` set to `OpenWrt`, `encryption` set to `psk2`, key set to temporary `12345678`, and `uci commit wireless` completed. No `wifi reload` performed yet. Next step is read-only UCI verification before applying the change.

SYNC 2026-09-19: Read-only verification passed for `wireless.default_radio0`: device radio0, network lan, mode ap, SSID OpenWrt, encryption psk2, disabled 0, temporary key 12345678. Configuration is committed but not yet applied with `wifi reload`.

SYNC 2026-09-19: `wifi reload` completed with empty output. User reports one visible SSID `OpenWrt`, but it appears without a password. This does not yet establish whether the open 2.4 GHz AP is masking the secured 5 GHz AP; current UCI previously showed 2.4 GHz `default_radio1` still `encryption='none'`, while 5 GHz `default_radio0` was set to WPA2. Next step is read-only verification of both AP interface configurations before any further change.

SYNC 2026-09-19: Read-only verification confirms the cause of the observed open SSID: 5 GHz `default_radio0` is `OpenWrt` with `psk2` and temporary key `12345678`; 2.4 GHz `default_radio1` is also `OpenWrt` but still `encryption='none'`. No change made in this verification step. Next step: set 2.4 GHz AP to the same WPA2/password configuration, then verify before reload.

SYNC 2026-09-19: User executed the 2.4 GHz WPA2 configuration command successfully (empty output). User reports the 5 GHz `OpenWrt` network is not visible to the client. No further Wi-Fi changes made yet. Next diagnostic step is read-only runtime status to determine whether the 5 GHz AP is actually enabled/running after `wifi reload`.

SYNC 2026-09-19: `iw dev` confirms phy0 has `phy0-ap0` type AP but it has no SSID/channel/width shown, while phy0-sta0 is associated on channel 36 at VHT40. 2.4 GHz `phy1-ap0` is active on channel 1 with SSID OpenWrt. This indicates the 5 GHz AP interface exists but is not fully configured/running as an active beaconing AP. Next step is read-only log inspection for hostapd/phy0 startup errors.

SYNC 2026-09-19: Log inspection shows phy0-ap0 previously reached `AP-ENABLED` and accepted a client, so the 5 GHz AP can operate. After the latest reload at 07:39, phy0-ap0 was disconnected/disabled and netifd reported link down; no subsequent `AP-ENABLED` for phy0-ap0 appears in the supplied log excerpt. The ath10k warnings (`pdev param 0 not supported by firmware`, peer stats -122) are present but were also seen during earlier working operation, so they are not yet established as the immediate cause. Next step is a read-only tail of the current log to capture the post-reload failure details.

SYNC 2026-09-19: `logread | tail -60` identifies a concrete runtime failure at 07:38:59: `netifd: radio0 ... wifi-scripts: command failed: Not supported (-122)`. After that phy0-ap0 was taken down and never logged `AP-ENABLED`; phy0-sta0 remained part of radio0 preparation. Earlier `AP-ENABLED` and client association prove the AP can work. The ath10k firmware warning is therefore relevant, but the immediate observed failure is the wifi-scripts `-122` during radio0 reload. No configuration change made in this diagnostic step.

SYNC 2026-09-19: `wifi status radio0` confirms radio0 is logically up, not disabled, and both interfaces are configured: `phy0-ap0` AP on lan with SSID OpenWrt/WPA2 and `phy0-sta0` STA on wan to SweetHomeU. However the status shows no stations and does not expose an active AP channel/operational state. This supports that the UCI configuration itself is present; the remaining issue is runtime activation of phy0-ap0 after reload. No configuration change made.

SYNC 2026-09-19: Corrected runtime interpretation: `ubus call hostapd.phy0-ap0 get_status` now returns `status: ENABLED`, SSID `OpenWrt`, BSSID `ba:69:f4:d6:e8:a5`, freq 5180 MHz, channel 36, DFS inactive. Thus the 5 GHz AP is currently active and configured at the same channel as the STA. The previously supplied claim that -122 occurs in 100% of cases on 64 MB devices and that `wpad-mesh-openssl` is required is not established and must not be treated as project fact. No package changes made.

SYNC 2026-09-19: `iw dev` read-only verification after hostapd ENABLED check: 2.4 GHz `phy1-ap0` is active as AP with SSID `OpenWrt`, channel 1 / 2412 MHz, HT20. 5 GHz `phy0-ap0` is type AP with BSSID ba:69:f4:d6:e8:a5 and txpower 23 dBm, but `iw dev` still does not expose SSID/channel/width for `phy0-ap0`; concurrently `phy0-sta0` is connected/operational on channel 36 / 5180 MHz, VHT40, center 5190 MHz. Thus hostapd reports the 5 GHz AP ENABLED, but kernel `iw dev` still does not show the AP operating channel/SSID. No configuration change was made. STAGE 6 remains IN_PROGRESS. Next step: one read-only runtime check only; do not reload Wi-Fi or change configuration yet.

SYNC 2026-09-19: `iw dev phy0-ap0 info` PASS for interface existence only: phy0-ap0 exists, type AP, wiphy 0, BSSID ba:69:f4:d6:e8:a5, txpower 23 dBm, but kernel still exposes no SSID, channel, width, or center frequency. This confirms the previously observed hostapd-vs-kernel discrepancy more directly. No configuration or Wi-Fi runtime change was made. STAGE 6 remains IN_PROGRESS. Next step: one read-only check of `ip link show phy0-ap0` to determine kernel carrier/operational state; no reload or configuration change.

SYNC 2026-09-19: `ip link show phy0-ap0` confirms `phy0-ap0` is administratively UP but `NO-CARRIER` and `state DOWN`, bridged to `br-lan`; permanent MAC b8:69:f4:d6:e8:a5 and runtime BSSID ba:69:f4:d6:e8:a5. This confirms the 5 GHz AP interface is not operational at kernel link level despite prior hostapd `ENABLED`. User proposed `uci set wireless.default_radio0.network='lan'` and `wifi down && wifi up`; these are not applied because `network='lan'` is already the current configuration and the proposed commands would not correct the identified kernel NO-CARRIER state. The claim that STA must necessarily be started before AP, or that lack of `ssid`/`channel` proves a hardware/mac80211 block, is not established by current evidence. No runtime/configuration change made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Detailed `logread` confirms the 5 GHz AP has previously reached real operational state: at 06:17:08 and 06:22:18 `phy0-ap0` link went up; at 07:08:37 hostapd reports `UNINITIALIZED->ENABLED` / `AP-ENABLED`, bridge forwarding and netifd link up followed; at 07:10:52 and 07:14:37 real clients authenticated/associated to `phy0-ap0`. At 07:38:59 a subsequent radio0 `wifi-scripts` start again fails with `command failed: Not supported (-122)`, followed by hostapd reload, client disconnect, and `phy0-ap0` link down. At 07:39:04 wifi-scripts prepares both AP and STA again. This proves concurrent 5 GHz STA+AP is supported and has actually worked; the current NO-CARRIER state is not a permanent hardware prohibition. The recurring `-122` is temporally associated with radio0 startup/reload, but its exact root cause is not established. No configuration change was made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Focused log window around 07:38:59 confirms the sequence precisely: hostapd reloads all interfaces and reloads phy0/phy1 settings; immediately after, netifd `radio0` starts and `wifi-scripts` returns `command failed: Not supported (-122)`; wpa_supplicant then applies a new phy0 config; hostapd reloads the phy0 AP BSS; the existing 5 GHz AP client is disconnected; `phy0-ap0` link goes down; netifd subsequently prepares both `phy0-ap0` and `phy0-sta0`. The excerpt does not identify which underlying operation inside wifi-scripts returned -122. Therefore -122 is confirmed at the radio0 startup/reload boundary, but exact failing operation remains unresolved. No configuration change made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Source inspection of mac80211.sh confirms the observed radio0 log line is generated by the generic mac80211 radio configuration path; it explicitly runs `iw phy ... set antenna`, `set distance`, and `set txpower`. The grep did not establish that `disassoc_low_ack` causes the radio reload or -122; that option belongs to hostapd BSS configuration. Forum suggestion to change disassoc_low_ack or disable mwan3 is therefore not accepted as a fix without evidence. No configuration change made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Background-trigger check completed. `crontab -l` produced no entries; `/etc/init.d/mwan3 status` produced no output and no mwan3 init script is present; `/etc/init.d/` contains `pbr`. Therefore no evidence of cron or mwan3 causing the 07:38:59 Wi-Fi reload. pbr is installed/present, but its status was not checked in this step and causality is not established. No configuration change. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Direct `iw` test completed without reload: `iw phy phy0 set distance 0` returned rc=0 and `iw phy phy0 set distance 10` returned rc=0. Therefore `distance=0` is not itself rejected by the driver in the current state, and the forum hypothesis that the -122 is caused simply by `set distance 0` is not supported. No UCI change made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: pbr status checked. pbr 1.2.2-r20 is installed and its status output is functional; uplink is wan/phy0-sta0/192.168.0.1. It reports no pbr policy chains, marking chains, or nft sets, and only the normal main IPv4 route/rule is present. `pgrep -af pbr` returned no process line. This provides no evidence that pbr is currently generating the 07:38:59 Wi-Fi reload. No pbr changes. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Attempted time-window extraction with `logread | sed -n '/07:38:40/,/07:39:10/p'`; user reports empty output. This does not provide new evidence about the Wi-Fi failure and does not alter STAGE 6 conclusions. No configuration change.

SYNC 2026-09-19: Full timestamp grep confirms the 07:38:59 sequence and adds an important observation: the reload begins with `hostapd: Set MLD config: [ ]`, `hostapd: Reload all interfaces`, and `wpa_supplicant: Set MLD config: [ ]`; the same MLD/reload pattern is also documented in multiple OpenWrt 25.12 issue logs on unrelated hardware, so these lines alone do not identify the initiator or prove an MLO/MLD configuration fault. The actual radio0 failure still follows immediately at `wifi-scripts: Starting` with `Not supported (-122)`. No configuration change. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: New evidence from repeated `Reload all interfaces` history and pbr source grep. The Wi-Fi reload pattern is recurring (07:37:31 Sep 17, 06:01:20/06:17:01/06:25:50/07:08:13/07:38:59 Sep 19) and each relevant radio0 occurrence is followed by `wifi-scripts ... command failed: Not supported (-122)`. pbr source contains interface-reload triggers and can reload network/firewall, but the grep found no direct `wifi`, `hostapd`, or `wpa_supplicant` invocation in the relevant pbr code; pbr status also shows no active policies. Therefore pbr remains not proven as the initiator of hostapd `Reload all interfaces`. The new logs show the event predates wifi-scripts and is not explained by distance. No configuration change. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: User reports the read-only search command `grep -RniE 'Reload all interfaces|reload_all|reload.*interface|hostapd.*reload|ubus.*hostapd' /etc /usr/lib /lib 2>/dev/null | head -100` appears to hang. No output was supplied, so this command produced no verified evidence and must not be treated as a completed diagnostic. User supplied a hypothesis that `https-dns-proxy` causes the Wi-Fi reloads based on temporal log correlation (`Setting trigger (on_boot)` → `hostapd: Reload all interfaces` → service start/update notrack/wan trigger). This hypothesis is NOT yet proven as causal. Do not remove `/etc/hotplug.d/iface/95-https-dns-proxy`, set undocumented UCI options, or restart `https-dns-proxy` until the actual installed configuration/hotplug files are read-only inspected. STAGE 6 remains IN_PROGRESS. NEXT: run exactly one safe read-only command to inspect `https-dns-proxy` UCI configuration; do not reload Wi-Fi or DNS.

SYNC 2026-09-19: Read-only recursive grep completed successfully (previously appeared hung). New evidence: `/etc/init.d/https-dns-proxy` contains `procd_add_raw_trigger "interface.*.up" 5000 ... reload 'on_interface_up'` and `procd_add_interface_trigger "interface.*" "$i" ... reload 'on_interface_trigger'`; the same lines are present via `/etc/rc.d/S20https-dns-proxy`. This proves https-dns-proxy registers interface-triggered service reloads. It does NOT yet prove that https-dns-proxy itself invokes `hostapd: Reload all interfaces`; the grep found no direct `hostapd reload` or `ubus.*hostapd` call in https-dns-proxy. pbr also has interface-reload handling, but prior evidence shows no active pbr policies and no direct wifi/hostapd invocation. STAGE 6 remains IN_PROGRESS. NEXT: inspect only the exact https-dns-proxy trigger code around lines 440–475, read-only, to determine which interfaces/options receive those triggers. No configuration/service/Wi-Fi change performed.

SYNC 2026-09-19: Read-only `uci show https-dns-proxy` and `sed -n '440,475p' /etc/init.d/https-dns-proxy` completed. Confirmed config: `force_dns=1`, `notrack_dns=1`, `force_dns_src_interface='lan'`, `procd_trigger_wan6='0'`, two DoH instances (Cloudflare 5053 and Google 5054). The service trigger code confirms: on boot it can register `interface.*.up` as a raw trigger; otherwise it resolves the configured WAN via `network_find_wan` (currently expected to be `wan`) and registers `interface.*` trigger for that WAN; WAN6 trigger is disabled by `procd_trigger_wan6=0`; it also registers a config-change trigger for its own UCI config. This proves https-dns-proxy is designed to reload itself when the WAN interface changes. It still does NOT prove that this self-reload directly causes `hostapd: Reload all interfaces`; no direct hostapd/ubus call is present in the inspected trigger function. No configuration or service state was changed. STAGE 6 remains IN_PROGRESS. NEXT: inspect the exact `on_interface_trigger` handler in the same script, read-only, to see what the https-dns-proxy reload actually does when `wan` changes. Do not restart or modify https-dns-proxy yet.

SYNC 2026-09-19: Read-only `grep -nE 'on_interface_trigger|on_interface_up' /etc/init.d/https-dns-proxy` completed. Only the trigger registrations at lines 457 and 469 were found; no handler function definitions named `on_interface_trigger` or `on_interface_up` were found in `/etc/init.d/https-dns-proxy`. Therefore the trigger callback names are not defined in this script and must be resolved through the procd/service framework or related package code. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS. NEXT: inspect the exact procd helper implementation for `procd_add_interface_trigger` and how it invokes the callback on reload, read-only; do not restart services or reload Wi-Fi.

SYNC 2026-09-19: User-side read-only checks confirmed: no `on_interface_up()` or `on_interface_trigger()` definitions were found in `/etc/init.d/https-dns-proxy`; an attempted alternate `sed` path failed because the path was invalid, and `cat -n` failed because BusyBox `cat` does not support `-n`. The requested `/lib/functions/procd.sh` range 680–715 only showed the `_procd_wrapper` export list, including `procd_add_interface_trigger`; it did not show the function implementation. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS. NEXT: locate the actual `procd_add_interface_trigger()` implementation read-only with `grep -n 'procd_add_interface_trigger' /lib/functions/procd.sh`. Avoid reloads/restarts.

SYNC 2026-09-19: User supplied additional read-only evidence from `/etc/init.d/https-dns-proxy`: `dnsmasq_restart()` is defined as `/etc/init.d/dnsmasq restart`; `start_service()` calls it only for `on_boot|on_config_update|on_hotplug`. User also located the actual procd interface-trigger implementation at `/lib/functions/procd.sh:281` (`_procd_add_interface_trigger`) and wrapper at line 692. A forum hypothesis claims this proves WAN/Wi-Fi hotplug invokes `start_service` with `on_hotplug`, then dnsmasq restart causes hostapd reload and ath10k -122, and proposes replacing dnsmasq restart with reload. This causal chain is NOT established by the supplied evidence: the https-dns-proxy trigger previously inspected passes callback parameter `on_interface_trigger`, not `on_hotplug`; `start_service`'s `on_hotplug` branch therefore cannot yet be attributed to that WAN trigger. The claimed dnsmasq→netifd→hostapd reload chain is also unverified. No modification was made. STAGE 6 remains IN_PROGRESS. NEXT: inspect `/lib/functions/procd.sh` lines 270–315 read-only to establish exactly what `_procd_add_interface_trigger` invokes and with which callback/arguments. Do NOT apply the forum sed workaround or restart services yet.

SYNC 2026-09-19: Read-only inspection of `/lib/functions/procd.sh` lines 270–315 completed. `_procd_add_interface_trigger()` constructs a procd trigger that matches an interface event (`interface.*`) for the specified interface and executes `run_script` with the exact arguments supplied by the caller. `_procd_add_reload_interface_trigger()` separately hard-codes `/etc/init.d/$name reload`. This confirms that https-dns-proxy's earlier registration `procd_add_interface_trigger ... /etc/init.d/${packageName} reload 'on_interface_trigger'` executes the https-dns-proxy init script with arguments `reload on_interface_trigger` when the WAN interface trigger fires. It does NOT show `on_hotplug`; therefore the forum claim that this WAN trigger enters `start_service()` with `on_hotplug` is not established and conflicts with the observed registration. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS. NEXT: inspect the rc.common/procd dispatch path that handles `/etc/init.d/https-dns-proxy reload on_interface_trigger`, read-only, to determine which service callback receives `on_interface_trigger`. Do not apply the forum workaround.

SYNC 2026-09-19: Read-only grep of `/etc/rc.common` confirmed reload dispatch locations: `start_service()` line 91, `stop_service()` line 95, generic `reload` extra command line 114, `rc_procd start_service "$@"` line 138, and reload handling around lines 166–168 where `reload_service "$@"` is called if that function exists. This establishes that the next step must inspect the exact rc.common reload block around lines 150–175 to determine whether https-dns-proxy's `reload on_interface_trigger` invokes `reload_service` or falls back to start/stop behavior. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: User asked whether https-dns-proxy can simply be removed in favor of WireGuard. `rc.common` reload logic was confirmed: if `reload_service()` exists it is called with the supplied arguments; otherwise `reload()` falls back to `start()`. This means the observed `reload on_interface_trigger` does not enter `start_service()` directly unless no `reload_service()` exists. No package/service/configuration changes were made. Architectural clarification: WireGuard is a VPN transport/tunnel, not itself a DoH resolver; it can carry DNS traffic or use a VPN-provided DNS server, but replacing https-dns-proxy with WireGuard would change the DNS architecture rather than provide an equivalent DoH service automatically. Before any removal, dependency/configuration impact must be checked and the replacement DNS path must be defined. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: User explicitly decided to keep https-dns-proxy and repair the current setup rather than remove it. `rc.common` reload behavior was confirmed: `reload()` calls `reload_service "$@"` if `reload_service()` exists; otherwise it calls `start`. The next diagnostic target is therefore whether `/etc/init.d/https-dns-proxy` defines `reload_service()`, and what it does. No configuration or service changes were made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: `grep -nE '^reload_service\(\)|reload_service' /etc/init.d/https-dns-proxy` returned empty output. Therefore `/etc/init.d/https-dns-proxy` does NOT define `reload_service()`. Under `/etc/rc.common`, `reload()` consequently falls back to `start()`. With the previously verified procd trigger command `... /etc/init.d/https-dns-proxy reload on_interface_trigger`, a WAN trigger therefore invokes `start_service` via the generic `start` path, with argument propagation to be verified next. This materially strengthens the causal path to `start_service()` but does not yet prove that `on_interface_trigger` becomes `on_hotplug`, nor that dnsmasq restart causes hostapd reload. No configuration/service change performed. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Read-only inspection of `/etc/rc.common` lines 120–145 confirms `start()` calls `rc_procd start_service "$@"`, and `rc_procd` invokes the supplied function with the original arguments. Combined with the prior findings (`reload_service()` absent and procd trigger command `/etc/init.d/https-dns-proxy reload on_interface_trigger`), the exact argument flow is now established: WAN trigger → init script `reload on_interface_trigger` → `reload()` fallback to `start` → `rc_procd start_service on_interface_trigger`. Therefore the forum claim that this path invokes `start_service` with `on_hotplug` is disproven. Since `start_service()` only restarts dnsmasq for `on_boot|on_config_update|on_hotplug`, the WAN-triggered `on_interface_trigger` path does NOT enter that dnsmasq restart case. The previously suspected https-dns-proxy→dnsmasq-restart→hostapd chain is therefore not supported by this trigger path. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: New `logread | grep -B 5 -A 5 "Reload all interfaces" | tail -80` evidence reviewed. At 07:06:53 firewall logs `ifup of wan (phy0-sta0)`, then https-dns-proxy starts at 07:06:56 and sets its WAN trigger; nevertheless `hostapd: Reload all interfaces` occurs later at 07:08:13, followed by radio0 `wifi-scripts: Starting` and `-122`. At 07:38:59 the same hostapd reload occurs with no https-dns-proxy message in the immediately preceding lines. At 06:01:20 a hostapd reload starts radio1 successfully; at 06:17:01 and 06:25:50 hostapd reloads precede radio0 failure. At 06:22:28–29 https-dns-proxy starts and sets its WAN trigger, but there is no hostapd reload immediately in that event window. This further weakens the hypothesis that https-dns-proxy directly initiates the hostapd reload. No configuration/service/Wi-Fi change performed. STAGE 6 remains IN_PROGRESS. NEXT: inspect the complete log window around one reproducible reload (07:38:45–07:39:10) for netifd/hostapd/wpa_supplicant/firewall/https-dns-proxy events, read-only, to identify the initiator immediately before `Reload all interfaces`.

SYNC 2026-09-19: The requested `logread | sed -n '/07:38:45/,/07:39:10/p'` returned empty output because the busybox/log timestamp context did not match that sed range. Separately, the user reports a new real-world state change: while investigating, the 5 GHz `OpenWrt` SSID appeared again and is visible with the configured password. This is an observed recovery of the 5 GHz AP without a configuration change in this step. It does not yet prove the root cause or permanent stability. STAGE 6 remains IN_PROGRESS. Preserve current configuration; next diagnostic should verify the live 5 GHz AP state with read-only `iw`/hostapd status rather than triggering a reload.

SYNC 2026-09-19: Verified live 5 GHz AP after spontaneous recovery. `iw dev phy0-ap0 info` reports interface phy0-ap0, SSID `OpenWrt`, type AP, channel 36 (5180 MHz), width 40 MHz, center1 5190 MHz, txpower 23.00 dBm. Multicast TXQ is active (2447 flows/packets, 565805 TX bytes). This confirms the 5 GHz AP is currently operational at the intended VHT40 configuration. No configuration change or reload was performed. STAGE 6 remains IN_PROGRESS pending stability/root-cause work.
