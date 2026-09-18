# MASTER PLAN — OpenWrt Variant A
## Clean rebuild with extroot + ZRAM + USB swap

Дата: 2026-09-18
Устройство: MikroTik hAP ac lite / RB952Ui-5ac2nD
Целевая ОС: OpenWrt 25.12.5
Target: ath79/mikrotik
Главный роутер: TP-Link Archer C20 v4
Статусы: NOT_STARTED / IN_PROGRESS / BLOCKED / FAILED / DONE

## 0. Архитектура
TP-Link Archer C20 v4
↓ Wi-Fi
MikroTik hAP ac lite — Wi-Fi STA
↓
MikroTik LAN/Wi-Fi
↓
Ноутбук

TP-Link остаётся главным маршрутизатором.

## 0.1 USB и целевая память
Текущая известная схема:
- /dev/sda1 — swap около 512 MiB
- /dev/sda2 — старый extroot /overlay
- /dev/sda3 — /mnt/data

Новая целевая архитектура Variant A:
- чистый OpenWrt без автоматического восстановления старой конфигурации;
- extroot создаётся заново после clean base и используется как /overlay;
- ZRAM используется как быстрый сжатый swap;
- USB swap используется как дополнительный резерв;
- отдельный /mnt/data сохраняется, если это удобно по ёмкости USB;
- данные на текущем USB неценны, поэтому после безопасного отделения старого extroot допускается полная пересозданная разметка USB отдельным destructive-этапом после предупреждения и подтверждения.

Принцип:
- extroot решает нехватку места на внутренней 16-МБ flash;
- ZRAM + USB swap предназначены для управления memory-pressure;
- extroot сам по себе не увеличивает RAM;
- большой swap не является гарантией отсутствия OOM.

---

## STAGE 0 — Safety inventory
STATUS: DONE

Цель: read-only inventory перед flash.

Проверить:
- board;
- release;
- kernel;
- /proc/mtd;
- lsblk;
- block info;
- mount;
- df -h;
- fstab;
- UCI network;
- UCI wireless;
- UCI firewall;
- installed APK;
- init scripts;
- Zapret2;
- DoH;
- ZRAM;
- USB state.

Критерий выхода:
полная инвентаризация сохранена на ПК.

Flash запрещён до завершения.

---

## STAGE 1 — Official firmware verification
STATUS: IN_PROGRESS

Цель: получить официальный OpenWrt 25.12.5 image именно для RB952Ui-5ac2nD.

Проверить:
- target;
- profile;
- filename;
- SHA256;
- size;
- official source.

Критерий выхода:
image и checksum однозначно подтверждены.

---

## STAGE 2 — Backup
STATUS: DONE

Цель: сохранить конфигурацию и технический snapshot.

Backup не восстанавливать автоматически после flash.

Критерий выхода:
backup находится на ПК и читается.

---

## STAGE 3 — Clean flash
STATUS: NOT_STARTED

Цель: OpenWrt 25.12.5 без старой конфигурации и без автоматического старого extroot. USB на этом этапе не пересоздавать.

OpenWrt scratch install использует sysupgrade без сохранения конфигурации, например sysupgrade -n; точная команда для устройства определяется после STAGE 0.

Критерий выхода:
новая OpenWrt загрузилась.

STOP:
если есть сомнение, какой раздел будет затронут.

---

## STAGE 4 — Clean base verification
STATUS: NOT_STARTED

Проверить:
- board;
- version;
- kernel;
- rootfs;
- overlay;
- USB;
- RAM;
- services.

Главный критерий:
старый /dev/sda2 НЕ является active /overlay.

Дополнительно: получить контрольный RAM baseline до extroot, ZRAM, USB swap, DoH и Zapret2.

Критерий выхода:
чистая база подтверждена.

---

## STAGE 5 — Minimal network
STATUS: NOT_STARTED

WAN:
- Wi-Fi STA;
- TP-Link;
- DHCP;
- gateway 192.168.0.1.

LAN:
- 192.168.1.1/24;
- DHCP.

Критерий выхода:
laptop gets 192.168.1.x, gateway 192.168.1.1, Internet and DNS work.

---

## STAGE 6 — MikroTik Wi-Fi AP
STATUS: NOT_STARTED

Целевой SSID: OpenWrt.

Критерий выхода:
ноутбук подключается к AP и получает LAN IP.

---

## STAGE 7 — Clean memory baseline
STATUS: NOT_STARTED

Зафиксировать:
- MemTotal;
- MemFree;
- MemAvailable;
- Slab;
- SReclaimable/SUnreclaim если доступны;
- SwapTotal;
- SwapFree;
- ZRAM state;
- процессы/RSS;
- load;
- overlay usage.

Это контрольная точка для всех следующих изменений.

Критерий выхода:
baseline сохранён на ПК/в журнале и пригоден для before/after сравнения.

---

## STAGE 8 — USB preparation + extroot
STATUS: NOT_STARTED

После clean base безопасно отделить старый extroot. Поскольку пользователь подтвердил, что данные на USB не важны, разрешается отдельный destructive-этап полной пересозданной разметки USB после предупреждения и подтверждения.

Целевая схема:
- extroot → /overlay;
- USB swap → swap;
- /mnt/data → отдельный data-раздел, если нужен.

Проверить UUID, filesystem, mount, boot behavior, доступное место и отсутствие старых конфигураций.

Критерий выхода:
новый extroot работает, /overlay находится на USB, загрузка воспроизводима, старые конфиги не восстановлены.

---

## STAGE 9 — ZRAM + USB swap
STATUS: NOT_STARTED

После STAGE 7 и STAGE 8 настроить два независимых слоя виртуальной памяти.

Стартовая экспериментальная точка:
- ZRAM 32 MiB;
- USB swap как дополнительный резерв.

Предварительный приоритет:
- ZRAM выше USB swap.

Размер ZRAM может быть изменён по результатам измерений. Зафиксировать:
- zram device/algorithm/size;
- swapon priority;
- SwapTotal/Free;
- MemAvailable;
- slab;
- RSS ключевых процессов;
- CPU/load;
- OOM events.

