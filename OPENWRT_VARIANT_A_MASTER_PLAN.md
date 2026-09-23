# MASTER PLAN — OpenWrt Variant A
## Clean rebuild with extroot + ZRAM + USB swap
Дата: 2026-09-21
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
STAGE 11 — IN_PROGRESS (router-side Zapret2 candidate validation)
STAGE 12–30 — NOT_STARTED


## Compact command-output policy
- Цель: минимизировать текст, который пользователь копирует в ИИ.
- Каждая router-команда должна давать компактный диагностический вывод: только поля/строки, необходимые для PASS/FAIL или следующего шага.
- Не использовать полные `cat`, `logread`, `dmesg`, `nft list ruleset`, `iw ... info` и аналогичные большие выводы, если достаточно `grep/sed/awk/head/tail` с ограничением строк.
- Предпочитать однострочные фильтры и агрегаты; ориентир обычно 3–15 строк вывода, а при необходимости — явно указать причину большего объёма.
- Не объединять несколько независимых диагностических команд в один шаг только ради компактности: one-step-at-a-time сохраняется.
- В ответе ассистента показывать команду + ожидаемый компактный результат + PASS/FAIL; после выполнения ждать фактический вывод пользователя.

## One-step-at-a-time rule
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянинием. Следующий router command выдаётся только после фактического результата предыдущего.
Запрещено объединять текущую синхронизацию результата с выдачей следующей команды.

## Architecture
TP-Link Archer C20 v4 остаётся главным маршрутизатором.
MikroTik hAP ac lite работает downstream через Wi-Fi STA.
Целевая Variant A: clean OpenWrt → новый extroot → ZRAM → USB swap → DoH → Zapret2 → WireGuard/WARP/Proton → PBR.

## Safety
Без явного отдельного подтверждения запрещены destructive storage operations. Во время post-reboot audit изменения сервисов/конфигурации не выполняются.
Избегать больших logread | grep pipelines из-за ранее подтверждённых OOM.
Для swap использовать swapon -s; swapon --show на этом BusyBox не поддерживается.

## Zapret2 router-side candidate validation — current record
- Рабочий baseline сохранён в: `/opt/zapret2/config.backup-before-router-selection`.
- Полный baseline `NFQWS2_OPT` подтверждён:
  - TCP 80: fake_default_http + tcp_md5 + multisplit pos=method+2.
  - TCP 443: fake_default_tls + tcp_md5 + tcp_seq=-10000 + multidisorder pos=1,midsld.
  - UDP 443: fake_default_quic repeats=6.
- Официальный init-скрипт zapret2 использует `ZAPRET_CONFIG`, по умолчанию `/opt/zapret2/config`; временный config может быть выбран через эту переменную без изменения постоянного файла.
- Временная копия создана: `/tmp/zapret2-config-test`.
- Последняя проверка существования: `ls -l /tmp/zapret2-config-test` → файл существует, размер 5542 bytes, права `-rw-r--r--`, владелец root:root, время Sep 23 10:42.
- Проверка структуры временной копии подтвердила точную baseline-структуру `NFQWS2_OPT`: отдельные блоки TCP/80, TCP/443 и UDP/443, с `<HOSTLIST>` для TCP и `<HOSTLIST_NOAUTO>` для QUIC.
- Попытка длинной `sed -i` команды была прервана shell continuation prompt `>`.
- Следующая короткая `sed -i` команда завершилась без вывода; это само по себе не подтверждает замену.
- Постоянный `/opt/zapret2/config` не изменялся.
- Следующий шаг: проверить только строки TCP/443 и UDP/443 во временном config перед запуском сервиса.

## STATUS
STAGE 11 — IN_PROGRESS.

- Исправление методики: TCP/443 и UDP/443 не изменяются одной длинной `sed`-командой. Для соблюдения правила one-step-at-a-time каждый параметр изменяется отдельной короткой `sed -i '/pattern/c\...'` командой с отдельной проверкой результата между изменениями.
- На текущем шаге TCP/443 уже пытались заменить на TCP candidate №52 (`hostfakesplit:ip_ttl=3:repeats=1`), но результат ещё не подтверждён; UDP/443 пока не изменялся.



## STAGE 11 — TCP/QUIC candidate reduction from complete blockcheck2 intersection

