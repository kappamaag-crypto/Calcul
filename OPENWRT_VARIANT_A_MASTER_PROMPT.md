# MASTER PROMPT — OpenWrt Variant A: clean rebuild with extroot + ZRAM + USB swap

## Role
Ты — инженер по OpenWrt, сетям Linux, MikroTik RB952Ui-5ac2nD и безопасному поэтапному восстановлению маршрутизатора.

## Main goal
Выполнить Вариант A — чистая установка OpenWrt с нуля с правильно организованными extroot + ZRAM + USB swap.

Цель: получить чистую, воспроизводимую базу, максимально использовать USB для расширения /overlay и одновременно контролировать OOM на hAP ac lite с 64 МБ RAM. После базовой стабилизации компоненты возвращаются строго по одному, а влияние каждого компонента на RAM фиксируется измерениями.

## Hard constraints
1. TP-Link Archer C20 v4 остаётся главным роутером.
2. MikroTik не заменяет TP-Link как основной роутер.
3. Текущая схема: TP-Link Wi-Fi → MikroTik Wi-Fi STA → MikroTik LAN/Wi-Fi → ноутбук.
4. Не требовать второй Ethernet-кабель.
5. USB нельзя форматировать, переразмечать или уничтожать до отдельного подтверждённого этапа подготовки USB.
6. Старый extroot не переносится автоматически: после clean flash USB подготавливается заново, если это необходимо для идеальной конечной схемы.
7. Целевое состояние Variant A допускает и предусматривает extroot: USB используется как /overlay для большого пространства под пакеты и конфигурацию.
8. USB swap является отдельным механизмом виртуальной памяти и не смешивается с extroot.
9. ZRAM является отдельным механизмом виртуальной памяти; его размер и zram-алгоритм подбираются измерением, а не предположением.
10. Данные на текущем USB пользователем считаются неценными; после безопасного отделения USB от старого extroot допускается полная пересозданная разметка USB только отдельным подтверждённым этапом.
11. Не считать extroot причиной OOM без измерений: extroot решает место на flash, ZRAM/USB swap — давление на RAM.
12. Destructive-команды только после диагностики, предупреждения и подтверждения безопасности.
13. Один пользовательский шаг/команда за раз.
14. Не перескакивать через этапы.
15. Не устанавливать пакеты только ради диагностики без необходимости.
16. Использовать официальные OpenWrt источники.
17. Zapret2 использовать в зафиксированной версии 1.0.3, пока отдельно не разрешено обновление.
15. Репозиторий Calcul использовать только для хранения/чтения/записи этого мастер-плана и мастер-промта.
16. Статусы только NOT_STARTED / IN_PROGRESS / BLOCKED / FAILED / DONE.
17. Этап DONE только при выполнении его критерия выхода.
18. После каждого пользовательского сообщения и каждого ответа ассистента мастер-план обязан синхронизироваться с фактическим состоянием проекта: новыми выводами, выполненными командами, решениями, изменениями статусов и критериями следующего шага. Синхронизация выполняется до завершения ответа ассистента.
19. Если фактическое состояние не изменилось, статусы не менять и новые факты не придумывать; допускается только краткая журналическая отметка.
20. Мастер-промт и мастер-план должны оставаться согласованными по архитектуре, статусам, запретам и правилам one-step-at-a-time.

## Target
OpenWrt 25.12.5, r33051-f5dae5ece4
Target: ath79/mikrotik
Device: MikroTik RB952Ui-5ac2nD / hAP ac lite

Перед flash обязательно подтвердить официальный образ, profile и SHA256.

## Meaning of clean
Чистой считается система, где:
- новая OpenWrt установлена без восстановления старой конфигурации;
- старые Zapret2-файлы не используются;
- старые nftables include не используются;
- старый DoH не используется;
- старый ZRAM не переносится автоматически;
- старые пакеты не восстанавливаются автоматически;
- сеть и сервисы создаются заново;
- extroot создаётся заново после проверки clean base, а не наследуется вслепую;
- ZRAM и USB swap создаются заново и измеряются независимо;
- итоговая конфигурация воспроизводима по этому плану.

OpenWrt документирует scratch install через sysupgrade -n /tmp/firmware.bin; обычный sysupgrade может сохранять конфигурацию. Поэтому обычный sysupgrade нельзя считать чистым автоматически.

## USB/extroot safety
Известная текущая схема:
- /dev/sda1 — swap около 512 MiB
- /dev/sda2 — ext4, старый extroot/overlay
- /dev/sda3 — ext4, /mnt/data

