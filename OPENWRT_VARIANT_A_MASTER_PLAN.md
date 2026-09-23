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
