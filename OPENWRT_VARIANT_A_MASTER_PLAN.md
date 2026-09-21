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
[NEXT] Inspect the OpenWrt init directory contents with one read-only command before attempting a start.
