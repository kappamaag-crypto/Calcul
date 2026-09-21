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

## CHANGELOG — 2026-09-21 — https-dns-proxy ↔ dnsmasq linkage audit
[RESULT] User supplied read-only effective dnsmasq configuration, https-dns-proxy UCI configuration, and TCP listener inspection.
[CONFIRMED DNSMASQ] dnsmasq has `noresolv='1'` and explicitly uses `127.0.0.1#5053` and `127.0.0.1#5054` as DNS servers. It also has `doh_server='127.0.0.1#5053' '127.0.0.1#5054'`.
[CONFIRMED BACKUP] dnsmasq has `doh_backup_noresolv='1'` and `doh_backup_server='192.168.0.1'`.
[CONFIRMED FORCE DNS] https-dns-proxy configuration has `force_dns='1'`, source interface `lan`, and intercepted destination ports 53 and 853.
[CONFIRMED INSTANCES] One configured instance listens on 127.0.0.1:5053 and uses Cloudflare DoH; the second listens on 127.0.0.1:5054 and uses Google DoH.
[CONFIRMED LISTENERS] dnsmasq listens on port 53 on LAN/WAN/loopback addresses; https-dns-proxy listens on 127.0.0.1:5053 and 127.0.0.1:5054.
[IMPORTANT] The two https-dns-proxy processes are not independent unused duplicates: both are explicitly wired into dnsmasq's active DNS configuration, and LAN DNS/DoT traffic is forced toward the proxy.
[IMPORTANT] This read-only result alone does not establish whether one instance can be removed without changing DNS redundancy/behavior; that requires a separate controlled decision and configuration change.
[NO CHANGE] The command was read-only; no service, DNS, firewall, network, or filesystem state changed.
[STATUS] Decision on two https-dns-proxy instances is now pending before Zapret2 re-validation.
[NEXT] Do not start Zapret2 until the https-dns-proxy decision is made and any approved change is separately tested.
