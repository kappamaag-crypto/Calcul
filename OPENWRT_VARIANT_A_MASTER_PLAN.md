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

## CHANGELOG — 2026-09-21 — dnsmasq switched to TP-Link upstream
[FACTUAL RESULT] The user executed the DNS reconfiguration command. It set `dnsmasq.noresolv=1`, removed the previous `server` list, added `server=192.168.0.1`, removed `doh_server`, `doh_backup_noresolv`, and `doh_backup_server`, committed UCI, and restarted dnsmasq.
[FACTUAL RESULT] The restart output included `udhcpc: started, v1.37.0`, `udhcpc: broadcasting discover`, and `udhcpc: no lease, failing`.
[IMPORTANT] This output occurred during dnsmasq restart, but it does not by itself prove that the WAN interface lost its existing lease or that DNS failed. No further conclusion is recorded until a read-only verification is performed.
[FACTUAL RESULT] The command did change and commit dnsmasq configuration; https-dns-proxy was not explicitly stopped or disabled by this command.
[STATUS] https-dns-proxy removal decision — IN_PROGRESS.
