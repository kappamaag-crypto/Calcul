# OPENWRT VARIANT A — START HERE

Это корневой handoff-файл проекта. Перед любой технической работой по роутеру новый AI обязан выполнить project preflight.

## Обязательный порядок чтения

1. `OPENWRT_VARIANT_A_MASTER_PROMPT.md` — обязательные правила, безопасность и workflow.
2. `OPENWRT_VARIANT_A_MASTER_PLAN.md` — фактическое состояние, история, стадии, завершенные проверки и точка остановки.
3. `OPENWRT_VARIANT_A_GLOSSARY.md` — команды, термины и уже реализованные возможности.
4. Затем — только релевантные implementation/evidence-файлы из корня репозитория.

## Правила

- Не начинать техническую работу с команды на роутере до чтения трех обязательных документов.
- Сначала определить последнюю подтвержденную точку в MASTER PLAN.
- Перед установкой или созданием чего-либо проверить, не реализована ли эта возможность уже.
- Не считать наличие файла, профиля или исторической команды доказательством активного состояния роутера.
- Свежий подтвержденный результат пользователя имеет приоритет над устаревшим историческим результатом; после этого MASTER PLAN должен быть синхронизирован.
- Репозиторий `Calcul` хранит состояние проекта и доказательства; техническую семантику OpenWrt/Linux/packages проверять по официальной документации.
- Соблюдать one-router-command-at-a-time.
- После user result + assistant response синхронизировать MASTER PLAN до следующей команды.

## На что обратить особое внимание

У проекта уже существуют реализованные функции, которые нельзя создавать заново без проверки: USB extroot, ZRAM/USB swap, диагностический CLI-набор, Zapret2 v1.0.3, Zapret2 nftables/NFQUEUE runtime и активный Zapret2 watchdog.

Запрет2 watchdog уже установлен и работает под OpenWrt procd. Не создавать второй watchdog.

## Текущая точка

На 2026-09-25: STAGE 14 IN_PROGRESS. Zapret2 watchdog deployment/activation DONE. Proton Gate 1 DONE. Proton Gate 2 DONE. Proton Gate 3 IN_PROGRESS. Endpoint host route protection DONE.

Следующий точный контролируемый шаг: создать изолированную UCI AWG-секцию `proton-awg-test`, не запускать её и не создавать default route.

## История

Подробная история находится в MASTER PLAN. Глоссарий содержит полный реестр команд и устойчивые определения. MASTER PROMPT содержит hard rules и workflow enforcement.
## CURRENT HANDOFF ENFORCEMENT — 2026-09-25

Перед любой новой командой/изменением AI обязан:
1. прочитать OPENWRT_VARIANT_A_MASTER_PROMPT.md;
2. прочитать OPENWRT_VARIANT_A_MASTER_PLAN.md;
3. прочитать OPENWRT_VARIANT_A_GLOSSARY.md;
4. сверить Capability Registry и evidence level (IMPLEMENTED IN REPOSITORY / DEPLOYED TO ROUTER / ACTIVE AT RUNTIME / VALIDATED);
5. восстановить точку остановки и только после этого читать релевантные implementation/evidence-файлы.

### Последнее подтвержденное изменение 2026-09-25
Google DoH instance 127.0.0.1:5054 удалён из UCI по решению пользователя; Cloudflare 127.0.0.1:5053 оставлен. https-dns-proxy успешно перезапущен. Проверка фактического post-restart runtime ещё ожидается.

Текущий проектный gate не меняется: STAGE 14 / Proton-AWG Gate 3 остаётся IN_PROGRESS. После завершения DoH post-restart validation следующий проектный шаг — изолированная UCI AWG-секция proton-awg-test без запуска и без default route.
## HANDOFF UPDATE — 2026-09-25 — latest diagnostic branch

The latest chat evidence is synchronized into MASTER PLAN and GLOSSARY:
- Proton OpenVPN TCP/443 direct and isolated multisplit/fakedsplit tests did not establish a control channel; do not treat either desync variant as a fix.
- proton.auth metadata is structurally ordinary; secrets are not stored in project docs.
- A plaintext HTTP probe to TCP/443 was non-diagnostic.
- The router's current BusyBox wget does not support -S.
- The router currently reports no openssl executable, which conflicts with an older package-install record; reconcile only if the tool is actually needed.
- No temporary qnum 65301 process or nft rule remains.