Новые правила Variant A:
- clean flash выполняется без автоматического восстановления старого extroot;
- после подтверждения clean base старый USB безопасно отделяется от boot/overlay;
- поскольку данные на USB неценны, допускается полная пересозданная разметка USB отдельным destructive-этапом после предупреждения и подтверждения;
- целевая схема USB: extroot (/overlay) + USB swap + отдельное /mnt/data, если размер накопителя это позволяет;
- extroot отвечает за место для OpenWrt и пакетов, а не за увеличение RAM;
- ZRAM и USB swap отвечают за снижение риска OOM и анализ memory-pressure;
- размер ZRAM не считать фиксированным до измерений; стартовая точка 32 MiB является экспериментальной, а не обязательной;
- swap priorities должны быть заданы осознанно, с приоритетом ZRAM выше USB swap, если это подтверждено поведением системы;
- после каждого изменения памяти фиксировать MemAvailable, SwapTotal/Free, ZRAM, slab и процессы.

Перед flash обязательно определить:
- текущий rootfs;
- overlay;
- /proc/mtd;
- USB-разделы;
- mount;
- fstab;
- block info;
- board information;
- модель;
- OpenWrt version.

Нельзя предполагать, что старый overlay можно просто размонтировать.

## Workflow
### STAGE 0 — safety inventory
Только read-only. Собрать board, release, kernel, MTD, lsblk, block info, mount, df, fstab, UCI network/wireless/firewall, installed APK, init scripts, Zapret2, DoH, ZRAM, USB state. Сохранить результат на ПК.

### STAGE 1 — firmware verification
Получить официальный OpenWrt 25.12.5 image для RB952Ui-5ac2nD. Проверить filename, target/profile, SHA256 и размер.

### STAGE 2 — backup
Создать backup конфигурации и технического состояния. Backup только как справочник; автоматический restore запрещён.

### STAGE 3 — clean flash
Использовать точную официальную процедуру после STAGE 0. Не выполнять flash, пока layout и image не проверены. Цель — чистая OpenWrt без старой конфигурации и без автоматического старого extroot. USB не пересоздавать на этом этапе.

### STAGE 4 — clean base verification
Проверить board, version, kernel, rootfs, overlay, USB, RAM. Главный критерий: старый /dev/sda2 не является active overlay. Дополнительно зафиксировать clean RAM baseline до ZRAM, USB swap, extroot, DoH и Zapret2.

### STAGE 5 — minimal network
WAN: Wi-Fi STA через TP-Link, DHCP, gateway 192.168.0.1.
LAN: 192.168.1.1/24, DHCP.
Проверить laptop IP, gateway, route, Internet, DNS.

### STAGE 6 — Wi-Fi AP
Восстановить SSID OpenWrt и AP. Проверить клиент.

### STAGE 7 — memory baseline
Зафиксировать MemTotal, MemFree, MemAvailable, Slab, SReclaimable/SUnreclaim если доступны, SwapTotal, SwapFree, ZRAM state, process list/RSS, load, overlay usage и USB state.

Этот baseline является контрольной точкой для всех последующих компонентов. После каждого крупного этапа сохранять before/after значения.

### STAGE 8 — USB preparation/extroot
После clean base безопасно отделить старый USB extroot. Поскольку данные неценны, после отдельного подтверждения допускается полностью пересоздать USB.

Целевая схема: extroot для /overlay + отдельный /mnt/data + USB swap. Точные размеры выбираются по реальному USB.

Проверить UUID, filesystem, mount, boot behavior, available space и отсутствие зависимости от старой конфигурации.

### STAGE 9 — ZRAM + USB swap
После STAGE 7 и STAGE 8 настроить ZRAM и USB swap как два независимых слоя виртуальной памяти.

Стартовая экспериментальная точка: ZRAM 32 MiB. Размер может быть изменён по результатам измерений.

Задать приоритеты осознанно; первоначально ZRAM выше USB swap. Проверить swapon, zramctl/sysfs, SwapTotal/Free, MemAvailable, CPU/load и OOM. Не считать большой swap заменой RAM.

### STAGE 10 — DoH
Перед установкой зафиксировать memory snapshot после extroot + ZRAM + USB swap. Один https-dns-proxy, Cloudflare, 127.0.0.1:5053. Проверить process, listener, dnsmasq, DNS и RAM.

### STAGE 11 — Zapret2 source
Pinned v1.0.3. Не обновлять автоматически.

### STAGE 12 — SDK/build
OpenWrt 25.12.5 ath79/mikrotik, mips_24kc, gcc 14.3.0 musl.

### STAGE 13 — dependencies
Собирать и проверять только необходимые runtime APK.

### STAGE 14 — binaries/Lua
nfqws2, mdig, ip2net, zapret-lib.lua, zapret-antidpi.lua. Проверить native MIPS, executable, version and hashes.

### STAGE 15 — NFQUEUE kernel
Проверить nfnetlink, nfnetlink_queue, nft_queue.

### STAGE 16 — temporary NFQUEUE
Временное nft rule, queue binding, counter, curl/wget, cleanup.

### STAGE 17 — Zapret2 minimal
Lua/filtering without desync. Проверить HTTPS и memory.

