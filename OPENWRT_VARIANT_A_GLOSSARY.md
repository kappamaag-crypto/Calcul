# Глоссарий OpenWrt Variant A

> Формат: **термин / команда / функция — что делает**.
> Источник терминов: рабочие чаты по настройке MikroTik hAP ac lite, `OPENWRT_VARIANT_A_MASTER_PLAN.md` и `OPENWRT_VARIANT_A_MASTER_PROMPT.md`.
> Глоссарий предназначен как справочник по функциям, командам, службам, механизмам, параметрам и типовым проверкам проекта.
>
> В разделах команд указано назначение команды и, где это важно, что именно она проверяет. Команды не являются самостоятельной инструкцией к изменению конфигурации: destructive- и конфигурационные действия выполняются только по мастер-плану и правилам workflow.

## A

**apk — менеджер пакетов OpenWrt 25.12.x** — устанавливает, удаляет, обновляет и ищет пакеты; в текущей системе используется вместо `opkg`.

**apk info — информация о пакете** — показывает сведения об установленном пакете.

**apk search — поиск пакетов** — ищет пакеты в доступных индексах/кэше APK.

**ash — оболочка BusyBox** — командный интерпретатор, используемый на роутере.

## B

**br-lan — мост LAN** — объединяет LAN-интерфейсы OpenWrt и предоставляет LAN-сегмент MikroTik.

**BusyBox — набор системных утилит** — предоставляет минимальные Unix-команды и оболочку на OpenWrt.

## C

**cat — чтение файла** — выводит содержимое файла; применяется для просмотра конфигурации, например `cat /tmp/resolv.conf.d/resolv.conf.auto`.

**chmod — изменение прав файла** — меняет права доступа; используется только когда это необходимо для запуска/исполнения файла.

**clear — очистка терминала** — очищает видимый экран терминала; состояние роутера не изменяет.

## D

**DHCP — автоматическая выдача сетевых параметров** — получает IP-адрес, шлюз и другие параметры интерфейса от DHCP-сервера.

**DHCPv6 — DHCP для IPv6** — получает параметры IPv6 от upstream-сети.

**df -h — проверка файловых систем** — показывает точки монтирования, размер, занятое и свободное место.

**dnsmasq — локальный DNS/DHCP-сервис** — обслуживает DNS-запросы клиентов и DHCP в LAN.

**DoH / DNS-over-HTTPS — DNS через HTTPS** — передаёт DNS-запросы через HTTPS; в проекте рассматривался через https-dns-proxy, но runtime-инстансы https-dns-proxy впоследствии остановлены и отключены.

**doh_server — upstream DoH-сервер dnsmasq/https-dns-proxy** — задаёт адрес локального DoH-слушателя или соответствующего upstream-механизма.

## E

**ELF — формат исполняемого файла Linux** — содержит машинный код и метаданные бинарного файла.

**eth0 — физический Ethernet-интерфейс LAN** — используется как часть LAN-схемы MikroTik.

**eth0.1 — VLAN-интерфейс LAN** — используется в текущем bridge LAN.

**eth1 — Ethernet-интерфейс WAN** — физический интерфейс, который ранее использовался в WAN-конфигурации; в текущей рабочей схеме upstream идёт через Wi-Fi STA.

**ext4 — файловая система Linux** — используется на USB-разделах, включая extroot и /mnt/data.

**extroot — внешний root/overlay OpenWrt** — переносит writable `/overlay` с внутренней flash на USB, увеличивая доступное место для пакетов и конфигурации; сам по себе RAM не увеличивает.

## F

**firewall — сетевой фильтр OpenWrt** — управляет разрешением, блокированием, NAT и forwarding трафика.

**FLOWOFFLOAD — управление поточным offload** — параметр Zapret2, определяющий отношение к flow offload; в текущей конфигурации установлен `donttouch`.

**fstab — таблица файловых систем** — определяет автоматическое монтирование разделов и swap при загрузке.

## G

**gateway — шлюз по умолчанию** — адрес маршрутизатора upstream, через который отправляется внешний трафик.

**GitHub / Calcul — хранилище мастер-документации** — используется только для хранения и синхронизации мастер-плана, мастер-промта и связанных проектных документов; не используется как технический источник OpenWrt.

**grep — фильтрация текста** — выбирает строки по шаблону; помогает быстро проверять параметры конфигурации и статусы. Большие `logread | grep` pipeline на данном устройстве избегаются из-за OOM-риска.

## H

**hAP ac lite / RB952Ui-5ac2nD — MikroTik-роутер проекта** — устройство с 64 МБ RAM, на котором работает OpenWrt 25.12.5.

**hostlist — список доменов для обработки Zapret2** — ограничивает применение desync определёнными доменами.

**hostlist-auto — автоматически формируемый список доменов Zapret2** — добавляет домены в список после условий, заданных параметрами auto-hostlist.

**https-dns-proxy — сервис DNS-over-HTTPS** — создаёт локальный DNS-прокси к DoH-серверам; в текущем проекте два экземпляра на 5053/5054 остановлены и отключены из автозапуска. Пакет не удалялся.

## I

**INIT_APPLY_FW — параметр Zapret2** — указывает, должен ли запуск интеграции применять firewall-состояние; в проекте значение `1` считается safety-relevant и не является самостоятельной командой запуска.

**init.d — каталог init-скриптов** — содержит сценарии управления службами при запуске/остановке.

**ip addr — просмотр IP-адресов интерфейсов** — показывает адреса и связанные параметры сетевых интерфейсов.

**ip link — просмотр состояния интерфейсов** — показывает UP/DOWN, NO-CARRIER и другие параметры link-уровня.

**ip route — просмотр таблицы маршрутизации** — показывает маршруты, default gateway и интерфейсы, через которые направляется трафик.

**ip2net — утилита Zapret2** — преобразует IP/сетевые диапазоны и используется компонентами Zapret2; native MIPS execution проверен.

**ipset — набор IP-адресов/сетей для фильтрации** — используется Zapret2 для управления группами адресов.

**iw dev — диагностика Wi-Fi-интерфейсов** — показывает беспроводные PHY/интерфейсы и их состояние.

## K

**kmod-nft-queue — kernel-модуль NFQUEUE для nftables** — предоставляет nftables queue-механизм для передачи пакетов пользовательскому процессу; в проекте установлен точный официальный пакет для kernel 6.12.94.

**kernel — ядро Linux OpenWrt** — управляет аппаратными ресурсами, сетью, памятью и драйверами.

**kernel 6.12.94 — версия ядра текущей OpenWrt-системы** — используется как база для проверки совместимости kernel-модулей.

## L

**LAN — локальная сеть MikroTik** — текущий LAN-сегмент имеет адрес 192.168.1.1/24.

**logread — чтение системного журнала** — показывает сообщения служб и ядра; применяется для точечной диагностики, желательно с ограничением объёма вывода.

**lua — язык/движок сценариев Zapret2** — используется для реализации логики обработки трафика и desync.

**ls -la — подробный список файлов** — показывает файлы, каталоги, права, владельца и наличие init-скриптов.

**zapret-antidpi.lua — Lua-библиотека Zapret2** — содержит функции анти-DPI обработки.

**zapret-auto.lua — Lua-библиотека Zapret2** — участвует в автоматической логике hostlist.

**zapret-lib.lua — базовая Lua-библиотека Zapret2** — предоставляет общие функции для Lua-логики Zapret2.

## M

**mips / MIPS32 — архитектура процессора MikroTik** — архитектура, под которую должны соответствовать исполняемые бинарники Zapret2.

**mips_24kc — OpenWrt package architecture** — архитектурная категория пакетов для текущей ath79-системы.

**mdig — DNS-утилита Zapret2** — используется Zapret2 для DNS-операций/диагностики.

**MemAvailable — доступная память Linux** — показатель памяти, которую система может предоставить новым процессам без критического давления.

**MemFree — свободная физическая RAM** — непосредственно свободная память без учёта кэшей.

**mount — монтирование файловой системы** — подключает файловую систему к дереву каталогов.

## N

**netifd — сетевой менеджер OpenWrt** — управляет интерфейсами, адресами, маршрутами и событиями сети.

**NFQUEUE — очередь пакетов между nftables и userspace** — передаёт выбранные пакеты пользовательскому процессу, например nfqws2.

**nfnetlink_queue — kernel-механизм NFQUEUE** — предоставляет интерфейс очередей сетевых пакетов для userspace.

**nfqws2 — основной userspace packet processor Zapret2** — принимает пакеты из NFQUEUE и применяет заданные анти-DPI/desync-стратегии.

**NFQWS2_ENABLE — параметр включения nfqws2** — управляет запуском NFQWS2 в конфигурации Zapret2.

**NFQWS2_OPT — параметры обработки nfqws2** — содержит правила фильтрации HTTP/TLS/QUIC и desync-операции.

**NFQWS2_PORTS_TCP — TCP-порты для nfqws2** — в текущей конфигурации 80 и 443.

