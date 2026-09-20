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
STAGE 11 — IN_PROGRESS
STAGE 12–30 — NOT_STARTED

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
- [CHANGED] STAGE 4 remains IN_PROGRESS. The clean-base criterion requiring the old `/dev/sda2` to be inactive is not yet satisfied.- [SAFETY] No unmount, formatting, repartitioning, fstab modification, package installation, or other state-changing operation was performed.
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
SYNC 2026-09-19: Pre-extroot overlay baseline PASS. `/overlay` is internal `/dev/mtdblock9`, jffs2, rw,noatime; size 7.0M, used 372K, available 6.6M. `du -sh /overlay` = 35.5K. USB extroot is not mounted yet. Next step is controlled copy of overlay to sda2.SYNC 2026-09-19: sda2 temporary mount PASS: `mount /dev/sda2 /mnt/extroot` completed with empty output. No fstab/extroot activation change yet.

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

SYNC 2026-09-19: User requested continuation after live verification of the recovered 5 GHz AP. No configuration change was made. Next action is a single passive read-only check of both 5 GHz STA and AP interfaces to verify simultaneous operation; do not reload/restart Wi-Fi.

SYNC 2026-09-19: Passive `iw dev` check confirms simultaneous 5 GHz AP + STA operation. phy0 has `phy0-ap0` SSID OpenWrt, AP, channel 36/5180 MHz, width 40 MHz, center1 5190 MHz, txpower 23 dBm, with active TXQ; and `phy0-sta0` type managed on the same channel 36/5180 MHz, width 40 MHz. phy1 2.4 GHz AP is also active on channel 1/2412 MHz HT20. This directly confirms the intended concurrent 5 GHz STA+AP state is currently operational. No reload/restart/config change was performed. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Passive `iw dev phy0-sta0 link` confirms the 5 GHz STA is connected to `SweetHomeU` BSSID d8:0d:17:e0:73:a8 at 5180 MHz, signal -26 dBm, RX 200.0 Mbit/s VHT-MCS9 40MHz short GI NSS1, TX 180.0 Mbit/s VHT-MCS8 40MHz short GI NSS1. RX/TX counters are active. Combined with the preceding `iw dev` result, concurrent 5 GHz STA+AP VHT40 operation is fully confirmed at this moment. No configuration/reload was performed. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: New read-only log evidence. `hostapd: Reload all interfaces` is followed by `netifd: radio0 ... wifi-scripts: Starting`; at 07:08:15 the 5 GHz AP explicitly reports `AP-DISABLED`, then at 07:08:37 `AP-ENABLED`. At 07:38:59 another hostapd reload is followed by radio0 wifi-scripts, but the supplied tail ends during interface preparation and does not show the eventual AP state. ath10k warnings include `pdev param 0 not supported by firmware` and `failed to enable peer stats info: -122`; additionally kernel WARN stack traces occur at 07:06:47 in ath10k-ct mac.c lines 9916 and 9941, followed by the same -122 peer-stats warning. This strengthens that radio0 reload/start is the immediate operational boundary around AP disruption, while the initiator of `Reload all interfaces` is still unidentified. No configuration/reload was performed by the user during this diagnostic command. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Exact 07:38:59–07:39:04 log window captured. At 07:38:59 hostapd performs `Reload all interfaces`; immediately the radio0 wifi-scripts starts and reports `command failed: Not supported (-122)`. Then hostapd reloads phy0/BSS, the existing 5 GHz client is disconnected at 07:39:02, `phy0-ap0` enters disabled state and link goes down at 07:39:03, and radio0 prepares both AP and STA interfaces at 07:39:04. This confirms the visible AP outage is a consequence of the radio0 reload sequence and -122 occurs at its start. The log still does not identify the upstream initiator of `hostapd: Reload all interfaces`; no config change was made. STAGE 6 remains IN_PROGRESS.

SYNC 2026-09-19: Real client test passed. User connected a phone to the 5 GHz `OpenWrt` AP and confirmed internet access. Station dump shows one authorized/associated client, signal about -41 dBm (average -44 dBm), TX 180.0 Mbit/s VHT-MCS8 40MHz short GI NSS1, RX 200.0 Mbit/s VHT-MCS9 40MHz short GI NSS1, tx retries 2, tx failed 0, expected throughput 157.281 Mbps, connected time about 99 s. This is direct proof that the recovered 5 GHz AP is serving a real client with working Internet at the intended VHT40 mode. No configuration/reload was performed. STAGE 6 remains IN_PROGRESS.


SYNC 2026-09-19: Продолжение STAGE 6. После успешного реального 5 GHz client test конфигурация не меняется. Следующий шаг — один read-only targeted search по /etc/hotplug.d, /etc/init.d, /lib/netifd, /lib/wifi и /usr/libexec для прямых вызовов wifi reload/up/down, hostapd reload/config_set или hostapd_cli reload. Цель — найти возможного инициатора `hostapd: Reload all interfaces`. Широкий рекурсивный поиск не используется; Wi-Fi/DNS/services не перезапускаются.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 6: подробная фиксация после реального 5 GHz client test

### Фактически подтверждено
- STAGE 6 остаётся IN_PROGRESS.
- 5 GHz VHT80 больше не является целью: пользователь подтвердил, что интернет-канал ограничен примерно 100 Мбит/с и VHT40 выбран как требуемый рабочий режим из соображений стабильности.
- 5 GHz STA и AP одновременно работают на radio0 в VHT40: STA phy0-sta0 подключён к SweetHomeU на 5180 MHz, channel 36, width 40 MHz; AP phy0-ap0 вещает OpenWrt на 5180 MHz, channel 36, width 40 MHz, center1 5190 MHz; AP txpower 23 dBm.
- Реальный клиентский тест пройден: телефон подключился к OpenWrt 5 GHz и получил Internet.
- iw dev phy0-ap0 station dump подтвердил реального ассоциированного/авторизованного клиента; зафиксированы рабочие TX/RX rates 180/200 Mbit/s VHT40, tx retries 2, tx failed 0, expected throughput около 157 Mbit/s. MAC клиента в мастер-файлы не записывается.- Это подтверждает, что одновременная 5 GHz STA+AP работа на данном оборудовании возможна и сейчас функционирует.

### Что НЕ подтверждено и не менять
- Не доказано, что https-dns-proxy является инициатором hostapd: Reload all interfaces.
- Не доказано, что pbr инициирует этот reload.
- Не доказано, что MLD-сообщения являются причиной reload.
- Не доказано, что distance=0 вызывает -122; прямой iw phy phy0 set distance 0 вернул rc=0.
- Не менять ieee80211w, network=lan, VHT40, pbr или https-dns-proxy без нового доказательства.
- Не удалять https-dns-proxy; пользователь выбрал ремонт текущей архитектуры.
- Не применять forum workaround с заменой dnsmasq restart на reload.

### Установленная цепочка https-dns-proxy
- https-dns-proxy регистрирует WAN interface trigger.
- Trigger вызывает /etc/init.d/https-dns-proxy reload on_interface_trigger.
- reload_service() в скрипте отсутствует, поэтому /etc/rc.common переводит reload в start.
- start() передаёт исходный аргумент on_interface_trigger в start_service().
- start_service() перезапускает dnsmasq только для on_boot|on_config_update|on_hotplug.
- Следовательно, WAN-triggered путь on_interface_trigger не соответствует on_hotplug и сам по себе не доказывает цепочку https-dns-proxy → dnsmasq restart → hostapd reload.

