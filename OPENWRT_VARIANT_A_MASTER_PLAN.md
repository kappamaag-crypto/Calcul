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
