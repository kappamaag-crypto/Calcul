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
STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation)
STAGE 12–30 — NOT_STARTED

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

## CHANGELOG — 2026-09-21 — official zapret2 Windows workflow clarified
[WEB VERIFICATION] Official bol-van/zapret2 source contains blockcheck2.sh and supports CYGWIN: under CYGWIN the script selects WINWS2/winws2 and Windivert. Official zapret2 documentation states that blockcheck requires Cygwin on Windows and cannot be run through WSL. The author's zapret-win-bundle is an official convenience distribution containing Cygwin, blockcheck/blockcheck2 and winws2.exe.
[IMPORTANT CORRECTION] The technical source/project remains official bol-van/zapret2. zapret-win-bundle is only the Windows distribution used to run the official tooling conveniently; it does not replace the router-side zapret2 source.
[WORKFLOW] Windows PC → official author bundle/environment → blockcheck2 → candidate strategy → compatibility review → router transfer only after separate validation.
[STATUS] STAGE 11 — IN_PROGRESS.

## CHANGELOG — 2026-09-21 — Windows blockcheck2 preparation started
[DECISION] Prepare the Windows PC before downloading/running blockcheck2. First verify Windows architecture/version because the official author's current bundle supports Windows x64/ARM64, and the exact preparation differs by architecture.
[SAFETY] No router command or configuration change is required for this preparation step. Do not install Cygwin separately if the official bundle will be used; the bundle already includes a minimal Cygwin environment.
[CURRENT ROUTER STATE] nfqws2 remains active on the MikroTik. Google works; YouTube/Telegram/WhatsApp remain non-working. No router strategy change has been made.
[RESULT] Windows read-only PowerShell check returned: Microsoft Windows 11 Pro, version 10.0.26200, OSArchitecture 64-разрядная. This establishes Windows x64 for the next preparation decision.
[STATUS] STAGE 11 — IN_PROGRESS.
[NEXT] Use the official bol-van/zapret-win-bundle Windows x64 path. No router changes are part of this synchronization step.


## CHANGELOG — 2026-09-21 — Zapret2 strategy-selection plan
[DECISION] Strategy selection will be performed on the Windows 11 x64 PC using the official `blockcheck2` tooling from the same `bol-van/zapret2` project. The router already has official Zapret2 v1.0.3 installed and running as `/opt/zapret2/nfq2/nfqws2`; no second Zapret project is being installed.
[PLAN]
1. Keep the router's current working configuration unchanged during strategy discovery.
2. On Windows, prepare the official `zapret-win-bundle` (minimal Cygwin + blockcheck2/winws2) for x64.
3. Select a small, representative domain set matching the currently failing services; begin with controlled individual tests, not parallel hammering.
4. Run blockcheck2 in batch mode with an explicit log, conservative timeouts, and `PARALLEL=0/1` only as appropriate; do not use parallel scanning by default.
5. First establish DNS/IP reachability results, then run the standard HTTP/HTTPS/QUIC strategy tests supported by the tool.
6. If comparing several domains, use `SCANLEVEL=force` when we need reliable COMMON/COVERAGE conclusions; otherwise treat skipped tests as non-exhaustive.
7. Record only strategies that produce reproducible PASS results, together with protocol, domain, IP version, and exact generated parameters.
8. Do not immediately copy the first successful strategy to the router. Review compatibility with the existing NFQWS2 config, hostlist/autohostlist behavior, memory budget, and current TCP/UDP scope first.
9. Transfer one validated strategy change to the already-installed router-side Zapret2, then test the affected service(s) and router resource usage before any additional change.
10. After each router-side strategy change, retain a rollback value and compare against the current known-good configuration.
[SAFETY] No curl installation on the router is required for the PC-based workflow. Do not run full blockcheck2 on the low-RAM router while its current nfqws2 configuration is active unless a separate decision gate authorizes it.
[STATUS] STAGE 11 — IN_PROGRESS (strategy discovery on PC).
[NEXT USER STEP] Prepare the Windows official bundle only; no router command in this turn.