### Безопасность следующего шага
Следующий диагностический шаг — только read-only targeted search по /etc/hotplug.d, /etc/init.d, /lib/netifd, /lib/wifi, /usr/libexec на прямые вызовы wifi reload/up/down, hostapd reload/config_set, hostapd_cli reload. Не выполнять reload/restart Wi-Fi, hostapd, wpa_supplicant, dnsmasq или https-dns-proxy. Один command за шаг.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 6: pbr netifd path inspection
- [CONFIRMED] Read-only grep of /etc/init.d/pbr found a dedicated `netifd()` function at line 1546 and `netifd_enabled` configuration handling; `netifd` is also exposed as an extra init command.
- [CONFIRMED] The previously identified `/etc/init.d/network reload` at line 1768 is inside the pbr `netifd()` processing function, after UCI network commit and before firewall reload.
- [NOT_PROVEN] The presence of this pbr function does not establish that it is being invoked periodically or that it initiates the observed `hostapd: Reload all interfaces` event.
- [NOT_PROVEN] No causal link from pbr to the periodic Wi-Fi reload has been established.
- [NEXT] Continue read-only mapping of the pbr `netifd()` function's declaration/call path and conditions. Do not invoke `/etc/init.d/pbr netifd`, network reload, firewall reload, Wi-Fi reload, hostapd reload, dnsmasq restart, or https-dns-proxy restart.
- [RULE] User explicitly requires synchronization of the master plan after each user message + assistant message. This synchronization is now recorded as an operational requirement; the master prompt need not change because its existing one-step/synchronization rule already covers it.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 6: pbr on_interface_reload path found
- [PASS] Read-only grep of /etc/init.d/pbr located the complete named \`on_interface_reload\` command/path.
- [CONFIRMED] pbr registers \`on_interface_reload\` as an extra init command and defines \`on_interface_reload()\` at line 2869.
- [CONFIRMED] pbr contains interface-trigger registration at line 3128 using \`procd_add_interface_trigger "interface.*" "$n" "/etc/init.d/\${packageName}" on_interface_reload "$n"\`. Therefore pbr can receive interface-triggered callbacks independently of the previously inspected https-dns-proxy trigger.
- [CONFIRMED] The pbr path contains \`process_interface ... 'reload_interface'\` handling and gateway/interface state checks around lines 2914–2982.
- [NOT_PROVEN] This establishes that pbr has an interface-reload mechanism, but does not yet prove that the observed \`hostapd: Reload all interfaces\` event is caused by pbr or that this trigger fires for the relevant interface at the observed times.
- [NEXT] Read-only inspect the exact pbr code around lines 2869–2990 and the trigger registration around 3115–3135 to determine what pbr does when an interface reload trigger fires. Do not invoke pbr, network reload, firewall reload, Wi-Fi reload, hostapd reload, dnsmasq restart, or https-dns-proxy restart.
- [RULE] Per user requirement, this result and the next diagnostic step are synchronized into the master plan after this user/assistant turn pair.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 6: pbr on_interface_reload implementation inspected
- [PASS] Read-only \`sed -n '2869,2990p' /etc/init.d/pbr\` completed.
- [CONFIRMED] pbr \`on_interface_reload()\` calls \`rc_procd start_service 'on_interface_reload' "$1"\`; therefore an interface-triggered pbr callback enters pbr's \`start_service()\` with the interface argument.
- [CONFIRMED] For \`on_interface_reload\`, pbr reads the reloaded interface, validates its routing-table IDs, checks that the interface is supported, checks for errors/service state/gateway state, then executes \`process_interface 'all' 'reset_globals'\` and \`config_foreach process_interface 'interface' 'reload_interface' "$reloadedIface"\`.
- [CONFIRMED] This pbr path performs policy-routing/interface processing only. The inspected section contains no direct \`wifi\`, \`hostapd\`, \`hostapd_cli\`, \`wpa_supplicant\`, or Wi-Fi radio reload command.
- [NOT_PROVEN] pbr can still indirectly participate in a broader network reload chain, but the inspected \`on_interface_reload\` handler itself does not directly explain \`hostapd: Reload all interfaces\`.
- [NEXT] Inspect pbr's trigger-registration block around lines 3115–3135 read-only to determine exactly which interfaces are registered for \`on_interface_reload\` and under what conditions. Do not invoke pbr or reload network/Wi-Fi/services.

## CHANGELOG — 2026-09-19 — [SYNC] compact diagnostic output rule
- [RULE] Для минимизации объёма текста, передаваемого в ИИ, диагностические команды должны по возможности формировать компактный вывод: только строки/поля, необходимые для текущего доказательства.
- [RULE] Не использовать широкие `sed`/рекурсивные `grep`/полные дампы, если точечный вывод отвечает на текущий вопрос.
- [RULE] Сохраняется one-step-at-a-time: одна диагностическая команда за шаг, затем ожидание фактического результата.
- [SYNC] Это уточнение формата диагностики; архитектура и ограничения мастер-промта не меняются.

- [OBSERVED] 2026-09-19 STAGE 6: pbr registers `on_interface_reload` via `procd_add_interface_trigger "interface.*" "$n" ... on_interface_reload "$n"` for interfaces in `ifacesTriggers`; it also registers config-change triggers for pbr/network/openvpn.
- [CONCLUSION] This confirms pbr can react to netifd interface events, but the observed block alone does not prove it initiates hostapd/Wi-Fi reload. Next diagnostic must identify the actual contents/source of `ifacesTriggers`.

- [OBSERVED] 2026-09-19 STAGE 6: `ifacesTriggers` is initialized at line 178 and populated at line 2635; comments indicate it is built before `is_wan_up` during interface enumeration. Trigger registration occurs only when non-empty.
- [NEXT] Inspect the compact source around line 2635 to determine exactly which interfaces enter `ifacesTriggers`.

- [OBSERVED] 2026-09-19 STAGE 6: `enumerate_interface` is a process-interface action case at line 2626, invoked by `config_foreach process_interface 'interface' 'enumerate_interface'` at line 2897; no standalone function definition exists.
- [NEXT] Inspect the surrounding `process_interface` case before line 2626 to identify the interface eligibility conditions.

- [OBSERVED] 2026-09-19 STAGE 6: `pbr.config.supported_interface` is unset. netifd currently exposes only `lan`, `loopback`, `wan`, `wan6`.
- [CONCLUSION] pbr therefore falls back to its automatic `is_uplink/is_wan/is_tunnel` eligibility logic; the current output alone does not prove which interfaces are registered for reload triggers.

- [OBSERVED] 2026-09-19 STAGE 6: pbr loads `ipv6_enabled` from `pbr.config.ipv6_enabled` (default 0), `uplink_interface` default `wan`, `uplink_interface6` default `wan6`; then assigns `uplink_interface4="$uplink_interface"`.
- [NEXT] Read the current pbr UCI values compactly to establish the actual trigger candidates.

- [OBSERVED] 2026-09-19 STAGE 6: попытка получить `pbr.instances.main.triggers` через `ubus service list` дала пустой вывод; это не подтверждает отсутствие procd-trigger, поскольку путь JSON мог не соответствовать фактической структуре ответа.
- [NEXT] Без перезапуска сервисов получить компактную структуру зарегистрированного экземпляра pbr через `jsonfilter`.

- [OBSERVED] 2026-09-19 STAGE 6: после ручного `wifi reload` фактически подняты `phy1-ap0` (AP 2.4 GHz, channel 1/2412 MHz), `phy0-ap0` (AP 5 GHz, channel 36/5180 MHz, VHT40) и `phy0-sta0` (STA 5 GHz, channel 36/5180 MHz, VHT40).
- [CONCLUSION] Wi-Fi reload завершился с восстановлением обеих AP и upstream STA; текущая одновременная STA+AP конфигурация фактически активна. Это не доказывает причину прежнего автоматического reload/-122.


## CHANGELOG — 2026-09-19 — [SYNC] router timezone inspection
- [PASS] Read-only UCI query returned `timezone=GMT0`, `zonename=UTC`.
- [CONFIRMED] Router system time is currently UTC/GMT, while the user reports local time 14:10 on 2026-09-19; the observed log-time offset is therefore consistent with the router being configured to UTC rather than the user's local UTC+5 time.
- [OBSERVED] The router has no `/usr/share/zoneinfo` entry matching the attempted `Etc/GMT-5`; the targeted lookup returned no result.
- [RULE] No timezone configuration change has been made yet. Do not guess a zone name. The next step should use the OpenWrt-supported POSIX timezone representation or another verified available mechanism, one command at a time.
- [CHANGED] STAGE 6 remains IN_PROGRESS; Wi-Fi configuration and services were not changed by this timezone inspection.


## CHANGELOG — 2026-09-19 — [SYNC] timezone UCI fields confirmed
- [PASS] Read-only `uci -q show system | grep -E 'timezone|zonename'` returned exactly `system.@system[0].timezone='GMT0'` and `system.@system[0].zonename='UTC'`.
- [CONFIRMED] Current timezone configuration is explicitly UTC/GMT0.
- [RULE] No timezone setting has been changed yet. Next step may set the verified POSIX UTC+5 representation, but only as one controlled configuration change followed by time verification.
- [CHANGED] STAGE 6 remains IN_PROGRESS.


## CHANGELOG — 2026-09-19 — [OBSERVATION] Wi-Fi security state changed
- [USER REPORT] Previously 5 GHz SSID `OpenWrt` was password-protected, while 2.4 GHz `OpenWrt` was open.
- [CURRENT USER REPORT] After the recent change, 2.4 GHz and 5 GHz appear as one `OpenWrt` network with a password.
- [RULE] Do not assume the cause. Verify UCI wireless configuration before changing anything.
- [CHANGED] STAGE 6 remains IN_PROGRESS.


## CHANGELOG — 2026-09-19 — [PASS] Wi-Fi configuration is committed
- [PASS] `uci -q changes wireless` returned empty output.
- [CONFIRMED] Current wireless configuration (2.4 GHz and 5 GHz AP) is already committed in UCI, so there are no pending in-memory UCI changes for `wireless`.- [FACT] Both AP sections currently use SSID `OpenWrt`, encryption `psk2`, and the same configured key; upstream STA remains `SweetHomeU` with `psk2`.
- [RULE] Do not infer when/how the 2.4 GHz security setting changed from this test; current UCI alone cannot establish change history.
- [CHANGED] STAGE 6 remains IN_PROGRESS.

## CHANGELOG — 2026-09-19 — [EVIDENCE] Wi-Fi reload timeline
- [EVIDENCE] Log shows a real `hostapd: Reload all interfaces` at router time 09:06:46, followed by phy0 reload, phy1 reload, `radio1 ... wifi-scripts: Starting`, and phy1 preparation.
- [EVIDENCE] At 07:40:03 the 2.4 GHz AP (`phy1-ap0`) accepted a client with `AP-STA-CONNECTED ... auth_alg=open`; this is historical evidence that the 2.4 GHz AP was open at that time.
- [EVIDENCE] At 08:43:41-42 the 5 GHz AP (`phy0-ap0`) accepted a client and completed an RSN/WPA handshake, confirming 5 GHz was password-protected at that time.
- [EVIDENCE] At 09:15:38 the 5 GHz AP again completed an RSN/WPA handshake after a disconnect/reconnect.
- [LIMITATION] The shown log does not contain a configuration-write/UCI event proving that the 2.4 GHz password was changed exactly at 09:06:46. It only establishes that 2.4 GHz was open at 07:40 and is currently configured as WPA2.
- [CHANGED] STAGE 6 remains IN_PROGRESS; no Wi-Fi configuration was modified by this diagnostic step.


## CHANGELOG — 2026-09-19 — [DECISION] Wi-Fi password change investigation closed
- [DECISION] No further tests are required specifically to determine why 2.4 GHz became password-protected.
- [CURRENT STATE] Both 2.4 GHz and 5 GHz APs use SSID `OpenWrt` with WPA2 and the configured key; this is accepted as the current working configuration.
- [LIMITATION] The exact origin/time of the 2.4 GHz password change remains unproven, with a plausible possibility that it resulted from an earlier manual/configuration step.
- [NEXT] Resume STAGE 6 core investigation: Wi-Fi/hostapd reload behavior and `Not supported (-122)`; avoid reopening the already sufficient password-history investigation.


## CHANGELOG — 2026-09-19 — [FAIL] timezone change did not take effect
- [RESULT] `date` returned `Sat Sep 19 09:17:45 GMT 2026`, while user reports local time 14:18 on 2026-09-19.
- [CONFIRMED] Date is correct, clock is 5 hours behind local UTC+5 time; timezone is still effectively GMT/UTC.
- [FACT] Previous timezone configuration command did not produce the intended UTC+5 runtime timezone.
- [RULE] Do not assume the POSIX UCI value alone controls the active runtime timezone; inspect the active timezone linkage/configuration read-only before changing it.
- [CHANGED] STAGE 6 remains IN_PROGRESS; no Wi-Fi/network service changes made.


## CHANGELOG — 2026-09-19 — [EVIDENCE] runtime TZ source identified
- [PASS] Read-only check returned `/etc/TZ=GMT0`, `ENV_TZ=<unset>`, while UCI contains `timezone=GMT-5`.
- [CONFIRMED] UCI was changed to the intended POSIX UTC+5 representation, but the active runtime timezone file `/etc/TZ` remains `GMT0`; this explains why `date` still reports GMT/UTC.
- [RULE] Next step is to apply the verified system timezone through the OpenWrt-supported mechanism that updates `/etc/TZ`, one command at a time; do not manually edit unrelated files or restart network/Wi-Fi services.
- [CHANGED] STAGE 6 remains IN_PROGRESS.

- [DONE] Ran `/etc/init.d/system reload` with no error; no Wi-Fi/network restart was intentionally requested.
- [PENDING] Must verify whether runtime `/etc/TZ` changed and whether `date` now reflects UTC+5; no conclusion yet.

## CHANGELOG — 2026-09-19 — [PASS] runtime timezone corrected
- [PASS] `/etc/init.d/system reload` updated `/etc/TZ` from `GMT0` to `GMT-5`.
- [PASS] `date` now returns `Sat Sep 19 14:19:19 GMT 2026`, matching the user's UTC+5 local clock.
- [FACT] The displayed abbreviation remains `GMT`; the important verified result is the UTC+5 offset represented by POSIX `GMT-5` and the correct wall-clock time.
- [CLOSED] Timezone runtime mismatch is resolved; no Wi-Fi/network restart was required.

## NEXT STEP — STAGE 6 — 2026-09-19
- Timezone issue is closed.
- [NEXT] Return to the unresolved periodic hostapd reload: quantify all recorded `Reload all interfaces` events and their timestamps before changing configuration.
- [METHOD] Compact read-only query only; no service/network/Wi-Fi restart.

## EVIDENCE — STAGE 6 — 2026-09-19
- [OBSERVED] Recent `hostapd: Reload all interfaces` events: Sep 17 12:23:20, 12:37:31; Sep 19 11:01:20, 11:17:01, 11:25:50, 12:08:13, 12:38:59, 14:06:46, 14:20:32.
- [OBSERVED] Intervals on Sep 19 are irregular (15:41, 8:49, 42:23, 30:46, 87:47, 13:46), so there is no simple fixed periodic timer demonstrated by this sample.
- [NEXT] Correlate one recent event with surrounding log lines to identify the immediate initiator; read-only only.

- [EVIDENCE] Around 14:20:32 only MLD/hostapd/wpa_supplicant messages are present: hostapd sets MLD config, reloads all interfaces and both PHY settings; wpa_supplicant sets MLD config at the same second.
- [CONCLUSION] This window does not expose an upstream netifd/pbr/https-dns-proxy initiator; causality remains unresolved. Do not attribute the reload to MLD or wpa_supplicant solely from same-timestamp messages.

- [CORRECTION] The prior time-window command covered only seconds 00–31, while the reload occurred at 14:20:32; therefore its empty output is not evidence that the event had no surrounding logs.
- [NEXT] Inspect 14:20:32–14:20:59 to determine whether the known `-122 / Not supported` sequence recurred after the latest reload.

- [PASS] After the 14:20:32 hostapd reload, `phy0-ap0` remains `type AP`, SSID `OpenWrt`, channel 36 / 5180 MHz, width 40 MHz.
- [CONCLUSION] The latest hostapd reload did not cause loss of the 5 GHz AP. The previously observed `-122 / Not supported` is not reproduced in the immediate post-reload window.

## CORRECTION — STAGE 6 — 2026-09-19
- [CORRECTED] `14:06:46` and `14:20:32` `hostapd: Reload all interfaces` events were generated during our manual Wi-Fi reload diagnostic activity and must NOT be treated as natural/periodic events.
- [CORRECTED] The latest confirmed natural reload sample remains the events before the manual intervention: 11:01:20, 11:17:01, 11:25:50, 12:08:13, 12:38:59.
- [RULE] Do not generate another Wi-Fi reload for diagnosis. Observe only; a future reload occurring without a manual trigger can be treated as a natural event.

## HARD CHECKPOINT — STAGE 6 — 2026-09-19
- [LOCKED FACT] The `hostapd: Reload all interfaces` events at 14:06:46 and 14:20:32 were caused by our manual Wi-Fi reload diagnostic actions. They are NOT evidence of spontaneous/periodic reloads and MUST NOT be used as natural-event samples.
- [LOCKED FACT] Last confirmed natural reload before manual testing: 12:38:59.
- [CONTROL POINT] At 14:24:58 the router had no reload after 14:20:32.
- [RULE FOR USER + AI] From this point, DO NOT execute `wifi reload`, `wifi down/up`, `/etc/init.d/network reload`, or reboot merely to reproduce this issue. Any reload occurring without such manual action is classified as a NATURAL EVENT candidate.
- [NATURAL EVENT PROCEDURE] On a new natural `hostapd: Reload all interfaces`, first capture the surrounding log window and check for `-122`, netifd, pbr, https-dns-proxy, hostapd/wpa_supplicant, and Wi-Fi state. Do not change configuration before evidence is captured.
- [ANTI-FORGET] This classification and procedure are mandatory for all subsequent STAGE 6 work unless explicitly superseded by a later evidence-based decision.


## CHANGELOG — 2026-09-19 — [OBSERVATION] STAGE 6 natural-event checkpoint
- [PASS] User confirmed there is no new `hostapd: Reload all interfaces` event after the 14:24:58 control point.
- [CONFIRMED] No new natural-event sample was obtained; the latest confirmed natural reload remains 12:38:59.
- [RULE] No artificial `wifi reload`, `wifi down/up`, network reload, or reboot will be used to force reproduction.
- [NEXT] Continue STAGE 6 with a compact read-only check of currently active Wi-Fi interfaces/state; no service or configuration changes.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 6 Wi-Fi active-state verification
- [PASS] `iw dev` confirms `phy1-ap0` is AP on 2.4 GHz channel 1 (2412 MHz), 20 MHz.
- [PASS] `iw dev` confirms `phy0-ap0` is AP on 5 GHz channel 36 (5180 MHz), VHT40.
- [PASS] `iw dev` confirms `phy0-sta0` is managed STA on 5 GHz channel 36 (5180 MHz), VHT40.
- [CONFIRMED] Both local APs and the upstream 5 GHz STA are currently present simultaneously.
- [NEXT] Read-only verification of upstream STA link and associated AP clients; no reload/restart/configuration change.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 6 upstream STA + client verification
- [PASS] `phy0-sta0` is connected to upstream SSID `SweetHomeU` at 5180 MHz (channel 36), VHT40.
- [PASS] STA link reports signal -33 dBm, RX 200.0 MBit/s and TX 180.0 MBit/s.
- [PASS] `phy0-ap0` has an associated and authorized client.
- [CONFIRMED] The current 5 GHz chain upstream STA → local AP is operational under the present configuration.
- [NOT_PROVEN] This does not identify the initiator of the historical spontaneous hostapd reloads or explain `-122`; those remain the unresolved STAGE 6 issue.
- [NEXT] Continue observation/read-only diagnostics without artificial reloads; do not alter Wi-Fi configuration based on this PASS.

## CHANGELOG — 2026-09-19 — [PASS] STAGE 6 -122 current evidence checkpoint
- [PASS] Read-only log query found historical `command failed: Not supported (-122)` at 11:17:03, 11:25:52, 12:08:15 and 12:38:59.
- [CLASSIFIED] The 14:06:52 `radio1` / `-122` line belongs to the manual Wi-Fi reload diagnostic and is excluded from the natural-event sample.
- [CONFIRMED] No newer `-122` event is present after the manual 14:06:52 event in the returned tail; the latest confirmed natural `-122` remains 12:38:59.
- [CONCLUSION] At the current observation point there is no evidence of a new spontaneous `-122` failure after the manual tests.
- [NEXT] Continue passive observation/read-only correlation; do not trigger Wi-Fi/network reloads merely to reproduce the historical event.


## CHANGELOG — 2026-09-19 — [EVIDENCE] natural event 12:38:59 causal ordering
- [PASS] Natural-event window around 12:38:59 captured successfully.
- [CONFIRMED] At 12:38:59 netifd `radio0` starts `wifi-scripts`; the same process immediately reports `command failed: Not supported (-122)`.
- [CONFIRMED] Only after that, at 12:39:00–12:39:04, wpa_supplicant/hostapd receive new phy0 configuration, hostapd reloads `phy0-ap0`, the AP link goes down, and radio0 preparation continues for both `phy0-ap0` and `phy0-sta0`.
- [IMPORTANT] This natural sample establishes temporal ordering: `radio0 wifi-scripts: Starting` → `-122` → hostapd/wpa_supplicant reconfiguration. Therefore the observed hostapd reload is not proven to be the primary initiator; it occurs downstream of radio0 configuration activity.
- [NOT_PROVEN] The upstream trigger that caused netifd to start `radio0` remains unidentified. Do not attribute it to pbr, https-dns-proxy, MLD, or another component without evidence.
- [NEXT] Identify the immediate trigger for the natural `radio0 wifi-scripts: Starting` event using a compact read-only log window immediately preceding 12:38:59; no reload/restart/configuration changes.


## CHANGELOG — 2026-09-19 — [DECISION] STAGE 6 investigation bounded
- [DECISION] The repeated search for the upstream initiator of the historical natural `radio0 wifi-scripts: Starting` event is closed for now; the relevant direct-call paths and pbr/https-dns-proxy mechanisms were already investigated without causal proof.
- [CONFIRMED] Natural-event ordering is documented: `radio0 wifi-scripts: Starting` → `-122` → wpa_supplicant/hostapd reconfiguration.
- [CONFIRMED] Current Wi-Fi is operational and no new natural reload/`-122` event has appeared after the observation checkpoint.
- [RULE] Do not continue broad repetitive log/source searches unless a new natural event provides new evidence.
- [NEXT] Move to STAGE 7 baseline resource measurements; read-only, one command at a time.


## CHANGELOG — 2026-09-19 — [EVIDENCE] STAGE 7 resource baseline
- [MEASURED] `free -h`: RAM total 54852 KiB, used 30916 KiB, free 15852 KiB, available 7600 KiB.
- [MEASURED] USB swap `/dev/sda1` is active: 524284 KiB total, 4424 KiB used, priority -2.
- [MEASURED] `/sys/block/zram0/disksize` is absent: ZRAM is not currently exposed/active as `zram0`.
- [NOTE] BusyBox `ps` in this build does not support GNU `ps -e`; the attempted RSS listing failed and caused no system change.
- [NEXT] Use BusyBox-compatible read-only process inspection, one command at a time.


## CHANGELOG — 2026-09-19 — [EVIDENCE] STAGE 7 process inventory
- [MEASURED] BusyBox `ps w` works and shows active userspace: procd, ubus, netifd, hostapd, wpa_supplicant, dnsmasq, odhcpd, ntpd, https-dns-proxy (2 instances), dropbear, udhcpc and kernel workers.
- [NOTE] `ps w` reports VSZ, not RSS, so it is not sufficient for attributing the measured RAM usage to individual processes.
- [CONFIRMED] No ZRAM process/device is visible from the previous `zram0` check; USB swap remains the only confirmed active swap.
- [NEXT] Measure VmRSS for the main userspace daemons using /proc, read-only.


## CHANGELOG — 2026-09-19 — [EVIDENCE] STAGE 7 kernel memory breakdown
- [MEASURED] Current `/proc/meminfo`: MemTotal 54852 KiB, MemFree 20044 KiB, MemAvailable 10592 KiB, Buffers 1752 KiB, Cached 2664 KiB, Slab 8564 KiB.
- [MEASURED] Slab split: SReclaimable 1260 KiB, SUnreclaim 7304 KiB; unreclaimable slab is the dominant reported kernel-memory component.
- [NOTE] The earlier `free -h` sample showed 7600 KiB available; the later read-only `/proc/meminfo` sample shows 10592 KiB available. This is a normal time-varying measurement and both samples remain historical control points; do not mix them as one instantaneous value.
- [NEXT] Complete the baseline with a compact kernel/network memory check before any ZRAM configuration change.


## CHANGELOG — 2026-09-19 — [EVIDENCE] slab category query limitation
- [MEASURED] `/proc/meminfo` confirms Slab 8564 KiB, SReclaimable 1260 KiB, SUnreclaim 7304 KiB.
- [LIMITATION] The attempted `/proc/slabinfo` category extraction returned no rows; this does not mean slab usage is absent, only that this particular parser/query did not produce usable category data.
- [NEXT] Verify the available `/proc/slabinfo` header/format with a minimal read-only query before deciding whether further slab attribution is worthwhile.


## CHANGELOG — 2026-09-19 — [EVIDENCE] STAGE 7 ZRAM/swap confirmation
- [CONFIRMED] No `/dev/zram*` device exists.
- [CONFIRMED] `/proc/swaps` contains only `/dev/sda1`, size 524284 KiB, used 4424 KiB, priority -2.
- [CONCLUSION] Current memory-compression layer is absent; USB swap is active and lightly used.
- [NEXT] STAGE 7 baseline data is sufficient to proceed to the planned ZRAM stage; no ZRAM configuration change has been made during baseline collection.


## CHANGELOG — 2026-09-19 — [TRANSITION] STAGE 8 USB/extroot
- [DONE] STAGE 7 RAM/resource baseline completed: USB swap active; ZRAM absent; baseline measurements recorded.
- [IN_PROGRESS] STAGE 8 USB/extroot started.
- [RULE] Before any extroot change, first perform a read-only verification of the current mount, overlay, fstab and USB filesystem state. No formatting, repartitioning, copying or rebooting is permitted at this verification step.


## CHANGELOG — 2026-09-19 — [EVIDENCE] STAGE 8 current extroot state
- [CONFIRMED] `/dev/sda2` is currently mounted as `/overlay`, ext4, rw,noatime; root overlay is backed by the USB extroot and has 6.2G available.
- [CONFIRMED] Actual extroot filesystem UUID is `e1c68a3a-0e55-4af9-afd8-961160b3afa2`, label `extroot`.
- [CONFIRMED] `/dev/sda1` is swap and enabled in UCI fstab.
- [IMPORTANT] UCI fstab entry `fstab.extroot.uuid` currently contains `244b7bbc-add1-46cd-bc1a-0143cfca5d6c`, which does NOT match the actual sda2 UUID. Despite this mismatch, sda2 is currently mounted as /overlay, so the active extroot appears to be selected by fstools/automatic extroot discovery rather than that explicit UUID entry.
- [IMPORTANT] UCI `fstab.@mount[0]` for `/mnt/data` also references old UUID `fa23e979-0f79-4fd7-92f6-88952fb95053`; this does not match the current USB partition state and must not be treated as valid without correction.
- [RULE] No fstab edits yet; first determine the exact boot-time/active extroot selection mechanism with read-only inspection.


## CHANGELOG — 2026-09-19 — [EVIDENCE] extroot implementation location
- [MEASURED] Searching `/libfstools` for extroot/fstab symbols returned no text matches; this directory does not expose the implementation as searchable scripts.
- [DECISION] Do not continue broad recursive source searches. Use the actual `mount_root` executable/interface for the next read-only verification.


## CHANGELOG — 2026-09-19 — [EVIDENCE] fstools ownership confirmed
- [CONFIRMED] `/sbin/mount_root` is provided by `fstools-2026.05.23~16718b6e-r1`.
- [LIMITATION] `mount_root -V` provides no version output; package ownership is the reliable version evidence.
- [DECISION] Stop reverse-engineering the compiled `mount_root` binary. Current runtime state is already sufficient to repair the stale UCI UUID entries safely, but the actual configuration change will be a separate explicit step and will not include reboot/reload yet.


## CHANGELOG — 2026-09-19 — [CHANGE] extroot UUID corrected
- [DONE] Updated and committed `fstab.extroot.uuid` to the actual current ext4 UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2`.
- [CONFIRMED] `fstab.extroot.target='/overlay'`, `fstype='ext4'`, `options='rw,noatime'`, `enabled='1'`.
- [RULE] No reboot/remount was performed by this change; current active /overlay remains untouched.
- [NEXT] Determine the actual UUID of the filesystem intended for `/mnt/data` before correcting its stale fstab entry.