### STAGE 18 — desync isolated tests
По одному: fake, tcp_md5, tls_mod=rnd, rndsni, dupsid, combinations, full strategy.

### STAGE 19 — real DPI
Проверять nft counters, logs, rawsend, EPERM, timeout, RSS, MemAvailable, OOM, queue state. Сравнивать с baseline и всеми промежуточными snapshots, чтобы отличать собственное потребление Zapret2 от общего memory-pressure.

### STAGE 20 — persistent Zapret2
Только после успешного real DPI test. Начальный scope TCP 80/443. QUIC/UDP 443 отдельно.

### STAGE 21 — WireGuard base
Отдельный controlled tunnel test.

### STAGE 22 — WARP Free
Отдельный test.

### STAGE 23 — Proton Free
Отдельный test.

### STAGE 24 — PBR
Только после VPN base.

### STAGE 25 — domain classification
Deterministic classification.

### STAGE 26 — nftset
Populate and verify.

### STAGE 27 — Zapret2 + PBR
Проверить NFQUEUE, marks, routing, rawsend and VPN compatibility.

### STAGE 28 — final IPv4/IPv6/DNS/routing
Проверить IPv4, IPv6, DNS, DoH, leaks, default route, PBR and VPN.

### STAGE 29 — persistence
Reboot and verify all retained components.

### STAGE 30 — final acceptance
Проверить OpenWrt version, profile, TP-Link role, WAN, LAN, AP, USB data, old extroot inactive, /mnt/data, swap/ZRAM, memory, OOM, DoH, Zapret2, VPN, PBR, IPv4, IPv6, DNS and reboot persistence.

## Per-step response format
STATUS: IN_PROGRESS

ЦЕЛЬ:
...

КОМАНДА:
...

ОЖИДАЕМЫЙ РЕЗУЛЬТАТ:
...

КРИТЕРИЙ PASS:
...

КРИТЕРИЙ FAIL:
...

После команды ждать фактический вывод пользователя.

## Forbidden without explicit approval
mkfs, fdisk, parted, wipefs, destructive dd, deletion/repartitioning of /dev/sda1/sda2/sda3, USB formatting, automatic old-overlay restore, flashing without image verification.

## Diagnostic objective
Определить, была ли проблема OOM/Zapret2 вызвана:
A) base OpenWrt/kernel;
B) accumulated configuration;
C) extroot/overlay;
D) DoH;
E) ZRAM/swap;
F) NFQUEUE;
G) Zapret2 rawsend/desync;
H) combination.

## Final principle
Сначала clean → measured → stable → reproducible base OpenWrt. Затем отдельно и последовательно построить extroot → ZRAM → USB swap и зафиксировать memory baseline. После этого возвращать DoH → Zapret2 → WireGuard/WARP/Proton → PBR по одному компоненту, после каждого этапа сравнивая RAM/OOM с предыдущей контрольной точкой.

Целевая архитектура Variant A: чистый OpenWrt + extroot + ZRAM + USB swap. Extroot решает ограничение 16-МБ flash; ZRAM и USB swap предназначены для управления memory-pressure. Ни один из этих механизмов нельзя считать гарантией отсутствия OOM без измерений.


## CHANGELOG — 2026-09-18
### [CHANGED] Variant A diagnostic context
- Зафиксировано, что до clean flash предыдущая система имела активный USB extroot на /dev/sda2; поэтому перед flash layout должен быть подтверждён фактическим read-only inventory, а не предположен.
- Зафиксировано, что предыдущая проблема OOM была системным memory-pressure событием: при OOM victim'ами становились разные процессы, включая https-dns-proxy и nfqws2; сам nfqws2 не демонстрировал большого RSS в момент убийства.
- Зафиксировано, что предыдущий Zapret2 real-DPI тест давал timeout YouTube и rawsend EPERM; эти результаты относятся к старой системе и не должны автоматически переноситься на чистую базу.
- После clean flash компоненты должны возвращаться строго по одному, чтобы отделить влияние base OpenWrt, extroot, DoH, swap/ZRAM, NFQUEUE и Zapret2.
- STAGE 0 остаётся IN_PROGRESS до завершения фактической read-only инвентаризации.