## CHANGELOG — 2026-09-21 — Windows blockcheck2 launch procedure prepared
[VERIFIED] Official author documentation recommends the official `zapret-win-bundle`; it contains minimal Cygwin and `blockcheck\\blockcheck2.cmd`, which is the Windows Zapret2-based DPI strategy analyzer. Windows x64 is supported; WSL is not the required environment.
[LAUNCH PROCEDURE] On the Windows 11 x64 PC: download the official bundle master ZIP; extract it to a simple ASCII path such as `C:\\zapret-win-bundle`; ensure no other DPI-bypass/Zapret software is running on the PC; open the bundle's `_CMD_ADMIN.cmd` as administrator; launch `blockcheck\\blockcheck2.cmd`. Do not launch `preset*.cmd` or install a Windows service. The purpose is strategy discovery only.
[TEST POLICY] First run the interactive blockcheck2 flow and allow its DNS/reachability checks. Use the currently failing services as test domains. Do not enable aggressive parallel testing. Save the generated log and exact successful strategy parameters. If a multi-domain COMMON/COVERAGE comparison is required, rerun with `SCANLEVEL=force`.
[TRANSFER GATE] No router-side strategy is changed until a candidate result is recorded, reviewed against the existing v1.0.3 nfqws2 configuration, and then transferred as a single controlled change with rollback and resource checks.
[STATUS] STAGE 11 — IN_PROGRESS.


## CHANGELOG — 2026-09-21 — [SYNC] force scan stopped / faster re-scan decision
- [OBSERVED] Windows official `blockcheck2` remained for hours in the `youtube.com` IPv4 HTTPS TLS 1.2 force scan and produced multiple `AVAILABLE` candidates plus many `UNAVAILABLE code=28` results.
- [DECISION] Do not continue the current exhaustive force scan indefinitely. The user may stop it with Ctrl+C; this does not alter the router-side Zapret2 configuration.
- [NEXT] For the next Windows pass, use a shorter scan level rather than `force`. Prefer `standard` as the balanced official investigation mode; `quick` is reserved for the fastest first-working candidate and is less suitable for comparing multiple candidate strategies. Keep router-side Zapret2 v1.0.3 unchanged until cross-domain evidence is obtained.
- [SAFETY] Before the next actual scan, the Windows PC must bypass the MikroTik's active nfqws2 path and connect directly to the TP-Link Archer C20 v4, so the current router-side Zapret2 does not contaminate strategy discovery.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery).


## CHANGELOG — 2026-09-21 — [SYNC] quick scan repeated TLS matrix / autottl clarification
- [OBSERVED] Windows quick scan is producing a long sequence of `UNAVAILABLE code=28` results while testing youtube.com IPv4 HTTPS TLS 1.2, including multiple fakedsplit positions and TTL values. The output is repetitive by design because the official standard test matrix iterates combinations.
- [VERIFIED] Official zapret2 standard definitions already test ordinary TTL values and then automatic-TTL variants (`ip_autottl=-delta,3-20`); therefore a blanket claim that manual autottl must be enabled to fix the current slowdown is not established.
- [VERIFIED] Official blockcheck2 defaults `CURL_MAX_TIME=2` seconds. Each failed candidate therefore contributes roughly a 2-second timeout, explaining the visible duration.
- [CORRECTION] Do not manually disable all Lua desync tests: zapret2 blockcheck2 is specifically testing nfqws2/winws2 strategies and its standard matrix legitimately contains Lua desync methods such as multisplit/fakedsplit/multidisorder.
- [DECISION] For the faster next pass, stop the current scan if it remains stuck in the same long matrix; use a narrowly scoped test rather than force/large multi-domain scanning. Router-side Zapret2 v1.0.3 remains unchanged.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery).


## CHANGELOG — 2026-09-21 — [SYNC] Windows Cygwin blockcheck2 quick multi-domain result
- [ENVIRONMENT] Official Windows bundle was launched through Cygwin; `blockcheck2` detected CYGWIN_NT-10.0-26200 x86_64, Windivert, curl 8.10.1 with HTTP/2 and HTTP/3 support.
- [TEST] Interactive custom scan: domains `youtube.com telegram.org whatsapp.com`; IPv4 only; HTTP=Y; TLS1.2=Y; TLS1.3=Y; HTTP3/QUIC=Y; repeats=1; scan level=quick.
- [RESULT youtube.com] HTTP works without bypass. HTTPS TLS1.2: no working winws2 strategy found in quick scan. TLS1.3: no working winws2 strategy found in quick scan. HTTP3/QUIC: working strategy found: `winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11`.
- [RESULT telegram.org] HTTP/TLS1.2/TLS1.3/HTTP3 all reported no working winws2 strategy in quick scan. TCP port 80/443 to the tested IPv4 `149.154.167.99` did not connect, so these results require manual interpretation and must not be treated as proof of a TLS-only DPI block.
- [RESULT whatsapp.com] HTTP/TLS1.2/TLS1.3/HTTP3 all reported no working winws2 strategy in quick scan. TCP port 80/443 to the tested IPv4 `157.240.0.60` did not connect, so these results require manual interpretation and must not be treated as proof of a TLS-only DPI block.
- [COMMON/COVERAGE] Quick scan reported TLS1.2 and TLS1.3 as not working across all three domains; HTTP3 had 1/3 working (YouTube); HTTP had 1/3 working without bypass. The tool explicitly states quick mode can skip strategies, so COMMON/COVERAGE are not exhaustive/trustworthy for final strategy selection.
- [TRANSFER GATE] No router-side strategy was changed. The YouTube QUIC candidate is recorded as a Windows candidate only; compatibility with router Zapret2 v1.0.3 and current NFQWS2 configuration must be reviewed before any transfer.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery / candidate review).