## CHANGELOG — 2026-09-19 — [EVIDENCE] /mnt/data is not currently mounted
- [CONFIRMED] Only `/dev/sda2` is mounted from USB, as `/overlay`.
- [CONFIRMED] No `/mnt/data` mount is active; `/mnt/data` is only an existing directory.
- [IMPORTANT] The stale `fstab.@mount[0].uuid=fa23e979-0f79-4fd7-92f6-88952fb95053` does not correspond to any currently mounted filesystem and must not be replaced with the extroot UUID.
- [NEXT] Determine whether the intended `/mnt/data` mount should be retained at all. Current USB layout has only sda1 swap + sda2 extroot, so there is no separate data partition available for /mnt/data.

## CHANGELOG — 2026-09-19 — [CHANGE] stale /mnt/data fstab entry removed
- [DONE] Removed only the obsolete `fstab.@mount[0]` entry for `/mnt/data` and committed fstab.
- [CONFIRMED] Current fstab contains only global settings, `/dev/sda1` swap, and the corrected extroot entry for `/dev/sda2`.
- [SAFETY] No filesystem, partition, mount point contents, or active /overlay was modified by this change.
- [NEXT] Verify final STAGE 8 runtime/config consistency without rebooting; then proceed to the next planned storage/memory stage.

## CHANGELOG — 2026-09-19 — [DONE] STAGE 8 extroot
- [PASS] Runtime verification: `/dev/sda2 on /overlay type ext4 (rw,noatime)`.- [PASS] Root overlay uses the USB ext4 filesystem: `overlayfs:/overlay`, 6.6G total, 6.2G available.
- [PASS] fstab contains only global settings, `/dev/sda1` swap, and corrected `extroot` UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2`.
- [PASS] Obsolete `/mnt/data` entry is absent.
- [DONE] STAGE 8 exit criterion met: USB extroot is active and persistently configured with the current UUID; no separate stale data mount remains.
- [NEXT] STAGE 9 — ZRAM + USB swap.


## CHANGELOG — 2026-09-19 — [IN_PROGRESS] STAGE 9 baseline
- [PASS] USB swap `/dev/sda1` is active: 524284 KiB total, 4168 KiB used, priority -2.
- [PASS] RAM baseline at start of STAGE 9: 54852 KiB total, 28432 KiB used, 17212 KiB free, 9512 KiB available.
- [PASS] `zram0` is currently absent; ZRAM has not yet been configured.
- [NEXT] Verify availability of the official OpenWrt ZRAM package/kernel support before installing or changing anything.


## CHANGELOG — 2026-09-19 — [BLOCKED] STAGE 9 package lookup
- [BLOCKED] `apk search -v '*zram*'` cannot search because all configured OpenWrt 25.12.5 `packages.adb` indexes are absent from the local apk cache.
- [CONFIRMED] No ZRAM package was installed or changed.
- [CONFIRMED] Existing USB swap remains untouched.
- [NEXT] Repair/refresh the official OpenWrt apk package indexes with a read-only/low-risk repository operation, then repeat the ZRAM package lookup.


## CHANGELOG — 2026-09-19 — [PROGRESS] STAGE 9 apk indexes restored
- [PASS] `apk update` successfully refreshed all configured OpenWrt 25.12.5 repositories.
- [PASS] Official package indexes are now available; apk reports 11080 distinct packages.
- [RESOLVED] Previous STAGE 9 block caused by missing local `packages.adb` cache is cleared.
- [NEXT] Repeat the ZRAM package availability check; no package installation yet.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 9 ZRAM package availability
- [PASS] Official repositories provide `kmod-zram-6.12.94-r1` (kernel compressed-RAM block device support).
- [PASS] Official repositories provide `zram-swap-32` (OpenWrt zram swap activation script).
- [CONFIRMED] No ZRAM package has been installed yet.
- [NEXT] Inspect package metadata/dependencies before installation; installation remains a separate controlled step.


## CHANGELOG — 2026-09-19 — [IN_PROGRESS] STAGE 9 sizing rule
- [CLARIFICATION] User supplied generic ZRAM guidance recommending `zram-swap`, optional `kmod-lib-lz4`, and 50–70% RAM sizing.
- [PROJECT RULE] Do not adopt the generic 50–70% sizing recommendation automatically: this router has ~54 MiB RAM, a 650 MHz MIPS CPU, and an already-active 512 MiB USB swap. ZRAM size and compression algorithm will be selected from actual package/kernel capabilities and measured behavior.
- [PROJECT RULE] Do not install `kmod-lib-lz4` unless the selected ZRAM configuration requires it; avoid unnecessary kernel modules.
- [NEXT] Inspect exact metadata/dependencies of the already-verified official `kmod-zram` and `zram-swap` packages before installation.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 9 package metadata
- [PASS] `kmod-zram-6.12.94-r1` matches the running kernel 6.12.94 and requires only `kmod-lib-lzo` as the compression dependency.
- [PASS] `zram-swap-32` depends on `kmod-zram` and `libc`.
- [PASS] No `kmod-lib-lz4` dependency is required by the official zram package; do not install it unnecessarily.
- [PASS] Package installed sizes are small: 37 KiB for kmod-zram and 5230 B for zram-swap.
- [NEXT] Before installation, inspect the actual `zram-swap` configuration/defaults so the router is not activated with an unsuitable size or policy.


## CHANGELOG — 2026-09-19 — [INFO] ZRAM package inspection
- [CONFIRMED] `apk manifest zram-swap` and `apk info -L zram-swap` returned no file list because the package is not installed; this does not indicate a package defect.
- [CLARIFICATION] User supplied an LZ4/LZO/ZSTD comparison. Project choice remains measurement-based: the currently verified `zram-swap` dependency chain uses `kmod-lib-lzo`; LZ4 is not installed and will not be added merely from generic performance claims.
- [NEXT] Inspect the available package metadata/state for `zram-swap` before installation, using apk's package policy information.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 9 package policy / capability check
- [PASS] `apk policy zram-swap` resolves official OpenWrt 25.12.5 mips_24kc/base package version 32.
- [INFO] Runtime ZRAM capability files/config were not visible because `kmod-zram` is not installed yet; absence of `/sys/block/zram-control/hot_add` therefore cannot be used to reject an algorithm.
- [NEXT] Install only the two verified official components `kmod-zram` and `zram-swap`; dependency `kmod-lib-lzo` is expected to be pulled automatically. Do not install LZ4/ZSTD modules at this point.


## CHANGELOG — 2026-09-19 — [EVENT] unexpected reboot during STAGE 9 package install
- [EVENT] `apk add kmod-zram zram-swap` reached `kmod-crypto-acompress-6.12.94-r1.post-install` at 0%, then SSH disconnected with `client_loop: send disconnect: Connection reset`; user reports the router rebooted.
- [IMPORTANT] Installation completion is unknown. Do not rerun `apk add` or start/restart ZRAM until package/runtime state is verified.
- [SAFETY] This reboot was not intentional and was not requested as a diagnostic action; investigate the cause from post-boot state/logs before making further changes.
- [NEXT] After reconnect, perform read-only verification of uptime, installed package state, kernel/ZRAM state, swap, and boot log evidence.


## CHANGELOG — 2026-09-19 — [DIAGNOSIS] post-reboot ZRAM install state
- [CONFIRMED] Router rebooted: uptime only 3 minutes after the interrupted installation.
- [CONFIRMED] `zram0` is absent; ZRAM is not active.
- [CONFIRMED] Existing USB swap `/dev/sda1` remains active (524284 KiB, 928 KiB used, priority -2).
- [IMPORTANT] `apk info` could not read package indexes because the local `packages.adb` cache was lost/cleared by the reboot; this does not by itself prove whether the partial package installation persisted.
- [NEXT] Do not reinstall yet. First restore the official apk indexes with `apk update`, then inspect installed package state and boot logs before deciding whether to resume installation.


## CHANGELOG — 2026-09-19 — [BLOCKED] apk update after reboot
- [BLOCKED] `apk update` partially failed: 2 repositories (target packages and base) returned `wgetFailed to send request: Operation not permitted` / unexpected EOF; 6 repositories refreshed successfully.
- [CONFIRMED] apk reports 10247 distinct packages, so the package database is partially available, but update is not fully successful.
- [IMPORTANT] This error occurred after the unexpected reboot during `apk add`; do not infer a network/DNS problem yet and do not retry installation blindly.
- [NEXT] Determine exactly which ZRAM-related packages, if any, were committed to the installed package database using a read-only package-state query.


## CHANGELOG — 2026-09-19 — [HYPOTHESIS] possible OOM-related instability during STAGE 9
- [OBSERVED] User reports recurring loss/freezing of 5 GHz and 2.4 GHz Wi-Fi and SSH becoming unresponsive; unexpected reboot also occurred during ZRAM package installation.
- [HYPOTHESIS] OOM/memory pressure is now a plausible common factor, but causation is NOT yet proven.
- [RULE] Do not attribute Wi-Fi/SSH failures to OOM until kernel logs show OOM-killer activity or memory pressure evidence.
- [RULE] Do not continue ZRAM installation/configuration until the current post-reboot memory/OOM state is checked.
- [NEXT] Read-only check of kernel log for OOM, memory allocation failures, kernel panic/watchdog, and reboot-adjacent evidence.

### Последний диагностический результат — watchdog reset
- Пользователь выполнил read-only проверку kernel/logread на OOM, allocation failure, kernel panic и lockup.
- Прямых сообщений OOM / "Killed process" / kernel panic / soft lockup / hard lockup в сохранённом logread не обнаружено.
- Обнаружено: `init: Watchdog has previously reset the system` и `procd: Watchdog has previously reset the system` при текущей загрузке.
- Вывод: предыдущая авария/зависание подтверждается watchdog reset, но причина (OOM, зависание Wi-Fi/драйвера, kernel stall или другое) пока НЕ установлена.
- Не выполнять повторную установку ZRAM и не перезагружать систему для воспроизведения до следующего read-only шага.


### pstore — результат
- Проверка `ls -la /sys/fs/pstore 2>/dev/null` дала пустой вывод.
- Сохранённого pstore-дампа предыдущего зависания нет.
- Причина watchdog reset по-прежнему не установлена; OOM не подтверждён.


### Память после watchdog reset — результат
- `free -h`: RAM total 54852 KiB, used 29208 KiB, free 15008 KiB, buff/cache 10636 KiB, available 8020 KiB.
- USB swap /dev/sda1 активен: 524284 KiB total, 3920 KiB used, 520364 KiB free.
- Текущие показатели не показывают исчерпания RAM: доступно около 8 MiB, swap почти полностью свободен.
- Это не подтверждает OOM как причину предыдущего зависания; гипотеза OOM остаётся неподтверждённой.


### После watchdog: uptime/logread — результат
- После watchdog-перезапуска система работала около 6 минут на момент проверки.
- Load average: 0.17 / 1.22 / 0.74 — признаков текущего CPU saturation по этим значениям нет.
- В хвосте журнала после загрузки виден обычный перезапуск dnsmasq; https-dns-proxy продолжает использовать локальные 127.0.0.1:5053 и :5054.
- В 15:34:59 появились два предупреждения dnsmasq о возможной DNS-rebind атаке для dns.msftncsi.com; само по себе это не объясняет watchdog reset.
- Новой причины аварии в этом выводе не обнаружено.


### dmesg после watchdog — Wi-Fi/драйвер
- После загрузки ath10k (5 ГГц) и ath9k (2,4 ГГц) проходят повторные циклы регистрации/отключения интерфейсов AP.
- Зафиксировано `ath10k_pci ... failed to enable peer stats info: -122` при подключении `phy0-sta0`.
- Также повторяется `pdev param 0 not supported by firmware`.
- Эти сообщения согласуются с ранее установленным фактом повторных Wi-Fi reconfiguration/reload и ошибкой `-122`, но сами по себе не доказывают причину watchdog reset или OOM.
- После восстановления `phy0-sta0` успешно associated, `phy0-ap0` перешёл в forwarding state; то есть Wi-Fi после загрузки поднялся.


### Фильтр dmesg ath10k/ath9k — уточнение
- Подтверждено: ath10k использует driver 6.15 и CT firmware `10.1-ct-87-__fW-022-d8dab8e8` для QCA9887.
- При загрузке ath10k успешно проходит probe/WMI init; признаков firmware crash/fatal/timeout в выводе нет.
- Ошибка `pdev param 0 not supported by firmware` повторяется при инициализации AP.
- `failed to enable peer stats info: -122` появляется при подключении STA; это уже известная ошибка -122, но причинную связь с watchdog не установлена.
- ath9k сообщает fallback загрузки EEPROM через sysfs; это происходит на старте и не сопровождается crash/fatal/timeout.
- Повторные циклы поднятия/снятия phy0/phy1 подтверждены.


### Wi-Fi/netifd correlation после watchdog — результат
- В 14:57:13 hostapd получил `Set new config for phy1` и `Restart interface for phy1`; одновременно netifd radio1 запустил wifi-scripts. Это происходит до установления WAN (WAN link connectivity только в 14:57:17).
- В 14:57:17 STA phy0-sta0 успешно ассоциировался; сразу после этого WAN поднялся, затем в 14:57:20 firewall получил reload из-за ifup WAN.
- https-dns-proxy стартовал в 14:57:23 и установил trigger WAN в 14:57:26, то есть его запуск произошёл ПОСЛЕ основной Wi-Fi инициализации после загрузки. Поэтому эти строки не подтверждают https-dns-proxy как инициатор первоначального Wi-Fi reload.
- dnsmasq был перезапущен в 14:57:40–14:57:41 уже после старта https-dns-proxy.
- Следовательно, текущий фрагмент подтверждает порядок: Wi-Fi/netifd → WAN → firewall → https-dns-proxy → dnsmasq; причинная связь с последующим watchdog всё ещё не установлена.


### Причина/инициатор Wi-Fi reload — промежуточный результат
- В 14:57:02 уже началась деинициализация phy0: wpa_supplicant получает `Set new config for phy phy0` и удаляет `phy0-sta0`; затем WAN disabled.
- В 14:57:07 hostapd деинициализирует phy1 и netifd radio1 выполняет `wifi-scripts: Tearing down phy1`.
- В 14:57:09 netifd radio0 выполняет `wifi-scripts: Starting`; затем hostapd/wpa_supplicant получают новые конфигурации phy0.
- В 14:57:11 запускается radio1. Таким образом, reload уже был инициирован ДО 14:57:02; данный фрагмент не показывает первичный источник события.
- Ошибки `rmdir ... Permission denied` относятся к удалению control directories при деинициализации и сами по себе не доказывают причину reload.


### Расширенный временной фрагмент — новый факт
- В 14:56:58 `wan` был enabled, затем в 14:56:59 disabled и снова enabled.
- В 14:57:01 netifd выполняет `radio0: wifi-scripts: Tearing down phy0`, после чего в 14:57:02 hostapd/wpa_supplicant деинициализируют phy0.
- Таким образом, перед Wi-Fi reload непосредственно наблюдается изменение состояния WAN. Это сильная временная корреляция, но источник изменения WAN пока не установлен.
- В 14:56:42–14:56:43 был SSH-вход с LAN; это не считается причиной без дополнительных доказательств.

- Узкий поиск по `pbr|firewall|network|wan|interface|reload|ubus|procd` в 14:56:55–14:57:01 не выявил инициатора; видны только три события netifd: WAN enabled → disabled → enabled.
- Поэтому pbr/firewall как непосредственный инициатор по этому фрагменту не доказаны. Следующий шаг — расширить окно немного раньше, не выполняя reload/restart.

- Расширение окна 14:56:30–14:56:59 не выявило дополнительных событий перед WAN flap. Единственные события до него: SSH-подключение 14:56:42–43, hostapd phy0 AP-ENABLED 14:56:44, hostapd подготовка phy1 14:56:44, ath10k RTS threshold 14:56:54; затем WAN enabled/disabled/enabled.
- Причина WAN flap остаётся неустановленной; SSH-событие само по себе причинностью не считается.

- Поиск автоматических `network reload/ifup/ifdown` в /etc/crontabs, /etc/init.d, /etc/hotplug.d, /etc/rc.d не обнаружил отдельного WAN-скрипта. Найдены штатные вызовы /etc/init.d/network и ath12k hotplug, последний относится к ath12k и не является текущим ath10k/ath9k сценарием. Причина WAN flap не установлена.

- В расширенном фрагменте обнаружено: https-dns-proxy установил WAN trigger в 14:56:23; затем в 14:56:58–59 WAN enabled→disabled→enabled; после этого начался teardown phy0 в 14:57:01. Это временная последовательность, но сам лог не показывает, что https-dns-proxy вызвал WAN flap.
- Дополнительно в 14:57:06 WAN снова disabled, затем 14:57:08 teardown phy1. Это усиливает связь между изменениями состояния WAN и последующим Wi-Fi teardown, но причинность ещё не доказана.

- Пользователь подтвердил повторную попытку установки ZRAM после фиксации текущих WAN/Wi-Fi корреляций. Повторная установка разрешена как отдельный контролируемый шаг Stage 9; перед выполнением необходимо сначала проверить текущее состояние пакетов/репозиториев и не выполнять сетевые reload/restart.

- Перед повторной установкой ZRAM проверено: `kmod-crypto-acompress`, `kmod-zram`, `kmod-lib-lzo`, `zram-swap` — все НЕ установлены. Предыдущая попытка не оставила установленных компонентов.

- Перед повторной установкой ZRAM `apk policy` показал отсутствие локальных `.adb` индексов для всех настроенных официальных репозиториев. Установка пока не выполняется; сначала требуется восстановить индексы через `apk update`.

- Повторная проверка `apk policy` после восстановления индексов успешна: `kmod-crypto-acompress 6.12.94-r1`, `kmod-lib-lzo 6.12.94-r1`, `kmod-zram 6.12.94-r1` и `zram-swap 32` доступны из официальных OpenWrt 25.12.5 репозиториев. Можно переходить к контролируемой повторной установке.

- Повторная установка ZRAM успешно завершена без разрыва SSH/перезагрузки: установлены `kmod-crypto-acompress 6.12.94-r1`, `kmod-lib-lzo 6.12.94-r1`, `kmod-zram 6.12.94-r1`, `zram-swap 32`; активирован `/dev/zram0` размером 26 MiB с алгоритмом сжатия LZO. `apk` завершил операцию: `OK: 15.5 MiB in 160 packages`.

- После успешной установки ZRAM `swapon -s` подтверждает два swap-устройства: `/dev/zram0` 26620 KiB, Used 0, Priority 100; `/dev/sda1` 524284 KiB, Used 6068 KiB, Priority -2. ZRAM имеет высокий приоритет и используется первым; USB swap остаётся резервным.
- Контрольная точка RAM: 54852 KiB total, 28148 used, 16928 free, 9508 available; суммарный swap 550904 KiB, used 6068 KiB.

- Проверка ZRAM: `comp_algorithm` показывает `lzo-rle [lzo]` — активен LZO; `disksize=27262976` bytes = 26 MiB; `mm_stat`: orig_data_size 4096, compr_data_size 55, mem_used_total 4096, swap_data_size 0. ZRAM пока практически не нагружен.

- Проверен /etc/init.d/zram: скрипт поддерживает `zram_size_mb`, `zram_comp_algo`, `zram_priority`; значения по умолчанию в скрипте — алгоритм LZO и priority 100. Скрипт автоматически поднимает zram swap при старте и имеет status/compact команды. В текущем выводе конкретные UCI-значения из /etc/config/system не показаны.

- UCI-параметры `system.@system[0].zram_size_mb`, `zram_comp_algo`, `zram_priority` явно не заданы. Следовательно, текущие фактические параметры ZRAM получены штатными defaults скрипта: 26 MiB, LZO, priority 100 (размер 26 MiB соответствует штатному расчёту для данной RAM).
- Проверка `/etc/init.d/zram status`: zram0 активен, размер 26 MiB, алгоритм `lzo-rle [lzo]`; original/compressed data 0.00 MiB, memory used 0.00 MiB, maximum memory ever used 0.00 MiB, same pages 0, pages compacted 0. ZRAM установлен и простаивает без фактической нагрузки; текущих признаков его заполнения/давления нет.

- По состоянию на текущую проверку: RAM 54852 KiB, available 8320 KiB; swap 550904 KiB суммарно. USB swap /dev/sda1: 524284 KiB, used 6068 KiB, priority -2. ZRAM /dev/zram0: 26620 KiB, used 0 KiB, priority 100. ZRAM является первым swap-слоем, USB swap — fallback.
- Проверена актуальная документация OpenWrt/Linux: OpenWrt штатно допускает zram_comp_algo lzo/lzo-rle/lz4/zstd и размер по умолчанию RAM/2048 (kB), поэтому текущие 26 MiB — штатный default, а утверждение «обязательно 50% RAM и LZ4» не является универсальным правилом. Сравнение LZO/LZ4 для данного hAP ac lite пока не делать без измерения на самом устройстве.

- Подтверждён runtime-список алгоритмов ZRAM: `lzo-rle [lzo]`. Доступны только LZO-RLE и LZO; LZ4 в текущем загруженном ZRAM/ядре не представлен. Текущий активный алгоритм — LZO.

- `/proc/sys/vm/swappiness` = 60. Это текущий kernel default/фактическое значение; пока не менять. Приоритет swap остаётся главным фактором порядка выбора: zram priority 100, USB swap -2.
- Точечная проверка `VmSwap` показала небольшие swap-резиденты у нескольких процессов: netifd 352 kB, wpa_supplicant 452/104 kB, urngd 56 kB, udhcpc 44 kB, ubusd 28 kB, procd 72 kB, odhcpd 40 kB, ntpd 16/108 kB. Это подтверждает, что swap используется на уровне отдельных страниц процессов, но само по себе не устанавливает, почему именно страницы оказались на USB swap при активном ZRAM. Вывод оставлен как диагностический факт, без причинного вывода.

- Проверка UCI-конфигураций показала: в `/etc/config/system` нет явных `zram_size_mb/zram_comp_algo/zram_priority`; в `/etc/config/fstab` присутствует секция `config swap` для USB swap. Это согласуется со штатными defaults ZRAM init-скрипта; параметры ZRAM не переопределены пользователем.

- Прямой просмотр /etc/init.d/zram подтвердил: при отсутствии UCI zram_comp_algo скрипт выбирает lzo; при отсутствии UCI zram_priority — 100; затем выполняет swapon -d -p 100. Полная строка расчёта zram_size в этом выводе не показана, поэтому размер 26 MiB пока подтверждён фактически по /sys и status, но не приписывается конкретной формуле без дополнительного чтения.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 DoH baseline
- [PASS] `/etc/init.d/https-dns-proxy status` returned `running`.
- [PASS] `127.0.0.1:5053` is listening on TCP and UDP, PID 2844.
- [PASS] `127.0.0.1:5054` is listening on TCP and UDP, PID 2845.
- [MEASURED] Current `https-dns-proxy` memory: PID 2844 VmRSS 1432 KiB, VmSwap 384 KiB, VmSize 3232 KiB; PID 2845 VmRSS 1472 KiB, VmSwap 380 KiB, VmSize 3232 KiB.
- [MEASURED] Combined VmRSS is 2904 KiB (~2.84 MiB); combined VmSwap is 764 KiB.
- [CONFIRMED] Both DoH instances are operational at the local listeners; no restart or configuration change was performed.
- [NEXT] Verify an actual DNS query through each local DoH listener (`5053` and `5054`) using a read-only query. Do not change or restart https-dns-proxy.
- [STATUS] STAGE 10 remains IN_PROGRESS until both listeners return valid DNS answers.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 DNS chain query PASS
- [PASS] Read-only command `nslookup openwrt.org 127.0.0.1` returned valid A and AAAA answers.
- [CONFIRMED] Local dnsmasq listener at `127.0.0.1:53` successfully resolved `openwrt.org` to A `64.226.122.113` and AAAA `2a03:b0c0:3:d0::1a51:c001`.
- [CONFIRMED] Current dnsmasq UCI configuration uses `noresolv='1'` and explicitly configures `127.0.0.1#5053` and `127.0.0.1#5054` as DoH proxy servers (`doh_server` and `doh_backup_server`).
- [IMPORTANT] This proves the local DNS chain through dnsmasq is functioning with the configured DoH proxy endpoints, but the BusyBox `nslookup` test cannot distinguish which of the two proxy listeners supplied the answer.
- [IMPORTANT] Direct per-port testing was not completed because this BusyBox build's `nc` supports only `nc IPADDR PORT` and does not provide the UDP options needed for the attempted raw DNS test; `socat`, `dig`, `drill`, `kdig`, and Lua are absent. No packages were installed and no service/configuration was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS: the overall DNS chain is PASS, but independent validation of both listeners `5053` and `5054` is still pending.
- [NEXT] Select a read-only method to distinguish/test the two local DoH listeners without installing packages or restarting services.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 netstat UDP check
- [PASS] Read-only command `netstat -unp | grep https-dns-proxy` completed successfully.
- [CONFIRMED] No UDP connected-socket rows were returned for `https-dns-proxy`.
- [IMPORTANT] Empty output does NOT prove that DNS is inactive or that either DoH listener is broken: the proxy listeners are local UDP servers, and BusyBox netstat only shows connected UDP sockets when present; it does not provide packet-level observation here.
- [CONFIRMED] No package installation, service restart, configuration change, Wi-Fi reload, network reload, or reboot was performed.
- [STATUS] STAGE 10 remains IN_PROGRESS.
- [NEXT] Use another already-installed read-only mechanism to distinguish/test traffic to 127.0.0.1:5053 and :5054; do not install packages or restart services merely for this test.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 nftables observation
- [PASS] Read-only `nft -a list table inet https_dns_proxy_notrack` completed successfully.
- [CONFIRMED] Table `inet https_dns_proxy_notrack` contains chain `raw_output` with two existing NOTRACK rules covering TCP/UDP destination ports 5053/5054 to 127.0.0.0/8 and source ports 5053/5054 from 127.0.0.0/8.
- [IMPORTANT] These NOTRACK rules have no packet/byte counters in the displayed ruleset, so this output does not establish whether traffic actually traversed either 5053 or 5054.
- [CONFIRMED] No nftables rule, counter, firewall configuration, service, network, Wi-Fi, or package state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS.
- [NEXT] Continue with a read-only method that can distinguish actual traffic to the two local DoH listeners without installing packages or restarting services.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 DoH instance mapping
- [PASS] Read-only inspection of running https-dns-proxy processes completed.
- [CONFIRMED] PID 2844 listens on local port 5053 and uses Cloudflare resolver URL https://cloudflare-dns.com/dns-query with bootstrap DNS 1.1.1.1, 1.0.0.1 and IPv6 equivalents.
- [CONFIRMED] PID 2845 listens on local port 5054 and uses Google resolver URL https://dns.google/dns-query with bootstrap DNS 8.8.8.8, 8.8.4.4 and IPv6 equivalents.
- [CONFIRMED] Both processes run as nobody:nogroup.
- [IMPORTANT] This establishes exact 5053→Cloudflare and 5054→Google mapping, but does not yet prove that live client DNS queries reached each upstream resolver independently.
- [CONFIRMED] No service, package, firewall, DNS, network, Wi-Fi, or process state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS.
- [NEXT] Continue with a read-only method that can provide independent evidence of live traffic/results for each DoH instance without restarting services or installing packages.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 https-dns-proxy log observation
- [PASS] Read-only log inspection completed.
- [CONFIRMED] dnsmasq repeatedly reports configured nameservers 127.0.0.1#5053 and 127.0.0.1#5054.
- [CONFIRMED] https-dns-proxy startup completed for both instances; logs show notrack rules updated and WAN trigger configured.
- [IMPORTANT] The available log output contains startup/configuration events but no per-query or per-instance DNS resolution statistics, so it does not independently prove live queries reached 5053 and 5054.
- [IMPORTANT] Log timestamps show https-dns-proxy instance restarts during the observed period; this output alone does not establish their cause.
- [CONFIRMED] No configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed by the read-only command.
- [STATUS] STAGE 10 remains IN_PROGRESS.
- [NEXT] Establish current running PIDs/listeners after the observed restarts, then choose the next non-invasive traffic-observation method.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 current DoH PIDs
- [PASS] Read-only `pgrep -af https-dns-proxy` completed successfully.
- [CONFIRMED] Current PID 2844 is the Cloudflare instance on port 5053.
- [CONFIRMED] Current PID 2845 is the Google instance on port 5054.
- [CONFIRMED] The two PIDs remained identical to the previously inspected processes despite the intervening log startup messages.
- [IMPORTANT] Current PID/listener identity is confirmed, but this still does not prove live upstream HTTPS traffic for either instance.
- [CONFIRMED] No configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS.
- [NEXT] Use an installed read-only socket view to look for active HTTPS connections associated with the two running proxy processes.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 active upstream DoH connections
- [PASS] Read-only `netstat -ntp | grep -E '2844|2845'` completed successfully.
- [CONFIRMED] PID 2844 (Cloudflare DoH listener 5053) has an ESTABLISHED TCP/443 connection from 192.168.0.112:35752 to 104.16.249.249:443.
- [CONFIRMED] PID 2845 (Google DoH listener 5054) has an ESTABLISHED TCP/443 connection from 192.168.0.112:33950 to 8.8.4.4:443.
- [OBSERVED] PID 2845 also has a CLOSE_WAIT connection to 8.8.4.4:443; this alone is not a failure because another Google connection is ESTABLISHED.
- [STRONG EVIDENCE] Both configured DoH instances have active upstream HTTPS/TCP connections at the time of measurement.
- [LIMITATION] This still does not directly map a specific client DNS query to a specific listener/query result, but it is substantially stronger evidence than startup logs alone.
- [CONFIRMED] No configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS pending the stage exit criterion.
- [NEXT] Perform a final read-only end-to-end DNS query test through local dnsmasq, then assess whether STAGE 10 exit criteria can be marked DONE based on the accumulated evidence.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 final DNS chain PASS
- [PASS] Read-only `nslookup openwrt.org 127.0.0.1` returned valid A and AAAA answers through the local DNS service at 127.0.0.1:53.
- [CONFIRMED] Local dnsmasq DNS resolution is functioning end-to-end at the client-facing local resolver.
- [CONFIRMED] UCI dnsmasq configuration points to both local DoH listeners 127.0.0.1#5053 and 127.0.0.1#5054.
- [CONFIRMED] PID 2844/5053 has an active upstream HTTPS connection to Cloudflare, and PID 2845/5054 has an active upstream HTTPS connection to Google from the preceding read-only socket observation.
- [IMPORTANT] The available installed tooling cannot attribute this single nslookup response to exactly one of the two listeners independently. Therefore the evidence proves the configured chain is operational and both DoH instances have active upstream connections, but does not provide per-query listener attribution.
- [STATUS] STAGE 10 remains IN_PROGRESS because the strict per-listener independent-query criterion has not been directly demonstrated.
- [CONFIRMED] No configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed.
- [NEXT] If strict per-listener attribution is required, use another already-installed read-only mechanism; otherwise the stage can be considered functionally verified with the stated limitation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 socket-to-listener mapping
- [PASS] Read-only mapping of https-dns-proxy socket inodes through /proc/net/tcp completed.
- [CONFIRMED] TCP socket inode 3668 is local 127.0.0.1:5053 in LISTEN state and belongs to PID 2844 (Cloudflare instance).
- [CONFIRMED] TCP socket inode 3863 is local 127.0.0.1:5054 in LISTEN state and belongs to PID 2845 (Google instance).
- [CONFIRMED] TCP socket inode 5677 belongs to PID 2844 and is an ESTABLISHED connection from 192.168.0.112:35752 to 104.16.249.249:443.
- [CONFIRMED] TCP socket inode 26743 belongs to PID 2845 and is an ESTABLISHED connection from 192.168.0.112:33950 to 8.8.4.4:443.
- [CONFIRMED] TCP socket inode 5674 belongs to PID 2845 and is CLOSE_WAIT to 8.8.4.4:443.
- [STRONG EVIDENCE] The local 5053/5054 listeners and their corresponding active upstream HTTPS sockets are now directly tied to the two running processes via kernel socket inode ownership.
- [LIMITATION] This still does not capture a per-query success response independently for each local listener; however, both listeners and both upstream paths are demonstrably active.
- [CONFIRMED] No configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS pending decision whether strict per-listener query attribution is mandatory for the stage exit criterion.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 UDP listener mapping
- [CONFIRMED] /proc/net/udp shows 127.0.0.1:5053 (inode 3667) and 127.0.0.1:5054 (inode 3862), both UDP state 07.
- [CONFIRMED] UDP inode 3667 matches PID 2844 socket FD; UDP inode 3862 matches PID 2845 socket FD.
- [CONFIRMED] Both https-dns-proxy instances therefore have active TCP and UDP local listeners on their configured ports.
- [CONFIRMED] No router configuration or service state was changed.
- [STATUS] STAGE 10 remains IN_PROGRESS pending strict per-listener query attribution / exit-criterion decision.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 nslookup capability check
- [CONFIRMED] BusyBox 1.37.0 nslookup supports only HOST [DNS_SERVER] plus query type/debug; no option for a custom DNS port.
- [CONFIRMED] Direct per-listener DNS querying of 127.0.0.1:5053 and 127.0.0.1:5054 cannot be performed with the currently installed nslookup.
- [LIMITATION] The previously observed nslookup 127.0.0.1 test validates the local dnsmasq chain, while socket/inode mapping validates both DoH listeners and their active HTTPS upstream connections, but neither independently attributes a DNS answer to each listener.
- [STATUS] STAGE 10 remains IN_PROGRESS under the strict existing criterion; no package installation or configuration change was made.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 wget capability check
- [CONFIRMED] /usr/bin/wget is available and supports HTTPS, custom HTTP headers, POST data, and timeouts.
- [LIMITATION] BusyBox wget speaks HTTP/HTTPS; it cannot issue a DNS wire-format query to the local UDP/TCP DNS listeners on ports 5053/5054, so it does not provide independent per-listener DNS attribution.
- [CONFIRMED] No router configuration, package, firewall, DNS, network, Wi-Fi, or service state was changed by this check.
- [STATUS] STAGE 10 remains IN_PROGRESS under the strict existing exit criterion.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 10 UDP queue observation
- [CONFIRMED] Before and immediately after a successful nslookup openwrt.org 127.0.0.1, both local UDP listeners 127.0.0.1:5053 and :5054 remained present with rx_queue=0 and tx_queue=0.
- [LIMITATION] /proc/net/udp queue fields are instantaneous queued-byte counts, not cumulative packet counters; the unchanged 0/0 values therefore cannot identify which listener processed the query.
- [CONFIRMED] The local dnsmasq DNS query succeeds while both DoH UDP listeners remain active.
- [STATUS] STAGE 10 remains IN_PROGRESS under the strict per-listener independent-query attribution criterion. No configuration or package state was changed.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 Zapret2 preflight
- [PASS] No zapret, tpws, or nfqws executable was found in PATH.
- [PASS] No /etc/zapret directory, /etc/init.d/zapret* entry, /usr/bin/tpws, or /usr/bin/nfqws was found.
- [CONFIRMED] STAGE 11 starts from a clean Zapret-related filesystem state based on the checked paths/commands.
- [STATUS] STAGE 11 remains IN_PROGRESS; no installation or configuration change has been made.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 extroot capacity preflight
- [PASS] /overlay is backed by /dev/sda2 (ext4, rw,noatime), size 6.6G with 6.2G available.
- [PASS] Root overlay is also reported as 6.6G, confirming the USB extroot is active.
- [OBSERVED] /tmp is tmpfs, 26.8M total with 25.0M available; no swap is placed in /tmp.
- [STATUS] STAGE 11 remains IN_PROGRESS; no package or configuration change was made.