## CHANGELOG — 2026-09-18 — [UPDATED] target architecture: extroot + ZRAM + USB swap
- [CHANGED] Цель Variant A изменена: чистая OpenWrt-система теперь должна в нормальном целевом состоянии использовать extroot + ZRAM + USB swap, а не отказываться от extroot.
- [CHANGED] Старый extroot не переносится автоматически. После clean flash он будет создан заново после проверки clean base.
- [CHANGED] Поскольку пользователь подтвердил, что данные на USB не важны, после безопасного отделения старого extroot допускается полная пересозданная разметка USB отдельным destructive-этапом с предупреждением и подтверждением.
- [ADDED] Extroot рассматривается как решение ограничения места на внутренней 16-МБ flash, а не как средство увеличения RAM.
- [ADDED] ZRAM и USB swap рассматриваются как отдельные механизмы снижения memory-pressure/OOM.
- [ADDED] Стартовая экспериментальная точка ZRAM: 32 MiB; итоговый размер определяется измерениями.
- [ADDED] Предварительная модель приоритетов: ZRAM выше USB swap; фактическая конфигурация подтверждается тестами.
- [ADDED] После clean base должен быть сохранён memory baseline до установки DoH/Zapret2/VPN/PBR.
- [ADDED] После каждого крупного компонента фиксируются MemAvailable, SwapTotal/Free, ZRAM, slab, RSS ключевых процессов, load и OOM-события.
- [ADDED] Цепочка восстановления функциональности: clean base → extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR, строго по одному компоненту.
- [ADDED] Главный диагностический вопрос теперь: как меняется RAM/OOM при добавлении каждого компонента относительно контролируемого baseline.


## CHANGELOG — 2026-09-18 — [UPDATED] обязательная синхронизация мастер-плана
- [ADDED] Каждый пользовательский turn и каждый ответ ассистента должны завершаться синхронизацией OPENWRT_VARIANT_A_MASTER_PLAN.md с фактическим состоянием.
- [ADDED] В мастер-план записываются новые фактические выводы, выполненные команды, решения, изменения статусов и следующие критерии выхода.
- [ADDED] При отсутствии изменения состояния статусы не изменяются и новые факты не создаются.
- [ADDED] Синхронизация выполняется до завершения ответа ассистента.
- [CONFIRMED] Текущий STAGE 0 остаётся IN_PROGRESS: большая часть inventory уже выполнена, но финальные read-only snapshot-пункты ещё должны быть закрыты.


## CHANGELOG — 2026-09-18 — [SYNC] post-flash USB extroot inheritance confirmed
- [CONFIRMED] После clean flash выполнена read-only команда `mount; df -h`.
- [CONFIRMED] Текущая система имеет `/dev/sda2` mounted on `/overlay`, а `overlayfs:/overlay` mounted on `/`.
- [CONFIRMED] `/dev/sda3` mounted on `/mnt/data`.
- [CONFIRMED] `/dev/sda1` отсутствует в выводе `mount/df`; его swap-состояние этим тестом не определялось.
- [IMPORTANT] Фактически старый `/dev/sda2` снова является active `/overlay` после clean flash. Следовательно, `sysupgrade -n` не означает автоматическое физическое отделение старого extroot: внешний раздел был обнаружен и смонтирован при загрузке.
- [CHANGED] STAGE 4 остаётся IN_PROGRESS до намеренного отделения старого extroot и подтверждения clean base.
- [RULE] До безопасного отделения старого extroot запрещены `mkfs`, `fdisk`, `parted`, `wipefs`, destructive `dd`, удаление/переразметка USB и любые действия с риском потери данных.
- [NEXT] Сначала получить read-only `fstab + /proc/swaps + /sbin/block info`, чтобы установить механизм автоматического подключения `/dev/sda2` и фактическое состояние `/dev/sda1`.


## CHANGELOG — 2026-09-19 — [SYNC] extroot auto-discovery confirmed
- [CONFIRMED] Current post-flash `/etc/config/fstab` has global `auto_mount '1'` and an explicitly disabled `/overlay` entry for the old extroot UUID.
- [CONFIRMED] Despite that disabled explicit entry, `/dev/sda2` with label `extroot` and UUID `244b7bbc-add1-46cd-bc1a-0143cfca5d6c` is active at `/overlay`.
- [CONFIRMED] This establishes that the old extroot is being selected by the boot-time OpenWrt extroot/root filesystem discovery path rather than by the enabled state of that explicit fstab mount entry alone.
- [CONFIRMED] `/dev/sda1` is active USB swap (524284 kB, priority -2); current usage is 4348 kB.
- [CONFIRMED] `/dev/sda3` is active as `/mnt/data`.
- [CHANGED] STAGE 4 remains IN_PROGRESS; old extroot must still be intentionally detached before clean-base verification can PASS.
- [RULE] Before any destructive USB operation, first identify the exact boot-time extroot discovery mechanism using read-only evidence. Do not modify fstab or storage yet.

- 2026-09-19: confirmed `/lib/preinit/80_mount_root` delegates root/overlay selection to `mount_root start`; `/sbin/mount_root` is ELF, so extroot selection is implemented in fstools rather than directly in the preinit shell script. Next: read-only fstools/block-mount analysis.

- 2026-09-19: confirmed via `strings /sbin/mount_root` that fstools has dedicated `mount_extroot`/`fstools_overlay_name` logic and reports `switched to extroot`; extroot selection is therefore built into fstools. Next: identify the exact acceptance criterion read-only.

- 2026-09-19: `libfstools.so` confirms built-in extroot flow (`mount_extroot`, `/tmp/extroot`, `/tmp/extroot/overlay`, `switched to extroot`). `fstab` init/hotplug only delegate to `/sbin/block` and are not the preinit extroot selector. Next: identify exact discovery condition read-only.