## CHANGELOG — 2026-09-21 — [SYNC] YouTube IPv4 TLS1.2 standard test result
- [TEST] Windows official blockcheck2 custom test: IPv4, domain `youtube.com`, HTTP=Y, TLS1.2=Y, TLS1.3=N, QUIC=N, repeats=1, scan level=standard.
- [OBSERVED] TCP/80 to `216.58.198.46` connected; HTTP without DPI bypass was AVAILABLE.
- [OBSERVED] TCP/443 to `216.58.198.46` connected, but direct HTTPS TLS1.2 timed out after ~2 seconds (`code=28`).
- [OBSERVED] The IP-block tests used IANA as a control; certificate-name mismatch errors occurred when intentionally testing one hostname against another IP. These certificate errors do not by themselves establish IP blocking.
- [RESULT] Standard scan tested two generated winws2 TLS1.2 strategies: `fake:blob=fake_default_tls:tcp_ts=-1000` and a fake/tcp_md5/multisplit combination. Both returned timeout `code=28`.
- [RESULT] Summary: HTTP works directly; IPv4 HTTPS TLS1.2 has no working winws2 strategy found within this standard test pass.
- [INTERPRETATION] This is a bounded standard result, not proof that no working strategy exists globally; it only records the strategies tested by this run.
- [NO ROUTER CHANGE] Router-side Zapret2 v1.0.3 configuration remains unchanged.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery / candidate review).


## CHANGELOG — 2026-09-21 — [SYNC] next controlled Windows test selected
- [DECISION] Official zapret2 documentation confirms `standard` is the investigation-oriented scan level, while `force` maximizes checks. Standard scripts include additional TLS desync families such as seqovl and fake/multi, so the previous two-candidate result must not be treated as exhaustive. citeturn0search3turn0search0turn0search4
- [NEXT TEST] Continue with one controlled YouTube IPv4 TLS1.2 standard run, but preserve a log. Do not change router configuration.
- [SAFETY] No router command is issued in this synchronization step. The Windows candidate-discovery workflow remains separate from router deployment.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery / candidate review).


## CHANGELOG — 2026-09-21 — [SYNC] YouTube IPv4 TLS1.2 standard scan: candidate inventory fixed
- [SOURCE] Windows official `blockcheck2` log: `blockcheck2-youtube-tls12-standard.log`.
- [TEST CONTEXT] Domain `youtube.com`; IPv4; HTTP=Y; TLS1.2=Y; TLS1.3=N; QUIC=N; repeats=1; scan level=standard. Direct HTTP was AVAILABLE; direct HTTPS TLS1.2 timed out with `code=28`. No router-side Zapret2 change was made.
- [IMPORTANT] The scan was stopped after >20 minutes. Therefore this is a bounded candidate inventory, not an exhaustive force scan and not a final common strategy.
- [INVENTORY] Exactly 22 distinct strategies in the log returned `AVAILABLE` for the YouTube IPv4 TLS1.2 test. They are grouped below by mechanism.

### A. MULTIDISORDER — primary candidate family (5)
1. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=host+1`
2. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld`
3. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld`
4. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld,1220`
5. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1`
- [ASSESSMENT] These are the cleanest initial candidates for controlled follow-up because they do not include the more complex seqovl/IP-TTL/TCP-header modifications.
- [NOT YET VERIFIED] Reproducibility, cross-domain coverage, and compatibility with router Zapret2 v1.0.3.

### B. SEQOVL + MULTISPLIT/MULTIDISORDER (5)
6. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multisplit:pos=10,midsld:seqovl=1`
7. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1`
8. `--lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1:seqovl_pattern=fake_default_tls`
9. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=2,midsld:seqovl=1`
10. `--lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=2,midsld:seqovl=1:seqovl_pattern=fake_default_tls`
- [ASSESSMENT] Reserve candidates. More complex than group A and therefore require separate compatibility/reproducibility testing.
- [NOT YET VERIFIED] Router v1.0.3 transfer safety or cross-domain behavior.