**NFQWS2_PORTS_UDP — UDP-порты для nfqws2** — в текущей конфигурации 443.

**nftables — современный firewall OpenWrt/Linux** — используется Zapret2 для создания NFQUEUE, set и firewall-правил.

**nozapret — исключения Zapret2** — набор адресов, которые должны обходиться без обработки Zapret2.

## O

**OOM — Out Of Memory** — состояние нехватки памяти, при котором kernel может завершать процессы для освобождения RAM.

**oom-killer — механизм Linux для выхода из критического memory pressure** — выбирает процесс-жертву для освобождения памяти.

**OpenWrt — операционная система роутера** — текущая ОС MikroTik hAP ac lite.

**/opt/zapret2 — каталог размещения Zapret2** — содержит бинарники, Lua, конфигурацию, ipset и init-интеграцию Zapret2.

**/overlay — writable-слой OpenWrt** — место хранения изменяемой конфигурации и установленных пакетов.

## P

**PBR — Policy Based Routing** — маршрутизация трафика по политикам; в проекте пакет pbr установлен/проверен, но активные политики на момент аудита отсутствовали.

**pgrep -a — поиск работающих процессов** — показывает PID и командную строку найденного процесса.

**pgrep -a nfqws2 — проверка работы Zapret2** — показывает, запущен ли процесс nfqws2 и каким командным путём он запущен; пустой вывод означает, что процесс с таким именем не найден.

**phy0-ap0 — Wi-Fi AP-интерфейс** — интерфейс точки доступа MikroTik.

**phy0-sta0 — Wi-Fi STA-интерфейс** — клиентский Wi-Fi-интерфейс MikroTik, подключённый к TP-Link.

**procd — менеджер служб OpenWrt** — запускает, контролирует и перезапускает сервисы.

## Q

**qnum — номер NFQUEUE** — идентификатор очереди, к которой nftables передаёт пакеты; в текущем Zapret2 используется queue 300.

**QUIC — транспорт поверх UDP** — современный протокол, часто используемый HTTP/3; в Zapret2 для него предусмотрена обработка UDP/443.

## R

**RAM — оперативная память** — физическая память устройства; у hAP ac lite около 64 МБ.

**REDIRECT — перенаправление трафика на локальный userspace-сервис** — возможный механизм для TPWS/аналогичных схем, рассматривавшийся в мастер-промте.

**resolv.conf.auto — автоматически сформированный DNS-конфиг интерфейсов** — содержит upstream DNS, полученные от сетевой конфигурации.

**rootfs — базовая корневая файловая система OpenWrt** — неизменяемая часть системы, обычно размещённая в squashfs.

## S

**sed — выбор/обработка строк файла** — используется для чтения отдельных диапазонов конфигурации без вывода всего файла.

**SET_MAXELEM — параметр максимального размера nftables/ipset set** — ограничивает число элементов; большое значение на 64-МБ устройстве требует memory-safety проверки.

**sha256sum — проверка SHA-256** — подтверждает целостность скачанных архивов/файлов и идентичность конфигураций.

**sleep — задержка выполнения** — используется в контролируемых тестах, когда нужно дать сервису время запуститься.

**Slab — память kernel cache** — память ядра для внутренних структур; отслеживается при расследовании memory pressure.

**sda1 — USB swap-раздел** — отдельный раздел USB, используемый как swap.

**sda2 — USB ext4-раздел** — в текущей архитектуре используется как extroot/overlay.

**swap — виртуальная память на накопителе** — позволяет выгружать часть страниц RAM на диск/USB; не заменяет физическую RAM.

**swapon -s — проверка активного swap** — показывает активные swap-устройства, размер, использование и приоритет.

**sysupgrade -n — чистое обновление OpenWrt без сохранения конфигурации** — используется как основа clean install workflow, когда это соответствует конкретной процедуре образа.

## T

**TCP — транспортный протокол** — основной транспорт для HTTP/HTTPS; Zapret2 в проекте обрабатывает TCP/80 и TCP/443.

**top -b -n 1 — одноразовый снимок процессов и памяти** — показывает состояние CPU/RAM и процессы без перехода в интерактивный режим.

**tpws — userspace TCP proxy Zapret** — альтернативный низкоресурсный путь анти-DPI, рассматриваемый отдельно от NFQWS2; в текущем workflow отложен, пока NFQWS2 оценивается.

**TP-Link Archer C20 v4 — главный роутер** — остаётся основным маршрутизатором; MikroTik подключён downstream.

**TFTP — протокол загрузки файлов по сети** — ранее использовался в процедуре восстановления/загрузки MikroTik.

## U

**UCI — Unified Configuration Interface OpenWrt** — система управления конфигурацией OpenWrt через `uci`.

**uci show — просмотр UCI-конфигурации** — выводит текущую конфигурацию OpenWrt без изменения параметров.

**udhcpc — DHCP-клиент BusyBox** — получает IPv4-адрес и параметры сети через DHCP.

**UDP — транспортный протокол без соединения** — используется, среди прочего, QUIC; Zapret2 в текущей конфигурации обрабатывает UDP/443.

**uhttpd — встроенный веб-сервер OpenWrt** — используется для LuCI; в текущем clean/rebuild состоянии ранее отсутствовал init-скрипт uhttpd.

## V

**VHT40 — режим Wi-Fi 5 GHz с шириной канала 40 MHz** — зафиксирован как рабочий целевой режим для текущего расследования Wi-Fi.

**VHT80 — режим Wi-Fi 5 GHz с шириной канала 80 MHz** — повторно не исследуется без отдельного запроса.

## W

**WAN — внешняя/upstream-сеть MikroTik** — в текущей архитектуре получает связь через Wi-Fi STA от TP-Link.

**WAN6 — IPv6 WAN-интерфейс** — получает IPv6-параметры upstream, если они доступны.

**wget — HTTP/HTTPS-клиент** — используется для контролируемой проверки доступности URL.

**wget -O /dev/null -T 10 https://example.com — router-side HTTPS baseline** — проверяет установление HTTPS-соединения и получение ответа с заданным тайм-аутом, не сохраняя загруженный контент.

**WARP Free — туннель Cloudflare** — запланированный отдельный этап после базовой сети, Zapret2 и selective routing.

**Wi-Fi AP — точка доступа MikroTik** — предоставляет беспроводной доступ клиентам LAN.

**Wi-Fi STA — клиентский Wi-Fi-интерфейс MikroTik** — подключает MikroTik к TP-Link без второго Ethernet-кабеля.

**WireGuard — VPN-туннель** — планируемый механизм для WARP/Proton и других controlled tunnel tests.

## Z

**ZRAM — сжатое блочное устройство в RAM** — используется как быстрый swap в оперативной памяти и позволяет снизить риск OOM; не увеличивает физический объём RAM.

**zapret-hosts-auto.txt — auto-hostlist Zapret2** — файл автоматически формируемых доменов для применения desync.

**zapret-ip.txt — основной IP-set Zapret2** — список IP-адресов, к которым применяются правила Zapret2.

**zapret-ip-user.txt — пользовательский IP-set** — пользовательские дополнительные адреса для Zapret2.

**zapret-ip-exclude.txt — исключения IP для Zapret2** — адреса, которые должны быть исключены из обработки.

**zapret-ip-ipban.txt — IP-ban set Zapret2** — список заблокированных/исключаемых адресов согласно логике Zapret2.

**Zapret2 — анти-DPI система** — применяет packet desync к выбранному TCP/UDP-трафику через nfqws2 и nftables; в проекте закреплена версия 1.0.3.

**zapret2 init script — скрипт управления Zapret2** — запускает/останавливает NFQWS2 и применяет интеграцию nftables; текущий путь: `/opt/zapret2/init.d/openwrt/zapret2`.

## Числовые и проектные параметры

**192.168.0.1 — upstream gateway TP-Link** — шлюз основной сети, через который MikroTik получает внешний доступ.

**192.168.0.55 — WAN/STA IPv4 MikroTik** — наблюдавшийся IPv4-адрес MikroTik в сети TP-Link.

**192.168.1.1/24 — LAN IPv4 MikroTik** — адрес LAN-моста MikroTik.

**300 — qnum Zapret2** — текущий номер NFQUEUE для nfqws2.

**5053/5054 — прежние локальные DoH-порты** — порты двух экземпляров https-dns-proxy; после DNS cleanup оба runtime-инстанса остановлены и отключены.

**64 МБ RAM — аппаратный лимит hAP ac lite** — ключевой фактор при оценке ZRAM, swap, nftables sets, NFQUEUE и Zapret2.

**25.12.5 — версия OpenWrt** — текущая установленная версия.

**1.0.3 — закреплённая версия Zapret2** — версия, с которой выполняется controlled validation.

## Команды: запуск, остановка и автозапуск служб

