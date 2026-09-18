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
STAGE 4 — IN_PROGRESS
STAGE 5–30 — NOT_STARTED

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
