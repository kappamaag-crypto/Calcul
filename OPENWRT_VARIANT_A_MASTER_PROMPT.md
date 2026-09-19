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