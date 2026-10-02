# WanHap — переход hAP ac lite на основной WAN-шлюз

Дата создания: 2026-09-28  
Последнее уточнение: 2026-10-02 — W4 в проверке client-side Internet  
Статус: **IN_PROGRESS**

## Цель

Перевести MikroTik hAP ac lite в основной и единственный домашний маршрутизатор по схеме:

```
Интернет / ISP
      ↓
   hAP eth1
      ↓
   hAP WAN
      ↓
  LAN + Wi-Fi
  sweethomeu
      ↓
   клиенты
      ↓
 DIRECT / существующий Zapret2
```

**TP-Link Archer C20 v4 в целевой схеме не участвует и после перехода должен быть выключен.**

## Жёсткое разделение текущего и целевого состояния

### Текущее рабочее состояние

До физического переключения hAP получает интернет через:

```
Archer C20
   ↓ Wi-Fi
phy0-sta0
   ↓
hAP
```

Этот путь нужен только для сохранения текущего доступа к hAP во время подготовки. Он **не является целевой WAN-схемой**.

### Целевое состояние

```
ISP
 ↓ Ethernet
hAP eth1
 ↓
hAP WAN
 ↓
br-lan + Wi-Fi sweethomeu
 ↓
клиенты
```

Archer C20 после завершения миграции выключен и не является upstream, NAT-шлюзом, DNS-шлюзом или обязательным элементом маршрутизации.

## DNS baseline

На TP-Link ранее зафиксирован DNS baseline GeoHide DNS:

```
https://dns.geohide.ru:8443/
```

Это относится только к исходной конфигурации Archer и **не означает**, что этот DNS автоматически должен быть перенесён на hAP.

Правило:
- первый WAN-переход не совмещать с изменением DNS;
- фактический текущий DNS hAP определить отдельно;
- целевую DNS-схему hAP выбрать отдельным этапом;
- DNS Archer не считать частью целевой схемы после выключения Archer.

## Текущая runtime-точка

### W0 — текущая схема WAN/LAN/Wi-Fi
**STATUS: DONE**

Подтверждено read-only:
- hAP ac lite / OpenWrt 25.12.5;
- LAN: `br-lan = 192.168.1.1/24`;
- текущий upstream: `phy0-sta0 = 192.168.0.100/24`;
- default route сейчас через `192.168.0.1 dev phy0-sta0`;
- `phy0-sta0` реально ассоциирован с SSID `SweetHomeU`;
- существующие AWG-интерфейсы остаются выключенными;
- изменений конфигурации W0 не выполнялось.

### W1 — физическая готовность прямого WAN-порта
**STATUS: DONE**

Подтверждено read-only:
- `eth1` существует;
- `eth1` находится административно UP, но имеет `NO-CARRIER`, поскольку Ethernet-кабель сейчас не подключён;
- `phy0-sta0` остаётся рабочим интернет-uplink;
- LAN и Wi-Fi AP hAP остаются UP.

Это подтверждает готовность физического WAN-порта к следующему тесту, но **не подтверждает**, что ISP использует DHCP, PPPoE или иной тип подключения.

## Правила миграции

- Archer C20 **не использовать как источник целевого интернета**.
- Не строить промежуточную схему «TP-Link LAN → hAP WAN» как часть WanHap.
- Не менять WAN + LAN + DNS + Wi-Fi + Zapret2 одновременно.
- Zapret2 / Deep Max Circular не перестраивать и не переустанавливать.
- AWG/WireGuard не включать и не использовать для проверки WAN.
- На каждом этапе использовать только статусы **NOT_STARTED / IN_PROGRESS / BLOCKED / FAILED / DONE**.
- Следующий этап начинать только после **DONE** предыдущего.
- Перед изменением основной сети иметь обратный путь и понятную процедуру rollback.
- Не выполнять лишнюю диагностику.

## Этапы

### W2 — Определить фактический ISP handoff и подготовить прямой WAN
**STATUS: DONE**

Цель — установить, что именно требуется hAP для прямого подключения к ISP.

Нужно определить по фактической текущей конфигурации провайдера/Archer:
- DHCP;
- PPPoE;
- статический IPv4;
- VLAN;
- другой способ аутентификации/инкапсуляции.

На этом этапе сетевую конфигурацию hAP ещё не переключать без необходимости.