### C. FAKE + TCP/IP header modification (8)
11. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=6:tls_mod=rnd,dupsid,padencap:repeats=1`
12. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1`
13. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
14. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1`
15. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1`
16. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1`
17. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1`
18. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1`
- [ASSESSMENT] Reserve/specialized candidates. They alter TCP/IP header characteristics and should not be copied to the router without a dedicated compatibility test.

### D. FAKE + automatic TTL (4)
19. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
20. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
21. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
22. `--lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
- [CORRECTION] The log contains successful autottl candidates, so manual autottl cannot be dismissed as ineffective. At the same time, this does not establish that autottl is required for the router.
- [NOTE] Candidate 21 is recorded exactly as present in the extracted log only if the preceding `wssize:wsize=1:scale=6` text is confirmed; do not transfer it until the exact source line is rechecked. The other autottl candidates have the full `wssize:wsize=1:scale=6` prefix.

### Candidate handling / transfer gate
- [DISCOVERY ONLY] All 22 entries are Windows `winws2` results for one domain/IP version/protocol and remain discovery candidates.
- [PRIMARY FOLLOW-UP] Start with group A, preferably candidates 1–3, because they are comparatively simple and avoid seqovl/header/TTL modifications.
- [SECONDARY] Group B only if group A is not reproducible or insufficient.
- [SPECIALIZED] Groups C/D are not to be transferred directly; require explicit compatibility review.
- [VERSION GATE] Windows bundle version is not assumed identical to router-pinned Zapret2 v1.0.3. Router transfer requires syntax/runtime compatibility review against v1.0.3.
- [NO ROUTER CHANGE] Current router-side `NFQWS2_OPT` remains unchanged.
- [NEXT] Perform a short controlled repeat test of 2–3 group-A candidates on Windows, preferably with an explicit log, before considering any router-side change.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery / candidate review).


## CHANGELOG — 2026-09-21 — [SYNC] HTTPS/TLS/QUIC priorities clarified
- [USER REQUIREMENT] Для YouTube основной приоритет стратегии подбора: HTTPS по TCP/443, отдельно TLS 1.2 и TLS 1.3. HTTP/80 считать второстепенным диагностическим протоколом.
- [TECHNICAL VERIFICATION] Official zapret2 blockcheck2 имеет отдельные проверки `curl_test_https_tls12`, `curl_test_https_tls13` и `curl_test_http3`; TLS 1.2/1.3 и HTTP/3 поэтому должны рассматриваться как отдельные тестовые поверхности. citeturn0search0
- [TLS] SNI remains relevant to TLS-based HTTPS DPI when ECH is not in use. Однако из этого нельзя выводить, что одна и та же desync-стратегия автоматически подходит TLS 1.2 и TLS 1.3: blockcheck2 официально тестирует их раздельно.
- [QUIC] Не исключать QUIC автоматически. HTTP/3/QUIC использует UDP/443 и является отдельным транспортным путём; official zapret2 blockcheck2 имеет отдельный `curl_test_http3` и отдельные UDP strategy tests. citeturn0search0
- [CURRENT EVIDENCE] В уже выполненных тестах YouTube IPv4 TLS1.2 обнаружены 22 AVAILABLE-кандидата; для YouTube IPv4 QUIC ранее был найден кандидат `--wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11`. Эти результаты пока discovery-only.
- [HTTP] Не удалять HTTP из диагностики навсегда: HTTP/80 остаётся полезным контрольным тестом доступности и позволяет отделить проблему HTTP/DNS/IP от HTTPS DPI. Но для последующего подбора основной ресурс тестирования направлять на TLS1.2/TLS1.3 и отдельно QUIC.
- [TEST MATRIX] Следующий этап стратегии: 1) TLS1.2 — проверить воспроизводимость кандидатов группы A; 2) TLS1.3 — провести отдельный controlled test; 3) QUIC — сохранить отдельным направлением; 4) HTTP — только контрольный тест, если нет специальной причины исследовать его обход.
- [NO ROUTER CHANGE] Текущий router-side Zapret2 v1.0.3 и `NFQWS2_OPT` не изменяются.
- [STATUS] STAGE 11 — IN_PROGRESS (Windows strategy discovery / candidate review).