Критерий выхода:
ZRAM и USB swap работают, приоритеты подтверждены, memory snapshot сохранён, нет нового OOM.

---

## STAGE 10 — DoH
STATUS: NOT_STARTED

Перед установкой сохранить memory snapshot после extroot + ZRAM + USB swap.

Цель:
один https-dns-proxy, Cloudflare, 127.0.0.1:5053.

Проверить process, listener, dnsmasq, DNS, RAM.

Критерий выхода:
DoH работает и baseline после DoH зафиксирован.

---

## STAGE 11 — Zapret2 source
STATUS: NOT_STARTED

Version: v1.0.3.

Критерий выхода:
source/version verified.

---

## STAGE 12 — SDK/build
STATUS: NOT_STARTED

Target:
ath79/mikrotik
mips_24kc
gcc 14.3.0
musl

Критерий выхода:
SDK/toolchain verified.

---

## STAGE 13 — Zapret2 dependencies
STATUS: NOT_STARTED

Критерий выхода:
runtime dependencies built/verified/installed.

---

## STAGE 14 — Zapret2 binaries/Lua
STATUS: NOT_STARTED

Target:
- nfqws2;
- mdig;
- ip2net;
- zapret-lib.lua;
- zapret-antidpi.lua.

Критерий выхода:
native MIPS, executable, version and hashes verified.

---

## STAGE 15 — NFQUEUE kernel
STATUS: NOT_STARTED

Check/install:
- nfnetlink;
- nfnetlink_queue;
- nft_queue.

Критерий выхода:
NFQUEUE functional.

---

## STAGE 16 — Temporary NFQUEUE
STATUS: NOT_STARTED

Temporary nft rule.

Проверить:
- queue binding;
- counter;
- HTTP/HTTPS;
- cleanup.

Критерий выхода:
traffic traverses queue successfully.

---

## STAGE 17 — Zapret2 minimal
STATUS: NOT_STARTED

Lua/filtering without desync.

Критерий выхода:
HTTPS works, process stable, memory stable.

---

## STAGE 18 — Desync isolated tests
STATUS: NOT_STARTED

Тесты:
- fake;
- tcp_md5;
- tls_mod=rnd;
- tls_mod=rndsni;
- tls_mod=dupsid;
- combinations;
- full strategy.

Критерий выхода:
каждый test result recorded.

---

## STAGE 19 — Real DPI and memory
STATUS: NOT_STARTED

Monitor:
- nft counters;
- logs;
- rawsend;
- EPERM;
- timeout;
- RSS;
- MemAvailable;
- SwapTotal/Free;
- ZRAM;
- slab;
- OOM;
- queue state.

Сравнивать каждый результат с clean baseline и последним стабильным snapshot.

Критерий выхода:
real target traffic works without OOM or persistent timeout.

---

## STAGE 20 — Persistent Zapret2
STATUS: NOT_STARTED

Initial scope:
TCP 80/443.

QUIC/UDP 443 is a separate task.

Критерий выхода:
reboot persistence + functional test.

---

## STAGE 21 — WireGuard base
STATUS: NOT_STARTED

Критерий выхода:
controlled tunnel works.

---

## STAGE 22 — WARP Free
STATUS: NOT_STARTED

Критерий выхода:
WARP route verified.

---

## STAGE 23 — Proton Free
STATUS: NOT_STARTED

Критерий выхода:
Proton route verified.

---

## STAGE 24 — PBR
STATUS: NOT_STARTED

Критерий выхода:
selected traffic follows intended route.

---

## STAGE 25 — Domain classification
STATUS: NOT_STARTED

Критерий выхода:
deterministic classification.

---

## STAGE 26 — nftset
STATUS: NOT_STARTED

Критерий выхода:
sets populated and used correctly.

---

## STAGE 27 — Zapret2 + PBR
STATUS: NOT_STARTED

Check:
- NFQUEUE;
- marks;
- routing;
- rawsend;
- VPN;
- no loops.

Критерий выхода:
no mark/routing conflict.

---

## STAGE 28 — Final IPv4/IPv6/DNS/routing
STATUS: NOT_STARTED

Check:
- IPv4;
- IPv6;
- DNS;
- DoH;
- DNS leak;
- default route;
- VPN;
- PBR.

Критерий выхода:
all paths documented.

---

## STAGE 29 — Persistence
STATUS: NOT_STARTED

After reboot check:
- network;
- Wi-Fi;
- USB data;
- swap;
- ZRAM;
- DoH;
- Zapret2;
- VPN;
- PBR.

Критерий выхода:
configuration survives reboot.

---

## STAGE 30 — Final acceptance
STATUS: NOT_STARTED

Checklist:
- OpenWrt version correct
- hardware profile correct
- TP-Link remains main router
- Wi-Fi STA WAN works
- LAN works
- AP works
- USB data preserved
- old /dev/sda2 extroot inactive
- /mnt/data works
- swap works
- ZRAM works if retained
- memory stable
- no OOM
- DoH works
- Zapret2 works
- rawsend EPERM understood/absent
- VPN works where configured
- PBR works
- IPv4 verified
- IPv6 verified
- DNS verified
- reboot verified
- final configuration documented

## Variant A success definition
Variant A is successful when:
1. OpenWrt is cleanly installed.
2. Old configuration is not restored.
3. Old extroot is not automatically inherited.
4. New extroot is intentionally created and verified as /overlay.
5. ZRAM is intentionally configured and measured.
6. USB swap is intentionally configured and measured.
7. Base network works.
8. Base Wi-Fi works.
9. Memory baseline is known before and after each major component.
10. DoH, Zapret2, VPN and PBR are reintroduced one by one.
11. Previous Zapret2/OOM problem can be reproduced or excluded scientifically.
12. Final state is reproducible from this plan.

## Current state
STAGE 0 — IN_PROGRESS
STAGE 1–30 — NOT_STARTED