## CHANGELOG — 2026-09-19 — [CORRECTION] workflow re-alignment
- [CONFIRMED] Master Prompt and Master Plan were re-read directly from the GitHub repository before continuing.
- [CORRECTION] The previous assistant response incorrectly advanced from STAGE 10 to STAGE 11/Zapret2. This was premature.
- [CONFIRMED] The current project work remains centered on STAGE 6 Wi-Fi root-cause investigation; STAGE 10 DoH remains IN_PROGRESS and must not be silently closed.
- [CONFIRMED] The latest STAGE 6 rules require read-only, one-command-at-a-time diagnostics and prohibit intentional Wi-Fi/hostapd/wpa_supplicant/dnsmasq/https-dns-proxy reloads or restarts during the investigation.
- [CONFIRMED] VHT40 is sufficient; simultaneous 5 GHz STA+AP and real-client Internet access are already proven. The periodic hostapd Reload all interfaces / radio0 / -122 sequence remains unresolved.
- [NEXT] Resume the exact next action defined by the master plan: targeted read-only search for direct initiators of Wi-Fi/hostapd reload in /etc/hotplug.d, /etc/init.d, /lib/netifd, /lib/wifi, and /usr/libexec.

## CHANGELOG — 2026-09-19 — [DECISION] STAGE 6 deferred by user
- [DECISION] User explicitly requested to temporarily skip STAGE 6 because the Wi-Fi/hostapd reload root cause has taken too long to isolate.
- [STATUS] STAGE 6 remains IN_PROGRESS; it is deferred, not DONE and not FAILED.
- [RULE] Do not perform the pending STAGE 6 root-cause search until the user explicitly asks to resume it.
- [DECISION] Continue the project with STAGE 11 Zapret2 while preserving all accumulated STAGE 6 evidence.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 continuation authorized
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [CONFIRMED] Earlier STAGE 11 preflight established that Zapret/Zapret2 binaries and config are absent and that the USB extroot has sufficient free space.
- [PIN] Zapret2 version remains fixed at v1.0.3; no automatic upgrade is permitted.
- [SOURCE] Official upstream release is bol-van/zapret2 v1.0.3, release commit b78b52c; release assets include zapret2-v1.0.3-openwrt-embedded.tar.gz and sha256sum.txt.
- [NEXT] First router action is read-only checksum-source verification for the pinned OpenWrt embedded archive. No installation or configuration change in this step.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 checksum-source diagnostic
- [FAILED] The attempted read-only command used `wget -S`, but this OpenWrt BusyBox wget build does not support the `-S` option; it supports `-s` only for spider mode.
- [CONFIRMED] Because wget rejected the option before processing the URL, the checksum file was not downloaded and no checksum was obtained.
- [CONFIRMED] No Zapret2 archive was downloaded, installed, extracted, configured, or executed.
- [STATUS] STAGE 11 remains IN_PROGRESS; checksum verification is NOT_STARTED/blocked at the download diagnostic, not a Zapret2 failure.
- [NEXT] Use the installed wget capabilities correctly with a single read-only download command without `-S`, saving `sha256sum.txt` to `/tmp/zapret-sha256.txt` and printing its contents.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 release asset digest confirmed
- [PASS] Read-only GitHub Release API inspection confirmed release v1.0.3 asset `zapret2-v1.0.3-openwrt-embedded.tar.gz` is uploaded and has size 4,314,955 bytes.
- [PASS] Official GitHub Release asset digest is `sha256:58e3aca09d50aa93d168e81993b19eb2f018d690af068551e88ae593bd786e2a`.
- [CONFIRMED] The digest is provided by GitHub for the exact pinned release asset; the separate `sha256sum.txt` contains checksums for files inside the release tree and does not list the embedded archive itself.
- [CONFIRMED] No Zapret2 archive was downloaded, installed, extracted, configured, or executed in this step.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Download the exact pinned `zapret2-v1.0.3-openwrt-embedded.tar.gz` archive to `/tmp`, calculate its SHA-256 locally, and compare it byte-for-byte with the official GitHub asset digest before extraction or installation.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive content inspection PASS
- [PASS] Read-only `tar -tzf /tmp/zapret2-v1.0.3-openwrt-embedded.tar.gz` completed successfully.
- [CONFIRMED] The pinned v1.0.3 embedded archive contains the OpenWrt init integration under `init.d/openwrt/`, including `90-zapret2`, `zapret2`, `functions`, and `firewall.zapret2`.
- [CONFIRMED] The archive contains MIPS binaries under `binaries/linux-mips/`: `ip2net`, `mdig`, and `nfqws2`.
- [CONFIRMED] The archive also contains other architectures, but no installation has been performed and no non-MIPS binary has been selected for the router.
- [CONFIRMED] Blockcheck2 scripts, Lua support files, fake packet data, ipset helpers, common firewall helpers, and installer scripts are present in the archive.- [CONFIRMED] Archive content inspection made no filesystem, package, firewall, network, Wi-Fi, service, or configuration changes on the router.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Before extraction/installation, perform a read-only inspection of the MIPS binary architecture/type and the OpenWrt installer/init scripts to verify compatibility and determine the minimum installation set for this 64 MiB MIPS router.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 installer architecture detection PASS
- [PASS] Read-only extraction of `install_bin.sh` and grep for architecture detection completed.- [CONFIRMED] The v1.0.3 installer explicitly includes `linux-mips`, `linux-mipsel`, `linux-mips64`, `linux-mipsel64`, `linux-lexra` and other architectures in its candidate list.
- [CONFIRMED] The installer reads ELF architecture metadata from binaries and compares it with the running environment before selecting a binary directory.
- [CONFIRMED] The script's normal successful path copies `ip2net`, `mdig`, and the packet-processing binary from the matching architecture directory; no installation was executed.
- [IMPORTANT] This output confirms that `linux-mips` is an explicit supported candidate, but it does not yet prove that the router's exact MIPS ABI/ELF type matches the archive binary.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform a read-only extraction of the actual `linux-mips` binaries and inspect their ELF header/type on the router before any installation.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive lost after reboot
- [CONFIRMED] Router was rebooted after a power interruption.
- [CONFIRMED] The pinned Zapret2 archive previously stored under `/tmp` is absent after reboot because `/tmp` is RAM-backed/tmpfs and is not persistent storage.
- [CONFIRMED] The attempted read-only ELF inspection could not run because the archive was no longer present.
- [NO CHANGE] No Zapret2 installation, extraction to the persistent filesystem, configuration, firewall, or service activation occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Re-download the exact pinned v1.0.3 archive to `/tmp` and re-verify SHA-256 against the already confirmed official GitHub asset digest before continuing ELF inspection.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 download blocked after reboot
- [FAILED] Re-download attempt for the pinned Zapret2 v1.0.3 archive failed with BusyBox wget: `Failed to send request: Operation not permitted`.
- [CONFIRMED] Failure occurred before SHA-256 calculation because wget did not create/download the archive.
- [CONFIRMED] This is a network/request-permission failure at the current router state; it is not evidence of a bad Zapret2 archive or checksum mismatch.
- [NO CHANGE] No Zapret2 installation, extraction, configuration, firewall, or service activation occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Diagnose the current outbound HTTPS/request path with a single read-only connectivity test before attempting another archive download.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 GitHub API connectivity PASS
- [PASS] Read-only BusyBox wget test to the official GitHub API succeeded after the previous `Operation not permitted` failure.
- [CONFIRMED] Router established HTTPS connection to api.github.com:443 and received the v1.0.3 release JSON for bol-van/zapret2.
- [CONFIRMED] This demonstrates that outbound HTTPS/GitHub API access is currently working; the previous download failure is not persistent at the API endpoint level.
- [NO CHANGE] No Zapret2 installation, extraction, configuration, firewall, Wi-Fi, or service state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Retry the exact pinned v1.0.3 embedded archive download to /tmp and immediately verify its SHA-256 against the already confirmed official GitHub asset digest before any extraction or installation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive download to persistent extroot PASS
- [PASS] Pinned Zapret2 v1.0.3 embedded archive downloaded successfully to persistent USB extroot path `/overlay/tmp/zapret2/zapret2-v1.0.3-openwrt-embedded.tar.gz`.
- [CONFIRMED] Downloaded size is 4,314,955 bytes, matching the official GitHub release asset size already verified.
- [IMPORTANT] The archive is now stored on persistent extroot rather than `/tmp`, avoiding unnecessary RAM/tmpfs consumption and preventing loss across reboot.
- [NO CHANGE] No extraction, installation, configuration, firewall, Wi-Fi, or service activation was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Calculate and verify the local SHA-256 against the already confirmed official digest before any extraction or installation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive extraction PASS
- [PASS] Verified SHA-256 matched the pinned official v1.0.3 release digest before extraction.
- [PASS] Zapret2 v1.0.3 embedded archive was extracted successfully into persistent extroot storage at `/overlay/tmp/zapret2/extract`.
- [NO CHANGE] No Zapret2 installation, executable deployment, configuration, firewall rule, service activation, or Wi-Fi/network restart was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform read-only ELF architecture/type inspection of the extracted `linux-mips` binaries before any installation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 ELF inspection tool unavailable
- [OBSERVED] BusyBox ash reported `file: not found` when attempting read-only ELF inspection; no package was installed.
- [NO CHANGE] No Zapret2 installation or configuration was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Use built-in read-only hex inspection of ELF headers instead of installing a diagnostic package.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 nfqws2 ELF header PASS
- [PASS] Read-only ELF header inspection of extracted `linux-mips/nfqws2` succeeded using BusyBox hexdump.
- [CONFIRMED] ELF32, big-endian data encoding, machine type MIPS (e_machine=8).
- [NO CHANGE] No package installation, binary installation, service activation, firewall modification, or Wi-Fi/network restart was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect the ELF headers of the remaining `linux-mips` binaries `ip2net` and `mdig` using the same read-only method.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 installer architecture logic inspected
- [PASS] Read-only inspection of `install_bin.sh` confirmed the installer has explicit architecture detection and includes `linux-mips`, `linux-mipsel`, `linux-mips64`, `linux-mipsel64`, and `linux-lexra` candidates.
- [CONFIRMED] The installer derives an ELF architecture value via `read_elf_arch` before selecting the binary architecture; no installation was executed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect the definition of `read_elf_arch` to determine exactly how the installer distinguishes the supported MIPS variants/ABI.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 ELF architecture compatibility PASS
- [PASS] Reproduced the Zapret2 installer's `read_elf_arch` calculation without executing or installing anything.
- [CONFIRMED] Running `/bin/sh` returns ELF identifier `010008`.
- [CONFIRMED] Extracted `linux-mips/ip2net` returns the same ELF identifier `010008`.
- [CONCLUSION] The selected `linux-mips` binary matches the router's executable ELF class/machine identifier used by the installer.
- [NO CHANGE] No Zapret2 installation, configuration, firewall, service activation, or Wi-Fi/network restart was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform the installer's actual read-only compatibility execution test for `ip2net` (stdin `0.0.0.0`) without running the installer itself.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 ip2net runtime compatibility PASS
- [PASS] Extracted `linux-mips/ip2net` executed successfully on the router with the installer's test input `0.0.0.0`.
- [CONFIRMED] Output was `0.0.0.0`, matching the installer's non-empty-output success criterion.
- [CONFIRMED] ELF identifier already matched the router `/bin/sh` as `010008`.
- [NO CHANGE] Zapret2 was not installed, enabled, configured, or integrated into firewall/network/Wi-Fi services.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform the same standalone runtime compatibility test for `mdig` and `nfqws2` only as appropriate, or inspect installer requirements before any deployment.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 install_bin requirements inspected
- [PASS] Read-only inspection of `install_bin.sh` completed through the binary deployment path.
- [CONFIRMED] On Linux the installer selects `nfqws2` as the packet-processing binary and tests architecture candidates including `linux-mips`.
- [CONFIRMED] On a successful match it would link `ip2net`, `mdig`, and `nfqws2` into `$ZAPRET_BASE/ip2net`, `$ZAPRET_BASE/mdig`, and `$ZAPRET_BASE/nfq2`; this deployment has NOT been executed.
- [IMPORTANT] The installer can remove an existing same-named file before creating each link; therefore no installer execution is authorized yet.
- [NO CHANGE] No Zapret2 files were installed into active paths, and no services/firewall/Wi-Fi/network settings were changed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect the embedded OpenWrt integration/install scripts read-only to determine prerequisites and exact installation scope before any deployment.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 OpenWrt integration inspection
- [PASS] Read-only inspection of Zapret2 OpenWrt integration scripts completed.
- [CONFIRMED] `zapret2` is a procd service with START=21 and can apply/remove firewall rules through `zapret_apply_firewall` / `zapret_unapply_firewall`.
- [CONFIRMED] The service launches `nfqws2` via the deployed `nfq2/nfqws2` path and uses Lua anti-DPI modules from the Zapret2 tree.
- [IMPORTANT] `90-zapret2` can react to interface up/down events and reload nftables interface sets; this integration must not be activated until configuration is reviewed.
- [NO CHANGE] No init script, firewall rule, service, Wi-Fi, or network configuration was installed or activated.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect the OpenWrt integration functions and configuration requirements read-only before deployment.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 firewall/NFQUEUE preflight
- [PASS] `nft` is available at `/usr/sbin/nft`.
- [PASS] `nfnetlink_queue` and `nfnetlink` kernel modules are loaded.
- [OBSERVED] `iptables` and `ip6tables` are absent; this OpenWrt system is using the nftables path, consistent with the inspected Zapret2 OpenWrt integration.
- [NO CHANGE] No modules were loaded, no firewall rules were changed, and Zapret2 was not installed or activated.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform the minimal `nfqws2` standalone startup/help check before deployment.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 nfqws2 runtime check
- [PASS] Extracted Zapret2 v1.0.3 MIPS `nfqws2` executed natively on the router and printed its version/usage.
- [CONFIRMED] Binary reports github version v1.0.3 (b78b52c4cd7f843da3ff0848a3430afbd401bdf2).
- [OBSERVED] `--help` is not a recognized option, but the binary still returned its built-in option/usage text; this is not a failure of the binary.
- [NO CHANGE] No daemon, NFQUEUE interception, or firewall configuration was started.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform the minimal `nfqws2 --version` exit check, then proceed to deployment if PASS.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 nfqws2 version check PASS
- [PASS] Standalone `nfqws2 --version` executed successfully on the router.
- [CONFIRMED] Runtime reports Zapret2 v1.0.3, commit b78b52c4cd7f843da3ff0848a3430afbd401bdf2, lua_compat_ver 6.
- [CONFIRMED] Native MIPS execution is therefore verified beyond the earlier usage/startup check.
- [NO CHANGE] No daemon, NFQUEUE interception, firewall rule, service, Wi-Fi, or network configuration was started or changed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Proceed to the minimum deployment step only after preserving the current preflight evidence; installation/configuration remain separate from this runtime test.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 Zapret2 embedded v1.0.3 file deployment
- [CONFIRMED] User requirement: after each user+assistant message pair, record factual OpenWrt Variant A changes in the master plan and update the master prompt when the workflow/rules need a change.
- [PASS] install_bin.sh getarch returned linux-mips.
- [PASS] /opt and /opt/zapret2 were initially absent; no pre-existing Zapret2 installation was overwritten.
- [PASS] Created /opt/zapret2 directory structure and copied the embedded v1.0.3 OpenWrt components without starting Zapret2.
- [PASS] Copied files/fake, common, ipset, blockcheck2.d, lua, OpenWrt init integration, config.default, installer/helper scripts, and the verified linux-mips binaries.
- [PASS] Created the three standard links: /opt/zapret2/nfq2/nfqws2, /opt/zapret2/ip2net/ip2net, /opt/zapret2/mdig/mdig.
- [PASS] Read-only verification: /opt/zapret2 contains 130 regular files and 3 symbolic links; nfqws2, ip2net, mdig are executable MIPS binaries.
- [CONFIRMED] The embedded release root contains config.default but no config; an attempted copy including config failed with cp: can't stat .../config, and no subsequent damage occurred. The correct config.default was then copied.
- [SAFETY] install_easy.sh was NOT executed. No Zapret2 daemon, firewall/NFQUEUE interception, cron, interface hook, or Wi-Fi/network reload was started by these deployment steps.
- [STATUS] STAGE 11 remains IN_PROGRESS; installation file layout is deployed, but service/firewall integration is intentionally not started.
- [NEXT] Perform a read-only runtime check of /opt/zapret2/ip2net/ip2net, then continue only one command at a time.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 installed ip2net runtime PASS
- [PASS] /opt/zapret2/ip2net/ip2net accepted 0.0.0.0 and returned 0.0.0.0.
- [CONFIRMED] Installed symlink resolves to the verified linux-mips ip2net binary and executes successfully on the router.
- [NO CHANGE] No daemon, firewall, NFQUEUE rule, cron, interface hook, Wi-Fi, or network configuration was started or changed by this test.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Continue with one read-only/runtime compatibility check at a time; do not start Zapret2 integration yet.