Future AI must classify tool/syntax failures separately from network/service failures and must not reopen exhausted desync testing without a new hypothesis.


---

## MANDATORY CAPABILITY PREFLIGHT — 2026-09-25

Before any technical action on Variant A, the AI MUST:
1. Read `OPENWRT_VARIANT_A_MASTER_PROMPT.md`.
2. Read the latest/current `OPENWRT_VARIANT_A_MASTER_PLAN.md`.
3. Read `OPENWRT_VARIANT_A_GLOSSARY.md`.
4. Audit the latest capability state for already implemented, configured, verified, disabled, failed and blocked functions.
5. Verify the current router state before relying on historical results.
6. Treat ImageBuilder/package availability as **AVAILABLE_FOR_BUILD**, not as proof of runtime installation.
7. After each user result, synchronize the master plan before the next substantive command.

### Current handoff checkpoint — 2026-09-25
USB is directly connected to the MikroTik and is detected as `/dev/sda` (~3.75 GiB). The new MBR layout is:
- `/dev/sda1`: 64 MiB Linux swap, initialized and active.
- `/dev/sda2`: ~3.7 GiB Linux partition, not yet formatted.
The current running firmware lacks `mkfs.ext4`/e2fsprogs, so ext4 creation is blocked until firmware/package reconciliation.

**Do not assume old extroot, /mnt/data, DoH, PBR, Zapret2, WARP or Proton states are currently active without fresh runtime verification.**

## CURRENT AUTHORITATIVE HANDOFF — 2026-09-25

The active project branch is STAGE 14 / Proton-AWG GATE 3 IN_PROGRESS.

Before every technical turn, a new AI must read this file, MASTER PROMPT, MASTER PLAN and GLOSSARY, inventory the repository root, audit the Capability Registry, and reconcile the latest router evidence. This is mandatory even when the request appears to concern only one feature.

Current exact stopping point:
- Zapret2 dedicated WireGuard path: runtime-confirmed active (QNUM 65300).
- Current Proton Free profile: structurally checked, standard WireGuard format; private key remains local/secret.
- Proton endpoint host route: verified via 192.168.0.1 on phy0-sta0.
- AWG interface: not created.
- UCI proto=amneziawg: absent.
- Default route: not changed for the AWG experiment.

**Next exact step:** create isolated UCI section proton-awg-test, do not start it, do not create a default route.

Older parallel notes (including pending DoH validation and historical OpenVPN/USB branches) must not displace this checkpoint unless explicitly selected.

## EXECUTION HANDOFF — 2026-09-25

Проект работает в режиме **EXECUTION**, а не в режиме повторного пересказа.

Стандартная команда пользователя **«Продолжай.»** означает:
1. выполнить обязательный repository preflight;
2. восстановить последний подтвержденный checkpoint;
3. найти следующий однозначный шаг MASTER PLAN;
4. сразу выполнить его, если он безопасен для выполнения без отдельного подтверждения;
5. выдать только один router command/test;
6. после результата синхронизировать MASTER PLAN до следующей изменяющей команды.

Не спрашивать повторно то, что уже разрешено текущим этапом. Не пересказывать весь план. Не повторять закрытые диагностики без новой причины.

Отдельное подтверждение сохраняется только для destructive/труднообратимых операций, риска потери доступа, flash/partition/format, массового изменения пакетов, включения нового default route/полной VPN-маршрутизации или передачи секретов.

**Рекомендуемая команда пользователя:** «Продолжай.»
**Максимально однозначная:** «Продолжай строго по MASTER PLAN с текущей точки. Один шаг.»

## AUTHORITATIVE HANDOFF CORRECTION — STAGE 14 / PROTON-AWG GATE 3 — 2026-09-25 20:58 GMT

The older handoff text saying that proton_awg_test had not yet been created is stale. Fresh router evidence proves that the isolated proton_awg_test interface exists and is active for the Gate 3 experiment.

Current authoritative state:
- proton_awg_test = UP/LOWER_UP, endpoint 194.180.33.20:51820, no received bytes, no observed handshake.
- Endpoint route = via 192.168.0.1 dev phy0-sta0 src 192.168.0.100.
- Dedicated Zapret2 QNUM 65300 = active under PID 3205; packet-id advanced with AWG TX during the big test; queue depth/drops remained 0.
- Bounded WAN capture saw outbound UDP/51820 only and no inbound endpoint response.
- STAGE 14 / Proton-AWG Gate 3 = IN_PROGRESS.
- Default route remains unchanged; no VPN activation or bypass claim.
- The next action must be selected from a new hypothesis; do not repeat equivalent Gate 3 captures.