### Change log — 2026-09-18
- [UPDATED] STAGE 0 remains IN_PROGRESS; no flash performed.
- [ADDED] Previous system diagnostic findings are recorded as pre-rebuild evidence only: OOM occurred under global memory pressure; nfqws2 was killed as a victim and did not show large RSS at the kill points.
- [ADDED] Previous Zapret2 real-DPI test produced YouTube timeout and rawsend EPERM; this is a baseline symptom to reproduce/exclude after clean rebuild, not a cause conclusion.
- [ADDED] Clean rebuild must be treated as a control experiment: base OpenWrt → network → memory baseline → USB data only → swap/ZRAM → DoH → Zapret2, one component at a time.
- [ADDED] Before STAGE 1, STAGE 0 must establish the exact current rootfs/overlay, /proc/mtd, USB partition layout, mounts, fstab, block info and board/release state.
- [CONFIRMED] /dev/sda2 is preserved physically but must not become active /overlay in Variant A; /dev/sda3 remains data; /dev/sda1 remains swap.
- [CONFIRMED] No destructive USB operation is permitted.

Do not execute flash until STAGE 0 inventory is complete and reviewed.


## Change log — 2026-09-18 — [UPDATED] target architecture: extroot + ZRAM + USB swap
- [CHANGED] Variant A больше не означает «без extroot». Целевое состояние: clean OpenWrt + новый extroot + ZRAM + USB swap.
- [CHANGED] Старый extroot не восстанавливается автоматически; он заменяется новым контролируемым extroot после clean base.
- [ADDED] Пользователь подтвердил, что данные на USB не важны; поэтому после безопасного отделения старого extroot разрешена полная пересозданная разметка USB отдельным destructive-этапом после предупреждения и подтверждения.
- [ADDED] Extroot используется для устранения ограничения внутренней 16-МБ flash и большого пространства под пакеты.
- [ADDED] ZRAM и USB swap используются как два отдельных механизма управления memory-pressure на 64-МБ hAP ac lite.
- [ADDED] Стартовая экспериментальная точка ZRAM — 32 MiB; окончательный размер определяется измерениями.
- [ADDED] Предварительный приоритет: ZRAM выше USB swap.
- [ADDED] После каждого крупного этапа сохранять RAM snapshot: MemAvailable, SwapTotal/Free, ZRAM, slab, RSS ключевых процессов, load и OOM.
- [ADDED] Цепочка: clean base → extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.
- [ADDED] Диагностическая цель: отделить влияние дискового extroot от RAM-pressure и отдельно измерить влияние ZRAM/swap, DoH, NFQUEUE и Zapret2.


## CHANGELOG — 2026-09-18 — [UPDATED] фактическое восстановление STAGE 0
- [CONFIRMED] STAGE 0 не означает, что диагностика ранее не выполнялась: значительная часть read-only inventory уже была реально выполнена в рабочей сессии.
- [CONFIRMED] Уже получены как фактические данные: board/model, OpenWrt 25.12.5 r33051-f5dae5ece4, target ath79/mikrotik, kernel 6.12.94, /proc/mtd, rootfs, active /overlay, USB sda1/sda2/sda3, mounts, fstab, /proc/cmdline, extroot/fstools mechanism, RAM/swap/ZRAM snapshots, network, Wi-Fi AP, firewall, package manager, DoH и предыдущая Zapret2/OOM диагностика.
- [CONFIRMED] Фактическое состояние старой системы: /dev/sda2 был активным USB extroot на /overlay; /dev/sda3 был /mnt/data; /dev/sda1 был swap.
- [CONFIRMED] lsblk -f в текущем read-only inventory недоступен: команда отсутствует. Это не FAIL системы; эквивалентную информацию нужно получить доступными OpenWrt-инструментами.
- [CHANGED] STAGE 0 не будет повторять уже выполненные тесты без причины. Перед STAGE 1 закрываются только недостающие финальные snapshot-пункты: актуальный block/USB state, актуальный mount/df snapshot и при необходимости актуальные package/service/UCI snapshots.
- [CONFIRMED] Flash по-прежнему запрещён до завершения и проверки STAGE 0.
- [ADDED] Исторические результаты DoH/Zapret2/OOM являются evidence старой системы и не считаются доказательством поведения чистой базы.
- [ADDED] После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с новым фактическим состоянием, выполненными командами, решениями, изменёнными статусами и следующими критериями выхода.
- [ADDED] Синхронизация выполняется до завершения ответа ассистента; при отсутствии изменения состояния факты и статусы не выдумываются и не изменяются.
- [ADDED] Мастер-промт и мастер-план должны оставаться согласованными: архитектура, статусы, запреты и правила one-step-at-a-time.

## CURRENT STAGE 0 FACTUAL CHECKPOINT — 2026-09-18
Статус: IN_PROGRESS

Уже подтверждено:
- board/model: MikroTik RB952Ui-5ac2nD / hAP ac lite;
- OpenWrt: 25.12.5 r33051-f5dae5ece4;
- target: ath79/mikrotik;
- kernel: 6.12.94;
- rootfs: internal SquashFS;
- /dev/sda2: old extroot, active /overlay in the pre-rebuild system;
- /dev/sda3: /mnt/data;
- /dev/sda1: swap;
- fstab: reviewed;
- /proc/cmdline: reviewed;
- mount_root/fstools extroot mechanism: reviewed;
- RAM/swap/ZRAM: measured historically;
- network/Wi-Fi/firewall: tested historically;
- apk package manager: confirmed;
- DoH: inventoried historically;
- Zapret2/NFQUEUE/OOM: tested historically.

Remaining STAGE 0 closure items:
1. Obtain current read-only block/USB inventory without relying on absent lsblk.
2. Obtain one current mount/df snapshot.
3. Obtain current package/service/UCI snapshots where needed for the final pre-flash inventory.
4. Consolidate the final inventory into the PC/project record.
5. Review the consolidated inventory and only then mark STAGE 0 DONE.

No flash is permitted until items 1–5 are complete.