SYNC 2026-09-19: [PASS] STAGE 11 standalone `/opt/zapret2/nfq2/nfqws2 --version` completed successfully. Runtime reports Zapret2 v1.0.3, commit `b78b52c4cd7f843da3ff0848a3430afbd401bdf2`, `lua_compat_ver 6`. No daemon, NFQUEUE interception, firewall rule, Wi-Fi or network configuration was started or changed. STAGE 11 remains IN_PROGRESS. NEXT: proceed to controlled installation of the OpenWrt service integration only after preserving the verified binary preflight; service/firewall activation remains a separate step.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 OpenWrt init integration files deployed
- [PASS] Controlled command copied `/opt/zapret2/init.d/openwrt/.` into `/etc/init.d/`.
- [CONFIRMED] Installed files: `/etc/init.d/90-zapret2` (840 bytes), `/etc/init.d/firewall.zapret2` (238 bytes), `/etc/init.d/zapret2` (2987 bytes), all timestamped 2026-09-19 18:14.
- [CONFIRMED] `/etc/init.d/zapret2` is executable; `90-zapret2` and `firewall.zapret2` are regular non-executable init integration files as deployed by the archive.
- [NO ACTIVATION] This command only placed init integration files; it did NOT start Zapret2, apply firewall/NFQUEUE rules, enable the service, add cron, or intentionally reload Wi-Fi/network services.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect the deployed init scripts/configuration read-only before any service enable/start or firewall activation.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 configuration-default preflight
- [PASS] Read-only grep of `/opt/zapret2/config.default` and `/opt/zapret2/init.d/openwrt/functions` completed successfully.
- [CONFIRMED] `INIT_APPLY_FW=1` is the release default, meaning service start can apply Zapret2 firewall integration unless explicitly controlled; therefore activation remains a separate gated step.
- [CONFIRMED] `NFQWS2_ENABLE=0` is the release default, so the nfqws2 packet processor is disabled by default until configuration changes are deliberately made.
- [CONFIRMED] Default NFQWS2 ports are TCP 80,443 and UDP 443; packet limits are TCP out 20/in 10 and UDP out 5/in 3.
- [CONFIRMED] `DESYNC_MARK=0x40000000` and `DESYNC_MARK_POSTNAT=0x20000000` match the values already observed in the OpenWrt integration defaults.
- [CONFIRMED] `QNUM=300`, `WS_USER=daemon`, and `OPENWRT_LAN=lan` are the integration defaults.
- [CONFIRMED] `MODE_FILTER=none` is the config.default value.
- [NO CHANGE] No service start/enable, firewall rule, NFQUEUE interception, network/Wi-Fi reload, or configuration activation was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Continue with read-only inspection of the relevant config.default section around INIT_APPLY_FW/NFQWS2 and the daemon configuration before any activation.

## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 full config.default section inspected
- [PASS] Read-only `sed -n '50,125p' /opt/zapret2/config.default` completed.
- [CONFIRMED] `NFQWS2_ENABLE=0`; no nfqws2 activation is currently requested by the release default.
- [CONFIRMED] `NFQWS2_OPT` contains HTTP/TLS/QUIC desync profiles, but these options are inert while `NFQWS2_ENABLE=0`.
- [CONFIRMED] `MODE_FILTER=none`; hostlist/ipset filtering is not selected by default.
- [CONFIRMED] `FLOWOFFLOAD=donttouch`; Zapret2 does not request a flow-offload change by this default.
- [CONFIRMED] `INIT_APPLY_FW=1`; service start/stop is configured to apply/unapply firewall integration on nftables OpenWrt unless the runtime path explicitly bypasses it.
- [CONFIRMED] Default OpenWrt LAN is `lan`; WAN/WAN6 are auto-detected unless explicitly configured.
- [NO CHANGE] No service enable/start, firewall/NFQUEUE rules, network/Wi-Fi reload, or config activation was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform one read-only check of the current active config file location/content and whether a separate runtime config exists, before any configuration editing or activation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 runtime config location check
- [PASS] Read-only check confirms `/opt/zapret2/config` does not exist; only `/opt/zapret2/config.default` is currently present.
- [CONFIRMED] `/opt/zapret2/init.d/openwrt/functions` and `90-zapret2` resolve `ZAPRET_CONFIG` to `$ZAPRET_RW/config` and source that file directly.
- [CONFIRMED] `/opt/zapret2/common/installer.sh` also writes/replaces variables in `$ZAPRET_CONFIG` during installer configuration.
- [IMPORTANT] `config.default` is not automatically the active runtime config: a separate `/opt/zapret2/config` is expected by the deployed init integration.
- [NO CHANGE] No config file was created, no service was enabled/started, no firewall/NFQUEUE rules were applied, and no network/Wi-Fi reload occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Before creating or editing the runtime config, perform one read-only inspection of the relevant installer/config initialization logic to determine the safe source/copy mechanism and required minimal variables.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 config creation mechanism confirmed
- [PASS] Read-only grep confirms `install_easy.sh` and `install_prereq.sh` define `ZAPRET_CONFIG=$ZAPRET_RW/config` and `ZAPRET_CONFIG_DEFAULT=$ZAPRET_BASE/config.default`.
- [CONFIRMED] Both scripts create the runtime config only when it does not exist, by creating its parent directory and copying `config.default` to `config`.
- [CONFIRMED] `common/installer.sh` subsequently modifies variables inside `$ZAPRET_CONFIG` through its configuration helpers.
- [IMPORTANT] This confirms the expected `/opt/zapret2/config` creation path without requiring blind execution of the full installer.
- [NO CHANGE] No runtime config was created or edited; no service, firewall/NFQUEUE, network/Wi-Fi activation occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect only the first configuration/initialization section of `install_prereq.sh` read-only to determine whether its early setup is safe to reuse or whether runtime config creation should be performed as a separate controlled file operation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 install_prereq early-path inspection
- [PASS] Read-only inspection of `/opt/zapret2/install_prereq.sh` lines 1–80 completed.
- [CONFIRMED] Runtime config initialization occurs immediately after variable definitions: if `$ZAPRET_CONFIG` is absent, the script creates its parent directory and copies `$ZAPRET_CONFIG_DEFAULT` to `$ZAPRET_CONFIG`.
- [CONFIRMED] Only after that copy does the script source config/common modules and proceed to `fix_sbin_path`, `fsleep_setup`, `check_system`, `require_root`, firewall selection, IPv6 selection and OpenWrt prerequisite checks.
- [IMPORTANT] The runtime config creation can therefore be isolated safely as a file-copy operation; the full `install_prereq.sh` remains a separate gated operation and will not be executed merely to create the config.
- [NO CHANGE] No runtime config, service, firewall/NFQUEUE, network or Wi-Fi state was changed by this inspection.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Create `/opt/zapret2/config` as an exact copy of the verified `/opt/zapret2/config.default`, then verify it read-only before any edits or activation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 runtime config created
- [PASS] Controlled `cp -p /opt/zapret2/config.default /opt/zapret2/config` completed with empty output.
- [CONFIRMED] The runtime config file has been created from the verified default template; exact content/metadata match is pending the next read-only verification.
- [NO CHANGE] No Zapret2 service, NFQUEUE interception, firewall rule, network/Wi-Fi reload, or reboot was performed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Verify `/opt/zapret2/config` existence, size, and SHA-256 equality with `config.default` using one read-only command.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 11 runtime config integrity verified
- [PASS] `/opt/zapret2/config` exists and is 5534 bytes.
- [PASS] `/opt/zapret2/config.default` exists and is 5534 bytes.
- [PASS] SHA-256 is identical for both files: `758cf25e3d57ccf2c0dd053b218d571e6ebb293293f341c8e5294a35ceed2f7b`.
- [CONFIRMED] Runtime config is an exact byte-for-byte copy of the shipped default template and has not yet been customized.
- [NO CHANGE] No Zapret2 service start/enable, firewall/NFQUEUE activation, interface hook activation, network/Wi-Fi reload, or reboot occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform a read-only configuration suitability audit of the runtime config for this OpenWrt topology before changing any variables or enabling Zapret2.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 11 runtime config default-state audit
- [PASS] Read-only audit of `/opt/zapret2/config` confirms the runtime configuration remains default/unmodified.
- [CONFIRMED] `NFQWS2_ENABLE=0`; TCP ports default `80,443`; UDP port default `443`; packet limits remain defaults (TCP OUT 20 / IN 10, UDP OUT 5 / IN 3).
- [CONFIRMED] `MODE_FILTER=none`, `FLOWOFFLOAD=donttouch`, `INIT_APPLY_FW=1`.
- [IMPORTANT] No explicit `ZAPRET_BASE`, `ZAPRET_RW`, `ZAPRET_CONFIG`, LAN/WAN override, or other custom activation setting is present in the runtime config; integration defaults from the OpenWrt init/functions layer therefore remain authoritative.
- [NO CHANGE] No config edits, service activation, firewall/NFQUEUE changes, network/Wi-Fi reload, or reboot occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Read-only audit the full config defaults around DNS, hostlists, mode/filter, offload and OpenWrt integration before deciding whether any configuration change is required.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 11 full runtime config audit
- [PASS] Full `/opt/zapret2/config` (lines 1–125) was inspected read-only.
- [CONFIRMED] Runtime config is still the exact default template; no custom variables have been added.
- [CONFIRMED] `NFQWS2_ENABLE=0`, `MODE_FILTER=none`, `FLOWOFFLOAD=donttouch`, `INIT_APPLY_FW=1`.
- [CONFIRMED] Default IP-set sizing is `SET_MAXELEM=522288` with `IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"`.
- [IMPORTANT] Because this router has only 64 MB RAM and already uses ZRAM/USB swap, the default IP-set/hash sizing must be assessed before any hostlist/ipset activation. Do not assume the default is suitable.
- [CONFIRMED] Default NFQWS2 rules contain HTTP/TLS/QUIC desync definitions but are inert while `NFQWS2_ENABLE=0` and `MODE_FILTER=none`.
- [NO CHANGE] No config edit, service start/enable, firewall/NFQUEUE activation, network/Wi-Fi reload, or reboot occurred.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform a read-only inspection of where `SET_MAXELEM` and `IPSET_OPT` are consumed, to estimate whether default hash allocation could be excessive before any activation.


## CHANGELOG — 2026-09-19 — [SYNC] User-requested complete STAGE 11 record
- [PASS] Complete STAGE 11 runtime-config discovery/deployment sequence recorded: missing runtime config, installer logic confirmation, isolated creation, exact integrity verification, and full default-config audit.
- [PASS] `/opt/zapret2/config` was created only by copying `/opt/zapret2/config.default`; no full installer was run for this purpose.
- [PASS] Both files are 5534 bytes with identical SHA-256 `758cf25e3d57ccf2c0dd053b218d571e6ebb293293f341c8e5294a35ceed2f7b`.
- [CONFIRMED] Runtime config remains default/inactive: `NFQWS2_ENABLE=0`, `MODE_FILTER=none`, `FLOWOFFLOAD=donttouch`, `INIT_APPLY_FW=1`; HTTP/TLS/QUIC NFQWS2 definitions remain inert.
- [IMPORTANT] `SET_MAXELEM=522288` and `hashsize 262144` are a mandatory memory-safety gate on the 64 MB router before hostlist/ipset activation.
- [NO ACTIVATION] No Zapret2 service start/enable, firewall/NFQUEUE application, interface-hook activation, network/Wi-Fi reload, or reboot occurred in this sequence.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect read-only how `IPSET_OPT` / `SET_MAXELEM` are consumed and estimate actual memory impact before activation or tuning.


## SYNC RULE UPDATE 2026-09-19 — STAGE 11 compact-output audit rule
- [CONFIRMED] User requires compact router-command output to minimize text copied into AI context.
- [RULE] Prefer targeted read-only commands with filtered/compact output (grep/sed/awk/cut when useful) instead of broad dumps.
- [RULE] One router command per step remains mandatory; compact output must not hide evidence needed for the factual state decision.
- [RULE] After each user+assistant pair, synchronize the factual result into this master plan; update the master prompt when the workflow rule changes.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Run one compact read-only search for where Zapret2 consumes NFQWS2/configuration/OpenWrt integration variables; no activation or network/Wi-Fi reload.


## CHANGELOG — 2026-09-19 — [PASS] STAGE 11 ipset/config consumer audit
- [PASS] Read-only grep completed for `IPSET_OPT`, `SET_MAXELEM`, `hashsize`, `maxelem` and for the main runtime variables.
- [CONFIRMED] `IPSET_OPT` / `SET_MAXELEM` are consumed by `/opt/zapret2/ipset/create_ipset.sh`; nftables/iptables paths use the resulting sets only when `MODE_FILTER=ipset`.
- [CONFIRMED] `/opt/zapret2/ipset/def.sh` defaults are `SET_MAXELEM=262144`, `IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"`, while the runtime config explicitly overrides `SET_MAXELEM=522288`.
- [IMPORTANT] The current runtime value is therefore substantially larger than the package default and remains a memory-safety concern on the 64 MB hAP ac lite. No ipset/hostlist activation is authorized yet.
- [CONFIRMED] `NFQWS2_ENABLE=0`, `MODE_FILTER=none`, and `FLOWOFFLOAD=donttouch` mean these ipset consumers are currently inactive.
- [NO CHANGE] No configuration, firewall/NFQUEUE, service, network/Wi-Fi state or storage was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Perform one compact read-only inspection of the exact `create_ipset.sh` backend branch around `create_ipset/create_nfset` to determine whether nftables uses kernel nft sets or legacy ipset semantics and what allocation is actually requested.

## CHANGELOG — 2026-09-19 — [SYNC] Zapret2 ipset consumer audit
- [PASS] Read-only audit completed for `IPSET_OPT`, `SET_MAXELEM`, `hashsize` and `maxelem` consumers.
- [CONFIRMED] `/opt/zapret2/ipset/create_ipset.sh` passes `IPSET_OPT` to ipset-mode sets and passes `SET_MAXELEM` directly to nftset creation.
- [CONFIRMED] `/opt/zapret2/ipset/def.sh` defaults to `SET_MAXELEM=262144` and `IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"` when not overridden.
- [CONFIRMED] Current runtime config explicitly overrides these defaults with `SET_MAXELEM=522288` and `IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"`.
- [IMPORTANT] The high `SET_MAXELEM=522288` value is not merely informational: it is consumed by actual ipset/nftset creation paths. On this 64 MB router it must be treated as a memory-risk parameter and must not be enabled until resource impact is assessed.
- [CONFIRMED] Current `NFQWS2_ENABLE=0` and `MODE_FILTER=none` keep the Zapret2 filtering path inactive; no ipset/nftset activation occurred during this audit.
- [CONFIRMED] `FLOWOFFLOAD=donttouch` is only acted upon for software/hardware values in the inspected nft paths.

## CHANGELOG — 2026-09-20 — [PASS] DNS rollback and Wi-Fi/DHCP recovery
- [CONTEXT] User changed DNS on the MikroTik/OpenWrt router through the OpenWrt application; afterward the phone had difficulty obtaining an IP / connecting normally.
- [DIAGNOSTIC] dnsmasq was found stopped. UCI showed custom DNS/DoH parameters: noresolv=1, multiple server entries, doh_server=127.0.0.1#5053/5054, and related backup settings.
- [ACTION] Only the custom DNS/DoH parameters were removed from the dnsmasq UCI section; DHCP/LAN settings were preserved. uci commit dhcp completed with empty output.
- [DIAGNOSTIC] The generated dnsmasq configuration still contained the old server entries, and logs showed “Cannot resolve server name at line 21” followed by “FAILED to start up” and a crash loop.
- [ACTION] /etc/init.d/dnsmasq restart regenerated the configuration and started dnsmasq successfully. The concurrent udhcpc “no lease” message concerned WAN DHCP, not LAN DHCP.
- [PASS] Final verification: dnsmasq status = running; dnsmasq process present; log shows it reads /tmp/resolv.conf.d/resolv.conf.auto and uses upstream DNS 192.168.0.1#53.
- [PASS] DHCP verification: dnsmasq reports 192.168.1.100–192.168.1.249, lease time 12h; br-lan is UP with 192.168.1.1/24; dnsmasq listens on UDP/67.
- [PASS] Wi-Fi verification: phone station is authenticated, associated and authorized, with strong signal around -40 dBm.
- [PASS] User confirmed that internet on the phone works.
- [CONCLUSION] The immediate DNS-induced dnsmasq failure is resolved by reverting the custom DNS/DoH settings and regenerating dnsmasq configuration. DHCP/Wi-Fi/internet functionality is currently working.
- [NO FURTHER DIAGNOSTIC] DHCP packet capture was not needed because the phone was already online.
- [SAFETY] No Zapret2 activation, firewall/NFQUEUE changes, routing changes, Wi-Fi configuration changes, or storage changes were performed during this recovery.
- [STATUS] Wi-Fi/DHCP incident is resolved; no further corrective action is pending.
- [NEXT] Preserve this working DNS state. If DoH/DNS is reintroduced later, test it separately and verify dnsmasq starts successfully before proceeding.


## CURRENT AUTHORITATIVE STATE — SYNC 2026-09-20 — TP-LINK WI-FI SSH ACCESS

This block is authoritative over older historical entries when they conflict with the latest verified runtime state.

### Topology and addressing
- [CONFIRMED] Main router remains TP-Link Archer C20 v4.
- [CONFIRMED] MikroTik hAP ac lite / RB952Ui-5ac2nD remains downstream from the TP-Link through Wi-Fi STA; MikroTik does NOT replace the TP-Link as the main router.
- [CONFIRMED] TP-Link LAN/upstream subnet is 192.168.0.0/24; TP-Link gateway is 192.168.0.1.
- [CONFIRMED] MikroTik WAN is DHCP on eth1 and currently receives 192.168.0.100/24 with gateway 192.168.0.1.
- [CONFIRMED] MikroTik LAN remains 192.168.1.1/24 on br-lan.
- [CONFIRMED] MikroTik WAN MAC is b8:69:f4:d6:e8:a0.
- [SECURITY] The MikroTik SSH rule is limited to source subnet 192.168.0.0/24; Internet-wide SSH access is not intended.

### SSH access from TP-Link Wi-Fi — DONE
- [CONFIRMED] SSH daemon is listening on TCP/22 on 0.0.0.0.
- [CONFIRMED] Before the firewall change, WAN input policy was REJECT and there was no TCP/22 allow rule.
- [CHANGE] Added UCI firewall rule:
  - ID: cfg0e92bd
  - name: Allow-SSH-from-TPLink
  - src: wan
  - src_ip: 192.168.0.0/24
  - proto: tcp
  - dest_port: 22
  - target: ACCEPT