---
<!-- 2026-09-26 supersession: USB/extroot/swap/zram runtime correction is recorded in the authoritative 2026-09-26 section at the end of this file. Older conflicting USB statements are historical/stale. -->
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-25 — USER DECISION / LATEST RECONCILIATION

> This section is an explicit current-state override. Older sections are intentionally retained for history and evidence, but any older statement that conflicts with this section is **HISTORICAL / STALE** and must not be used as the next-action checkpoint.

### Current project checkpoint
- **WireGuard / AmneziaWG / Proton tunnel branch: PAUSED by user.** The existing Proton-AWG experiment remains unfinished and unvalidated; this is an execution pause, **not** a technical FAILED/BLOCKED conclusion.
- The WireGuard branch is moved to the **FINAL MAJOR IMPLEMENTATION/VALIDATION STAGE**. Do not resume AWG/WireGuard tests, parameter sweeps, endpoint A/B tests, default-route activation, or full-VPN routing unless the user explicitly reopens it or the final stage is reached.
- **Zapret2 Telegram/WhatsApp scope: BLOCKED** for the current Zapret2-only approach. Evidence indicates that at least part of the problem may be IP-level rather than ordinary DPI. Do not continue blind NFQWS/MODE_FILTER/desync tuning without a new hypothesis.
- **Zapret2 remains active and useful for the validated DPI-oriented scope.** Current known configuration includes MODE_FILTER=autohostlist, TCP 80/443, UDP 443, main QNUM=300, dedicated WireGuard-pattern QNUM=65300, FLOWOFFLOAD=donttouch, INIT_APPLY_FW=1, DISABLE_IPV6=1, SET_MAXELEM=522288.
- **Zapret2 watchdog: INSTALLED / ACTIVE AT RUNTIME / HEALTHY.** Do not create a second watchdog.
- **DoH / https-dns-proxy: RETIRED from the current Variant A workflow by explicit user decision.** Historical DoH installation/configuration/evidence remains in this repository, but it must not be reintroduced unless the user explicitly requests it. Any older note describing DoH as the next active task is HISTORICAL / STALE.
- **USB current runtime truth:** /dev/sda1 = 64 MiB Linux swap, initialized/active; /dev/sda2 = remaining ~3.7 GiB Linux partition, **not formatted**. Current firmware lacks mkfs.ext4/e2fsprogs, so ext4 creation is BLOCKED pending firmware/package reconciliation. Any older claim that /dev/sda2 is already ext4/extroot or that /dev/sda3 is active is HISTORICAL / STALE unless newer runtime evidence proves otherwise.
- **Memory:** ZRAM + USB swap are retained as current project mechanisms; persisted vm.min_free_kbytes=2048 has passed load validation. Do not casually change memory tuning without a new hypothesis.
- **Archer C20 v4 remains the main router.** The MikroTik hAP ac lite remains downstream and must not be promoted to the primary router without an explicit user decision.

### Next-action rule after this reconciliation
Because the tunnel branch is frozen and Telegram/WhatsApp Zapret2-only scope is blocked, the next project action must be selected from the highest-priority **incomplete non-tunnel capability** after a fresh capability audit. Do not follow stale numeric stage text merely because it appears earlier in this document.

### Evidence ladder
Use explicit states: IMPLEMENTED IN REPOSITORY → AVAILABLE_FOR_BUILD → INSTALLED / DEPLOYED TO ROUTER → CONFIGURED → ACTIVE AT RUNTIME / RUNTIME_VERIFIED → VALIDATED, with DISABLED, PLANNED, BLOCKED, FAILED recorded separately. A historical record never outranks newer verified runtime evidence.

### Preservation rule
No historical information is to be deleted merely because it is no longer current. Retain old test results, configurations, stage notes, commits and hypotheses, but label superseded material as **HISTORICAL / STALE / RETIRED / PAUSED** where applicable.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — USB / EXTROOT / SWAP / ZRAM RUNTIME VERIFICATION

This section supersedes all older USB-storage statements that conflict with the runtime evidence below. Older USB/extroot preparation records are retained as HISTORY only and must not be used as the current next-action checkpoint.