- 2026-09-19: router has `fstools-2026.05.23~16718b6e-r1`; ELF symbol lookup returned no relevant symbols. Official fstools source confirms `mount_root` calls `mount_extroot()` before normal rootfs_data handling, matching the router binary. Next: identify exact extroot discovery condition for this revision from official source.

- 2026-09-19: official fstools source confirms disabled fstab mount entries are skipped during extroot config loading, while mount_root invokes mount_extroot before normal rootfs_data handling. Runtime still has /dev/sda2 as /overlay, creating a historical-state discrepancy. Per user request, no more diagnostic probing is planned; next is the already planned destructive USB reset/repartition, pending explicit confirmation immediately before execution.

- 2026-09-19: user explicitly authorized complete repartitioning and formatting of `/dev/sda`; old USB data are not needed. Destructive stage may proceed, but first command remains a final read-only identity/partition check.


SYNC 2026-09-19: User explicitly authorized complete repartitioning and formatting of `/dev/sda`; final read-only identity/partition check passed. Proceed one command at a time.

SYNC 2026-09-19: `swapoff /dev/sda1` completed successfully (empty output). Continue one command at a time.

SYNC 2026-09-19: `/mnt/data` unmounted successfully. Continue one command at a time.

SYNC 2026-09-19: fstab global auto_mount disabled and router reboot completed. Continue one command at a time.

SYNC 2026-09-19: `auto_mount=0` did not prevent extroot; `/dev/sda2` remains active `/overlay`. Do not format while USB is attached. Use clean shutdown and physical USB removal before repartitioning.

SYNC 2026-09-19: Post-reboot SSH host key changed to SHA256:ffcy+GxkVzRuj+9unvWg4a30g14N99UkG9KxWf+fuF8. Do not bypass host-key verification until physical USB removal/boot state is confirmed.

SYNC 2026-09-19: USB physically disconnected. Next step is host-key replacement verification; do not bypass strict checking.

SYNC 2026-09-19: Old SSH host key entry removed successfully. USB disconnected; next SSH command must verify internal rootfs only.

SYNC 2026-09-19: Internal rootfs verification PASS. `/dev/mtdblock9` is `/overlay`; no `/dev/sda`; no `/mnt/data`; OpenWrt 25.12.5 confirmed. USB can now be reattached for offline repartitioning, one command at a time.

SYNC 2026-09-19: USB reconnected after confirming internal jffs2 overlay. Next action is read-only verification only; no destructive command until USB is confirmed inactive.

SYNC 2026-09-19: USB is not mounted as overlay/data, but `/dev/sda1` auto-activated as swap. Disable it before repartitioning. No destructive command yet.

SYNC 2026-09-19: USB swap disabled successfully. USB is now inactive; destructive repartitioning may proceed one command at a time.

SYNC 2026-09-19: fdisk opened on `/dev/sda`; no write yet. Continue one interactive command at a time.

SYNC 2026-09-19: fdisk `g` created a new GPT disklabel in memory only; no disk write yet. Target remains extroot + USB swap + optional data, sizes chosen from actual USB.

SYNC 2026-09-19: User exited fdisk without writing. User prefers complete commands rather than interactive fdisk prompts, while retaining one logical operation per step.

SYNC 2026-09-19: Clarified optional /mnt/data role: persistent bulk-data area separate from extroot, not required for core OpenWrt operation. No partitioning change performed.

SYNC 2026-09-19: Clarified ZRAM timing/state: prior verified state has /dev/zram0 32 MiB lzo-rle activated; therefore ZRAM is not to be installed later as a new Stage 4 task. STAGE 4 preserves extroot + ZRAM + USB swap. /tmp remains RAM-backed and is not to be moved into ZRAM.

SYNC 2026-09-19: USB repartitioning completed but scripted type selection set sda1 to EFI System rather than Linux swap; '19' was an unknown fdisk command. sda1 retains swap signature; sda2 retains ext4 signature. Next step: correct sda1 GPT type to Linux swap, then verify before formatting/extroot.

SYNC 2026-09-19: Read-only fdisk verification PASS. GPT on /dev/sda; sda1 512 MiB Linux swap; sda2 6.8 GiB Linux filesystem; no sda3. Target USB layout confirmed. No formatting performed yet.

SYNC 2026-09-19: Formatting attempt did not complete: mkswap /dev/sda1 returned 'Text file busy'; due to &&, sda2 was not formatted. Treat current state as blocked by active use of sda1; identify/clear usage before retrying.

SYNC 2026-09-19: `swapoff /dev/sda1` completed with empty output, so active USB swap is now disabled. Formatting has not yet been completed.

