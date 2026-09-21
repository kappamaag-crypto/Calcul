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
STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation)
STAGE 12–30 — NOT_STARTED

## One-step-at-a-time rule
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянием. Следующий router command выдаётся только после фактического результата предыдущего.
Запрещено объединять текущую синхронизацию результата с выдачей следующей команды.

## Architecture
TP-Link Archer C20 v4 остаётся главным маршрутизатором.
MikroTik hAP ac lite работает downstream через Wi-Fi STA.
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.

## Safety
Без явного отдельного подтверждения запрещены destructive storage operations. Во время post-reboot audit изменения сервисов/конфигурации не выполняются.
Избегать больших `logread | grep` pipelines из-за ранее подтверждённых OOM.
Для swap использовать `swapon -s`; `swapon --show` на этом BusyBox не поддерживается.

## CHANGELOG — 2026-09-21 — nfqws2 absent after reboot
[FACTUAL RESULT] The user executed `pgrep -a nfqws2`; the output was empty.
[CONCLUSION] No nfqws2 process is running after reboot.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 start command path not found
[FACTUAL RESULT] The user executed `/opt/zapret2/init.d/sysv/zapret2 start`; BusyBox ash returned `-ash: /opt/zapret2/init.d/sysv/zapret2: not found`.
[CONCLUSION] The previously referenced Zapret2 init-script path is not executable/resolvable at that exact path after reboot. This does not yet establish whether Zapret2 files are missing, relocated, or the script has an interpreter/path dependency problem.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 files present, init layout differs
[FACTUAL RESULT] Read-only directory listing shows `/opt/zapret2` is present with binaries, config, nfq2, ipset, and `init.d`. Under `/opt/zapret2/init.d` there is no `sysv` directory; available directories are `custom.d.examples.linux` and `openwrt`.
[CONCLUSION] The earlier `init.d/sysv/zapret2` path was incorrect for the currently deployed Zapret2 tree. Zapret2 itself is present; no deletion is indicated by this result.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — OpenWrt Zapret2 init script found
[FACTUAL RESULT] Read-only listing of `/opt/zapret2/init.d/openwrt` shows executable `zapret2` (2987 bytes), plus `90-zapret2`, `firewall.zapret2`, `functions`, and `custom.d`.
[CONCLUSION] The correct executable init script in the current deployment is `/opt/zapret2/init.d/openwrt/zapret2`.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Zapret2 started successfully after reboot
[FACTUAL RESULT] The user executed `/opt/zapret2/init.d/openwrt/zapret2 start`. The command started `/opt/zapret2/nfq2/nfqws2` with qnum 300, TCP ports 80/443, UDP 443, and the configured autohostlist desync rules. Output reports successful nftables application, creation/reload of the nftables set backend, population of zapret/ipban/nozapret sets, insertion of IPv4 NFQWS postrouting/prerouting rules for TCP/UDP, and `net.netfilter.nf_conntrack_tcp_be_liberal = 1`. The command returned to the shell without an error.
[CONCLUSION] Zapret2/NFQWS2 start procedure completed successfully after reboot. This establishes successful startup/configuration application, but does not yet establish stable runtime, absence of OOM recurrence, or application-level service functionality.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — nfqws2 remains running
[FACTUAL RESULT] The user executed `pgrep -a nfqws2`; output was `3578 /opt/zapret2/nfq2/nfqws2`.
[CONCLUSION] The nfqws2 process started by Zapret2 is still running at the verification point after startup.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Router-side HTTPS baseline passes with Zapret2
[FACTUAL RESULT] The user executed `wget -O /dev/null -T 10 https://example.com` while nfqws2 was running. Connection to `8.6.112.6:443` completed successfully and 559 bytes were downloaded.
[CONCLUSION] Basic router-side HTTPS connectivity remains functional with the current Zapret2 configuration. This does not yet establish application-level functionality for Telegram, WhatsApp, or other client applications.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — Client service validation after Zapret2 restart
[FACTUAL RESULT] User reports: Google works; YouTube does not work; Telegram does not work; WhatsApp does not work.
[CONCLUSION] Current autohostlist Zapret2 configuration passes basic router-side HTTPS and Google client access, but client-side YouTube, Telegram, and WhatsApp are not working. Application-level validation therefore remains FAILED for those services under the current configuration; STAGE 11 remains IN_PROGRESS because diagnosis/strategy validation is incomplete.
[USER NOTE] User recalls that an automatic strategy-selection/autodetection mechanism had previously been launched. This recollection is recorded as a hypothesis/previous workflow reference, not yet as a verified current runtime state.

