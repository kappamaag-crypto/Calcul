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