- [PASS] Firewall configuration was committed and reloaded successfully.
- [PASS] Firewall reload completed without error; the existing https-dns-proxy NOTRACK include was loaded normally.
- [PASS] User verified that a device connected to TP-Link SweetHomeU Wi-Fi can SSH to MikroTik at 192.168.0.100.
- [RESULT] Deferred task “access OpenWrt from TP-Link Wi-Fi without LAN” is now completed.
- [SAFETY] No uhttpd/LuCI was installed. User explicitly chose CLI/SSH management because of the router's limited RAM.
- [SAFETY] No LAN addressing, WAN DHCP mode, Wi-Fi configuration, routing topology, or Zapret2 activation was changed to achieve SSH access.

### TP-Link DHCP reservation — DONE
- [CONFIRMED] TP-Link Archer C20 V4 DHCP reservation has been created and restored to the MAC address actually observed by the TP-Link for the MikroTik Wi-Fi STA client.
- [CONFIRMED] TP-Link DHCP/client table shows: IP `192.168.0.100` → MAC `BA:69:F4:D6:E8:A5` for device `Openwrt`.
- [CONFIRMED] MikroTik `eth1` WAN interface itself reports MAC `B8:69:F4:D6:E8:A0`; this is a different interface MAC and is not the MAC TP-Link uses for the DHCP reservation in this Wi-Fi-STA topology.
- [CONFIRMED] The TP-Link reservation was temporarily entered with `B8:69:F4:D6:E8:A0`, then corrected back to `BA:69:F4:D6:E8:A5` after the TP-Link DHCP/client table confirmed that `BA:69:F4:D6:E8:A5` is the MAC associated with `192.168.0.100`.
- [CONFIRMED] Current intended reservation: `BA:69:F4:D6:E8:A5` → `192.168.0.100`, enabled/default group.
- [RULE] Keep MikroTik WAN configured as DHCP. Do not convert the MikroTik WAN to a manually configured static IP merely to achieve address persistence.
- [RESULT] TP-Link-side DHCP reservation task is complete for the currently observed MikroTik Wi-Fi STA client identity.

### DNS recovery state — PRESERVE
- [CONFIRMED] The DNS-induced dnsmasq failure from 2026-09-20 was resolved by removing the custom DNS/DoH UCI parameters and regenerating dnsmasq configuration.
- [CONFIRMED] Current working upstream DNS path is via /tmp/resolv.conf.d/resolv.conf.auto, upstream 192.168.0.1#53.
- [RULE] Do not reintroduce DoH/DNS customization until it is tested separately and dnsmasq startup is verified.
- [IMPORTANT] The current working DNS state is separate from the SSH access change and must be preserved.

### Stage status at this sync
- STAGE 0 — DONE
- STAGE 1 — DONE
- STAGE 2 — DONE
- STAGE 3 — DONE
- STAGE 4 — DONE
- STAGE 5 — DONE
- STAGE 6 — IN_PROGRESS (deferred by user; current Wi-Fi works, historical reload/-122 root cause remains bounded/unresolved)
- STAGE 7 — DONE
- STAGE 8 — DONE
- STAGE 9 — DONE (ZRAM + USB swap verified)
- STAGE 10 — IN_PROGRESS (DoH baseline/chain verified with stated per-listener attribution limitation; DNS was subsequently rolled back on 2026-09-20)
- STAGE 11 — IN_PROGRESS (Zapret2 deployed but intentionally inactive)
- STAGE 12–30 — NOT_STARTED

### What was checked for missing plan synchronization
- [FIXED] The prior deferred TP-Link-Wi-Fi → MikroTik SSH-access task is now recorded with actual WAN address, WAN MAC, firewall rule, commit/reload result, and user-confirmed successful SSH access.
- [FIXED] The decision not to install uhttpd/LuCI and to use CLI/SSH management is recorded.
- [ADDED] The remaining TP-Link-side DHCP reservation task is explicitly recorded as NOT_STARTED, with exact MAC/IP values and the official Archer C20 V4 UI path.
- [CONFIRMED] The 2026-09-20 DNS rollback/recovery was already present in the plan and is retained; no duplicate or conflicting recovery is introduced.
- [RULE] Do not mark TP-Link DHCP reservation DONE until it is actually created/verified on the Archer C20 V4.
- [RULE] This SSH-access change does not require a Master Prompt workflow-rule update; existing one-step-at-a-time, synchronization, compact-output, and safety rules remain sufficient.

## CHANGELOG — 2026-09-20 — [SYNC] TP-Link Wi-Fi SSH access and DHCP reservation tracking
- [PASS] Read-only/verified topology state recorded: TP-Link 192.168.0.1/24 → MikroTik WAN DHCP 192.168.0.100/24 → MikroTik LAN 192.168.1.1/24.
- [PASS] MikroTik WAN MAC recorded in the operational plan: b8:69:f4:d6:e8:a0.
- [PASS] Firewall rule Allow-SSH-from-TPLink recorded with source 192.168.0.0/24 and TCP/22 destination.
- [PASS] User-confirmed SSH access from a TP-Link SweetHomeU Wi-Fi client to 192.168.0.100.
- [PASS] uhttpd/LuCI intentionally not installed; CLI/SSH remains the management method.
- [NOT_STARTED] TP-Link DHCP reservation for 192.168.0.100 → B8-69-F4-D6-E8-A0 has not yet been created/verified.
- [NEXT] On the TP-Link, use DHCP → Address Reservation → Add New; enter the MikroTik WAN MAC and 192.168.0.100, enable the entry, save, and then verify the reservation.
- [NO CHANGE] No MikroTik router command or network configuration is required merely to prepare this TP-Link reservation; MikroTik WAN remains DHCP.

## CHANGELOG — 2026-09-20 — [SYNC] Wi-Fi channel width set to 20 MHz
- [CONFIRMED] User reports that Wi-Fi channel width has been set to 20 MHz on both the TP-Link Archer C20 and the MikroTik/OpenWrt.
- [SCOPE] This is a configuration/state note only; no router command was issued by the assistant in this turn.
- [IMPORTANT] The exact radio band/interface and channel numbers were not independently verified in this turn.
- [SAFETY] No Wi-Fi reload/restart was requested or performed; current connectivity remains unchanged by this sync.

## CHANGELOG — 2026-09-20 — [SYNC] Wi-Fi channel assignments recorded
- [CONFIRMED] User reports 5 GHz channel = 36 and 2.4 GHz channel = 13.
- [SCOPE] These channel numbers are recorded together with the previously reported 20 MHz channel width on both TP-Link Archer C20 and MikroTik/OpenWrt.
- [IMPORTANT] This is user-reported configuration state; the assistant did not independently query either radio in this turn.

## CHANGELOG — 2026-09-20 — [SYNC] Speed-test discrepancy via SweetHomeU vs OpenWrt
- [OBSERVATION] User reports a speed test on the SweetHomeU network with direct/current path result: download **65.42 Mbit/s**, upload **79.28 Mbit/s**.
- [IMPORTANT] User reports that the result through the MikroTik/OpenWrt path is approximately **2× lower** than the SweetHomeU result; the exact OpenWrt-side download/upload figures were not supplied in this sync.
- [DIAGNOSTIC STATUS] This is recorded as an observed performance discrepancy, not as a confirmed root cause.
- [POSSIBLE FACTORS TO TEST] Wi-Fi STA link between TP-Link and MikroTik, 20 MHz channel width, radio conditions, hAP ac lite CPU/NAT limits, QoS/SQM if present, and client-side Wi-Fi path. Zapret2, WireGuard/WARP/Proton are not currently active and therefore are not treated as the present cause.
- [SAFETY] No configuration or network change was made in response to the speed result.
- [NEXT] Before changing configuration, perform a single compact read-only check of the current TP-Link↔MikroTik Wi-Fi STA link parameters. Do not reload/restart Wi-Fi during diagnosis.

## CHANGELOG — 2026-09-20 — [PASS] STAGE 11 ipset runtime-directory resolution
- [PASS] Read-only command resolved `IPSET_RW_DIR=$ZAPRET_RW/ipset` from `/opt/zapret2/ipset/def.sh`.
- [CONFIRMED] With the current default `ZAPRET_RW=$ZAPRET_BASE`, the effective runtime ipset directory is `/opt/zapret2/ipset`.
- [OBSERVATION] The subsequent `find` produced no file listing, so no regular files were found directly in `/opt/zapret2/ipset` at the time of the check.
- [NO CHANGE] No Zapret2 configuration, service, firewall/NFQUEUE, network/Wi-Fi or storage state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Continue with one compact read-only audit of the list-file path variables/actual list files under the resolved runtime directory before any activation.

## CHANGELOG — 2026-09-20 — [PASS] STAGE 11 Zapret2 list-path audit
- [PASS] Read-only audit resolved the configured list paths from `/opt/zapret2/ipset/def.sh`.
- [CONFIRMED] `ZIPLIST=/opt/zapret2/ipset/zapret-ip.txt`.
- [CONFIRMED] `ZIPLIST6=/opt/zapret2/ipset/zapret-ip6.txt`.
- [CONFIRMED] `ZIPLIST_EXCLUDE=/opt/zapret2/ipset/zapret-ip-exclude.txt`.
- [CONFIRMED] `ZIPLIST_IPBAN=/opt/zapret2/ipset/zapret-ip-ipban.txt`.
- [CONFIRMED] `ZIPLIST_IPBAN6=/opt/zapret2/ipset/zapret-ip-ipban6.txt`.
- [CONFIRMED] The `find` audit returned no `.txt`, `.gz` or `.list` files under `/opt/zapret2` at the time of the check.
- [IMPORTANT] The configured list paths therefore currently point to files that are not present; no hostlist/ipset data is currently staged there.
- [NO CHANGE] No Zapret2 configuration, service, firewall/NFQUEUE, network/Wi-Fi or storage state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Perform one compact read-only inspection of the scripts that generate/fetch these lists, to distinguish expected first-run absence from a missing deployment step. Do not generate or download lists yet.

## CHANGELOG — 2026-09-20 — [PASS] STAGE 11 Zapret2 list-generation audit
- [PASS] Read-only grep confirmed multiple official Zapret2 list-generation/update scripts are present under `/opt/zapret2/ipset`.
- [CONFIRMED] Examples include `get_antifilter_ip.sh`, `get_antifilter_ipsmart.sh`, `get_antifilter_ipsum.sh`, `get_antifilter_ipresolve.sh`, `get_reestr_preresolved*.sh`, `get_reestr_resolvable_domains.sh`, `get_refilter_*.sh`, `get_user.sh`, and `get_ipban.sh`.
- [CONFIRMED] These scripts ultimately reference the configured `ZIPLIST*` paths and commonly invoke `create_ipset.sh` after obtaining/building list data.
- [CONFIRMED] `create_ipset.sh` supports both legacy ipset and nft-set backends; its nft path uses the configured `SET_MAXELEM`/related capacities when creating sets.
- [IMPORTANT] The previous absence of list files is therefore consistent with a not-yet-initialized list-generation state; it does not by itself indicate a broken Zapret2 deployment.
- [NO CHANGE] No list was downloaded/generated; no ipset/nft set, firewall/NFQUEUE, service, network/Wi-Fi or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Perform one compact read-only inspection of the list-source selection/configuration variables and the default/user list inputs, without executing any generator.

## CHANGELOG — 2026-09-20 — [PASS] STAGE 11 Zapret2 source-variable audit
- [PASS] Read-only audit confirmed `SET_MAXELEM=522288` in the runtime config.
- [CONFIRMED] `DISABLE_IPV6=1`; current Zapret2 configuration disables IPv6 processing.
- [CONFIRMED] Effective runtime list directory is `/opt/zapret2/ipset`.
- [CONFIRMED] User-list inputs resolve there as `zapret-hosts-user.txt`, `zapret-hosts-user-ipban.txt`, and `zapret-hosts-user-exclude.txt`.
- [IMPORTANT] No explicit `ZUSERLIST*`, `IPSET_DIR`, or `SET_MAXELEM_EXCLUDE` assignment was found in the selected files; defaults/derived values in `def.sh` therefore apply.
- [NO CHANGE] No lists were generated/downloaded and no nft/ipset/firewall/service/network state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Inspect the default config's list-source variables and relevant generator selection logic read-only before deciding whether any list initialization is needed.

## CHANGELOG — 2026-09-20 — [PASS] STAGE 11 Zapret2 filter-mode audit
- [PASS] Read-only inspection of list-generation/install logic confirmed supported `MODE_FILTER` values in `install_easy.sh`: `none`, `ipset`, `hostlist`, `autohostlist`.
- [CONFIRMED] Current runtime/default configuration is `MODE_FILTER=none`.
- [CONFIRMED] With `MODE_FILTER=none`, the installer does not select an active list mode; list generation is therefore not currently required for the inactive baseline.
- [CONFIRMED] When list modes are selected, the installer has predefined GETLISTS/GETLIST_DEF selections; no such selection has been activated on this router.
- [NO CHANGE] No generator, download, list creation, nft/ipset creation, firewall/NFQUEUE, service, network/Wi-Fi or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Before any activation decision, perform a compact read-only audit of the exact installer branch around `MODE_FILTER` and list selection. Do not execute `install_easy.sh`.

## CHANGELOG — 2026-09-20 — STAGE 11 installer branch verification
- Read-only inspection of install_easy.sh confirmed modes: none, ipset, hostlist, autohostlist.
- Current runtime MODE_FILTER=none, so automatic list download is inactive.
- Hostlist/autohostlist and ipset list-generator choices were confirmed in the installer branch.
- install_easy.sh was not executed; no lists, nft/ipset sets, firewall, NFQUEUE, service, network, Wi-Fi or DNS state changed.
- STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- Next: read-only inspection of the firewall activation path around INIT_APPLY_FW=1; do not execute it.

## CHANGELOG — 2026-09-20 — STAGE 11 firewall-path audit
- Read-only command against `/opt/zapret2/init.d/openwrt.sh` produced no matching output.
- This does not establish that the firewall integration is absent: the inspected path may not exist, may differ in this Zapret2 layout, or may not contain the searched terms.
- No state was changed; Zapret2 remains inactive.
- STAGE 11 remains IN_PROGRESS.
- Next: identify the actual Zapret2 init/startup scripts present under `/opt/zapret2` read-only, then inspect the relevant firewall integration file.

## CHANGELOG — 2026-09-20 — STAGE 11 init-file inventory
- Read-only `find` under `/opt/zapret2` (depth <=3) returned no files matching `openwrt*`, `*init*`, or `*service*`.
- Therefore the controlled Zapret2 deployment currently contains no matching init/service wrapper at those paths; this is consistent with the decision not to run `install_easy.sh` or install service hooks.
- No state changed; Zapret2 remains inactive and firewall/NFQUEUE integration has not been activated.
- STAGE 11 remains IN_PROGRESS.
- Next: inspect the top-level `/opt/zapret2` directory structure and relevant executable/script names read-only to locate the intended firewall integration mechanism without installing or executing anything.

## CHANGELOG — 2026-09-20 — STAGE 11 Zapret2 directory structure correction
- [CONFIRMED] `/opt/zapret2` exists and contains the controlled Zapret2 deployment: binaries, blockcheck2.d, common, config/config.default, files, init.d, ip2net, ipset, lua, mdig, nfq2, tmp, and installer/uninstaller scripts.
- [CORRECTION] The earlier `find -maxdepth 2 -type f` produced no output despite the directory containing files; this does not prove the deployment lacked files. The subsequent `ls -la` is authoritative for the top-level inventory.
- [CONFIRMED] An `init.d` directory is present, but previous filename-filtering did not reveal matching files; its contents must be inspected directly.
- [NO CHANGE] No Zapret2 service, firewall/NFQUEUE, list generator, network, Wi-Fi or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.

## CHANGELOG — 2026-09-20 — STAGE 11 init.d direct inventory
- [PASS] Read-only command `find /opt/zapret2/init.d -maxdepth 3 -type f -printf '%p\n' 2>/dev/null | sort` completed successfully.
- [CONFIRMED] The command returned no file paths, so no regular files were found under `/opt/zapret2/init.d` at the time of this check.
- [CORRECTION] This narrows the previous finding: `/opt/zapret2/init.d` exists as a directory, but its current contents contain no regular files within depth 3.
- [NO CHANGE] No Zapret2 installer, service hook, firewall/NFQUEUE activation, list generation, network/Wi-Fi or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] The next step is one compact read-only inspection of the `/opt/zapret2` directory entries around `init.d`/related scripts to determine whether the integration is represented by non-regular files or another official path. Do not execute installers or activation scripts.

## CHANGELOG — 2026-09-20 — STAGE 11 init.d structure inspection
- [PASS] Read-only `ls -la /opt/zapret2/init.d` completed successfully.
- [CONFIRMED] `/opt/zapret2/init.d` contains two directories: `custom.d.examples.linux` and `openwrt`.
- [CORRECTION] The previous `find ... -type f` result was empty because the relevant Zapret2 integration content is nested inside subdirectories; the `init.d` directory itself is not empty.
- [NO CHANGE] No Zapret2 installer, service hook, firewall/NFQUEUE activation, list generation, network/Wi-Fi or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Perform one compact read-only listing of `/opt/zapret2/init.d/openwrt` to identify the actual OpenWrt integration files without executing them.

## CHANGELOG — 2026-09-20 — STAGE 11 OpenWrt integration inventory
- [PASS] Read-only `ls -la /opt/zapret2/init.d/openwrt` completed successfully.
- [CONFIRMED] OpenWrt integration contains regular files `90-zapret2` (840 bytes), `firewall.zapret2` (238 bytes), `functions` (6105 bytes), and executable `zapret2` (2987 bytes).
- [CONFIRMED] It also contains a `custom.d/` directory.
- [CORRECTION] The Zapret2 OpenWrt integration files are present in the controlled deployment; their presence does not mean they are installed into `/etc/init.d`, `/etc/init.d/firewall`, firewall includes, or enabled at boot.
- [NO CHANGE] No integration script was executed and no service/firewall/NFQUEUE/network/Wi-Fi/DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Perform one compact read-only command to inspect `90-zapret2`, `firewall.zapret2`, and the top-level function/launcher headers without executing them.