**/opt/zapret2/init.d/openwrt/zapret2 start — запуск Zapret2** — запускает текущую интеграцию Zapret2, включая nfqws2 и необходимые nftables-правила. Это фактическая команда запуска, использованная после reboot.

**/opt/zapret2/init.d/openwrt/zapret2 stop — остановка Zapret2** — останавливает runtime Zapret2 и убирает/отключает связанные runtime-правила согласно логике init-скрипта.

**/opt/zapret2/init.d/openwrt/zapret2 restart — перезапуск Zapret2** — последовательно применяет остановку и запуск; используется только когда restart нужен по текущему плану.

**pgrep -a nfqws2 — проверка процесса Zapret2** — подтверждает наличие работающего nfqws2; это проверка runtime, а не автозапуска.

**ls -la /opt/zapret2/init.d/openwrt — проверка init-структуры Zapret2** — показывает наличие и права init-скрипта OpenWrt и связанных файлов.

**ls -l /etc/rc.d/ | grep zapret2 — проверка boot-ссылок Zapret2** — ищет символические ссылки в каталоге автозапуска; наличие соответствующей ссылки подтверждает регистрацию запуска через rc.d, но не доказывает, что сервис успешно стартует после reboot.

**/etc/init.d/<service> status — проверка статуса init-службы** — если конкретный init-скрипт поддерживает `status`, команда показывает его состояние; отсутствие поддержки `status` не означает автоматически, что служба не запущена.

**/etc/init.d/<service> start — запуск init-службы** — запускает службу через стандартный OpenWrt init-интерфейс, если у неё есть соответствующий init-скрипт.

**/etc/init.d/<service> stop — остановка init-службы** — останавливает службу через init-скрипт.

**/etc/init.d/<service> enable — включение автозапуска** — создаёт/активирует boot-ссылки службы в OpenWrt.

**/etc/init.d/<service> disable — отключение автозапуска** — удаляет/деактивирует boot-ссылки службы в OpenWrt.

**ls -l /etc/rc.d/ | grep https-dns-proxy — проверка автозапуска https-dns-proxy** — в проекте применялось после `disable`; пустой вывод означал отсутствие boot-ссылки.

**pgrep -a https-dns-proxy — проверка runtime https-dns-proxy** — показывает запущенные процессы сервиса; после cleanup ожидается пустой вывод.

**/etc/init.d/https-dns-proxy stop — остановка https-dns-proxy** — останавливает runtime DoH-прокси без удаления установленного пакета.

**/etc/init.d/https-dns-proxy disable — отключение автозапуска https-dns-proxy** — предотвращает автоматический запуск сервиса при загрузке.

## Команды: проверка сетевого соединения и DNS

**ip addr — проверка IP-соединения** — позволяет увидеть, получил ли интерфейс адрес и какие адреса назначены.

**ip route — проверка маршрута в Интернет** — позволяет проверить наличие default route и upstream gateway.

**ping <IP/hostname> — базовая проверка ICMP-доступности** — проверяет достижимость узла по ICMP, если ICMP разрешён; успешный ping не доказывает работоспособность HTTPS или конкретного приложения.

**nslookup <domain> <DNS-server> — проверка DNS через конкретный сервер** — позволяет отделить проблему DNS от проблем маршрутизации/HTTPS; например, `nslookup example.com 192.168.0.1` проверяет доступность DNS TP-Link.

**cat /tmp/resolv.conf.d/resolv.conf.auto — проверка полученного upstream DNS** — показывает DNS-серверы, сформированные сетевой конфигурацией OpenWrt.

**wget -O /dev/null -T 10 https://example.com — контролируемая HTTPS-проверка** — проверяет DNS, маршрут, TCP/443 и TLS/HTTPS до указанного сайта с ограничением времени; это router-side тест и не заменяет тест клиентского приложения.

**curl -I --max-time 10 https://example.com — проверка HTTPS-заголовков** — запрашивает только HTTP-заголовки с тайм-аутом, если curl установлен; не следует считать наличие curl гарантированным.

## Команды: проверка Wi-Fi

**iw dev — список Wi-Fi PHY/интерфейсов** — показывает существующие Wi-Fi-интерфейсы.

**iw dev phy0-ap0 station dump — проверка подключённых клиентов AP** — показывает станции, их association/authentication и радиостатистику.

**iwinfo — диагностика Wi-Fi OpenWrt** — показывает сведения о радиомодуле, канале, режиме и подключениях, если утилита установлена.

## Команды: память, OOM и ресурсы

**free — снимок RAM и swap** — позволяет проверить свободную/доступную RAM и использование swap до и после запуска тяжёлых компонентов.

**free -m — RAM и swap в мегабайтах** — компактный вариант `free` для оценки объёмов памяти.

**top -b -n 1 — одноразовый снимок процессов и памяти** — показывает наиболее заметные процессы и текущее использование ресурсов.

**cat /proc/meminfo — детальная диагностика памяти ядра** — показывает MemFree, MemAvailable, Slab, SReclaimable, SUnreclaim, swap и другие показатели.

**logread — диагностика OOM и служб** — позволяет искать сообщения ядра и служб о запуске, остановке и OOM; большие необработанные выборки следует избегать.

**grep -E '...' /proc/meminfo — точечная выборка показателей памяти** — позволяет получить только нужные поля без вывода всего `/proc/meminfo`.

**swapon -s — проверка активного swap** — показывает активные swap-устройства, размеры, использование и приоритет.

## Команды: файловые системы, USB и extroot

**lsblk — просмотр блочных устройств** — показывает диски и разделы, если утилита доступна.

**mount — проверка/просмотр монтирования** — без аргументов показывает смонтированные файловые системы; с аргументами может выполнять монтирование и потому требует осторожности.

**df -h — проверка свободного места** — используется для контроля USB/extroot и внутренней flash.

**cat /etc/config/fstab — просмотр конфигурации монтирования** — показывает, какие разделы должны автоматически монтироваться и как настроен swap.

**blkid — определение UUID/типов файловых систем** — показывает UUID и типы файловых систем на блочных устройствах, если утилита установлена.

**swapon /dev/sda1 — активация USB swap** — включает указанный swap-раздел; это изменение состояния системы, поэтому выполняется только по плану.

**mount /dev/sda2 /mnt/data — ручное монтирование USB-раздела** — подключает ext4-раздел к указанной точке; изменение состояния системы, выполнять только по плану.

## Команды: UCI и конфигурация OpenWrt

**uci show — полный просмотр UCI-конфигурации** — показывает активные настройки без изменения.

**uci show network — просмотр сетевой UCI-конфигурации** — показывает интерфейсы, bridge, адреса, VLAN и связанные network-параметры.

**uci show dhcp — просмотр DNS/DHCP-конфигурации** — показывает параметры dnsmasq/DHCP, включая upstream DNS и server/noresolv.

**uci get <section.option> — чтение одного UCI-параметра** — получает значение конкретной настройки без изменения.

**uci set <section.option>=<value> — изменение UCI-параметра** — меняет значение в staging-конфигурации; само по себе не означает, что изменение применено к работающему сервису.

**uci delete <section.option> — удаление UCI-параметра** — удаляет указанную настройку из staging-конфигурации.

**uci commit — запись UCI-изменений** — сохраняет staged UCI-изменения в постоянную конфигурацию; применять только после проверки правильности изменения.

**/etc/init.d/dnsmasq restart — перезапуск dnsmasq** — применяет текущую конфигурацию dnsmasq к работающему сервису; может кратковременно влиять на DNS/DHCP.

## Команды: Zapret2 и стратегия обработки

**grep -E '^(MODE_FILTER|NFQWS2_ENABLE|NFQWS2_OPT|NFQWS2_PORTS_TCP|NFQWS2_PORTS_UDP|FLOWOFFLOAD|INIT_APPLY_FW|DISABLE_IPV6)=' /opt/zapret2/config — чтение ключевых параметров Zapret2** — показывает режим фильтрации, включение nfqws2, правила NFQWS2, TCP/UDP-порты, flow offload, firewall integration и IPv6-параметр без изменения конфигурации.

**MODE_FILTER=autohostlist — автоматическое формирование hostlist** — режим, при котором Zapret2 автоматически формирует список доменов для применения заданных правил; это не то же самое, что автоматический выбор лучшей desync-стратегии.

**blockcheck2.sh — тестирование стратегий Zapret** — инструмент Zapret для последовательной проверки вариантов обработки/обхода на выбранных ресурсах; сам факт наличия инструмента не означает, что автоподбор уже был выполнен в текущем runtime.

**NFQWS2_OPT — описание конкретных desync-стратегий** — задаёт фильтры HTTP/TLS/QUIC и операции вроде fake, multisplit и multidisorder; изменение этого параметра меняет фактическую обработку трафика.

**nft list ruleset — просмотр активного nftables ruleset** — позволяет проверить, какие nftables-таблицы, sets и правила реально установлены после запуска Zapret2.

**pgrep -a nfqws2 — проверка активного nfqws2** — подтверждает, что userspace-процесс Zapret2 существует после запуска.