## CHANGELOG — 2026-09-21 — Zapret2 configuration audit: autohostlist confirmed
[FACTUAL RESULT] The user executed:
`grep -E '^(MODE_FILTER|NFQWS2_ENABLE|NFQWS2_OPT|NFQWS2_PORTS_TCP|NFQWS2_PORTS_UDP|FLOWOFFLOAD|INIT_APPLY_FW|DISABLE_IPV6)=' /opt/zapret2/config`
Output:
`NFQWS2_ENABLE=1`
`NFQWS2_PORTS_TCP=80,443`
`NFQWS2_PORTS_UDP=443`
`NFQWS2_OPT="`
`MODE_FILTER=autohostlist`
`FLOWOFFLOAD=donttouch`
`INIT_APPLY_FW=1`
`DISABLE_IPV6=1`
The command did not display the contents of the multiline `NFQWS2_OPT` value because the value starts with a quote and continues on subsequent lines.
[CONCLUSION] NFQWS2 is enabled; configured TCP ports are 80/443; configured UDP port is 443; MODE_FILTER is `autohostlist`; FLOWOFFLOAD is `donttouch`; INIT_APPLY_FW is `1`; DISABLE_IPV6 is `1`. The exact multiline desync strategy block remains not yet re-read by this command and therefore is not re-verified by this result.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Continue with a read-only inspection that captures the complete multiline `NFQWS2_OPT` block before any strategy change.

## CHANGELOG — 2026-09-21 — compact diagnostic output rule
[DOCUMENTATION CHANGE] Added a compact-output rule to MASTER PROMPT and GLOSSARY.
[MASTER PROMPT] Diagnostic commands should return only data required for the current PASS/FAIL criterion; prefer targeted grep/awk/sed/head/tail/tr over large raw outputs.
[GLOSSARY] Added the same rule as a named glossary concept.
[SAFETY] This does not change one-step-at-a-time: independent diagnostics are not combined merely to reduce message count.
[COMMITS] MASTER PROMPT: b707d537a392475ed1d81f1c2af36fab19320649; GLOSSARY: ce5c9aa0da52504c095ad6d097531d1dfb617c15.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — full NFQWS2_OPT verified
[FACTUAL RESULT] The user executed `sed -n '/^NFQWS2_OPT="/,/^"/p' /opt/zapret2/config` and the complete multiline value was returned:
`--filter-tcp=80 --filter-l7=http <HOSTLIST> --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5 --lua-desync=multisplit:pos=method+2 --new`
`--filter-tcp=443 --filter-l7=tls <HOSTLIST> --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tcp_seq=-10000 --lua-desync=multidisorder:pos=1,midsld --new`
`--filter-udp=443 --filter-l7=quic <HOSTLIST_NOAUTO> --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=6`
[CONCLUSION] The exact current NFQWS2 strategy block is now verified. TCP/80 uses HTTP `fake` + `multisplit`; TCP/443 uses TLS `fake` + `multidisorder`; UDP/443 uses QUIC `fake` with 6 repeats. No strategy change was made.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] The next diagnostic must be read-only and must verify the hostlist files referenced by the active configuration before any strategy modification.

## CHANGELOG — 2026-09-21 — hostlist file probe returned empty
[FACTUAL RESULT] The user executed `find /opt/zapret2 -maxdepth 2 -type f \\( -name '*hostlist*' -o -name '*.txt' \\) -printf '%p %s bytes\\n' 2>/dev/null | head -20`; output was empty.
[CONCLUSION] No matching hostlist-named or `.txt` files were found within `/opt/zapret2` at max depth 2 by this probe. This does not yet prove that the active `<HOSTLIST>` / `<HOSTLIST_NOAUTO>` placeholders resolve to no data, because the actual paths may be generated elsewhere or represented under different filenames/deeper directories.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Perform one read-only diagnostic to identify how the active configuration resolves `<HOSTLIST>` and `<HOSTLIST_NOAUTO>`, without changing configuration.

