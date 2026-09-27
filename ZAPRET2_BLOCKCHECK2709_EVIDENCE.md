# ZAPRET2 — BLOCKCHECK2709 EVIDENCE / SERVICE MATRIX

Источник: `blockcheck2709.log` в репозитории `kappamaag-crypto/Calcul`.
Blob SHA: `f1413839059d5f86b2856aa6ddc62b2e7ed38bb3`.
Дата загрузки/фиксации: 2026-09-27.

## 1. Общая выборка

- Лог содержит **301 тестируемый домен** в итоговой coverage-выборке.
- Лог создан в Cygwin/WinDivert с `winws2`; параметры `--wf-*` являются Windows interception и НЕ переносятся буквально на OpenWrt.
- Переносим только применимую `payload/desync`-логику в nfqws2.
- Итоговый summary blockcheck прямо предупреждает, что результаты не являются «magic pill» и требуют понимания/проверки на целевом DPI.

## 2. Общая статистика coverage

Из summary `blockcheck2709.log`:

- TLS 1.2 без bypass: 150/301.
- TLS 1.3 без bypass: 143/301.
- HTTP без bypass: 160/301.
- QUIC без bypass: 70/301.
- HTTP `http_methodeol`: 198/301.
- TLS 1.3 `tcpseg:pos=0,-1:seqovl=1 + drop`: 193/301.
- HTTP `http_hostcase`: 160/301.
- HTTP `fake_default_http + tcp_ts=-1000`: 149/301.
- QUIC `fake_default_quic:repeats=11`: 108/301.
- QUIC `send:ipfrag + drop`: 70/301.
- TLS 1.2 `fake_default_tls + tcp_ts=-1000`: 10/301.
- TLS 1.2 сложный вариант с fake/MD5/multisplit: 2/301.
- TLS 1.3 такой же `fake_default_tls + tcp_ts=-1000`: 2/301.

Важно: число 198/301 означает число доменов, для которых именно эта комбинация была отмечена как рабочая в blockcheck, а не процент успешности на реальном hAP.

## 3. Четырёхсервисная матрица

### YouTube

В keyword-matched evidence найдены 6 доменов с рабочими стратегиями:
- youtube.com
- www.youtube.com
- m.youtube.com
- youtubei.googleapis.com
- youtube.googleapis.com
- youtube.ru

Рабочие классы:
- HTTP: `http_hostcase`
- QUIC: `fake_default_quic:repeats=11`

TLS-стратегия из этого keyword-matched блока не получена как WORKING_IN_BLOCKCHECK; отсутствие такой строки не означает автоматически, что весь YouTube TLS не работает.

### Instagram

В keyword-matched evidence найдены 4 домена:
- instagram.com
- www.instagram.com
- i.instagram.com
- scontent.cdninstagram.com

Рабочие классы:
- HTTP: `http_methodeol`
- TLS 1.3: `tcpseg:pos=0,-1:seqovl=1 + drop`
- QUIC: `fake_default_quic:repeats=11`

### WhatsApp

В keyword-matched evidence найдены 2 домена:
- api.whatsapp.com
- v.whatsapp.net

Рабочие классы:
- HTTP: `http_hostcase`
- TLS 1.3: `tcpseg:pos=0,-1:seqovl=1 + drop`

### Telegram

Для:
- telegram.org
- www.telegram.org
- t.me
- telegram.me
- api.telegram.org
- core.telegram.org
- web.telegram.org
- desktop.telegram.org

blockcheck2709.log не показал ни одной строки `working strategy found`.

Итог для Telegram в этом прогоне:
- HTTP: NOT WORKING
- TLS 1.2: NOT WORKING
- TLS 1.3: NOT WORKING
- QUIC: NOT WORKING

Это **не доказывает**, что Telegram невозможно обойти вообще. Это означает, что данный blockcheck-прогон не нашёл рабочей winws2-стратегии для перечисленных Telegram-доменов.

## 4. Пересечение стратегий

По фактически найденным WORKING_IN_BLOCKCHECK стратегиям:

- YouTube ∩ Instagram = QUIC `fake_default_quic:repeats=11`
- YouTube ∩ WhatsApp = HTTP `http_hostcase`
- Instagram ∩ WhatsApp = TLS 1.3 `tcpseg:pos=0,-1:seqovl=1 + drop`
- YouTube ∩ Instagram ∩ WhatsApp = **пустое пересечение одной конкретной стратегии**.
- Telegram ∩ любой из трёх = **пусто**, поскольку в текущем прогоне Telegram не имеет WORKING_IN_BLOCKCHECK стратегии.

Следствие: нельзя сейчас объявлять одну найденную стратегию универсальной для всех четырёх сервисов.

## 5. Практическая группа кандидатов для OpenWrt

На основании 2709 evidence наиболее значимые кандидаты для последующей hAP-проверки:

### HTTP
1. `http_methodeol` — 198/301
2. `http_hostcase` — 160/301
3. `fake_default_http + tcp_ts=-1000` — 149/301

### TLS 1.3
1. `tcpseg:pos=0,-1:seqovl=1 + drop` — 193/301

### QUIC
1. `fake_default_quic:repeats=11` — 108/301
2. `send:ipfrag + drop` — 70/301

### TLS 1.2 fallback
1. `fake_default_tls + tcp_ts=-1000` — 10/301

Эти цифры — evidence ranking, а не окончательный порядок эффективности на hAP.

## 6. Что изменилось относительно 2609

Новый лог существенно расширил выборку: 301 домен против 95 в предыдущей evidence-сводке.

Повторно подтверждены основные классы:
- `http_methodeol`
- `http_hostcase`
- `fake_default_http + tcp_ts=-1000`
- TLS 1.3 `tcpseg + drop`
- QUIC `fake_default_quic`
- QUIC `send:ipfrag + drop`
- TLS 1.2 `fake_default_tls + tcp_ts=-1000`

Новый лог не устранил Telegram gap.

## 7. Текущий статус

- BLOCKCHECK2709 evidence = **ANALYZED**
- Four-service matrix = **DONE FOR CURRENT BLOCKCHECK EVIDENCE**
- Universal strategy for all four services = **NOT ESTABLISHED**
- Telegram Zapret2-only blockcheck coverage = **BLOCKED / NOT_FOUND_IN_THIS_RUN**
- OpenWrt/hAP runtime validation = **NOT_STARTED**
- Existing router configuration = **UNCHANGED BY THIS ANALYSIS**

## 8. Следующий этап

Следующий этап — **S2 OpenWrt translation map**, затем резервная копия текущего Zapret2 и поочерёдная runtime-проверка минимального набора на hAP.

До runtime-проверки:
- не менять DNS;
- не менять PBR;
- не возобновлять WG/AWG;
- не добавлять десятки стратегий одновременно;
- не объявлять Telegram решённым;
- не заменять текущий рабочий Zapret2 конфиг целиком.