## CHANGELOG — 2026-09-18 — [ADDED] turn-by-turn synchronization rule
- [ADDED] Every user message and every assistant response is a synchronization boundary for the master plan.
- [ADDED] At each boundary, the plan records new factual outputs, executed commands, decisions, blockers, and next exit criteria.
- [ADDED] If a turn produces no state change, the plan is not allowed to invent one or change a status; only a brief confirmation log may be added.
- [ADDED] The synchronization must be completed before the assistant response is finalized.

## CHANGELOG — 2026-09-18 — [SYNC] current diagnostic turn
- [CONFIRMED] `cat /proc/partitions` completed: /dev/sda = 7630848 blocks; sda1 = 524288 blocks; sda2 = 6010880 blocks; sda3 = 1094656 blocks; zram0 = 32768 blocks.
- [CONFIRMED] `cat /proc/mounts` completed: /dev/sda2 is active /overlay; /dev/sda3 is /mnt/data; /dev/sda1 is not a mounted filesystem.
- [CONFIRMED] `cat /proc/swaps` completed: /dev/zram0 = 32764 KiB, used 5464 KiB, priority 100; /dev/sda1 = 524284 KiB, used 0 KiB, priority -2.
- [CONFIRMED] `df -h` completed: /overlay and / are 5.6G with 5.2G available; /mnt/data is 1017.6M with 947.8M available; /tmp is 26.8M with 24.7M available; /rom is 6.0M squashfs.
- [CONFIRMED] `cat /etc/config/fstab` completed: sda1 swap enabled; /overlay UUID 244b7bbc-add1-46cd-bc1a-0143cfca5d6c is disabled; /mnt/data UUID 635bc144-d79a-4e6d-a315-0e1655eb995c is enabled.
- [CONFIRMED] `blkid` unavailable; no diagnostic package installation performed.
- [CONFIRMED] /sys block inspection completed: sda1 1048576 sectors, sda2 12021760 sectors, sda3 2189312 sectors; partition numbers 1/2/3.
- [CONFIRMED] `cat /proc/cmdline` completed: console=ttyS0,115200n8 rootfstype=squashfs,jffs2; no explicit root= or extroot/overlay parameter.
- [CONFIRMED] `/etc/init.d/fstab` reviewed: START=11 and boot() invokes `/sbin/block mount`.
- [CONFIRMED] `/sbin/block` exists, executable, size 40997 bytes; `file` unavailable.
- [CORRECTION] The previous proposed command `/sbin/block -h 2>&1` is not required by the master plan. The plan requires current “block info”, not a generic help dump. Do not install `file` or other packages solely for diagnostics.
- [DECISION] Do not further investigate the old extroot mechanism at this point by speculative commands. The current pre-flash inventory should proceed to the remaining explicitly required current package/service/UCI snapshots.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS; no flash, formatting, repartitioning, or other destructive operation performed.


## CHANGELOG — 2026-09-18 — [SYNC] block info completed
- [CONFIRMED] `/sbin/block info` completed successfully.
- [CONFIRMED] /dev/mtdblock8: UUID=732a86de-549cb5e0-082f5b2d-b848b495, TYPE=squashfs, MOUNT=/rom.
- [CONFIRMED] /dev/mtdblock9: TYPE=jffs2.
- [CONFIRMED] /dev/sda1: TYPE=swap, VERSION=1.
- [CONFIRMED] /dev/sda2: UUID=244b7bbc-add1-46cd-bc1a-0143cfca5d6c, LABEL=extroot, VERSION=1.0, MOUNT=/overlay, TYPE=ext4.
- [CONFIRMED] /dev/sda3: UUID=635bc144-d79a-4e6d-a315-0e1655eb995c, LABEL=data, VERSION=1.0, MOUNT=/mnt/data, TYPE=ext4.
- [RESOLVED] Ранее отмеченное несоответствие UUID для /dev/sda2 разрешено: UUID из текущего /etc/config/fstab полностью совпадает с фактическим UUID /dev/sda2; fstab-запись /overlay остаётся disabled, но /dev/sda2 фактически активен как /overlay.
- [CONFIRMED] Текущая физическая USB-разметка и фактические файловые системы теперь подтверждены через /proc/partitions, /proc/mounts, df -h, /etc/config/fstab и /sbin/block info.
- [DECISION] Дальнейшее исследование старого extroot через спекулятивные команды не требуется для текущего STAGE 0; не менять /overlay, fstab, swap или ZRAM.
- [CONFIRMED] STAGE 0 остаётся IN_PROGRESS до завершения оставшихся package/service/UCI snapshots, консолидации inventory в PC/project record и финального review.



## CHANGELOG — 2026-09-18 — [SYNC] init scripts snapshot completed
- [CONFIRMED] `ls -la /etc/init.d/` completed successfully.
- [CONFIRMED] `uhttpd` init script is present and executable (7404 bytes); earlier absence was stale historical evidence and is superseded by this current snapshot.
- [CONFIRMED] `https-dns-proxy`, `pbr`, `network`, `dnsmasq`, `firewall`, `fstab`, `wpad` and `zapret2` init scripts are present.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS; no configuration or service state was changed by this read-only command.