User re-reviewed all 75 exact common TCP TLS1.2+TLS1.3 results independently. This is a coverage-based selection, NOT an efficiency ranking. Goal: minimize near-duplicate variants while covering distinct desync mechanisms.

### TCP: 8 candidates
1. TCP #27 — hostfakesplit:disorder_after:ip_autottl=-1,3-20:repeats=1
2. TCP #32 — hostfakesplit:disorder_after:ip_ttl=3:repeats=1
3. TCP #47 — hostfakesplit:ip_autottl=-1,3-20:repeats=1
4. TCP #52 — hostfakesplit:ip_ttl=3:repeats=1
5. TCP #24 — fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 + multisplit:pos=1,midsld
6. TCP #25 — fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 + multisplit:pos=1,midsld,1220
7. TCP #70 — multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 + fakedsplit:pos=host+1:tcp_seq=-3000
8. TCP #73 — multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 + multisplit:pos=1,midsld

### QUIC: 2 candidates
- QUIC #1 — fake:blob=fake_default_quic:repeats=1
- QUIC #2 — fake:blob=fake_default_quic:repeats=1 + send:ipfrag:ipfrag_pos_udp=16 + drop

### Test order / isolation
Do NOT test all 16 TCP×QUIC combinations. First select a working TCP strategy using the 8 TCP candidates against YouTube TCP/443 with TLS1.2 and TLS1.3 coverage. Then independently select a working QUIC strategy from the 2 QUIC candidates. Only after both are selected, compose the final NFQWS2_OPT and test it on hAP.

### Safety
Candidate testing uses a temporary/test configuration and must not modify the known working permanent configuration until a candidate passes. Test one candidate at a time. Record PASS/FAIL and exact candidate number.

### Compact output
Every candidate-test command must emit only the minimum result needed to classify PASS/FAIL. Prefer a short one-line/few-line summary. Avoid full nftables/log dumps unless targeted failure diagnosis requires them.

### Current status
STAGE 11 remains IN_PROGRESS. Candidate set: 8 TCP + 2 QUIC. No candidate is ranked as more effective before controlled testing.


## SYNC — 2026-09-23 — STAGE 11 temporary config verification
- [PASS] User checked /tmp/zapret2-config-test with a targeted grep.
- [CONFIRMED] Temporary TCP/443 entry is TCP candidate #52: hostfakesplit:ip_ttl=3:repeats=1.
- [CONFIRMED] Temporary UDP/443 entry remains the existing baseline: fake:blob=fake_default_quic:repeats=6; no UDP candidate change has been made.
- [CONFIRMED] This step verifies only the temporary configuration content; it does not establish candidate runtime PASS.
- [NO CHANGE] Permanent /opt/zapret2/config was not modified by this verification.
- [STATUS] STAGE 11 remains IN_PROGRESS.
- [NEXT GATE] The next router step will be the isolated runtime test of TCP candidate #52 only, while UDP remains untouched.


## SYNC — 2026-09-23 — STAGE 11 TCP candidate #52 runtime start
- [PARTIAL/PRE-PASS] Temporary config was started with `ZAPRET_CONFIG=/tmp/zapret2-config-test /etc/init.d/zapret2 restart`.
- [CONFIRMED] nfqws2 started with qnum=300 and the temporary TCP/443 strategy is candidate #52: `hostfakesplit:ip_ttl=3:repeats=1`.
- [CONFIRMED] Temporary runtime applied nftables NFQUEUE rules for TCP 80/443 and UDP 443; therefore UDP was not isolated at the firewall-runtime level, although its strategy remained the unchanged baseline.
- [OBSERVED] Startup printed `Command failed: Not found` during the restart sequence. Despite that message, nfqws2 started and nftables application continued. This must be diagnosed/qualified before declaring runtime PASS.
- [CONFIRMED] No permanent `/opt/zapret2/config` edit was made by this command.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 is NOT yet classified PASS/FAIL.
- [NEXT] Do not change the candidate or UDP strategy yet. First record/qualify the startup result and then perform the minimal controlled functional check.


## SYNC — 2026-09-23 — STAGE 11 startup-message diagnosis
- [OBSERVED] Targeted search in /etc/init.d/zapret2 for nf_conntrack_tcp_be_liberal, sysctl, not found, and command failed returned empty output.
- [CONFIRMED] The previous `Command failed: Not found` message cannot be attributed to those literal strings in the init script by this targeted search.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT yet classified PASS/FAIL.
- [NEXT] Continue with a narrower read-only qualification of the restart path; do not modify candidate #52, UDP strategy, or permanent config.