## CHANGELOG — 2026-09-21 — autohostlist and automatic strategy-selection context verified
[USER INPUT] User provided information about automatic strategy selection via blockcheck/zapret-checker and about Zapret2 use cases for Telegram (media, calls, web).
[VERIFICATION] Official zapret2 documentation confirms that `MODE_FILTER=autohostlist` uses the standard hostlist plus `ipset/zapret-hosts-auto.txt`, and that autohostlist detects block-like conditions and automatically adds hosts to the auto hostlist. The current `<HOSTLIST>` / `<HOSTLIST_NOAUTO>` placeholders are specifically designed to engage these lists. citeturn0search0turn0search5
[IMPORTANT CORRECTION] The empty `find` result does not mean autohostlist is absent. The standard auto list is named `zapret-hosts-auto.txt`, which does not contain the substring `hostlist`; therefore the previous filename filter could miss that filename, although it would match `.txt` if the file were directly under the searched depth. The exact current contents/path still require a direct read-only check of `/opt/zapret2/ipset`.
[STRATEGY TOOL] A separate zapret2-nextgen-blockcheck project documents automated strategy probing and can run multiple nfqws2 candidates, but it is not part of the official bol-van/zapret2 tree. It should not be installed or executed on this router until its compatibility, resource requirements, and safety are checked against this project. citeturn0search7
[TELEGRAM SCOPE] Zapret2 is a DPI circumvention framework; it does not guarantee that every Telegram function will work. TCP/TLS web traffic and UDP/QUIC traffic can be targeted by configured nfqws2 profiles, but actual Telegram media/calls behavior depends on the Telegram transport, ports, DPI behavior, hostlists, and working strategy. No Telegram-specific success is currently established on this router.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Perform a read-only inspection of the actual `/opt/zapret2/ipset` directory and relevant file sizes before considering automatic strategy testing.


## CHANGELOG — 2026-09-21 — synchronization before next diagnostic
[SYNC] This assistant response records the current factual state before issuing the next router diagnostic. No router configuration, service, firewall, hostlist, or strategy was changed by this synchronization.
[VERIFICATION] Official zapret2 `common/list.sh` confirms that `HOSTLIST_BASE` defaults to `$ZAPRET_BASE/ipset`; `HOSTLIST_AUTO` is `$HOSTLIST_BASE/zapret-hosts-auto.txt`; and `<HOSTLIST>` / `<HOSTLIST_NOAUTO>` are expanded differently under `MODE_FILTER=autohostlist`. citeturn0view0
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] After this synchronization, issue exactly one read-only command to list files directly in `/opt/zapret2/ipset`.


## CHANGELOG — 2026-09-21 — /opt/zapret2/ipset is empty; blockcheck2 context verified
[FACTUAL RESULT] The user executed the planned read-only command listing regular files directly under `/opt/zapret2/ipset`; output was empty.
[CONCLUSION] The deployed `/opt/zapret2/ipset` directory currently contains no regular files at maxdepth 1. Therefore the expected `zapret-hosts-auto.txt` file is not currently present there as a regular file. This explains why the previous hostlist probe found nothing, but it does not by itself prove that the active placeholder expansion is invalid or that autohostlist cannot create the file at runtime.
[USER INPUT] User supplied information that official zapret2 includes the `blockcheck2.sh` automatic strategy-selection utility for Linux and `blockcheck2.cmd` for Windows, and described its purpose as testing multiple DPI-bypass strategies and reporting working parameters.
[WEB VERIFICATION] The official `bol-van/zapret2` repository currently contains `blockcheck2.sh` and the `blockcheck2.d` test framework. Official release notes also document changes to blockcheck2. citeturn0search0turn0search2
[IMPORTANT] The user-described automatic strategy selection is therefore an official zapret2 component, unlike the previously mentioned separate `zapret2-nextgen-blockcheck` project. However, no blockcheck2 run has been performed on this router in the current stage, and no strategy change is authorized by this result.
[SAFETY] Do not launch blockcheck2 yet: first verify its local presence/version and invocation requirements with one read-only command. Running the checker may generate traffic, consume CPU/RAM, and interact with nfqws2/firewall state; current STAGE 11 is still a post-reboot validation stage.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] First verify the deployed `blockcheck2.sh` file and its basic usage/version information using a read-only command; do not start the strategy scan yet.


## CHANGELOG — 2026-09-21 — synchronization before blockcheck2 presence check
[SYNC] Current `/opt/zapret2/ipset` probe result and the official blockcheck2 context are already recorded. No router configuration or service state was changed during this synchronization.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] One read-only local presence/usage check for `blockcheck2.sh` is now authorized.


## CHANGELOG — 2026-09-21 — local blockcheck2.sh present
[FACTUAL RESULT] The user executed the read-only presence check. `/opt/zapret2/blockcheck2.sh` exists, is executable (`-rwxr-xr-x`), owned by `root:root`, and has size 47692 bytes; timestamp shown by `ls` is Sep 19 18:17.
[CONCLUSION] The official blockcheck2 shell script is present locally and executable on the deployed Zapret2 tree. This does not yet establish its compatibility with the current OpenWrt environment, resource requirements, or safe invocation while nfqws2 is active.
[SAFETY] No blockcheck2 scan has been launched and no strategy/configuration has been changed.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Perform one read-only inspection of the script's usage/help path to determine supported invocation options before any test run.


