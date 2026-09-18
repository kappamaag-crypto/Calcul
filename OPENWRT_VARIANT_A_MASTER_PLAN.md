# MASTER PLAN — OpenWrt Variant A
## Clean rebuild without active extroot

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

## 0.1 USB
Текущая известная схема:
- /dev/sda1 — swap около 512 MiB
- /dev/sda2 — старый extroot /overlay
- /dev/sda3 — /mnt/data

Правило: USB не форматировать, не переразмечать, не удалять разделы.

Variant A:
- /dev/sda2 сохраняется, но не используется как /overlay;
- /dev/sda3 сохраняется;
- /mnt/data возвращается отдельно;
- extroot возвращается только после стабилизации базовой системы.

---

## STAGE 0 — Safety inventory
STATUS: IN_PROGRESS

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
STATUS: NOT_STARTED

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
STATUS: NOT_STARTED

Цель: сохранить конфигурацию и технический snapshot.

Backup не восстанавливать автоматически после flash.

Критерий выхода:
backup находится на ПК и читается.

---

## STAGE 3 — Clean flash
STATUS: NOT_STARTED

Цель: OpenWrt 25.12.5 без старой конфигурации.

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
- SwapTotal;
- SwapFree;
- processes;
- load;
- overlay usage.

Критерий выхода:
baseline сохранён.

---

## STAGE 8 — USB data only
STATUS: NOT_STARTED

Подключить:
 /dev/sda3 → /mnt/data

Не подключать:
 /dev/sda2 → /overlay

Проверить UUID, filesystem, mount, read/write.

Критерий выхода:
данные доступны, clean overlay сохраняется.

---

## STAGE 9 — Swap/ZRAM
STATUS: NOT_STARTED

После baseline.

При необходимости:
- existing swap;
- ZRAM;
- первоначально 32 MiB.

Критерий выхода:
swap работает, RAM stable, no OOM.

---

## STAGE 10 — DoH
STATUS: NOT_STARTED

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
- OOM;
- queue state.

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
3. Old extroot is not active.
4. USB data remains intact.
5. Base network works.
6. Base Wi-Fi works.
7. Memory baseline is known.
8. Components are reintroduced one by one.
9. Previous Zapret2/OOM problem can be reproduced or excluded scientifically.
10. Final state is reproducible from this plan.

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