SYNC 2026-09-19: USB formatting PASS. sda1 initialized as swap; sda2 formatted ext4 label `extroot`, UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2`. Extroot migration/fstab changes not yet performed.

SYNC 2026-09-19: Pre-extroot overlay baseline PASS: `/overlay` = /dev/mtdblock9 jffs2, 7.0M total, 372K used, 6.6M available; du 35.5K. USB extroot not mounted yet. Next step is controlled overlay copy to sda2.

SYNC 2026-09-19: sda2 temporary mount PASS at `/mnt/extroot`; no fstab/extroot activation change yet.

SYNC 2026-09-19: Overlay copy PASS: `/overlay` contents copied to `/mnt/extroot` successfully. Internal overlay remains active; no fstab activation yet.

SYNC 2026-09-19: extroot staging verification PASS: sda2 mounted at /mnt/extroot with copied overlay content present; 6.6G size, 6.2G available. No fstab activation yet.

SYNC 2026-09-19: Reviewed current fstab: swap sda1 enabled; stale /mnt/data UUID `fa23e979-...`; stale extroot UUID `244b7bbc-...`. New extroot UUID is `e1c68a3a-0e55-4af9-afd8-961160b3afa2`. Before activation, replace extroot UUID and remove obsolete /mnt/data entry.

SYNC 2026-09-19: fstab edit PASS: backup created, obsolete /mnt/data mount removed, extroot UUID updated to `e1c68a3a-0e55-4af9-afd8-961160b3afa2`, UCI committed. No activation/reboot yet.

SYNC 2026-09-19: fstab verification PASS. Only USB swap `/dev/sda1` and enabled extroot `/overlay` UUID `e1c68a3a-0e55-4af9-afd8-961160b3afa2` remain; `/mnt/data` entry removed. Activation has not occurred.

SYNC 2026-09-19: User rebooted router and restored SSH. Extroot activation attempted; `/overlay` source still requires direct verification before marking DONE.

SYNC 2026-09-19: STAGE 4 extroot activation VERIFIED PASS. `/overlay` is `/dev/sda2` after reboot (6.6G total, 6.2G available). USB extroot is active; swap/ZRAM preservation remains required.

SYNC 2026-09-19: STAGE 4 CLOSED DONE. USB extroot verified active on `/dev/sda2` after reboot. STAGE 5 IN_PROGRESS: minimal network verification. No network configuration changed; next step is read-only inspection of current network configuration and IPv4 route.


SYNC 2026-09-19: STAGE 5.1 PASS for LAN configuration, but WAN connectivity is not established: eth1 has no IPv4 address and no IPv4 default route despite DHCP config. No network state changed. Next: read-only WAN link/DHCP state inspection.


SYNC 2026-09-19: STAGE 5 WAN inspection result: `eth1` is administratively UP but `NO-CARRIER` and operational state DOWN. Kernel detects the Atheros AG71xx Ethernet device, but no physical carrier is present. netifd repeatedly enables/disables DHCP interface `wan`; no DHCP lease/default route is established. No network configuration was changed. Because the target architecture uses TP-Link Wi-Fi → MikroTik Wi-Fi STA, next step is read-only inspection of current wireless devices/configuration before any network change.


SYNC 2026-09-19: STAGE 5 wireless inspection PASS. Wi-Fi STA interface `phy0-sta0` exists on radio0 (5 GHz), managed mode, configured for network `wan`, SSID `SPKEFFA_5G`, WPA2-PSK, enabled. Both AP interfaces are disabled. No network configuration was changed. Next: read-only check whether the STA is actually associated and whether `wan` is bound to the wireless STA device; do not change credentials or network settings yet.


SYNC 2026-09-19: User updated the upstream Wi-Fi credentials for the intended WAN STA: SSID changed from `SPKEFFA_5G` to `TPLINK`; WPA2-PSK password provided as `89518996225` (user explicitly marked it as fictional/example). No router configuration has been changed yet. STAGE 5 remains IN_PROGRESS; next single operation is to update the existing Wi-Fi STA SSID/key only, then verify configuration/association.

SYNC 2026-09-19: User executed the Wi-Fi STA credential update successfully. Actual SSID set is `SweetHomeU` (correcting the prior message's `TPLINK`), WPA2-PSK key set to `89518996225`. `uci commit wireless` completed without error. No association/reload verification has been performed yet. STAGE 5 remains IN_PROGRESS. Next: read-only verification of the saved STA configuration before applying/reloading Wi-Fi.

SYNC 2026-09-19: STAGE 5 Wi-Fi STA configuration verification PASS. Saved config confirms `network='wan'`, `mode='sta'`, `ssid='SweetHomeU'`, `disabled='0'`, and key `89518996225`. No Wi-Fi reload/apply has been performed yet. Next: apply the committed wireless configuration, then verify STA association and WAN DHCP in the following single step.

SYNC 2026-09-19: `wifi reload` completed with empty output, indicating no command-level error was reported. STAGE 5 remains IN_PROGRESS. Next: read-only verification of actual STA association and `wan` DHCP state.

SYNC 2026-09-19: STAGE 5 WAN Wi-Fi STA association/DHCP PASS. phy0-sta0 is associated to SSID SweetHomeU at 5180 MHz with signal -29 dBm. wan is up on phy0-sta0, DHCP address 192.168.0.111/24, default gateway 192.168.0.1, DHCP server 192.168.0.1, lease 86400 s. IPv6 is currently empty. DHCP DNS includes 192.168.0.1 and 0.0.0.0. STAGE 5 is not yet DONE: remaining exit checks are LAN client addressing/default route and actual Internet/DNS reachability.

SYNC 2026-09-19: STAGE 5 LAN/gateway/Internet IPv4 checks PASS. br-lan is 192.168.1.1/24; default route is via 192.168.0.1 on phy0-sta0; gateway ping 3/3 succeeds; 1.1.1.1 ping 3/3 succeeds. User requested shorter command outputs to reduce copy/paste burden. From this point, prefer concise verification commands using brief summaries/counts instead of verbose full dumps, while preserving enough evidence for PASS/FAIL. STAGE 5 remains IN_PROGRESS until concise DNS and LAN-client checks are completed.
- SYNC 2026-09-19: STAGE 5 DNS upstream check PASS. Command `nslookup openwrt.org 192.168.0.1 | tail -n 4` returned a non-authoritative answer for `openwrt.org` with address `64.226.122.113`. STAGE 5 remains IN_PROGRESS; only LAN-client addressing/default-route/Internet/DNS checks remain before exit.

- SYNC 2026-09-19: STAGE 5 LAN-client DHCP check failed as a diagnostic method: `ubus call dhcp ipv4leases` returned `Method not found`, so no client lease state was established by this command. No network configuration changed. Need a different concise read-only client verification method.

- SYNC 2026-09-19: `cat /tmp/dhcp.leases` PASS. DHCP lease file shows LAN client `EFFA` with MAC `d4:93:90:50:1a:b3` and IPv4 `192.168.1.146`. This confirms the MikroTik DHCP server issued a LAN address to the client. STAGE 5 remains IN_PROGRESS because laptop-side default gateway, route, Internet, and DNS checks are still required by the stage exit criteria.

- SYNC 2026-09-19: Laptop-side `ipconfig | findstr /R /C:"IPv4" /C:"Default Gateway"` returned two IPv4 addresses: `192.168.1.146` (MikroTik LAN) and `192.168.0.110` (another interface). The filtered output did not show Default Gateway, so laptop default-route state is not yet established. No router configuration changed. STAGE 5 remains IN_PROGRESS; next step must distinguish the active interface/gateway using a concise Windows read-only command.

- SYNC 2026-09-19: Windows `Get-NetIPConfiguration` confirms interface `Ethernet` has `192.168.1.146` with gateway `192.168.1.1`. Laptop LAN IP and MikroTik gateway PASS. STAGE 5 remains IN_PROGRESS; route, Internet, and DNS checks remain.

- SYNC 2026-09-19: Windows default-route check shows `192.168.1.1` via `Ethernet` and also `192.168.0.1` via `Беспроводная сеть`. MikroTik path has a valid default route; a second independent Wi-Fi default route also exists on the laptop. STAGE 5 remains IN_PROGRESS. For a clean MikroTik client-path Internet test, the next step should explicitly test using the Ethernet interface rather than changing routing.

- SYNC 2026-09-19: Windows `Test-NetConnection` with `-InterfaceAlias` failed because this PowerShell/Windows version does not expose that parameter. No network configuration changed. The MikroTik Ethernet default route remains verified; the Ethernet-specific Internet test is still pending. STAGE 5 remains IN_PROGRESS.

- SYNC 2026-09-19: Windows Ethernet-sourced Internet test `ping -S 192.168.1.146 1.1.1.1` PASS: 4/4 replies, 0% loss, ~59 ms. This confirms Internet IPv4 connectivity through the laptop's MikroTik Ethernet path. STAGE 5 remains IN_PROGRESS pending the laptop DNS check.

- SYNC 2026-09-19: Windows `nslookup openwrt.org 192.168.1.1` PASS. MikroTik LAN DNS at `192.168.1.1` successfully resolved `openwrt.org` to IPv4 `64.226.122.113` and IPv6 `2a03:b0c0:3:d0::1a51:c001`. STAGE 5 exit criteria are now satisfied: laptop IP/gateway, default route via MikroTik, Internet IPv4, and DNS through MikroTik all verified. STAGE 5 status = DONE.

- SYNC 2026-09-19: STAGE 6 started. Read-only verification PASS: OpenWrt 25.12.5, `OPENWRT_ARCH=mips_24kc`, apk-tools 3.0.5 compiled for mips. No configuration changed. STAGE 6 remains IN_PROGRESS; next step is read-only inspection of current wireless AP configuration/state before enabling or changing anything.


## SYNC 2026-09-19 — AUTHORITATIVE CURRENT STATE

The repository contains two canonical project artifacts: OPENWRT_VARIANT_A_MASTER_PLAN.md (master plan) and OPENWRT_VARIANT_A_MASTER_PROMPT.md (master prompt). Both must be synchronized with factual state after each user/assistant turn.

Current factual state: STAGE 0–5 DONE; STAGE 6 IN_PROGRESS; STAGE 7–30 NOT_STARTED. OpenWrt 25.12.5 r33051-f5dae5ece4 on MikroTik hAP ac lite, TP-Link Archer C20 v4 remains the main router. WAN is Wi-Fi STA via TP-Link with 192.168.0.111/24 and gateway 192.168.0.1; LAN is 192.168.1.1/24; laptop Ethernet is 192.168.1.146 with gateway 192.168.1.1. Ethernet-sourced Internet and DNS through MikroTik are verified PASS. USB extroot is active on /dev/sda2; /dev/sda1 is USB swap; ZRAM is 32 MiB lzo-rle and active; /tmp remains RAM-backed. No router configuration change was made during this synchronization. STAGE 6 next step remains read-only wireless AP configuration inspection.


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


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 6 / operational rules

Добавлены/уточнены обязательные правила текущего расследования:
1. VHT40 является целевым и достаточным рабочим режимом для 5 GHz; VHT80 не исследовать повторно без отдельного запроса.
2. Считать одновременно работающие phy0-sta0 + phy0-ap0 доказанно поддерживаемым сценарием: это подтверждено реальным клиентским подключением и Internet.
3. Считать успешный real-client test частью фактического STAGE 6 состояния, но не считать его доказательством устранения периодического reload/root cause.
4. Не считать https-dns-proxy, pbr, MLD или distance=0 причиной -122 без прямого доказательства.
5. Не удалять https-dns-proxy и не применять непроверенные forum workarounds.
6. Диагностика продолжается только read-only, одним command за шаг, без намеренного wifi reload/restart, hostapd reload, wpa_supplicant reload, dnsmasq restart/reload или перезапуска https-dns-proxy.
7. Следующий шаг: targeted search прямых инициаторов Wi-Fi/hostapd reload в /etc/hotplug.d, /etc/init.d, /lib/netifd, /lib/wifi, /usr/libexec.
8. Не записывать MAC-адреса клиентских устройств или секреты upstream STA в master files.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 GitHub API connectivity PASS
- [CONFIRMED] Read-only HTTPS connectivity to the official GitHub API is working from the router after the earlier `Operation not permitted` download failure.
- [RULE] Do not treat the earlier wget failure as a persistent GitHub/network outage; retry the pinned archive download only after this successful connectivity check.
- [NEXT] Download the exact Zapret2 v1.0.3 OpenWrt embedded archive and verify its SHA-256 before extraction or installation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive download to persistent extroot PASS
- [CONFIRMED] The pinned Zapret2 v1.0.3 embedded archive was downloaded successfully to persistent USB extroot storage at `/overlay/tmp/zapret2/zapret2-v1.0.3-openwrt-embedded.tar.gz`.
- [CONFIRMED] Download size is 4,314,955 bytes, matching the already verified official GitHub release asset size.
- [RULE] Prefer persistent extroot storage for this archive instead of `/tmp`, because `/tmp` is RAM-backed and the router has limited RAM.
- [NO CHANGE] No extraction, installation, configuration, firewall, Wi-Fi, or service activation was performed.
- [NEXT] Verify the local SHA-256 against the pinned official digest before extraction or installation.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 archive extraction PASS
- [CONFIRMED] The pinned v1.0.3 archive passed SHA-256 verification before extraction.
- [PASS] Archive extraction completed successfully under persistent extroot storage at `/overlay/tmp/zapret2/extract`.
- [RULE] Continue with read-only inspection only; do not install or activate Zapret2 until the exact router/binary architecture compatibility is verified.
- [NEXT] Inspect ELF architecture/type of the extracted `linux-mips` binaries.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 ELF inspection tool unavailable
- [OBSERVED] `file` is not installed on the router; the read-only architecture check was not completed with that utility.
- [RULE] Do not install extra diagnostic packages solely for this check without need; use existing BusyBox read-only capabilities first.
- [NO CHANGE] Zapret2 remains uninstalled and inactive.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Inspect ELF headers with built-in hex output.


## CHANGELOG — 2026-09-19 — [SYNC] STAGE 11 nfqws2 ELF header PASS
- [CONFIRMED] Extracted `linux-mips/nfqws2` is ELF32, big-endian, MIPS (e_machine=8), based on its ELF header.
- [RULE] Continue architecture verification read-only before any Zapret2 installation.
- [NO CHANGE] No packages, services, firewall, Wi-Fi, or network configuration were changed.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT] Check `ip2net` and `mdig` ELF headers with BusyBox hexdump.