## CHANGELOG — 2026-09-18 — [SYNC] UCI network snapshot completed
- [CONFIRMED] `uci show network` completed successfully.
- [CONFIRMED] WAN is `eth1` with DHCP; WAN6 is `eth1` with DHCPv6.
- [CONFIRMED] LAN is `br-lan` over `eth0.1`, static `192.168.1.1/24`, with IPv6 assignment length 60.
- [CONFIRMED] Switch VLAN 1 is enabled with ports `1 2 3 4 0t`.
- [CONFIRMED] WAN device MAC is `b8:69:f4:d6:e8:a0`; LAN VLAN device MAC is `b8:69:f4:d6:e8:a1`.
- [CONFIRMED] No network configuration was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] wireless UCI snapshot completed
- [CONFIRMED] `uci show network` was repeated and matches the previously recorded network snapshot; no network configuration change detected.
- [CONFIRMED] `radio0` is 5 GHz, channel 36, VHT80; its AP interface is enabled, SSID `OpenWrt`, attached to `lan`, open encryption.
- [CONFIRMED] `radio1` is 2.4 GHz, channel 1, HT20; its AP interface is disabled, SSID `OpenWrt`, attached to `lan`.
- [CONFIRMED] An additional `radio0` station interface exists on `wan`, SSID `SPKEFFA_5G`, WPA2-PSK, with a configured key. This is current configuration evidence only; credentials are not reproduced in the master plan.
- [CONFIRMED] No wireless configuration was changed by these read-only commands.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] firewall UCI snapshot completed
- [CONFIRMED] `uci show firewall` completed successfully.
- [CONFIRMED] Defaults: input REJECT, output ACCEPT, forward REJECT, SYN flood protection enabled.
- [CONFIRMED] LAN zone is ACCEPT/ACCEPT/ACCEPT; WAN zone is REJECT/ACCEPT/DROP with masquerading and MTU fix enabled.
- [CONFIRMED] LAN→WAN forwarding is configured.
- [CONFIRMED] Standard DHCP/DHCPv6, ICMP/ICMPv6, IGMP, MLD and IPSec-related firewall rules are present.
- [CONFIRMED] Enabled nftables include `/etc/zapret2/nfqws2.nft` with `fw4_compatible='1'`; this is configuration evidence only and is not treated as proof that Zapret2 is currently active or functional.
- [CONFIRMED] No firewall configuration was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] swap runtime snapshot completed
- [CONFIRMED] `/dev/sda1` is active USB swap: 524284 KiB, currently 0 KiB used, priority -2.
- [CONFIRMED] `/dev/zram0` is active swap: 32764 KiB, currently 5692 KiB used, priority 100.
- [CONFIRMED] ZRAM has higher swap priority than USB swap in the current runtime state.
- [CONFIRMED] This was a read-only runtime check; no swap or ZRAM configuration was changed.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] ZRAM parameters snapshot completed
- [CONFIRMED] `/dev/zram0` compression algorithm is `lzo-rle` (selected; `lzo` is also available).
- [CONFIRMED] ZRAM disksize is `33554432` bytes = 32 MiB.
- [CONFIRMED] Current ZRAM `mm_stat` is: `5623808 2909753 4636672 0 7806976 0 6173 395 2515`.
- [CONFIRMED] This was a read-only runtime check; no ZRAM configuration was changed.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] DoH service runtime status completed
- [CONFIRMED] `/etc/init.d/https-dns-proxy status` returned `running`.
- [CONFIRMED] `https-dns-proxy` is currently running; this does not yet prove its listener, upstream, DNS integration, or RAM usage.
- [CONFIRMED] No service configuration or runtime state was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] DoH UCI configuration snapshot completed
- [CONFIRMED] `https-dns-proxy` listens on `127.0.0.1:5053`.
- [CONFIRMED] Upstream resolver is Cloudflare DoH: `https://cloudflare-dns.com/dns-query`.
- [CONFIRMED] Bootstrap DNS includes Cloudflare IPv4/IPv6 addresses.
- [CONFIRMED] `force_dns='1'`, source interface `lan`, forced ports `53` and `853`, `notrack_dns='1'`.
- [CONFIRMED] `dnsmasq_config_update='*'` is configured.
- [CONFIRMED] Service runs as `nobody:nogroup`; WAN6 procd trigger is disabled.
- [CONFIRMED] No DoH configuration was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] Zapret2 runtime status completed
- [CONFIRMED] `/etc/init.d/zapret2 status` returned `not running`.
- [CONFIRMED] Zapret2 init script is present (from the previously completed init-script snapshot), but the service is currently not running.
- [CONFIRMED] This read-only status check did not start, stop, or otherwise modify Zapret2.
- [CONFIRMED] The firewall snapshot already showed an enabled nftables include for `/etc/zapret2/nfqws2.nft`; current service status does not prove whether that include is populated or functionally effective.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] Zapret2 nftables include snapshot completed
- [CONFIRMED] `/etc/zapret2/nfqws2.nft` exists, size 163 bytes, mode `0644`, owned by `root:root`.
- [CONFIRMED] Current content defines `chain zapret2_nfqueue` as a `filter` chain on `forward`, priority `-1`, policy `accept`.
- [CONFIRMED] The chain currently matches TCP/443 arriving on `br-lan`, increments a counter, and queues packets to NFQUEUE number 100 with `bypass`.
- [CONFIRMED] This is configuration evidence only; it does not prove that the chain is loaded into the active nftables ruleset or that a userspace `nfqws2` process is bound to queue 100.
- [CONFIRMED] No file or firewall configuration was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] active nftables ruleset snapshot completed
- [CONFIRMED] `nft list ruleset` completed successfully.
- [CONFIRMED] Active `inet fw4` contains `chain zapret2_nfqueue` on `forward`, priority `filter - 1`, policy `accept`.
- [CONFIRMED] Active rule matches TCP/443 arriving on `br-lan` and sends packets to NFQUEUE 100 with `bypass`.
- [CONFIRMED] Current counter at snapshot time: `74292` packets / `53447458` bytes.
- [CONFIRMED] Active nftables ruleset also contains the https-dns-proxy TCP/UDP 853 reject rules, DNS 53 redirects to local port 53, and `https_dns_proxy_notrack` handling for local port 5053.
- [CONFIRMED] There is a runtime/configuration discrepancy: `/etc/init.d/zapret2 status` returned `not running`, while the `zapret2_nfqueue` chain is active in nftables.
- [CONFIRMED] No nftables, Zapret2, or DoH configuration was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS; this discrepancy is recorded for later investigation and is not being corrected during STAGE 0.