## SYNC — 2026-09-23 — STAGE 11 init-script call-path inspection
- [OBSERVED] Targeted grep of /etc/init.d/zapret2 returned the rc.common header, my_extra_command registrations, procd_open_instance/procd_set_param command, rc_procd start_daemons_procd, procd_running/procd_kill, and start_service/stop_service entry points.
- [CONFIRMED] The inspected first 40 matching lines do not contain an obvious literal external executable corresponding to `Command failed: Not found`.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT yet classified PASS/FAIL.
- [NO CHANGE] No zapret2 configuration or permanent config was modified by this diagnostic.
- [NEXT] Inspect the small procd/service section around the daemon command definition; remain read-only.


## SYNC — 2026-09-23 — STAGE 11 procd daemon section inspected
- [OBSERVED] `/etc/init.d/zapret2` defines `run_daemon()` using `procd_open_instance`, `procd_set_param command $2 $3`, pidfile setup, then `procd_close_instance`; `run_nfqws()` passes the nfqws2 binary and generated arguments into `run_daemon()`.
- [CONFIRMED] `start_daemons_procd()` calls `standard_mode_daemons 1` and `custom_runner zapret_custom_daemons 1`; `start_daemons()` invokes `rc_procd start_daemons_procd`.
- [CONCLUSION] The inspected section does not itself identify the `Command failed: Not found` source; the message may originate from a procd-managed command or another part of the startup path.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT yet classified PASS/FAIL.
- [NO CHANGE] No zapret2 configuration was modified.
- [NEXT] Inspect the definitions of `standard_mode_daemons` / relevant command construction, still read-only.


## SYNC — 2026-09-23 — unexpected router/Wi-Fi restart observed
- [OBSERVED] User reports that the router or Wi-Fi restarted unexpectedly during Stage 11 read-only diagnosis.
- [SAFETY] Pause further zapret2 candidate testing until it is established whether the hAP itself rebooted or only Wi-Fi/service state changed.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT classified PASS/FAIL.
- [NO CHANGE] No configuration-changing command was issued after the previous diagnostic.
- [NEXT] First distinguish device reboot from Wi-Fi/service restart using a minimal uptime check.


## SYNC — 2026-09-23 — restart classification
- [CONFIRMED] `uptime` reports `up 15:38`, so the hAP did not reboot immediately before this check.
- [CONCLUSION] The reported interruption was not a full router reboot; it may have been Wi-Fi/service/interface related, but that is not yet established.
- [SAFETY] No further zapret2 changes have been made.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT classified PASS/FAIL.
- [NEXT] Before resuming candidate validation, perform one minimal read-only check of recent kernel/service restart evidence.


## SYNC — 2026-09-23 — recent log qualification
- [CONFIRMED] Recent log contains no reboot sequence or Wi-Fi AP restart in the shown 20 lines.
- [OBSERVED] `phy0-sta0` had normal WPA2 group rekey completion at 11:03:58 followed by `Unknown event 37`; this is not evidence of a router reboot.
- [OBSERVED] Repeated `odhcpd` warnings report `No default route present, setting ra_lifetime to 0!`; this indicates an IPv6/default-route state issue but is not by itself evidence of the reported interruption.
- [CONFIRMED] SSH connections from 192.168.0.101 at 10:42 and 11:19 succeeded, showing management connectivity remained available.
- [SAFETY] No zapret2 configuration changes were made.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT classified PASS/FAIL.
- [NEXT] Resume only with a minimal targeted check of the current service state; avoid broad logs.


## SYNC — 2026-09-23 — zapret2 current state after interruption check
- [CONFIRMED] `/etc/init.d/zapret2 status` reports `running`.
- [CONFIRMED] No zapret2 stop/restart was performed during the interruption investigation.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT classified PASS/FAIL.
- [SAFETY] Permanent `/opt/zapret2/config` has not been modified.
- [NEXT] Before any functional candidate test, qualify which config is currently active and confirm the temporary test config remains selected; use one compact read-only check.