**wget -O /dev/null -T 10 https://example.com — router-side baseline при Zapret2** — применяется до/после изменения Zapret2, чтобы проверить, не сломан ли базовый HTTPS на самом роутере.

**клиентский тест Google / YouTube / Telegram / WhatsApp — проверка реальной доступности сервисов** — выполняется с подключённого клиентского устройства; router-side `wget` не заменяет проверку приложений Telegram/WhatsApp или полноценного пользовательского HTTPS/QUIC-трафика.

## Команды: автозапуск и проверка после reboot

**reboot — перезагрузка роутера** — полностью перезапускает OpenWrt; используется для проверки, что extroot, swap, службы и boot-интеграции действительно восстанавливаются автоматически.

**pgrep -a <process> после reboot — проверка runtime после загрузки** — показывает, запустился ли конкретный процесс автоматически; пустой вывод означает отсутствие процесса на момент проверки.

**ls -l /etc/rc.d/ | grep <service> — проверка регистрации автозапуска** — показывает boot-ссылки init-службы; наличие ссылки проверяет регистрацию, но не успешность фактического запуска.

**/etc/init.d/<service> enabled — проверка автозапуска, если поддерживается скриптом** — показывает состояние enable/disable у init-скрипта, если конкретный скрипт реализует эту возможность.

**pgrep -a https-dns-proxy после reboot — проверка, что отключённый DoH-прокси не стартовал** — в текущем проекте после reboot был получен пустой вывод, что подтвердило отсутствие runtime-процесса.

**pgrep -a nfqws2 после reboot — проверка автозапуска Zapret2** — показывает, стартовал ли nfqws2 после перезагрузки; ранее после reboot вывод был пустым, поэтому Zapret2 запускался вручную для повторной проверки.

## Состояния проекта

**NOT_STARTED — этап не начат** — работы по этапу ещё не выполнялись.

**IN_PROGRESS — этап выполняется** — этап имеет незавершённые проверки или действия.

**BLOCKED — этап заблокирован** — дальнейший шаг невозможен до устранения внешнего/предыдущего ограничения.

**FAILED — этап не прошёл критерий** — выполненная проверка не соответствует критерию этапа.

**DONE — этап завершён** — критерий выхода этапа выполнен фактическими проверками.

## Правила рабочего процесса

**One-step-at-a-time — один router command за шаг** — после результата команды сначала фиксируется фактическое состояние, и только в следующем пользовательском цикле выдаётся следующая команда.

**Master Plan synchronization — синхронизация мастер-плана** — после каждого пользовательского результата фактическое состояние, команда, вывод, выводы и следующий критерий записываются в мастер-план.

**Master Prompt synchronization — синхронизация мастер-промта** — выполняется при изменении workflow или safety rules, чтобы правила работы оставались согласованными с мастер-планом.

**Destructive-operation gate — защита от разрушительных операций** — форматирование, переразметка USB и другие destructive-действия выполняются только после диагностики, предупреждения и отдельного подтверждения.

**Technical-source separation — разделение источников** — репозиторий пользователя используется для мастер-документации; технические утверждения о OpenWrt должны опираться на официальные источники/релизы, а не на собственный репозиторий.

## Текущие подтверждённые факты Zapret2

**nfqws2 runtime PASS — native MIPS execution** — бинарник nfqws2 v1.0.3 успешно выполняется на роутере.

**Zapret2 start PASS — запуск после reboot** — текущий OpenWrt init-скрипт успешно запустил nfqws2 и применил nftables.

**nfqws2 process PASS — процесс жив** — после запуска `pgrep -a nfqws2` показал работающий процесс.

**Router-side HTTPS PASS — базовый HTTPS работает** — `wget https://example.com` успешно загрузил 559 байт при работающем nfqws2.

**Telegram/WhatsApp validation — клиентская проверка** — работа приложений не считается подтверждённой router-side wget; требуется отдельный реальный клиентский тест.

## Compact-output rule
**Компактный диагностический вывод — минимальный достаточный вывод** — команда должна возвращать только поля/строки, необходимые для текущего критерия PASS/FAIL. Для больших источников использовать точечные `grep -E`, `awk`, `sed -n`, `head`, `tail`; полный `logread`, `cat /proc/meminfo`, `nft list ruleset` и `uci show` применять только когда полный вывод действительно нужен. Компактность не должна объединять независимые шаги и нарушать one-step-at-a-time.


---

# Полный реестр команд проекта — исторический

> Этот раздел добавлен для сохранения фактически использовавшихся команд из рабочих чатов Variant A.
> Команды приведены в том виде, в котором они зафиксированы в истории/рабочем контексте.
> Команды, которые были только предложены как пример и не подтверждены фактическим выполнением, не должны интерпретироваться как подтверждённые действия.
> Destructive-команды не являются разрешением на повторное выполнение.

## 1. RouterOS / подготовка MikroTik до OpenWrt

~~~text
/export file=before-openwrt
/system backup save name=before-openwrt
/system resource print
/system package print
/system routerboard print
/system routerboard upgrade
/system reboot
~~~

## 2. OpenWrt: базовая идентификация системы

~~~text
ubus call system board
cat /etc/openwrt_release
uname -a
uname -r
uname -m
cat /proc/cpuinfo
free
free -h
df -h
df -h /
df -h /overlay
df -h /mnt/data
~~~

## 3. OpenWrt: блочные устройства, USB и kernel-модули

~~~text
ls -l /dev/
ls -l /dev/sda*
cat /sys/class/block/sda/size
dmesg | grep -i usb
dmesg | grep -Ei 'usb|scsi|sd[a-z]'
find /lib/modules/6.12.94 -type f | grep -E 'usb|ehci|scsi|ext4'
lsblk
blkid
mount
mount | grep -E '(/overlay|/mnt/data|/dev/sda[123])'
~~~

## 4. USB/extroot: исторические команды

~~~text
opkg update
opkg install kmod-usb-storage block-mount kmod-fs-ext4
mkdir -p /tmp/extoverlay
mount /dev/sda2 /tmp/extoverlay
tar -C /overlay -cvf - . | tar -C /tmp/extoverlay -xf -
umount /tmp/extoverlay
sed -n '8820,8940p' /sbin/block
sed -n '1390,1410p' /sbin/mount_root
ls -la /mnt/data
find /mnt/data -maxdepth 3 -printf '%M %u:%g %s %p\n' 2>/dev/null | sort
~~~

### Expand-root workflow

~~~text
opkg update
opkg install parted losetup resize2fs
wget -U "" -O expand-root.sh https://openwrt.org/_export/code/docs/guide-user/additional-software/extroot_configuration?codeblock=0
chmod +x expand-root.sh
./expand-root.sh
reboot
~~~

## 5. Swap / память

~~~text
cat /proc/swaps
swapon -s
free
free -h
free -m
cat /proc/meminfo
grep -E '^(MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree|Slab|SReclaimable|SUnreclaim):' /proc/meminfo
top -b -n 1
swapon /dev/sda1
~~~

## 6. Сеть: интерфейсы, адреса и маршруты

~~~text
ip addr
ip -br addr
ip -4 addr
ip link
ip link show eth1
ip route
ip -4 route
ip neigh
ifstatus wan
uci show network
uci show network && echo '--- IPv4 ---' && ip -4 addr && echo '--- ROUTES ---' && ip -4 route
ip link show eth1 && echo '--- DHCP/NETIFD ---' && logread | grep -E 'eth1|wan' | tail -50
~~~

## 7. Wi-Fi

~~~text
iw phy
iw dev
iw phy | grep -E 'Wiphy|Band|Interface modes|managed|AP|channel|HT|VHT' -A8 -B2
iw dev phy0-sta0 link
iw dev phy0-ap0 station dump
iwinfo
iw dev && echo '--- WIRELESS UCI ---' && uci show wireless
uci show wireless
wifi reload
lsmod | grep -E 'ath|mac80211|cfg80211|wpad'
~~~

### Поиск механизмов reload Wi-Fi/network

~~~text
grep -RniE 'wifi[[:space:]]+(reload|up|down)|wifi[._-](reload|up|down)|hostapd(_cli)?[[:space:]]+(reload|config_set)|ubus[[:space:]].*hostapd|reload[[:space:]].*hostapd' /etc/hotplug.d /etc/init.d /lib/netifd /lib/wifi /usr/libexec 2>/dev/null
grep -RniE '/etc/init\.d/network|service[[:space:]]+network|/etc/init\.d/.*network|ubus[[:space:]].*(network|network\.reload)|/sbin/ifup|/sbin/ifdown|/sbin/wifi' /etc/hotplug.d /etc/init.d /lib/netifd /lib/wifi /usr/libexec 2>/dev/null
~~~

## 8. DNS / resolver / dnsmasq