### Fresh read-only runtime evidence
- `/dev/sda` is present and detected by OpenWrt as a ~7.28 GiB USB disk.
- `/dev/sda1` = 512 MiB swap partition; initialized and ACTIVE at runtime with priority **-2**.
- `/dev/sda2` = ext4 filesystem, LABEL **extroot**, UUID **e1c68a3a-0e55-4af9-afd8-961160b3afa2**; mounted read-write at **/overlay**.
- `/` is `overlayfs:/overlay`, therefore the active writable root is backed by the USB extroot.
- `/dev/sda3` is NOT part of the current partition table.
- `fstab` has an enabled ext4 mount for the extroot UUID at `/overlay` and an enabled `/dev/sda1` swap entry.
- `/proc/swaps` shows both `/dev/sda1` (~512 MiB, priority -2) and `/dev/zram0` (~26 MiB, priority 100) ACTIVE.
- `zram0` current disk size is 27,262,976 bytes (~26 MiB); current swap use is non-zero, so zram is not merely configured but active in runtime.
- `vm.min_free_kbytes = 2048` is currently loaded.
- `df -h` reports `/overlay` and `/` with about 6.6 GiB total and about 6.2 GiB available.
- Current filtered `dmesg` shows successful ext4 recovery/mount and swap/zram activation; no current `I/O error`, ext4 filesystem error, journal error, or swap/zram error was present in the supplied audit.

### Capability decision
- **USB extroot = RUNTIME_VERIFIED / DONE for the current planned capability.**
- **USB swap = RUNTIME_VERIFIED / DONE.**
- **ZRAM = RUNTIME_VERIFIED / DONE.**
- The previously documented branch claiming `/dev/sda2` was unformatted and waiting for `mkfs.ext4/e2fsprogs` is **HISTORICAL / STALE**.
- The previously documented proposed action `apk search -e e2fsprogs` / formatting `/dev/sda2` is superseded and MUST NOT be used as the next project action.
- No filesystem formatting, repartitioning, package installation, or reboot was performed as part of this verification.
- This evidence is read-only runtime verification; boot-persistence beyond the current boot is not additionally claimed unless separately tested.

### Current storage layout
```
/dev/sda
├─ /dev/sda1  512 MiB  swap     ACTIVE, priority -2
└─ /dev/sda2  ~6.6 GiB ext4    LABEL=extroot, mounted /overlay, RW
```

Any older statement that says `/dev/sda2` is unformatted, that ext4 creation is blocked, that `/mnt/data` is currently mounted from `/dev/sda3`, or that the current USB is only a staging device is historical/stale unless a newer verified runtime result explicitly changes it.


---
## AUTHORITATIVE CURRENT-STATE OVERRIDE — 2026-09-26 — WI-FI RUNTIME VERIFICATION

This section supersedes older Wi-Fi statements where they conflict. Older Wi-Fi records remain history only.

- phy0-ap0 is UP as 5 GHz AP, channel 36 / 5180 MHz, SSID OpenWrt, WPA2 (psk2), BSSID b8:69:f4:d6:e8:a5.
- phy1-ap0 is UP as 2.4 GHz AP, channel 1 / 2412 MHz, SSID OpenWrt, WPA2 (psk2), BSSID b8:69:f4:d6:e8:a6.
- phy0-sta0 is UP and actively associated to the Archer-side upstream SSID SweetHomeU on 5 GHz, 5180 MHz; observed signal -41 dBm, RX/TX bitrate 86.7 MBit/s.
- Both APs are attached to lan; the STA interface is attached to wan in the current UCI.
- Hostapd status for both APs is present and reports the expected BSSID/SSID/frequency/channel.
- Recent logs contain successful WPA2 4-way handshakes and normal upstream group rekeying. No current fatal hostapd/wpa_supplicant/ath10k failure is evidenced by the supplied bounded log.
- Repeated "wpa_supplicant: Unknown event 37" messages occur after successful upstream group rekeying; with the STA remaining associated and passing traffic, this is recorded as an observed compatibility/noise message, not as a confirmed Wi-Fi failure.
- Capability state: dual-band hAP AP service = RUNTIME_VERIFIED / DONE; Archer-side 5 GHz STA uplink = RUNTIME_VERIFIED / DONE; WPA2 on both APs = RUNTIME_VERIFIED / DONE.
- Still incomplete: management/access to the hAP/OpenWrt from an Archer-side Wi-Fi client without LAN has not been validated and remains a separate capability.
- Do not change wireless configuration merely from this audit.