## CHANGELOG — 2026-09-18 — [SYNC] STAGE 0 continuation
- [CONFIRMED] User requested continuation of the controlled STAGE 0 inventory.
- [CONFIRMED] Previously recorded STAGE 0 facts remain unchanged; no router configuration or runtime state was modified in this synchronization.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] RAM snapshot completed
- [CONFIRMED] `free -k` completed successfully.
- [CONFIRMED] RAM: total 54852 KiB, used 33328 KiB, free 12168 KiB, shared 16 KiB, buff/cache 9356 KiB, available 4552 KiB.
- [CONFIRMED] Aggregate active swap: total 557048 KiB, used 5692 KiB, free 551356 KiB.
- [CONFIRMED] This snapshot is a current STAGE 0 memory baseline under the existing pre-rebuild configuration; it is not the clean-base baseline required by later STAGE 7.
- [CONFIRMED] No system state was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] detailed memory snapshot completed
- [CONFIRMED] `/proc/meminfo` snapshot: MemTotal 54852 kB; MemFree 12116 kB; MemAvailable 4556 kB; Buffers 1892 kB; Cached 6328 kB; Slab 10128 kB; SReclaimable 1248 kB; SUnreclaim 8880 kB; SwapTotal 557048 kB; SwapFree 551356 kB.
- [CONFIRMED] Current kernel slab is 10128 kB, of which 8880 kB is SUnreclaim and 1248 kB is SReclaimable.
- [CONFIRMED] This is a STAGE 0 runtime snapshot under the current pre-rebuild configuration, not the clean-base STAGE 7 baseline.
- [CONFIRMED] No system state was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] BusyBox ps RSS command compatibility
- [CONFIRMED] `ps -o pid,ppid,rss,comm,args | sort -k3 -nr | head -20` is unsupported by BusyBox 1.37.0; `ps` reports only the `w` wide-output option.
- [CONFIRMED] No system state was changed; the failed command was read-only.
- [CONFIRMED] The planned RSS snapshot has not yet been obtained.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] BusyBox wide process snapshot
- [CONFIRMED] `ps w` works on BusyBox 1.37.0 and reports PID, USER, VSZ, STAT, COMMAND.
- [CONFIRMED] The output does not provide RSS; therefore the originally planned RSS ranking cannot be obtained with this BusyBox `ps` invocation.
- [CONFIRMED] Current notable VSZ values include: https-dns-proxy PID 5573 = 3244 kB; dnsmasq PID 6386 = 3788 kB; hostapd PID 3606 = 3724 kB; wpa_supplicant PID 3608 = 3760 kB; netifd PID 5575 = 2908 kB; uhttpd PID 2226 = 2488 kB; rpcd PID 3739 = 2116 kB; logd PID 1385 = 2072 kB. These are VSZ, not RSS, and are not used as an RSS baseline.
- [CONFIRMED] `uhttpd` is currently running (PID 2226), superseding the older historical observation that its init script was missing.
- [CONFIRMED] `https-dns-proxy` is running (PID 5573).
- [CONFIRMED] `zapret2` does not appear in the process list, consistent with its previously recorded `not running` service state.
- [CONFIRMED] No system state was changed by this read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] https-dns-proxy RSS snapshot
- [CONFIRMED] PID 5573 (`https-dns-proxy`) memory snapshot: VmSize 3244 kB; VmRSS 1936 kB; RssAnon 332 kB; RssFile 1604 kB; RssShmem 0 kB.
- [CONFIRMED] RSS is obtainable directly from `/proc/<PID>/status` on this system without installing diagnostic packages.
- [CONFIRMED] This is a current STAGE 0 process-memory snapshot, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] dnsmasq RSS snapshot
- [CONFIRMED] PID 6386 (`dnsmasq`) memory snapshot: VmSize 3788 kB; VmRSS 1092 kB; RssAnon 156 kB; RssFile 936 kB; RssShmem 0 kB.
- [CONFIRMED] This is a current STAGE 0 process-memory snapshot, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] hostapd RSS snapshot
- [CONFIRMED] PID 3606 (`hostapd`) memory snapshot: VmSize 3724 kB; VmRSS 1452 kB; RssAnon 208 kB; RssFile 1244 kB; RssShmem 0 kB.
- [CONFIRMED] This is a current STAGE 0 process-memory snapshot, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] wpa_supplicant RSS snapshot
- [CONFIRMED] PID 3608 (`wpa_supplicant`) memory snapshot: VmSize 3760 kB; VmRSS 1036 kB; RssAnon 136 kB; RssFile 900 kB; RssShmem 0 kB.
- [CONFIRMED] This is a current STAGE 0 process-memory snapshot, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] netifd RSS snapshot
- [CONFIRMED] PID 5575 (`netifd`) memory snapshot: VmSize 2908 kB; VmRSS 1052 kB; RssAnon 224 kB; RssFile 812 kB; RssShmem 16 kB.
- [CONFIRMED] This is a current STAGE 0 process-memory snapshot, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] complete process RSS snapshot
- [CONFIRMED] A single read-only `/proc` loop successfully collected `VmRSS` for all accessible user-space PIDs and sorted them descending.
- [CONFIRMED] Largest measured RSS at this snapshot: `https-dns-proxy` PID 5573 = 1936 kB; `hostapd` PID 3606 = 1452 kB; `dnsmasq` PID 6386 = 1092 kB; `netifd` PID 5575 = 1052 kB; `wpa_supplicant` PID 3608 = 1036 kB.
- [CONFIRMED] Other notable user-space RSS: ash PID 9762 = 964 kB; udhcpc PID 4342 = 948 kB; ash PID 7925 = 944 kB; ntpd PID 2901 = 916 kB; udhcpc PID 3038 = 892 kB; procd PID 1 = 876 kB; crond PID 2150 = 848 kB; odhcpd PID 2091 = 812 kB; ubusd PID 633 = 696 kB; dropbear PID 7924 = 628 kB; logd PID 1385 = 588 kB.
- [CONFIRMED] Several procd/jail wrapper processes report 8 kB RSS in this snapshot; these are not treated as equivalent to the real service processes.
- [CONFIRMED] `uhttpd` PID 2226 appears as an 8 kB jail/wrapper entry in this `/proc` snapshot; this does not replace the previously confirmed running `uhttpd` service process information and should not be interpreted as its true service RSS without further PID correlation.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] aggregate RSS and memory snapshot
- [CONFIRMED] Aggregate process RSS command returned `15748 kB`, but its output was visibly contaminated/interleaved with terminal text (`nreclaim|SwapTotal|SwapFree):' /proc/meminfo15748 kB`). Therefore `15748 kB` is recorded as observed output but NOT accepted as a clean/validated aggregate RSS value.
- [CONFIRMED] Concurrent `/proc/meminfo` snapshot: MemTotal 54852 kB; MemFree 13592 kB; MemAvailable 5352 kB; SwapTotal 557048 kB; SwapFree 551612 kB; Slab 10208 kB; SReclaimable 1332 kB; SUnreclaim 8876 kB.
- [CONFIRMED] Compared with the previous snapshot, MemFree increased by 1476 kB, MemAvailable increased by 796 kB, SwapFree increased by 256 kB, Slab increased by 80 kB, SReclaimable increased by 84 kB, and SUnreclaim decreased by 4 kB. These are point-in-time differences only and are not interpreted causally.
- [CONFIRMED] No system state was changed by the commands.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] validated aggregate process RSS
- [CONFIRMED] Clean aggregate `VmRSS` across `/proc/[0-9]*/status`: **14804 kB**.
- [CONFIRMED] This aggregate is accepted as the current STAGE 0 process RSS snapshot.
- [CONFIRMED] It is a point-in-time snapshot under the current pre-rebuild configuration, not the clean STAGE 7 baseline.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] historical OOM evidence confirmed
- [CONFIRMED] Current `dmesg` contains multiple historical kernel OOM events; this is strong evidence that the present pre-rebuild configuration has experienced severe memory pressure.
- [CONFIRMED] Recorded OOM victims include `rpcd`, `nfqws2`, `dnsmasq`, multiple `https-dns-proxy` instances, `sysntpd`, `utpl`, and `netifd`; the log also contains repeated `oom_reaper` messages.
- [CONFIRMED] Relevant later events include: PID 5574 `https-dns-proxy` killed at dmesg timestamp 4906.266585 with total-vm 3680 kB, anon-rss 660 kB, file-rss 1756 kB; PID 3746 `nfqws2` killed at timestamp 4353.270030; PID 7881 `nfqws2` killed at timestamp 9107.087198 with total-vm 2888 kB, anon-rss 60 kB, file-rss 96 kB.
- [CONFIRMED] These messages are historical kernel-log evidence and do not by themselves establish that an OOM condition is occurring at the present instant.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.