~~~text
cat /etc/resolv.conf
cat /tmp/resolv.conf.d/resolv.conf.auto
nslookup example.com 192.168.0.1
nslookup example.com 192.168.1.1
nslookup openwrt.org 127.0.0.1
dnsmasq --version
dnsmasq --version 2>&1 | head -5
/etc/init.d/dnsmasq status
/etc/init.d/dnsmasq restart
netstat -lnp 2>/dev/null | grep ':53 ' || ss -lnp 2>/dev/null | grep ':53 '
ps | grep '[h]ttps-dns-proxy'
~~~

### Поиск/проверка dnsmasq-пакетов

~~~text
apk search -v 'dnsmasq*' | grep -E 'dnsmasq|nft' | head -80
apk list --installed 2>/dev/null | grep '^dnsmasq' || true
apk info -s dnsmasq dnsmasq-full dnsmasq-nftset 2>/dev/null || true
apk info -R dnsmasq-full
apk add --simulate dnsmasq-full
apk add dnsmasq-full
apk list --installed | grep '^dnsmasq'
dnsmasq --version | head -5
~~~

### DNS / PBR / nftset discovery

~~~text
nft --version 2>&1
grep -R -E 'dnsmasq.nftset|nftset|resolver_set' /usr/share/pbr /etc/config/pbr 2>/dev/null | head -40
find /usr/share -maxdepth 3 -type f \( -iname '*geo*' -o -iname '*site*' -o -iname '*domain*' \) 2>/dev/null | head -80
uci get pbr.config.enabled
~~~

## 9. https-dns-proxy

~~~text
/etc/init.d/https-dns-proxy stop
/etc/init.d/https-dns-proxy disable
ls -l /etc/rc.d/ | grep https-dns-proxy
pgrep -a https-dns-proxy
ps | grep '[h]ttps-dns-proxy'
~~~

## 10. Проверка Интернет / DNS / HTTPS

~~~text
ping -c 2 192.168.0.1
ping -c 2 1.1.1.1
ping -c 2 openwrt.org
ping -c 2 -W 3 1.1.1.1
ping -c 4 192.168.0.1
ping -c 4 1.1.1.1
ping -c 4 openwrt.org
wget https://example.com
wget -O /dev/null -T 10 https://example.com
curl -I --max-time 10 https://example.com
~~~

## 11. OpenWrt package manager / packages

~~~text
apk --version
apk search curl
command -v curl || echo 'curl: NOT_INSTALLED'
apk info e2fsprogs
apk policy luci-base luci-mod-admin-full luci-theme-bootstrap uhttpd uhttpd-mod-ubus
apk list --installed 2>/dev/null | grep -E '^(luci|uhttpd|rpcd)'
~~~

Исторически до перехода на APK также использовались:

~~~text
opkg update
opkg install wireguard-tools
opkg install luci-proto-wireguard
~~~

## 12. UCI

~~~text
uci show
uci show network
uci show wireless
uci show dhcp
uci get <section.option>
uci set <section.option>=<value>
uci delete <section.option>
uci commit
~~~

## 13. Zapret2: структура и установка v1.0.3

~~~text
sed -n '730,780p' /overlay/tmp/zapret2/extract/zapret2-v1.0.3/install_easy.sh
sed -n '350,430p' /overlay/tmp/zapret2/extract/zapret2-v1.0.3/install_easy.sh
cd /overlay/tmp/zapret2/extract/zapret2-v1.0.3 && sh ./install_bin.sh getarch
printf '/opt: '; ls -ld /opt 2>/dev/null || echo ABSENT
printf '/opt/zapret2: '; ls -ld /opt/zapret2 2>/dev/null || echo ABSENT
sed -n '1,80p' /opt/zapret2/install_prereq.sh
~~~

Результат определения архитектуры:

~~~text
linux-mips
~~~

## 14. Zapret2: конфигурация и аудит