## CHANGELOG — 2026-09-21 — blockcheck2 prerequisite check
[FACTUAL RESULT] The user invoked `/opt/zapret2/blockcheck2.sh --help 2>&1 | head -40`. The script detected Linux/OpenWrt, kernel 6.12.94, OpenWrt 25.12.5 r33051-f5dae5ece4, board `ath79/mikrotik`, arch `mips_24kc`, nftables firewall, and `CURL=curl`. It then reported `/opt/zapret2/blockcheck2.sh: line 406: curl: not found`, warned that DPI-bypass processes are already running, specifically that blockcheck requires all DPI-bypass methods to be disabled, and finally stopped at the prerequisite check with `curl does not exist. please install` and `press enter to continue`.
[CONCLUSION] The installed blockcheck2 script is compatible enough to identify the current OpenWrt environment, but it cannot proceed in the current state because `curl` is absent and the active `nfqws2`/DPI-bypass process would interfere with blockcheck. No scan was performed and no strategy/configuration was changed.
[SAFETY] Do not install curl or stop nfqws2 yet. Both would be an explicit state change and require checking package availability/resource impact and a controlled plan for stopping/restoring Zapret2.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] First determine whether a usable `curl` package is available from the configured OpenWrt package indexes, using a read-only package-cache/repository check. Do not install anything yet.


## CHANGELOG — 2026-09-21 — incorrect apk path for curl availability check
[FACTUAL RESULT] The user executed `/sbin/apk search curl 2>&1 | head -20`; BusyBox returned `-ash: /sbin/apk: not found`.
[CONCLUSION] This result only establishes that `/sbin/apk` is not an executable path on the current system. It does not establish that the `apk` package manager is absent; the project state already identifies `apk` as the package manager and a prior shell environment used `apk` successfully. No package was installed and no service/configuration was changed.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Determine the actual `apk` executable path with one read-only command before retrying the curl availability check.


## CHANGELOG — 2026-09-21 — apk executable path confirmed
[FACTUAL RESULT] The user executed `command -v apk`; output is `/usr/bin/apk`.
[CONCLUSION] The active package manager executable is `/usr/bin/apk`. The previous `/sbin/apk` failure was only a path error. No package was installed and no service/configuration was changed.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Retry the read-only curl package search using the confirmed `/usr/bin/apk` path.


## CHANGELOG — 2026-09-21 — user safety guidance for blockcheck2
[USER INPUT] User supplied a warning that running blockcheck2 directly on the low-resource router may create substantial CPU/process/memory load, and proposed running `blockcheck2.cmd` on a computer instead, then transferring the resulting strategy parameters to the router.
[WEB VERIFICATION] Official zapret2 source confirms that blockcheck2 requires `curl`, checks for already-running DPI-bypass processes, and explicitly warns that such processes must be disabled because they can interfere with blockcheck. The checker contains many individual strategy tests, including repeated TCP-segment tests, so a full scan can be materially heavier than a single connectivity test. citeturn0search0turn0search9turn0search12
[IMPORTANT QUALIFICATION] The specific claims of “hundreds of requests”, “dozens of parallel curl processes”, “100% CPU”, “OOM/reboot”, and a fixed “20–40 MB” memory cost were not established by the sources checked here. They must not be recorded as verified facts. The project's actual RAM constraints and process behavior require measurement or source-specific confirmation.
[PROJECT DECISION] Given the current 64 MB-class hAP ac lite, active nfqws2, missing curl, and post-reboot validation stage, do not run blockcheck2 on the router at this point. A computer-based blockcheck2 run is a safer candidate workflow, but compatibility of its resulting strategy with this exact OpenWrt deployment must still be validated before applying it.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] The previously requested `apk search curl` result has not yet been supplied. Continue with the package-availability check only if needed; do not install curl or stop nfqws2 yet.


## CHANGELOG — 2026-09-21 — curl package available in apk search
[FACTUAL RESULT] The user executed `/usr/bin/apk search curl 2>&1 | head -20`. The package index search returned `curl-8.21.0-r1` and related curl/libcurl packages, including `libcurl4-8.21.0-r1`.
[CONCLUSION] A `curl` package is visible to the current apk search, so the missing-curl prerequisite for blockcheck2 is potentially satisfiable from the configured package sources. This result does not establish that installation is currently safe or that the package database/repositories are fully healthy; it only establishes that `curl-8.21.0-r1` is discoverable by `apk search`.
[SAFETY] No package was installed. `nfqws2` was not stopped. blockcheck2 was not run.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] Before any installation or service change, verify the exact installed/package-manager state and available flash/RAM margin with one compact read-only diagnostic; do not install curl yet.