## CHANGELOG — 2026-09-18 — [SYNC] latest OOM event identified
- [CONFIRMED] Latest OOM-related kernel-log event is at dmesg timestamp **9107.087198 s**: `nfqws2` PID 7881 was killed; total-vm 2888 kB, anon-rss 60 kB, file-rss 96 kB, shmem-rss 0 kB, pgtables 28 kB, oom_score_adj 0.
- [CONFIRMED] The immediately preceding OOM invocation was by `nfqws2` at timestamp 9106.470226 s.
- [CONFIRMED] No later `Out of memory`, `oom-killer`, or `oom_reaper` message appears in the selected tail.
- [CONFIRMED] This remains historical kernel-log evidence; it does not prove a current OOM at the present instant.
- [CONFIRMED] No system state was changed by the read-only command.
- [CONFIRMED] STAGE 0 remains IN_PROGRESS.

- [CONFIRMED] ZRAM snapshot: `/sys/block/zram0/comp_algorithm` = `[lzo-rle] lzo`; `disksize` = 33554432 bytes (32 MiB); `mm_stat` = `5427200 2836716 4497408 0 7806976 0 6195 394 2515`.
- [CONFIRMED] Current swap snapshot: `/dev/zram0` 32764 kB, used 5436 kB, priority 100; `/dev/sda1` 524284 kB, used 0 kB, priority -2.
- [CONFIRMED] ZRAM and USB swap are both active concurrently; ZRAM has higher priority.
- [CONFIRMED] No configuration/state was changed by this read-only command.


## Change log — 2026-09-18 — [STAGE 0 CLOSED / STAGE 1 STARTED]
- [DONE] STAGE 0 read-only inventory is complete from the collected evidence: board/release/kernel, /proc/mtd, USB partition state, block info, mounts, df, fstab, UCI network/wireless/firewall, installed APK snapshot, init scripts, Zapret2, DoH, ZRAM and swap, RAM/process RSS, and historical OOM evidence are recorded in the project record.
- [CONFIRMED] BusyBox utilities `lsblk`, `blkid` and `file` are unavailable on the current system; equivalent storage evidence was obtained from `/proc/partitions`, `/sbin/block info`, mounts and filesystem metadata. No diagnostic packages were installed solely to replace them.
- [CONFIRMED] No flash, formatting, repartitioning, unmounting, fstab modification, swap modification, or other destructive operation was performed during STAGE 0.
- [CONFIRMED] STAGE 0 exit condition is satisfied in the project record; flash remains forbidden until the exact official image is independently verified in STAGE 1.
- [IN_PROGRESS] STAGE 1 — verify official OpenWrt 25.12.5 image/profile/filename/SHA256/size for MikroTik RB952Ui-5ac2nD.

## Change log — 2026-09-18 — [STAGE 1 verification: official image identified]
- [CONFIRMED] Official OpenWrt 25.12.5 target directory is `ath79/mikrotik`.
- [CONFIRMED] Official image for this hardware is `mikrotik_routerboard-952ui-5ac2nd-squashfs-sysupgrade.bin`.
- [CONFIRMED] Official SHA256: `61874d62db99a67c0be290a862466ded967d2b14cca88debd7b8ca2af7cc8078`.
- [CONFIRMED] Official listed size: 7680.3 KB.
- [CONFIRMED] A separate `-v7` image exists, but the selected target image is the ordinary non-`-v7` sysupgrade image, consistent with the RouterBOOT 6.41.3 / ordinary-image requirement in the project plan.
- [CONFIRMED] Official supplementary files include `profiles.json`, `sha256sums`, `sha256sums.asc`, `sha256sums.sig` and the ath79/mikrotik SDK/toolchain.
- [CONFIRMED] No image was flashed or downloaded to the router; this was official-source verification only.
- [IN_PROGRESS] Next STAGE 1 action: verify the downloaded image on the PC against the official SHA256 before any flash planning.

