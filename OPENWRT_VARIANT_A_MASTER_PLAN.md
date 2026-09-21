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
После каждого пользовательского сообщения и каждого ответа ассистента мастер-план синхронизируется с фактическим состоянием. Следующий router command выдаётся только после фактического результата предыдущего.
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
[WEB VERIFICATION] Official bol-van/zapret2 source contains blockcheck2.sh and explicitly supports CYGWIN: under CYGWIN the script selects WINWS2/winws2 and Windivert. Official zapret2 documentation states that blockcheck requires Cygwin on Windows and cannot be run through WSL. The same official documentation recommends zapret-win-bundle as the easier distribution, while the bundle repository is maintained by bol-van and contains blockcheck/blockcheck2 and winws2.exe. citeturn0search3turn0search2turn0search0
[IMPORTANT CORRECTION] The technical source/project remains official bol-van/zapret2. zapret-win-bundle is a Windows distribution/bundle for running the official tooling conveniently; it is not a replacement technical source for the router deployment.
[WORKFLOW] For this project: Windows PC → official bol-van/zapret2-compatible blockcheck2 environment (prefer the author's zapret-win-bundle for convenience) → collect candidate winws2 strategy → validate candidate semantics/parameters against the router's nfqws2 build/config → transfer only after separate compatibility check.
[SAFETY] Do not run blockcheck2 on the router at this time. Current router has active nfqws2, missing curl, low RAM margin, and STAGE 11 remains post-reboot validation.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## CHANGELOG — 2026-09-21 — current validated Zapret2 state
[FACTUAL RESULT] Router currently has nfqws2 running from /opt/zapret2/nfq2/nfqws2. Current NFQWS2_OPT is fixed and verified:
TCP/80: HTTP fake + multisplit.
TCP/443: TLS fake + multidisorder.
UDP/443: QUIC fake with repeats=6.
MODE_FILTER=autohostlist; FLOWOFFLOAD=donttouch; INIT_APPLY_FW=1; DISABLE_IPV6=1.
Google works; YouTube, Telegram and WhatsApp do not work. Router-side wget https://example.com succeeds.
[FACTUAL RESULT] /opt/zapret2/ipset currently has no regular files at maxdepth 1. This does not by itself prove placeholder expansion failure.
[FACTUAL RESULT] /opt/zapret2/blockcheck2.sh exists and is executable. Running its help/prerequisite path on the router detected missing curl and active DPI-bypass interference; no scan was performed and no configuration was changed.
[PACKAGE FACT] /usr/bin/apk search finds curl-8.21.0-r1; curl is not installed. Extroot /overlay has about 6.2G available; RAM availability remains limited.
[STATUS] STAGE 11 — IN_PROGRESS (post-reboot Zapret2 re-validation).

## Next controlled action
No router command is issued by this synchronization.
Next workflow step, when the user is ready, is on the Windows PC only: obtain the author's current Windows bundle/environment for zapret2 blockcheck2, ensure other DPI-bypass tools are stopped on the PC, and run one controlled blockcheck2 test. Do not transfer or apply a candidate strategy to the router until its parameters are separately checked for compatibility with the installed zapret2 v1.0.3/nfqws2 environment.
