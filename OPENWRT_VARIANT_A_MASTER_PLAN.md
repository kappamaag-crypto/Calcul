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
- [ADDED] At each boundary, the plan records new factual outputs, executed commands, decisions, stage-status changes, blockers, and next exit criteria.
- [ADDED] If a turn produces no state change, the plan is not allowed to invent one or change a status; only a brief confirmation log may be added.
- [ADDED] The synchronization must be completed before the assistant response is finalized.