## Change log — 2026-09-18 — [STAGE 1 SHA256 PASS]
- [PASS] PC image `C:\WinBox\Opnewrt\openwrt-25.12.5-ath79sys.bin` SHA256 = `61874D62DB99A67C0BE290A862466DED967D2B14CCA88DEBD7B8CA2AF7CC8078`.
- [PASS] Computed SHA256 exactly matches the official OpenWrt 25.12.5 `mikrotik_routerboard-952ui-5ac2nd-squashfs-sysupgrade.bin` checksum recorded for STAGE 1.
- [CONFIRMED] The local filename is custom/renamed, but the hash establishes that its contents match the verified official sysupgrade image.
- [CONFIRMED] No flashing or other router state change has occurred.
- [IN_PROGRESS] STAGE 1 remains active until the required official image verification record is complete; next step is PC-side size/identity check, not flashing.


## Change log — 2026-09-18 — [STAGE 2 STARTED]
- [DONE] STAGE 2 backup archive created and verified present: `/tmp/openwrt-backup-stage2-20260918-101532.tar.gz`, size 7.6K; archive contents have not yet been inspected.
- [IN_PROGRESS] STAGE 2 backup started. No router state changed.
- [CONFIRMED] Backup must be saved separately from the router and must not be automatically restored after clean flash.

- [DONE] STAGE 2 exit criterion satisfied: configuration backup and technical snapshot are stored on the PC, backup archive was readable, and its SHA-256 was confirmed matching after transfer. No restore or destructive operation performed.
- [IN_PROGRESS] STAGE 3 — Clean flash preparation started. No flash command has been executed.
- [DONE] STAGE 3.1 device/firmware identity rechecked: model `MikroTik RouterBOARD 952Ui-5ac2nD (hAP ac lite)`, board `mikrotik,routerboard-952ui-5ac2nd`, OpenWrt `25.12.5`, target `ath79/mikrotik`; matches the verified ordinary sysupgrade image. No flash executed.
- [DONE] STAGE 3.2 local firmware file confirmed present on PC and user confirmed its SHA-256 matches official `61874d62db99a67c0be290a862466ded967d2b14cca88debd7b8ca2af7cc8078`. No flash executed.
- [DONE] STAGE 3.3 management LAN confirmed: `br-lan` is UP with `192.168.1.1/24`. No flash executed.
- [DONE] STAGE 3.4 `sysupgrade -h` confirmed available and supports `-n`, `-T/--test`, `-F`, and backup/restore options. No flash executed.
- [DONE] STAGE 3.5 verified firmware image copied to router `/tmp/openwrt-25.12.5-ath79sys.bin`; user confirmed its SHA-256 matches the verified official hash. No flash executed.
- [DONE] STAGE 3.6 `sysupgrade -T /tmp/openwrt-25.12.5-ath79sys.bin` returned empty output and no error; recorded as a successful dry-run verification. No flash executed.
- [AUTHORIZED] User explicitly confirmed the clean flash. Planned command: `sysupgrade -n /tmp/openwrt-25.12.5-ath79sys.bin`. This will erase current writable configuration/overlay state; USB partitions are not intentionally formatted or repartitioned.

- [BLOCKED] After `sysupgrade -T /tmp/openwrt-25.12.5-ath79sys.bin`, user reports the terminal/session appears frozen. No evidence of actual flash; `sysupgrade -n` has NOT been executed. Do not power-cycle or flash until live router state is rechecked.


## Change log — 2026-09-18 — [SYNC] фактический результат clean flash
- [CONFIRMED] После предыдущего шага пользователь сообщил фактические признаки перезагрузки после выполнения `sysupgrade -n /tmp/openwrt-25.12.5-ath79sys.bin`: штатная Wi-Fi сеть `OpenWrt` исчезла, прежняя SSH-сессия отключилась.
- [CONFIRMED] Пользователь повторно подключился по Wi-Fi к сети `SPKEFFA_5G`; ноутбук физически оставлен подключённым Ethernet-кабелем к MikroTik LAN.
- [INFERRED] По совокупности признаков наиболее вероятно, что clean flash фактически был выполнен и роутер перезагрузился. Это пока не считается окончательным PASS STAGE 3 до проверки новой системы.
- [CONFIRMED] Никаких утверждений о новом rootfs/overlay, версии, конфигурации, USB и сети после flash пока не принимается без фактической проверки.
- [CHANGED] STAGE 3 остаётся IN_PROGRESS до read-only проверки новой загрузившейся системы.
- [NEXT] Следующий единственный шаг: проверить доступность MikroTik по LAN на `192.168.1.1` и получить `echo ALIVE; uptime` по SSH. Не выполнять reboot, power-cycle, flash, formatting или другие destructive actions.


## Change log — 2026-09-18 — [SYNC] clean flash boot confirmed / high load observed
- [PASS] Read-only SSH check succeeded: `ssh root@192.168.1.1 "echo ALIVE; uptime"` returned `ALIVE` and `up 4:38`; this confirms the MikroTik rebooted and is currently reachable after the suspected clean flash.
- [CONFIRMED] Reported load average at that moment was `15.99, 11.29, 5.45`, which is abnormally high for this 64-MB device and must be investigated before proceeding with configuration.
- [CONFIRMED] A second identical SSH command did not return / appeared to hang. This is a current responsiveness symptom, not yet assigned a cause.
- [CHANGED] STAGE 3 remains IN_PROGRESS; clean flash boot is now strongly confirmed, but STAGE 3 PASS still requires read-only verification of the new firmware/rootfs/overlay and absence of inherited old extroot.
- [NEXT] Because SSH responsiveness is currently uncertain and load is high, the next step is a read-only network reachability test from the laptop. No reboot, power-cycle, flash, package installation, formatting, or configuration changes.