~~~text
grep -RniE 'NFQWS2_ENABLE|MODE_FILTER|FLOWOFFLOAD|OPENWRT_LAN|OPENWRT_WAN4|OPENWRT_WAN6|INIT_APPLY_FW' /opt/zapret2/common /opt/zapret2/*.sh 2>/dev/null | head -80
grep -E '^(MODE_FILTER|NFQWS2_ENABLE|NFQWS2_OPT|NFQWS2_PORTS_TCP|NFQWS2_PORTS_UDP|FLOWOFFLOAD|INIT_APPLY_FW|DISABLE_IPV6)=' /opt/zapret2/config
sed -n '/^NFQWS2_OPT=/,/^MODE_FILTER=/p' /opt/zapret2/config
sed -n '/^NFQWS2_OPT="/,/^"/p' /opt/zapret2/config
~~~

Текущие исторически зафиксированные значения:

~~~text
NFQWS2_ENABLE=1
NFQWS2_PORTS_TCP=80,443
NFQWS2_PORTS_UDP=443
MODE_FILTER=autohostlist
FLOWOFFLOAD=donttouch
INIT_APPLY_FW=1
DISABLE_IPV6=1
~~~

## 15. Zapret2: точный NFQWS2_OPT

~~~text
--filter-tcp=80 --filter-l7=http <HOSTLIST> --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5 --lua-desync=multisplit:pos=method+2 --new
--filter-tcp=443 --filter-l7=tls <HOSTLIST> --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tcp_seq=-10000 --lua-desync=multidisorder:pos=1,midsld --new
--filter-udp=443 --filter-l7=quic <HOSTLIST_NOAUTO> --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=6
~~~

## 16. Zapret2: запуск, остановка и runtime

~~~text
/opt/zapret2/init.d/openwrt/zapret2 start
/opt/zapret2/init.d/openwrt/zapret2 stop
pgrep -a nfqws2
ls -la /opt/zapret2/init.d/openwrt
ls -l /etc/rc.d/ | grep zapret2
/etc/init.d/<service> status
/etc/init.d/<service> start
/etc/init.d/<service> stop
/etc/init.d/<service> enable
/etc/init.d/<service> disable
reboot
~~~

Исторически проверенный, но неправильный путь:

~~~text
/opt/zapret2/init.d/sysv/zapret2
~~~

## 17. Zapret2: nftables / NFQUEUE

~~~text
nft list ruleset 2>/dev/null | sed -n '1,120p'
nft list table inet zapret2
nft -a list table inet zapret2
nft -a list chain inet zapret2 postnat
sed -n '145,285p' /opt/zapret2/ipset/create_ipset.sh | grep -nE 'create_ipset|create_nfset|IPSET_OPT|SET_MAXELEM|nft|ipset|hash:net'
find /opt/zapret2/ipset -maxdepth 1 -type f -print
~~~

## 18. Zapret2: hostlist / autohostlist

~~~text
find /opt/zapret2/ipset -maxdepth 1 -type f -print
~~~

Значения, использовавшиеся в тестах:

~~~text
MODE_FILTER=none
MODE_FILTER=hostlist
MODE_FILTER=autohostlist
~~~

## 19. Zapret2: set/qnum

~~~text
SET_MAXELEM=522288
QNUM=300
~~~

## 20. Zapret2: процесс и фактические аргументы

~~~text
tr '\0' ' ' < /proc/$(pidof nfqws2)/cmdline
pidof nfqws2
pgrep -a nfqws2
~~~

## 21. blockcheck2 на роутере

~~~text
ls -l /opt/zapret2/blockcheck2.sh
/opt/zapret2/blockcheck2.sh --help 2>&1 | head -40
/usr/bin/apk search curl
command -v curl || echo 'curl: NOT_INSTALLED'
~~~

## 22. Windows: официальный zapret-win-bundle / Cygwin

~~~text
Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version,OSArchitecture
C:\zapret-win-bundle\cygwin\cygwin.cmd
~~~

## 23. Windows/Cygwin: aliases

~~~text
alias blockcheck='C:/zapret-win-bundle/blockcheck/zapret/blockcheck.sh'
alias blockcheck-kyber='CURL=curl-kyber 'C:/zapret-win-bundle/blockcheck/zapret/blockcheck.sh''
alias blockcheck2='C:/zapret-win-bundle/blockcheck/zapret2/blockcheck2.sh'
alias blockcheck2-kyber='CURL=curl-kyber 'C:/zapret-win-bundle/blockcheck/zapret2/blockcheck2.sh''
alias ip2net='C:/zapret-win-bundle/blockcheck/zapret/ip2net/ip2net'
alias ll='ls -la'
alias ls='ls --color=auto'
alias mdig='C:/zapret-win-bundle/blockcheck/zapret/mdig/mdig'
alias winws='C:/zapret-win-bundle/blockcheck/zapret/nfq/winws'
alias winws2='C:/zapret-win-bundle/blockcheck/zapret2/nfq2/winws2'
alias winws2-antidpi='C:/zapret-win-bundle/blockcheck/zapret2/nfq2/winws2' --lua-init='@C:/zapret-win-bundle/blockcheck/zapret2/lua/zapret-lib.lua' --lua-init='@C:/zapret-win-bundle/blockcheck/zapret2/lua/zapret-antidpi.lua' --lua-init='@C:/zapret-win-bundle/blockcheck/zapret2/lua/zapret-auto.lua'
~~~

## 24. Windows/Cygwin: blockcheck2

~~~text
blockcheck2
blockcheck2 2>&1 | tee ~/blockcheck2.log
blockcheck2 2>&1 | tee ~/blockcheck2-youtube-tls12-standard.log
~~~

## 25. blockcheck2: использованные интерактивные матрицы

### YouTube quick

~~~text
youtube.com
IPv4
HTTP=Y
TLS1.2=Y
TLS1.3=N
QUIC=Y
repeats=1
scan=quick
~~~

### YouTube + Telegram + WhatsApp quick

~~~text
youtube.com telegram.org whatsapp.com
IPv4
HTTP=Y
TLS1.2=Y
TLS1.3=Y
QUIC=Y
repeats=1
scan=quick
~~~

### YouTube TLS1.2 standard

~~~text
youtube.com
IPv4
HTTP=Y
TLS1.2=Y
TLS1.3=N
QUIC=N
repeats=1
scan=standard
~~~

### Планируемый полный discovery

~~~text
youtube.com
IPv4
HTTP=N
TLS1.2=Y
TLS1.3=Y
QUIC=Y
repeats=1
parallel=N
scan=standard
~~~

## 26. QUIC/HTTP3: найденный кандидат

~~~text
winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
~~~

## 27. TLS1.2: 22 найденных YouTube IPv4 кандидата

### A — wssize + multidisorder

~~~text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=host+1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld,1220
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
~~~

### B — seqovl / multisplit / multidisorder

~~~text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:pos=10,midsld:seqovl=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1:seqovl_pattern=fake_default_tls
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multidisorder:pos=2,midsld:seqovl=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=multidisorder:pos=2,midsld:seqovl=1:seqovl_pattern=fake_default_tls
~~~

### C — fake + TCP/IP header modification

~~~text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=6:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1
~~~

### D — fake + automatic TTL

~~~text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
~~~

## 28. Build workflow: Zapret2 / MIPS

~~~text
PKG_CONFIG_PATH="$HOME/zapret2-build/deps/lib/pkgconfig"
./configure --prefix=/ --host=mips-unknown-linux-muslsf --enable-static --disable-shared --disable-dependency-tracking
make clean >/dev/null 2>&1 || true && CPPFLAGS="-I$HOME/zapret2-build/deps/include" LDFLAGS="-L$HOME/zapret2-build/deps/lib" make -j"$(nproc)"
~~~

Staging paths:

~~~text
~/zapret2-build/deps/include
~/zapret2-build/deps/lib
~~~

## 29. Исторические служебные/файловые команды

~~~text
cat /tmp/resolv.conf.d/resolv.conf.auto
cat /etc/config/fstab
ls -la
ls -l /etc/rc.d/
ls -l /etc/rc.d/ | grep zapret2
ls -l /etc/rc.d/ | grep https-dns-proxy
find /opt/zapret2/ipset -maxdepth 1 -type f -print
~~~

## 30. Правила интерпретации blockcheck2

~~~text
TLS1.2 AVAILABLE != TLS1.3 AVAILABLE
TLS1.2 AVAILABLE != QUIC AVAILABLE
TLS1.3 AVAILABLE != QUIC AVAILABLE
~~~

Это не shell-команды, а правила интерпретации результатов.

## 31. Важное правило полноты

Новый фактически использованный shell-командный вызов из рабочего чата Variant A добавляется в этот реестр с:
1. точной командой;
2. назначением;
3. статусом/результатом, если он известен;
4. пометкой, если команда была только предложена и не выполнялась.

Не смешивать shell-команды, значения конфигурации, интерактивные ответы blockcheck2 и результаты тестов.

Историческая команда не является разрешением на повторный запуск. Особенно это относится к sysupgrade, операциям с разделами, mount/swapon, opkg/apk add, UCI-изменениям, firewall/nftables и изменению Zapret2 config.


---

# Дополнение к полному реестру — команды, восстановленные из MASTER PROMPT / MASTER PLAN и истории диалога

> Цель этого блока — закрыть дополнительные команды, найденные при повторном сопоставлении текущего глоссария с накопленной историей проекта. Команды из этого блока не считаются автоматически выполненными только потому, что они записаны в документации.

## 36. Root / extroot / mount_root / fstools

~~~text
mount; df -h
strings /sbin/mount_root
sed -n '1390,1410p' /sbin/mount_root
sed -n '8820,8940p' /sbin/block
grep -nE '...' /sbin/mount_root
cat /sbin/mount_root
cat /sbin/block
mount /dev/sda2 /mnt/extroot
umount /mnt/extroot
swapoff /dev/sda1
~~~

Исторически анализировались:
~~~text
/lib/preinit/80_mount_root
/sbin/mount_root
/sbin/block
/tmp/extroot
/tmp/extroot/overlay
/dev/mtdblock9
~~~

## 37. fstab / root / USB read-only inspection

~~~text
cat /etc/config/fstab
grep -nE 'config global|auto_mount|overlay|uuid|sda1|sda2|sda3' /etc/config/fstab
uci show fstab
uci get fstab.@global[0].auto_mount
mount | grep -E 'overlay|mnt/data|sda'
df -h
~~~

## 38. Wireless netifd / ubus / AP+STA diagnostics

~~~text
ubus call network.wireless status
iw dev
iw phy
iw phy phy1 info
ip link show phy1-ap0
ip link show phy0-ap0
iw dev phy0-ap0 info
iw dev phy0-ap0 link
iw dev phy0-sta0 link
iw dev phy0-ap0 station dump
iw phy phy0 info
iw phy phy0 info | grep -A25 -B5 'VHT Capabilities'
iw dev | grep -A8 -B1 'phy0-ap0'
iw dev && echo '--- WIRELESS UCI ---' && uci show wireless
uci show wireless.radio0
uci show wireless | grep -A12 -B2 'OpenWrt-5G'
uci show wireless | grep -A8 -B2 'wireless.@wifi-iface'
uci show wireless | grep -E 'country|country3'
wifi status radio0
wifi reload
wifi down && wifi up
~~~

## 39. Direct iw radio parameter checks

~~~text
iw phy phy0 set distance 0
iw phy phy0 set distance 10
iw phy ... set antenna
iw phy ... set distance
iw phy ... set txpower
iw reg get
~~~

## 40. hostapd / wpa_supplicant runtime

~~~text
ubus call hostapd.phy0 get_status
ubus call hostapd.phy0-ap0 get_status
hostapd.phy0 get_status
hostapd.phy0-ap0 get_status
ps | grep '[h]ostapd'
ps | grep '[w]pa_supplicant'
pgrep -af hostapd
pgrep -af wpa_supplicant
~~~

Runtime paths:
~~~text
/usr/sbin/hostapd -s -g /var/run/hostapd/global
/usr/sbin/wpa_supplicant -n -s -g /var/run/wpa_supplicant/global
/var/run/hostapd-phy0.conf
~~~

## 41. Логи Wi-Fi / hostapd / kernel

~~~text
logread
logread | tail -60
logread | grep -B 5 -A 5 'Reload all interfaces' | tail -80
logread | sed -n '/07:38:40/,/07:39:10/p'
logread | sed -n '/07:38:45/,/07:39:10/p'
dmesg
dmesg | grep -Ei 'ath10k|ath9k|hostapd|wpa|phy0|phy1'
grep -RniE 'Reload all interfaces|reload_all|reload.*interface|hostapd.*reload|ubus.*hostapd' /etc /usr/lib /lib 2>/dev/null | head -100
~~~

## 42. https-dns-proxy / procd / rc.common / hotplug

~~~text
uci show https-dns-proxy
sed -n '440,475p' /etc/init.d/https-dns-proxy
grep -nE 'on_interface_trigger|on_interface_up' /etc/init.d/https-dns-proxy
grep -n 'procd_add_interface_trigger' /lib/functions/procd.sh
grep -nE '^reload_service\(\)|reload_service' /etc/init.d/https-dns-proxy
grep -nE 'start_service\(\)|stop_service\(\)|reload_service\(\)|reload\(\)' /etc/rc.common
cat /etc/rc.common
ls -l /etc/hotplug.d/iface/95-https-dns-proxy
cat /etc/hotplug.d/iface/95-https-dns-proxy
ls -l /etc/rc.d/S20https-dns-proxy
~~~

Исторически проверенные вызовы/строки:
~~~text
procd_add_raw_trigger 'interface.*.up' 5000 ... reload 'on_interface_up'
procd_add_interface_trigger 'interface.*' '$i' ... reload 'on_interface_trigger'
/etc/init.d/https-dns-proxy reload on_interface_trigger
/etc/init.d/$name reload
rc_procd start_service "$@"
reload_service "$@"
rc_procd start_service on_interface_trigger
~~~

## 43. pbr / background trigger checks

~~~text
/etc/init.d/pbr status
pgrep -af pbr
uci get pbr.config.enabled
grep -R -E 'dnsmasq.nftset|nftset|resolver_set' /usr/share/pbr /etc/config/pbr 2>/dev/null | head -40
crontab -l
/etc/init.d/mwan3 status
ls /etc/init.d/
~~~

## 44. Network / DHCP historical diagnostics

~~~text
ifstatus wan
ubus call dhcp ipv4leases
cat /tmp/dhcp.leases
ip -4 addr
ip -4 route
ip neigh
~~~

Windows:
~~~text
ipconfig | findstr /R /C:'IPv4' /C:'Default Gateway'
Get-NetIPConfiguration
ping -S 192.168.1.146 1.1.1.1
nslookup openwrt.org 192.168.1.1
~~~

## 45. Package / kernel / Zapret2 binary preflight

~~~text
apk info
apk info e2fsprogs
apk policy luci-base luci-mod-admin-full luci-theme-bootstrap uhttpd uhttpd-mod-ubus
lsmod | grep -E 'ath|mac80211|cfg80211|wpad'
nfqws2 --help
nfqws2 --version
/opt/zapret2/nfq2/nfqws2 --help
/opt/zapret2/nfq2/nfqws2 --version
sha256sum <file>
hexdump -C <file> | head
file <file>
~~~

## 46. Zapret2 installer/source inspection

~~~text
sed -n '1,80p' /opt/zapret2/install_prereq.sh
sed -n '350,430p' /overlay/tmp/zapret2/extract/zapret2-v1.0.3/install_easy.sh
sed -n '730,780p' /overlay/tmp/zapret2/extract/zapret2-v1.0.3/install_easy.sh
cd /overlay/tmp/zapret2/extract/zapret2-v1.0.3 && sh ./install_bin.sh getarch
~~~

Результат определения архитектуры:
~~~text
linux-mips
~~~

## 47. Zapret2 file/deployment inspection

~~~text
ls -la /opt/zapret2
ls -la /opt/zapret2/nfq2
ls -la /opt/zapret2/lua
ls -la /opt/zapret2/init.d/openwrt
ls -la /opt/zapret2/ipset
ls -l /opt/zapret2/config
ls -l /opt/zapret2/config.default
cmp /opt/zapret2/config /opt/zapret2/config.default
sha256sum /opt/zapret2/config /opt/zapret2/config.default
~~~

Staging paths:
~~~text
/overlay/tmp/zapret2
/overlay/tmp/zapret2/extract
/overlay/tmp/zapret2/extract/zapret2-v1.0.3
/overlay/tmp/zapret2/zapret2-v1.0.3-openwrt-embedded.tar.gz
~~~

## 48. Zapret2 nftables / queue / set audit

~~~text
nft list table inet zapret2
nft -a list table inet zapret2
nft -a list chain inet zapret2 postnat
nft list ruleset
nft --version 2>&1
sed -n '145,285p' /opt/zapret2/ipset/create_ipset.sh | grep -nE 'create_ipset|create_nfset|IPSET_OPT|SET_MAXELEM|nft|ipset|hash:net'
find /opt/zapret2/ipset -maxdepth 1 -type f -print
~~~

## 49. Zapret2 runtime arguments / process state

~~~text
pidof nfqws2
pgrep -a nfqws2
tr '\0' ' ' < /proc/$(pidof nfqws2)/cmdline
~~~

## 50. Zapret2 hostlist / filter configuration inspection

~~~text
grep -E '^(MODE_FILTER|NFQWS2_ENABLE|NFQWS2_OPT|NFQWS2_PORTS_TCP|NFQWS2_PORTS_UDP|FLOWOFFLOAD|INIT_APPLY_FW|DISABLE_IPV6)=' /opt/zapret2/config
sed -n '/^NFQWS2_OPT=/,/^MODE_FILTER=/p' /opt/zapret2/config
find /opt/zapret2/ipset -maxdepth 1 -type f -print
~~~

Исторические значения:
~~~text
MODE_FILTER=none
MODE_FILTER=hostlist
MODE_FILTER=autohostlist
FLOWOFFLOAD=donttouch
INIT_APPLY_FW=1
DISABLE_IPV6=1
NFQWS2_ENABLE=0
NFQWS2_ENABLE=1
NFQWS2_PORTS_TCP=80,443
NFQWS2_PORTS_UDP=443
SET_MAXELEM=522288
QNUM=300
~~~

## 51. Internet / router-side application tests

~~~text
wget https://example.com
wget -O /dev/null -T 10 https://example.com
wget https://api.telegram.org
curl -I --max-time 10 https://example.com
nslookup example.com 192.168.1.1
nslookup example.com 192.168.0.1
ping -c 2 192.168.0.1
ping -c 2 1.1.1.1
~~~

## 52. Windows official bundle / launch files

~~~text
C:\zapret-win-bundle\cygwin\cygwin.cmd
C:\zapret-win-bundle\_CMD_ADMIN.cmd
C:\zapret-win-bundle\blockcheck\blockcheck2.cmd
C:\zapret-win-bundle\blockcheck\blockcheck2-kyber.cmd
~~~

## 53. Windows/Cygwin environment checks

~~~text
Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version,OSArchitecture
uname -a
uname -m
curl --version
~~~

Зафиксированный runtime:
~~~text
CYGWIN_NT-10.0-26200
version 3.4.10-1.x86_64
firewall type is windivert
CURL=curl
curl 8.10.1 (x86_64-pc-cygwin)
~~~

## 54. blockcheck2 interactive protocol selection

~~~text
test = custom / standard
domain(s) = youtube.com
IP version = IPv4
HTTP = Y/N
TLS 1.2 = Y/N
TLS 1.3 = Y/N
QUIC = Y/N
repeats = 1
scan level = quick / standard / force
parallel = N
~~~

Текущий целевой discovery-вариант:
~~~text
standard
youtube.com
IPv4
HTTP=N
TLS1.2=Y
TLS1.3=Y
QUIC=Y
repeats=1
parallel=N
~~~

## 55. blockcheck2 logging

~~~text
blockcheck2 2>&1 | tee ~/blockcheck2.log
blockcheck2 2>&1 | tee ~/blockcheck2-youtube-tls12-standard.log
~~~

## 56. Windows blockcheck2 negative/control candidates

~~~text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
~~~

Обе стратегии в соответствующем стандартном YouTube TLS1.2 проходе завершились UNAVAILABLE code=28.

## 57. Windows blockcheck2 candidate parameter families

~~~text
wssize:wsize=1:scale=6
multidisorder:pos=host+1
multidisorder:pos=midsld
multidisorder:pos=1,midsld
multisplit:pos=10,midsld:seqovl=1
seqovl=midsld-1
ip_ttl=6
tcp_md5
badsum
tcp_ack=-66000
tcp_ts=-1000
tcp_flags_unset=ACK
tcp_flags_set=SYN
ip_autottl=-1,3-20
ip_autottl=-2,3-20
ip_autottl=-3,3-20
ip_autottl=-4,3-20
~~~

## 58. QUIC / HTTP3

~~~text
winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
curl --http3-only
~~~

## 59. Linux source/build workflow for MIPS

~~~text
PKG_CONFIG_PATH="$HOME/zapret2-build/deps/lib/pkgconfig"
./configure --prefix=/ --host=mips-unknown-linux-muslsf --enable-static --disable-shared --disable-dependency-tracking
make clean >/dev/null 2>&1 || true && CPPFLAGS="-I$HOME/zapret2-build/deps/include" LDFLAGS="-L$HOME/zapret2-build/deps/lib" make -j"$(nproc)"
~~~

## 60. File/process/low-level helper commands

~~~text
printf '/opt: '; ls -ld /opt 2>/dev/null || echo ABSENT
printf '/opt/zapret2: '; ls -ld /opt/zapret2 2>/dev/null || echo ABSENT
head -40
tail -50
grep -n 'procd_add_interface_trigger' /lib/functions/procd.sh
find /usr/share -maxdepth 3 -type f \( -iname '*geo*' -o -iname '*site*' -o -iname '*domain*' \) 2>/dev/null | head -80
cat /tmp/resolv.conf.d/resolv.conf.auto
~~~

## 61. Исторически неудачные / неподдержанные команды

~~~text
ubus call dhcp ipv4leases
swapon --show
ubus call hostapd.phy0 get_status
/opt/zapret2/init.d/sysv/zapret2
~~~

Результаты:
- ubus call dhcp ipv4leases → Method not found;
- swapon --show → не поддерживается используемым BusyBox;
- ubus call hostapd.phy0 get_status → объект/метод не найден в текущем runtime;
- /opt/zapret2/init.d/sysv/zapret2 → путь не найден; рабочая OpenWrt-интеграция находится в /opt/zapret2/init.d/openwrt/zapret2.

## 62. Правило накопительного реестра

Каждая новая команда из рабочего чата добавляется в глоссарий в точной использованной форме. Рядом указывается один из типов/статусов:

~~~text
EXECUTED
MENTIONED
PROPOSED
FAILED
UNSUPPORTED
STATE-CHANGING
DESTRUCTIVE
~~~

Команда не считается EXECUTED только потому, что она существует в мастер-плане или была рекомендована ассистентом. Фактический вывод хранится отдельно от команды.

Историческая команда не является разрешением на повторный запуск, особенно для sysupgrade, операций с разделами, mount/swapon, opkg/apk add, UCI-изменений, firewall/nftables и изменения Zapret2 config.


---

# Дополнение — команды из раннего Variant A workflow, отсутствовавшие в реестре

## 63. USB partition / filesystem commands

~~~text
fdisk
fdisk /dev/sda
mkfs
mkfs.ext4
mkfs.ext4 /dev/sda1
block info
blkid
mount
umount
~~~

Эти команды относятся к историческому USB workflow. fdisk, mkfs и аналогичные операции являются state-changing/destructive и не должны выполняться повторно без отдельного safety gate.

## 64. Destructive-operation command names recorded by the project

~~~text
fdisk
mkfs
dd
sysupgrade
rm -rf
~~~

Это перечень опасных команд, который был отдельно установлен в мастер-правилах проекта. Наличие в глоссарии не означает, что команда разрешена к выполнению.

## 65. extroot / filesystem preparation utilities

~~~text
parted
losetup
resize2fs
tar
~~~

Применялись/упоминались в historical extroot/expand-root workflow.

## 66. Memory / ZRAM utilities

~~~text
zramctl
swapon -s
swapoff /dev/sda1
~~~

zramctl был указан как инструмент проверки ZRAM; фактическое состояние ZRAM также анализировалось через /sys и /proc.

## 67. OpenWrt ImageBuilder / image verification command names

~~~text
sha256sum
sysupgrade -n /tmp/firmware.bin
~~~

sysupgrade -n относится к clean-flash workflow и является destructive/state-changing операцией.

## 68. Package/install command names recorded in the historical plan

~~~text
apk add
apk add --simulate
opkg update
opkg install
~~~

Точные пакеты и параметры должны проверяться по текущему OpenWrt release и архитектуре перед повторным использованием.

## 69. Historical technical objects often passed to commands

~~~text
/dev/sda
/dev/sda1
/dev/sda2
/dev/sda3
/overlay
/mnt/data
/mnt/extroot
/tmp/extroot
~~~

Это объекты/пути, а не самостоятельные shell-команды.

## 70. Complete-registry note

По состоянию на эту ревизию глоссарий объединяет:
- основной command registry;
- дополнения из MASTER PLAN;
- дополнения из MASTER PROMPT;
- доступные восстановимые команды из раннего Variant A workflow;
- Windows/Cygwin и blockcheck2;
- все 22 зафиксированных TLS1.2 кандидата и отдельный QUIC кандидат.

Гарантировать наличие команд из чатов, содержимое которых не представлено в доступной истории/файлах, невозможно; такие команды не выдумываются.


## Compact output protocol

Проектный стандарт для новых команд:
- команда должна возвращать только диагностически значимые строки;
- предпочтительны `grep/sed/awk/head/tail` и однострочные агрегаты вместо полных дампов;
- ориентир 3–15 строк вывода, если больший объём не нужен для принятия решения;
- компактность вывода не отменяет правило one-step-at-a-time;
- большие выводы допустимы только когда именно полный дамп является объектом проверки.

Тип: POLICY

## 71. Diagnostic package set installed — 2026-09-23

Фактически установлен расширенный CLI-набор диагностических инструментов на OpenWrt 25.12.5 / ath79/mikrotik. Установка завершилась успешно: `OK: 32.2 MiB in 231 packages`.

### Сетевые и диагностические пакеты
- **tcpdump** — захват и просмотр реальных сетевых пакетов; основной инструмент для проверки WARP UDP/2408 и входящих ответов.
- **ip-full** — расширенные возможности команды `ip` для адресов, маршрутов, правил и интерфейсов.
- **ss** — просмотр TCP/UDP-сокетов и состояний соединений.
- **ethtool** — диагностика параметров сетевых интерфейсов и offload.
- **curl** — управляемые HTTP/HTTPS-запросы и сетевые проверки.
- **socat** — гибкие TCP/UDP-тесты и соединение потоков.
- **conntrack** — просмотр и управление таблицей connection tracking/NAT.
- **netcat** — TCP/UDP-проверки и сетевой troubleshooting; выбран вместо недоступного `netcat-openbsd`.
- **iperf3** — измерение пропускной способности.
- **bind-dig** — подробная DNS-диагностика.

### TLS / сертификаты
- **openssl-util** — OpenSSL CLI для TLS/сертификатов и криптографической диагностики.
- **ca-bundle** — набор корневых CA-сертификатов.
- **ca-certificates** — инфраструктура CA-сертификатов для проверки TLS.

### Низкоуровневая диагностика / процессы
- **strace** — трассировка системных вызовов процессов.
- **lsof** — определение процессов, использующих файлы и сетевые сокеты.
- **procps-ng** — расширенные утилиты процессов, включая `ps`/аналогичные инструменты.
- **htop** — интерактивный просмотр процессов и использования RAM/CPU.
- **file** — определение типа файлов.
- **less** — удобный просмотр большого текстового вывода.

### Работа с файлами / конфигурациями
- **nano** — простой терминальный текстовый редактор.
- **diffutils** — сравнение файлов/конфигураций.
- **findutils** — расширенный поиск файлов.
- **gawk** — обработка и агрегация текстового вывода.
- **tar** — tar-архивы.
- **gzip** — gzip-сжатие.
- **xz** — xz-сжатие.
- **unzip** — распаковка ZIP-архивов.

### Проверка имён пакетов
Для OpenWrt 25.12.5 подтверждены следующие соответствия:
- `conntrack-tools` — **недоступен**; правильный доступный пакет: `conntrack`.
- `netcat-openbsd` — **недоступен**; правильный доступный пакет: `netcat`.
- `zip` — отдельный пакет **не найден**; `unzip` доступен. Создание ZIP сейчас проекту не требуется.
- `vim-full` — сознательно не устанавливался: для текущей диагностики не нужен и не является приоритетом на 64-МБ устройстве.

### Фактически выполненная команда установки
```text
apk add tcpdump ip-full ss ethtool curl socat conntrack netcat iperf3 bind-dig openssl-util ca-bundle ca-certificates strace lsof procps-ng htop file less nano diffutils findutils gawk tar gzip xz unzip
```

Статус: **EXECUTED / PASS**. Пакеты установлены; итог `apk` — 32.2 MiB in 231 packages.

Важно: наличие этих пакетов в глоссарии не означает, что все инструменты должны запускаться одновременно. Из-за ограниченной RAM hAP ac lite (~64 MB) диагностические инструменты используются по одному/по необходимости.



## 72. Zapret2 startup / runtime activation — 2026-09-24
### Command
```text
/etc/init.d/zapret2 start
```

### Status
**EXECUTED / STATE-CHANGING / PASS**

### Verified startup result
- Started `nfqws2` qnum=300 with TCP 80/443 and UDP 443 filters under `MODE_FILTER=autohostlist`.
- Started `nfqws2` qnum=65300 for payload selectors:
  - `wireguard_initiation`
  - `wireguard_response`
  - `wireguard_cookie`
- Applied nftables successfully.
- Inserted qnum=300 rules:
  - IPv4 TCP destination ports 80/443, original packets 1–20;
  - IPv4 TCP source ports 80/443, reply packets 1–10;
  - IPv4 UDP destination port 443, original packets 1–5;
  - IPv4 UDP source port 443, reply packets 1–3.
- Inserted qnum=65300 rules:
  - UDP length 156 with payload marker `0x01000000`;
  - UDP length 100 with payload marker `0x02000000`;
  - UDP length 72 with payload marker `0x03000000`.
- Startup set `net.netfilter.nf_conntrack_tcp_be_liberal = 1`.

### Important interpretation
The successful start confirms the service and nftables/NFQUEUE rules were applied. It does **not** by itself prove that any specific application (for example WARP or YouTube) is functioning through those rules.

### Historical note
The qnum=65300 WireGuard-related rules are runtime rules observed during this start; their presence must not be treated as proof that WireGuard traffic is successfully handshaking.



## 73. Workflow checkpoint — 2026-09-24
- Repository state was re-read before continuing the router workflow.
- Zapret2 remains documented as ACTIVE after the successful service start.
- No router configuration was changed by this checkpoint.


## 74. Zapret2 functional baseline — 2026-09-24
- With Zapret2 active, an HTTPS request to example.com completed within the 5-second timeout and returned HTML from Example Domain.
- This confirms basic HTTPS connectivity with the current runtime rules; it is not proof of application-specific bypass behavior.