Критерий DONE:
- тип ISP WAN документирован;
- необходимые параметры известны;
- сохранены rollback-условия;
- Zapret2/DNS/AWG не изменены.

### W3 — Физически подключить ISP напрямую к hAP
**STATUS: DONE**

Схема:

```
ISP
 ↓ Ethernet
hAP eth1
```

Archer при этом не должен становиться upstream для hAP.

Текущий `phy0-sta0` не удалять заранее: он остаётся в конфигурации только до подтверждения нового WAN.

Критерий DONE:
- `eth1` получает физический carrier;
- hAP получает корректное WAN-состояние согласно W2;
- на hAP есть Internet;
- LAN hAP остаётся доступен;
- DNS не изменялся как побочный эффект.

### W4 — Сделать прямой ISP WAN основным
**STATUS: IN_PROGRESS**

После подтверждения W3:
- прямой ISP WAN на `eth1` становится основным;
- текущий Wi-Fi uplink `phy0-sta0` отключается только как отдельное контролируемое изменение;
- default route должен перейти на прямой WAN;
- LAN/Wi-Fi hAP не должны быть перестроены без необходимости.

Критерий DONE:
- Internet идёт через `eth1`;
- `phy0-sta0` больше не нужен для выхода в Internet;
- LAN/Wi-Fi клиентов работают;
- Zapret2 остаётся активным;
- rollback описан и проверяем.

### W5 — Сделать hAP самостоятельным домашним шлюзом
**STATUS: NOT_STARTED**

Целевая локальная архитектура:
- DHCP на hAP;
- DNS-поведение определяется отдельным DNS-gate;
- NAT/firewall на hAP;
- SSID `sweethomeu`;
- обычный трафик → DIRECT;
- проблемный трафик → существующий Zapret2.

Archer не должен требоваться для работы клиентов.

### W5-DNS — Отдельно определить и проверить DNS hAP
**STATUS: NOT_STARTED**

Не совмещать с WAN-переключением.

Возможные варианты:
- оставить текущий DNS hAP;
- отдельно перенести выбранную DNS-схему;
- выбрать другую схему после проверки.

Критерий DONE:
- целевая схема явно выбрана;
- DNS-тесты успешны;
- обычный HTTPS работает;
- Zapret2 не изменён.

### W6 — Выключить Archer C20 и исключить его из схемы
**STATUS: NOT_STARTED**

После успешных W4/W5/W5-DNS:

```
ISP → hAP → sweethomeu → клиенты
```

Archer:
- отключён;
- не является шлюзом;
- не является upstream;
- не участвует в DNS/NAT домашней сети.

### W7 — Финальная минимальная проверка
**STATUS: NOT_STARTED**

Проверить только необходимое:
1. клиент получает IP от hAP;
2. клиент использует целевой DNS;
3. обычный HTTPS работает;
4. один представитель проблемного сервиса проходит через текущий Zapret2;
5. WAN сохраняется после обычного restart hAP;
6. Archer действительно не требуется.

Без новых экспериментов со стратегиями.

## Rollback

До подтверждения W4 исходная конфигурация `phy0-sta0` не удаляется.

При неудаче прямого WAN:
1. вернуть физическое подключение к исходной схеме;
2. вернуть предыдущую WAN-конфигурацию hAP;
3. проверить `phy0-sta0`;
4. не трогать Zapret2;
5. не включать AWG/WireGuard ради обхода проблемы WAN.

Rollback означает возврат к предыдущей рабочей схеме, а не добавление Archer в целевую архитектуру.

## Финальное состояние

```
ISP
 ↓ Ethernet
hAP eth1 / WAN
 ↓
hAP LAN + Wi-Fi
 ↓
sweethomeu
 ↓
клиенты
 ↓
DIRECT
или
Zapret2
```

**TP-Link Archer C20: ВЫКЛЮЧЕН / НЕ УЧАСТВУЕТ В ОСНОВНОЙ СЕТИ.**

## Следующая точка

**W0 = DONE**  
**W1 = DONE**  
**W2 = DONE**  
**W3 = DONE**  
**W4 = IN_PROGRESS**

Следующее действие — отдельный контролируемый этап W4: сделать прямой `eth1` постоянным основным WAN и только после этого отключить временный `phy0-sta0`.

---