## CHANGELOG — 2026-09-21 — extroot and current resource state clarified
[USER CORRECTION] User clarified that the deployed system uses extroot and therefore package storage is on USB-backed `/dev/sda2`, not the original 16 MB internal flash overlay.
[FACTUAL RESULT] `df -h /overlay /mnt/data` reports `/dev/sda2` as the active `/overlay`: 6.6G total, 13.5M used, 6.2G available, 0% use. `/mnt/data` resolves through `overlayfs:/overlay` in the displayed output. `free -h` reports RAM total 54852 KiB, used 34864 KiB, free 12556 KiB, buff/cache 7432 KiB, available 3984 KiB; swap total 550904 KiB, used 4980 KiB, free 545924 KiB.
[CONCLUSION] The prior concern about internal-flash capacity for installing `curl` is not applicable to the current extroot overlay: there is ample extroot storage. The remaining immediate resource concern for running blockcheck2 is RAM/CPU and interference with the active nfqws2 process, not package storage.
[SAFETY] No package was installed and no service/configuration was changed.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] If the project is to use `curl` for further diagnostics, its installation can now be considered from a storage perspective; however, blockcheck2 itself should remain off-router unless a controlled test is explicitly planned.


## CHANGELOG — 2026-09-21 — curl binary confirmed absent
[FACTUAL RESULT] The user executed `command -v curl || echo 'curl: NOT_INSTALLED'`; output was `curl: NOT_INSTALLED`.
[CONCLUSION] No `curl` executable is currently available in PATH. The earlier `apk search` result confirms package availability, but installation has not occurred.
[CONTEXT] Current extroot has approximately 6.2G available, so package storage is not a practical constraint. Current RAM availability is low, so no blockcheck2 execution is planned on-router.
[SAFETY] No package or service state was changed.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] If curl is needed for the project, install it as a separate controlled step; otherwise proceed with the PC-based blockcheck2 workflow. No blockcheck2 scan should be started on the router.


## CHANGELOG — 2026-09-21 — PC-based blockcheck2 strategy-selection workflow
[USER DECISION] Пользователь выбрал рабочий путь: **подбор стратегии на ПК → перенос параметров на роутер**.
[WEB VERIFICATION] Официальные материалы bol-van/zapret2 подтверждают наличие blockcheck2 как штатного инструмента автоматического подбора стратегий; официальный Windows bundle содержит blockcheck2.cmd, а запуск blockcheck2 требует, чтобы другие средства обхода DPI были остановлены. Для Windows также документировано, что найденные стратегии нужно затем отдельно тестировать в рабочем winws2. 
[PROJECT DECISION] На роутере не устанавливаем curl только ради blockcheck2 и не останавливаем текущий nfqws2 для запуска полного подбора. Подбор выполняется на Windows-ПК. Полученные строки стратегий рассматриваются как КАНДИДАТЫ, а не как автоматически совместимая конфигурация роутера.
[VALIDATION RULE] Перед переносом на роутер сохраняем исходный NFQWS2_OPT. На ПК сначала проверяем кандидатов на целевых проблемных сервисах; затем на роутере переносим только конкретные параметры, сохраняя существующие фильтры, hostlist-режим и требуемые Lua/blob-зависимости. После каждого изменения — отдельная проверка и возможность отката.
[IMPORTANT] YouTube, Telegram и WhatsApp нельзя считать одной тестовой точкой: результат blockcheck2 для одного домена/транспорта не доказывает работу всего приложения или всех его функций. Официальная документация отдельно предупреждает, что blockcheck проверяет конкретный домен и curl-трафик, а у разных клиентов могут отличаться TLS fingerprints/транспорт.
[CURRENT ROUTER FACTS] На роутере сейчас nfqws2 работает; текущий NFQWS2_OPT уже зафиксирован; Google работает, YouTube/Telegram/WhatsApp не работают. curl не установлен, но пакет curl-8.21.0-r1 виден через /usr/bin/apk search; extroot имеет около 6.2G свободного места. Эти факты не меняются данным workflow.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).
[NEXT] На ПК подготовить официальный Zapret2/zapret-win-bundle с blockcheck2.cmd, остановить на ПК любые собственные DPI-bypass средства, затем выполнить первый контролируемый тест для одной целевой точки. Результаты не переносить на роутер до отдельной проверки совместимости.