## CHANGELOG — 2026-09-20 — STAGE 11 OpenWrt integration structure audit
- [CONFIRMED] Read-only inspection completed for `/opt/zapret2/init.d/openwrt/90-zapret2`, `firewall.zapret2`, and the first 100 lines of `functions`.
- [CONFIRMED] `90-zapret2` is an interface-event hook that targets `/etc/init.d/zapret2`; when that service exists and is enabled, it can reload nftables ifsets or restart firewall handling on interface events.
- [CONFIRMED] `firewall.zapret2` sources the OpenWrt helper functions and calls `zapret_apply_firewall`.
- [CONFIRMED] `functions` sources Zapret2 config/common firewall/daemon/list/custom helpers and contains automatic WAN/LAN interface discovery plus NFQWS firewall helper functions.
- [IMPORTANT] These files are currently only in `/opt/zapret2`; this inspection did not establish installation into `/etc/init.d`, firewall include registration, service enablement, or execution.
- [NO CHANGE] No Zapret2 service, firewall, NFQUEUE, interface hook, DNS, Wi-Fi, or network state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Inspect the actual `/opt/zapret2/init.d/openwrt/zapret2` launcher read-only before considering any installation/copy action.


## CHANGELOG — 2026-09-20 — STAGE 11 launcher audit
- [CONFIRMED] Read-only inspection of `/opt/zapret2/init.d/openwrt/zapret2` completed.
- [CONFIRMED] Launcher is an OpenWrt `/etc/rc.common`/procd service script with `USE_PROCD=1` and `START=21`.
- [CONFIRMED] It provides firewall/daemon control commands and starts `nfqws2` through procd when daemon configuration enables it.
- [CONFIRMED] With `INIT_APPLY_FW=1`, service start/stop can apply/unapply Zapret2 firewall integration unless OpenWrt fw3 integration handles it separately.
- [IMPORTANT] The script itself is still only under `/opt/zapret2/init.d/openwrt/zapret2`; inspection does not prove it is installed as `/etc/init.d/zapret2` or enabled.
- [NO CHANGE] No service, daemon, firewall, NFQUEUE, network, Wi-Fi, or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; Zapret2 remains intentionally inactive.
- [NEXT] Final read-only installation-state check: determine whether `/etc/init.d/zapret2` currently exists and what it resolves to. No activation.


## CHANGELOG — 2026-09-20 — STAGE 11 installation-state check
- [CONFIRMED] `/etc/init.d/zapret2` exists, is executable (`-rwxr-xr-x`), size 2987 bytes, matching the inspected controlled launcher size.
- [CONFIRMED] `readlink /etc/init.d/zapret2` produced no output, so it is not a symlink according to this check; it is a regular installed copy at `/etc/init.d/zapret2`.
- [IMPORTANT] Existence of the init script does not by itself prove the service is enabled, running, or applying firewall/NFQUEUE rules.
- [NO CHANGE] The check was read-only; Zapret2 service, daemon, firewall, NFQUEUE, network, Wi-Fi, and DNS state were not changed.
- [STATUS] STAGE 11 remains IN_PROGRESS because activation was explicitly deferred by the user. Zapret2 remains intentionally inactive.
- [NEXT] Installation audit is complete. Any further step must be a separate activation decision; do not enable/start Zapret2 automatically.


## CHANGELOG — 2026-09-20 — Zapret2 activation decision
- [DECISION] User authorized proceeding with Zapret2 activation after completing the read-only installation/integration audit.
- [SAFETY] Activation will remain one-command-at-a-time; first step is a read-only enabled/running-state check before any service action.
- [GUARD] Do not alter `config`, lists, firewall, NFQUEUE, DNS, Wi-Fi, or network settings in the first activation step.
- [STATUS] STAGE 11 remains IN_PROGRESS pending controlled activation and verification.


## CHANGELOG — 2026-09-20 — Zapret2 pre-activation state
- [CONFIRMED] `/etc/init.d/zapret2 enabled` returned rc=1: service is not enabled at boot.
- [CONFIRMED] `/etc/init.d/zapret2 status` reported `inactive`.
- [NO CHANGE] Status check was read-only; no service, daemon, firewall, NFQUEUE, DNS, Wi-Fi, or network state changed.
- [STATUS] STAGE 11 remains IN_PROGRESS. Zapret2 is installed but currently inactive and not enabled.
- [NEXT] Before first activation, perform one read-only config sanity check focused on activation gates and `SET_MAXELEM`; do not enable/start yet.


## CHANGELOG — 2026-09-20 — Zapret2 activation gate verified
- [CONFIRMED] Current runtime config has `NFQWS2_ENABLE=0`, `MODE_FILTER=none`, `INIT_APPLY_FW=1`, `FLOWOFFLOAD=donttouch`, `DISABLE_IPV6=1`, and `SET_MAXELEM=522288` with `IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"`.
- [SAFETY] `SET_MAXELEM` remains a configured capacity value only; no live nft set using it has been confirmed. Because `MODE_FILTER=none` and no lists are present, the first activation step should not intentionally create the large IP set.
- [DECISION] To activate Zapret2 itself, the required configuration gate is `NFQWS2_ENABLE=1`; this is a deliberate configuration change and must be followed by verification before service start.
- [STATUS] STAGE 11 remains IN_PROGRESS.


## CHANGELOG — 2026-09-20 — Zapret2 NFQWS2 gate enabled
- [CONFIRMED] `/opt/zapret2/config` now contains `NFQWS2_ENABLE=1`.
- [CONFIRMED] The change was limited to the Zapret2 runtime configuration; the service has not yet been started.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Start Zapret2 once, then immediately verify service state, daemon process, and firewall state before any further change.


## CHANGELOG — 2026-09-20 — First Zapret2 start result
- [RESULT] `/etc/init.d/zapret2 start` launched `nfqws2` configuration for TCP 80/443 and UDP 443 with queue 300.
- [RESULT] Zapret2 attempted nftables activation and created/loaded nft set structures (`zapret`, `ipban`, `nozapret`), but all four NFQWS nft rule insertions failed with `Error: Could not process rule: No such file or directory` while inserting into table `inet zapret2` chains `postnat`/`prenat`.
- [IMPORTANT] The start command did not report a clean successful firewall activation. Current daemon/table state must be verified read-only before any repair or stop/start action.
- [SAFETY] Do not retry `start`, `restart`, firewall reload, or configuration edits until the partial-activation state is inspected.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED pending read-only state inspection.


## CHANGELOG — 2026-09-20 — Zapret2 partial-activation state verified
- [CONFIRMED] `zapret2 status` reports `running`.
- [CONFIRMED] `nfqws2` process is running as user `daemon` (PID 4375 at inspection time).
- [CONFIRMED] `inet zapret2` table exists.
- [CONFIRMED] Sets `zapret` and `ipban` were created with `size 522288`; `nozapret` size 65536; WAN interface set contains `phy0-sta0`; LAN set contains `br-lan`.
- [CONFIRMED] Hook chains and supporting chains exist, but `postnat` and `prenat` chains are empty; therefore the four NFQWS queue rules that failed during start are not installed.
- [CONFIRMED] The table has active hook rules that jump into the empty `postnat`/`prenat` chains, so this is a partial activation state and requires controlled diagnosis.
- [SAFETY] Do not restart/stop/restart firewall or edit configuration until the cause of the failed nft rule insertion is identified.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.


## CHANGELOG — 2026-09-20 — nftables queue-module audit
- [CONFIRMED] Kernel has `nf_tables`, `nfnetlink`, and `nfnetlink_queue` loaded.
- [CONFIRMED] `nft_ct`, NAT, flow-offload, fib, meta-related base nftables functionality visible in the loaded-module inventory; no `nft_queue` module is present in the `lsmod` result.
- [IMPORTANT] The absence of `nft_queue` in `lsmod` is a strong candidate for the `No such file or directory` failure on rules containing `queue num 300`, but it is not yet proof that the module is unavailable; it could be built-in or loadable but not currently loaded.
- [SAFETY] No module was loaded and no network/firewall/service state was changed by this audit command.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.
- [NEXT] Perform one read-only filesystem check for the `nft_queue` kernel module before considering any module-load or package action.


## CHANGELOG — 2026-09-20 — nft_queue module filesystem check failed
- [RESULT] Attempted read-only `/bin/find` check for `nft_queue.ko`, but this OpenWrt image does not contain `/bin/find` (`-ash: /bin/find: not found`).
- [IMPORTANT] This does not establish whether `nft_queue.ko` exists; the diagnostic utility itself is absent.
- [NO CHANGE] No module, service, firewall, network, Wi-Fi, or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.
- [NEXT] Use a shell glob/read-only `ls` check instead of `find`.


## CHANGELOG — 2026-09-20 — nft_queue module absence confirmed by module-path glob
- [CONFIRMED] Read-only check `/lib/modules/6.12.94/*nft_queue*` returned `No such file or directory`.
- [CONFIRMED] `nft_queue` is not present as a directly named module file in the standard module directory, while `nfnetlink_queue` is loaded.
- [IMPORTANT] This strongly supports the hypothesis that the `queue` nftables expression required by Zapret2 is unavailable as a loadable module in the current image; exact kernel/package configuration still needs verification before any change.
- [NO CHANGE] No package, kernel module, service, firewall, network, Wi-Fi, or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.
- [NEXT] Inspect the kernel module dependency/index metadata read-only for `nft_queue` before installing or loading anything.


## CHANGELOG — 2026-09-20 — nft_queue module index check
- [RESULT] Read-only grep of `modules.dep` and `modules.alias` for `nft_queue`/`queue` returned no output.
- [CONFIRMED] No indexed `nft_queue` module or matching alias is present in the current kernel module metadata.
- [CONCLUSION] The current OpenWrt kernel/module set does not expose `nft_queue` as a loadable module through the standard module metadata. This explains the nft rule insertion failure as the leading technical cause, but the exact package/config source should still be checked before installing anything.
- [NO CHANGE] No module, package, service, firewall, network, Wi-Fi, or DNS state was changed.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.


## CHANGELOG — 2026-09-20 — Official OpenWrt package research
- [WEB VERIFIED] Official OpenWrt 25.12.5 repositories publish a package named `kmod-nft-queue-6.12.94-r1.apk` for multiple 6.12.94 targets, confirming the package exists in the 25.12.5 release family. The current device-specific ath79/mikrotik package index still needs direct verification before installation.
- [WEB VERIFIED] OpenWrt release 25.12.5 is the relevant official release tree; kernel-module packages are target/kernel-build specific, so a package from another target must not be installed.
- [SAFETY] Do not install the x86/other-target `kmod-nft-queue` package. First inspect the router's configured official APK repositories and exact target kmods feed.
- [STATUS] STAGE 11 remains IN_PROGRESS / activation verification BLOCKED.

- [OBSERVED 2026-09-20] `/etc/apk/repositories` does not exist (`cat: can't open ... No such file or directory`). Do not infer repository configuration from this path; inspect apk configuration using a read-only command next.
- [CLARIFICATION 2026-09-20] User correctly distinguished `kmod-nft-queue` (nftables `queue` expression/kernel integration) from `kmod-nfnetlink-queue` (NFQUEUE/netlink userspace communication). Current router has `nfnetlink_queue` loaded, while `nft_queue` is absent from loaded modules and module files/metadata. This distinction is now authoritative for STAGE 11 diagnosis.
- [OBSERVED 2026-09-20] `apk update` completed successfully: official ath79/mikrotik packages feed and exact device kernel feed `.../targets/ath79/mikrotik/kmods/6.12.94-1-1951ed9cd221294b56a47180c29ca5a9/packages.adb` were fetched; APK reports `OK: 11080 distinct packages available`. Earlier `apk policy` warnings were due to missing local caches before update, not proof that repositories were unavailable.
- [NEXT] Query the now-populated official APK database for the exact `kmod-nft-queue` package before installation.
- [OBSERVED 2026-09-20] `apk search -v 'kmod-nft-queue*'` found exact package `kmod-nft-queue-6.12.94-r1 - Netfilter nf_tables queue support` in the refreshed official package database. This matches the running kernel version 6.12.94; installation has NOT yet been performed.

## DECISION RECORD — 2026-09-20 — LOW-RAM ZAPRET2 STRATEGY / TPWS FIRST
- Target: MikroTik hAP ac lite / RB952Ui-5ac2nD, 64 MB RAM; recent MemAvailable was only about 3–4 MiB.
- Do not treat package availability as proof that NFQUEUE is safe. NFQUEUE can increase RAM/CPU pressure; Kernel Panic/OOM is workload/config dependent and must not be presented as inevitable.
- kmod-nfnetlink-queue and kmod-nft-queue are distinct. nfnetlink_queue is already present/loaded; nft_queue support is absent.
- Official exact package found after apk update: kmod-nft-queue-6.12.94-r1, matching kernel 6.12.94. It has NOT been installed.
- Before installing kmod-nft-queue, audit TPWS from the already deployed Zapret2 v1.0.3.
- TPWS is a transparent TCP proxy path and does not require the nftables queue expression. Initial scope is TCP-only; UDP/QUIC parity with NFQWS2 is not assumed.
- Do not assume kmod-nft-tproxy is mandatory. Verify whether existing REDIRECT/DNAT/NAT support is sufficient for the installed OpenWrt/Zapret2 integration.
- ByeDPI/ciadpi is an alternative candidate, not the default replacement; do not install it before TPWS audit.
- Current Zapret2 remains partially activated: nfqws2 runs and inet zapret2 exists, but queue num 300 rule insertion fails. Do not restart/stop Zapret2 during audit unless explicitly authorized.
- Decision gate before architecture change: verify TPWS binary/executability; available options; OpenWrt integration path; redirect mechanism; RAM/CPU cost; functionality lost versus NFQWS2; and whether any additional kernel module is actually required.
- Workflow: one router command at a time; read-only audit first; no unverified packages; official OpenWrt/Zapret sources only; compact output without hiding required evidence.
- [DECISION 2026-09-20] TPWS audit is deferred as a fallback path. Continue Zapret2/NFQWS2 first; TPWS remains reserved if NFQWS2 cannot be made stable/safe on the 64 MB device. Do not switch architectures prematurely. Next read-only step: inspect `apk info -a kmod-nft-queue-6.12.94-r1` before any installation.
- [OBSERVED 2026-09-20] `apk info -a kmod-nft-queue-6.12.94-r1` returned no output. This did not provide package metadata; it does not invalidate the earlier `apk search` result. Do not infer package size/dependencies from the empty result. Continue with a read-only APK repository/policy query before installation.
- [OBSERVED 2026-09-20] `apk policy kmod-nft-queue` confirms exactly one candidate: version `6.12.94-r1` from the official OpenWrt 25.12.5 `ath79/mikrotik` kernel feed with kernel ABI path `6.12.94-1-1951ed9cd221294b56a47180c29ca5a9`. This is the exact target/kernel package source; package is still not installed.
- [WEB VERIFIED 2026-09-20] Official OpenWrt 25.12.5 ath79 release tree is current; target-specific kernel package must come from ath79/mikrotik. The exact `kmod-nft-queue-6.12.94-r1` package is listed in OpenWrt's kernel package trees and the router's own `apk policy` already confirms the exact ath79/mikrotik feed. Do not use another target's package. The package archive is small (about 3 KB in comparable official 25.12.5 kernel indexes), but archive size alone is not a RAM-safety assessment.
- [NEXT] Use APK simulation/read-only dependency resolution before any installation, so we can see what would be installed and its disk impact without changing the router.
- [OBSERVED 2026-09-20] `apk add --simulate kmod-nft-queue` reports `(1/1) Installing kmod-nft-queue (6.12.94-r1)` and `OK: 15.5 MiB in 161 packages`. This is a simulated transaction and did not install the module. The 15.5 MiB figure is the total installed-package database/filesystem footprint represented by the simulation, not the RAM consumption of kmod-nft-queue itself and not proof of OOM safety.
- [OBSERVED 2026-09-20] Current resources before possible `kmod-nft-queue` installation: `/overlay` is `/dev/sda2` extroot, 6.6G total / 6.2G available, only 13.5M used. RAM: 54852 KiB total, 30536 KiB used, 17456 KiB free, 6860 KiB buff/cache, 8596 KiB available (~8.4 MiB). Swap: 550904 KiB total, 9352 KiB used, 541552 KiB free. This is materially more headroom than the earlier ~3–4 MiB MemAvailable measurement, but RAM remains constrained.
- [DECISION GATE] Disk space is not a constraint for the simulated package transaction. RAM remains the primary risk. The simulation did not establish module runtime RAM usage; installation and loading must be treated as separate steps, with post-install/post-load memory checks.
- [REQUEST 2026-09-20] Before installing `kmod-nft-queue`, user requested an exact read-only check of ZRAM and USB swap separately; no package installation has been performed yet.
- [OBSERVED 2026-09-20] `swapon --show` is unsupported by this BusyBox implementation (`unrecognized option: -`). It did not change swap state and therefore did not provide per-device details. Use the supported BusyBox `swapon -s` for the next read-only check.
- [OBSERVED 2026-09-20] User installed the exact official `kmod-nft-queue` package: `6.12.94-r1`. APK post-install completed successfully; package database reports `15.5 MiB in 161 packages`. This closes the package-install gate. NFQWS2/nft queue activation has not yet been re-tested after installation.
- [OBSERVED 2026-09-20] Post-install module verification: `lsmod | grep -E 'nft_queue|nfnetlink_queue'` shows `nft_queue 12288 0` and `nfnetlink_queue 24576 1`; `nf_tables` lists `nft_queue` among loaded modules. The required nftables queue expression support is therefore loaded. Next step: controlled Zapret2/NFQWS2 activation re-test, not a package change.
- [OBSERVED 2026-09-20] `/etc/init.d/zapret2 status` reports `running` after installation/loading of `kmod-nft-queue`. This confirms the daemon is currently running, but does not by itself prove that all NFQWS2 nft queue rules were successfully inserted. A targeted read-only nftables verification is next.
- [OBSERVED 2026-09-20] `nft list chain inet zapret2 postnat` shows an empty `postnat` chain. Therefore NFQWS2 post-NAT queue rules are not currently present in this chain, despite the service reporting `running`. This confirms activation is still only partial/not verified. No corrective change was made.