## 2026-10-02 — AUTHORITATIVE W2/W3 DIRECT-WAN RESULT

### W2 — ISP handoff: DONE

Прямое подключение Ufanet к hAP показало фактический handoff:
- IPv4 DHCP/IPoE;
- DHCP client: BusyBox `udhcpc 1.37.0`;
- DHCP server: `10.1.48.57`;
- default gateway: `100.96.0.1`;
- address space observed: `100.96.0.0/16` (CGNAT);
- MTU 1500;
- VLAN/PPPoE не требуются для этой handoff-схемы.

### W3 — Direct ISP WAN: DONE

hAP `eth1` was connected directly to the ISP Ethernet cable. The actual TP-Link WAN MAC `E2:0D:17:E0:73:A7` was cloned, but MAC cloning alone did not restore Internet access.

The discriminating variable was DHCP Client ID / Option 61 generated automatically by OpenWrt 25.12.5.

Before the fix, `udhcpc` contained:

```
-x 0x3d:ff6f1799c8000466caeaee30844603a5937a1625ca68ba
```

The global DUID was:

```
000466caeaee30844603a5937a1625ca68ba
```

DHCP lease acquisition succeeded, but external traffic failed.

The штатный setting:

```
network.wan.sendclientid='none'
```

caused `udhcpc` to use `-C` and omit Option 61.

After DHCP reacquisition:
- WAN IP: `100.96.79.207/16`;
- gateway: `100.96.0.1`;
- `ping -c 3 1.1.1.1`: 3/3 replies, 0% loss;
- average RTT: ~58.4 ms;
- HTTPS request to `https://1.1.1.1`: RC=0.

Therefore direct ISP → hAP `eth1` is runtime-verified.

### Root-cause boundary

The A/B experiment establishes the DHCP Client ID as the discriminating variable on this exact hAP/OpenWrt 25.12.5/Ufanet path. It is not a universal claim that Ufanet or other ISPs reject DHCP Option 61.

### Final relevant WAN configuration

```
network.wan.proto='dhcp'
network.wan.device='eth1'
network.wan.macaddr='e2:0d:17:e0:73:a7'
network.wan.sendclientid='none'
```

No Zapret2, Deep Max Circular, AWG/WireGuard, DNS strategy, PBR, or unrelated LAN/Wi-Fi subsystem was changed for this W3 validation.

Detailed evidence: `WANHAP_W3_DIRECT_WAN_DHCP_CLIENT_ID.md`.

**W4 remains NOT_STARTED.** It is the separate controlled step that will make direct `eth1` the permanent primary WAN and disable the temporary `phy0-sta0` uplink.


## 2026-10-02 — AUTHORITATIVE WANHAP W4 RUNTIME CHECKPOINT

**W4 = IN_PROGRESS** — direct ISP WAN is active on eth1, but client-side Internet is not yet fully validated. The router itself has working IPv4 Internet, while at least one TV client currently reports no Internet. Therefore W4 must not be marked DONE until a LAN/Wi-Fi client is confirmed working through the direct WAN.

Verified runtime:
- eth1 WAN is UP via DHCP/IPoE.
- WAN address: 100.96.79.207/16.
- Gateway: 100.96.0.1.
- Default route: default via 100.96.0.1 dev eth1.
- Router ping to 1.1.1.1: 3/3, 0% loss, ~58.3 ms.
- Temporary phy0-sta0 is disabled.
- Both APs are active as SweethomeU, WPA2/PSK2, on 2.4 GHz and 5 GHz.
- No IPv4 default route remains through phy0-sta0.
- Archer C20 is already physically OFF and is not part of the target WAN path.

Important client observation:
- Previous test client 192.168.1.227 is currently FAILED in ARP/neighbour state; this does not prove a WAN fault.
- A TV currently has no Internet, so LAN-client end-to-end validation remains incomplete.
- Do not change DNS, Zapret2, AWG/WireGuard, firewall or WAN configuration merely to mask this symptom. Diagnose the affected client path first.

Wi-Fi credential is intentionally NOT recorded in repository documentation.
Backup created before Wi-Fi change: /mnt/data/wanhap-w4-20260928-224206.

Next gate: identify whether the TV has a valid DHCP lease/default gateway/DNS and whether it can reach 192.168.1.1, 1.1.1.1, and DNS separately. Only after a client is confirmed working should W4 become DONE.