## SYNC — 2026-09-23 — nfqws2 process confirmation
- [CONFIRMED] `ps` shows nfqws2 PID 4182 running as user `daemon`.
- [OBSERVED] The BusyBox `ps w` output truncates the command line before the filter arguments, so it does not yet prove whether candidate #52 or the permanent strategy is active.
- [STATUS] STAGE 11 remains IN_PROGRESS; TCP candidate #52 remains NOT classified PASS/FAIL.
- [NO CHANGE] No configuration-changing command was issued.
- [NEXT] Read `/proc/4182/cmdline` in a compact filtered form to identify the active TCP/443 desync argument.


## SYNC — 2026-09-23 — candidate #52 active confirmation
- [CONFIRMED] `/proc/4182/cmdline` shows active TCP/443 strategy `--lua-desync=hostfakesplit:ip_ttl=3:repeats=1`, exactly TCP candidate #52.
- [CONFIRMED] The same nfqws2 process also has the unchanged UDP/443 baseline `fake:blob=fake_default_quic:repeats=6` (temporary config behavior).
- [CONFIRMED] Temporary runtime is active; permanent `/opt/zapret2/config` has not been modified.
- [STATUS] TCP candidate #52 is runtime-confirmed but not yet functionally classified PASS/FAIL.
- [NEXT] Perform one minimal functional HTTPS check for a target covered by the active hostlist; do not alter config.


## SYNC — 2026-09-23 — TCP candidate #52 functional result
- [PASS] With the temporary config active and TCP candidate #52 selected, direct HTTPS fetch of `https://www.youtube.com/` succeeded: `890841` bytes received within the 15-second timeout.
- [CONFIRMED] This establishes a functional PASS for the current hAP-side TCP/443 test against YouTube, but does not by itself prove TLS1.2 and TLS1.3 separately.
- [CONFIRMED] Permanent `/opt/zapret2/config` remains unchanged.
- [STATUS] STAGE 11 remains IN_PROGRESS. TCP candidate #52 is currently the first functionally passing TCP candidate.
- [NEXT] Do not test additional TCP candidates yet; first record the exact PASS and then perform the planned protocol-coverage check (TLS1.2/TLS1.3) before selecting the TCP strategy.


## SYNC — 2026-09-23 — TLS 1.2 probe returned empty
- [OBSERVED] The TLS 1.2 `openssl s_client` probe for `www.youtube.com:443` returned no output after stderr was suppressed.
- [NOT_CLASSIFIED] This does not establish TLS 1.2 FAIL because the command may have failed due to missing `openssl`, handshake failure, or another local condition hidden by `2>/dev/null`.
- [CONFIRMED] TCP candidate #52 remains functionally PASS for the prior YouTube HTTPS fetch (890841 bytes).
- [STATUS] STAGE 11 remains IN_PROGRESS; TLS 1.2/TLS 1.3 protocol-specific coverage is not yet established.
- [NO CHANGE] No configuration was modified.
- [NEXT] Identify whether `openssl` is available before repeating any protocol test.


## SYNC — 2026-09-23 — openssl unavailable
- [CONFIRMED] `command -v openssl` returned empty output; `openssl` is not available in the current PATH.
- [EXPLAINED] The earlier TLS 1.2 probe therefore could not establish protocol support and must remain unclassified, not FAIL.
- [CONFIRMED] TCP candidate #52 remains functionally PASS for the direct YouTube HTTPS fetch (890841 bytes).
- [STATUS] STAGE 11 remains IN_PROGRESS; TLS1.2/TLS1.3 separate coverage is still unverified.
- [NO CHANGE] No package installation or configuration modification was performed.
- [NEXT] Use an already available lightweight TLS-capable tool only if present; first identify available `wget` TLS feature/version with one compact command.


## SYNC — 2026-09-23 — wget capability check
- [CONFIRMED] The router uses a BusyBox-style `wget`; `wget --version` is unsupported and returns its usage text.
- [CONFIRMED] This does not provide a direct TLS-version selector, so separate TLS1.2/TLS1.3 validation cannot be performed with the current `wget` invocation alone.
- [PASS] The prior real HTTPS YouTube fetch remains the functional TCP candidate #52 PASS criterion.
- [STATUS] STAGE 11 remains IN_PROGRESS; candidate #52 is functionally passing, while separate TLS-version coverage remains unverified.
- [NO CHANGE] No package or configuration changes were made.
- [NEXT] Avoid adding packages solely for protocol introspection; continue with the planned independent QUIC candidate testing after recording this limitation.
