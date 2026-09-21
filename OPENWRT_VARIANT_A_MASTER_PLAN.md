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
STAGE 11 — DONE
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

## CHANGELOG — 2026-09-21 — https-dns-proxy removal decision pending
[USER DECISION] User states that neither two nor one `https-dns-proxy` instances are needed and asks to consider stopping/removing the DoH proxy layer before Zapret2 re-validation.
[CURRENT FACT] dnsmasq currently depends on local listeners 127.0.0.1:5053 and 127.0.0.1:5054, so simply stopping `https-dns-proxy` without first changing dnsmasq would leave its configured upstream listeners unavailable.
[IMPORTANT] Therefore the safe sequence is: first define/verify the replacement DNS path, then change dnsmasq, verify DNS resolution, and only after successful verification stop/disable the two `https-dns-proxy` instances.
[PROPOSED REPLACEMENT] The already observed WAN resolver path is 192.168.0.1 (TP-Link Archer C20), and the existing `doh_backup_server` is also 192.168.0.1. This is a candidate replacement path, but it must be explicitly confirmed before configuration changes.
[SAFETY] No service or configuration has been changed yet. Zapret2 remains paused until the DNS architecture is settled and tested.
[STATUS] https-dns-proxy removal decision — IN_PROGRESS.
