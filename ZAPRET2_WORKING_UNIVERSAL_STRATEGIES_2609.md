# CONTROL DOCUMENTS — 2026-09-27

Для переноса стратегий на OpenWrt использовать:
- ZAPRET2_STRATEGY_MASTER_PLAN.md — план, stages, evidence rules и exact stopping point.
- ZAPRET2_STRATEGY_MASTER_PROMPT.md — обязательные правила для AI при Strategy Work.

Этот файл является evidence-сводкой blockcheck2609_FULL.log. Он НЕ заменяет два мастер-документа и НЕ является доказательством runtime-валидации на hAP.

---

# ZAPRET2 — WORKING / UNIVERSAL STRATEGIES 2609

Источник: `blockcheck2609_FULL.log` из репозитория Calcul.
SHA исходного файла: `d42227bdc262c4437e4d1f78e28369c41075b3d6`.

Дата анализа: 2026-09-26.

## 1. Важное замечание

Лог создан `blockcheck2` в среде Cygwin/WinDivert и содержит тесты `winws2`.
Поэтому `--wf-*` из лога — это механизм Windows-перехвата, а НЕ параметры,
которые надо переносить в OpenWrt.

Ниже сохранена только полезная для zapret2 часть стратегии:
`--payload=...` + `--lua-desync=...`.

Статус AVAILABLE означает, что конкретная комбинация прошла тест
blockcheck в исходном тестовом окружении. Это не является гарантией,
что та же комбинация оптимальна для конкретного ISP/DPI или hAP OpenWrt.

## 2. Итог анализа

В логе найдено 7 уникальных рабочих комбинаций стратегии.

| Приоритет | Протокол/назначение | Стратегия | Число доменов с AVAILABLE |
|---|---|---|---:|
| 1 | HTTP | `http_methodeol` | 95 |
| 2 | TLS 1.3 | `tcpseg pos=0,-1 seqovl=1 + drop` | 92 |
| 3 | HTTP | `http_hostcase` | 84 |
| 4 | HTTP | `fake_default_http + tcp_ts=-1000` | 74 |
| 5 | QUIC | `fake_default_quic repeats=11` | 42 |
| 6 | QUIC | `send:ipfrag + drop` | 26 |
| 7 | TLS 1.2 | `fake_default_tls + tcp_ts=-1000` | 10 |

Всего в выборке: 95 различных доменных имён.

## 3. ОСНОВНОЙ ОБЩИЙ НАБОР

### A. HTTP — основной кандидат

Покрытие: 95/95 тестированных доменов.

```
--payload=http_req --lua-desync=http_methodeol
```

Это наиболее широко повторяющаяся рабочая стратегия в данном логе.

### B. TLS 1.3 — основной кандидат

Покрытие: 92/95 доменов.

```
--payload=tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop
```

Эту стратегию следует рассматривать отдельно от HTTP:
она работает с TLS ClientHello на TCP/443.

### C. HTTP hostcase

Покрытие: 84/95 доменов.

```
--payload=http_req --lua-desync=http_hostcase
```

### D. HTTP fake

Покрытие: 74/95 доменов.

```
--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
```

## 4. QUIC / UDP 443

### E. QUIC fake

Покрытие: 42/95 доменов.

```
--payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
```

### F. QUIC IP fragmentation

Покрытие: 26/95 доменов.

```
--payload=quic_initial --lua-desync=send:ipfrag --lua-desync=drop
```

Не следует автоматически добавлять обе QUIC стратегии в постоянную
конфигурацию одновременно. Их лучше тестировать как отдельные варианты.

## 5. TLS 1.2 — отдельный fallback

Покрытие: 10 доменов.

```
--payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
```

В исходном логе эта стратегия встречается существенно реже, поэтому
она не должна быть первым общим вариантом.

## 6. Рекомендуемая структура для дальнейшего тестирования на OpenWrt

### HTTP

1. `http_methodeol`
2. `http_hostcase`
3. `fake_default_http + tcp_ts=-1000`

### HTTPS/TLS

1. `tcpseg:pos=0,-1:seqovl=1 + drop`
2. `fake_default_tls + tcp_ts=-1000` как TLS 1.2 fallback

### QUIC

1. `fake_default_quic:repeats=11`
2. `send:ipfrag + drop`

## 7. Что НЕ следует делать

Не переносить в OpenWrt буквально строки вида:

```
--wf-l3=ipv4
--wf-tcp-out=80
--wf-tcp-out=443
--wf-udp-out=443
```

Это параметры WinDivert/winws2 из Windows-теста.

На OpenWrt эти направления должны задаваться nftables/NFQUEUE,
а внутри nfqws2 используется соответствующая payload/desync стратегия.

## 8. Важное различие HTTP / TLS / QUIC

Одна стратегия не означает, что весь трафик надо отправлять через неё.

- `http_req` → HTTP-запросы.
- `tls_client_hello` → TCP TLS ClientHello.
- `quic_initial` → QUIC Initial на UDP/443.

Поэтому для практической конфигурации zapret2 эти группы должны
рассматриваться как независимые обработчики.

## 9. Кандидат на универсальный профиль

Если нужен минимальный набор для последующей проверки на hAP,
первым кандидатом является:

```
HTTP:
--payload=http_req --lua-desync=http_methodeol

TLS:
--payload=tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop

QUIC:
--payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
```

Дополнительные fallback:

```
HTTP:
--payload=http_req --lua-desync=http_hostcase

HTTP:
--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000

QUIC:
--payload=quic_initial --lua-desync=send:ipfrag --lua-desync=drop

TLS 1.2:
--payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
```

## 10. Интерпретация для проекта Calcul

Эти результаты следует считать:

`WORKING_IN_BLOCKCHECK`

а не:

`CONFIRMED_ON_HAP`

Перед постоянным включением на MikroTik hAP ac lite каждая выбранная
комбинация должна пройти отдельную проверку на текущей конфигурации
OpenWrt/nfqws2.

Особенно важно не смешивать результаты Windows/winws2 с уже имеющимся
на hAP режимом NFQUEUE/nfqws2 без адаптации правил перехвата.

## 11. Источник

`blockcheck2609_FULL.log`

Repository:
`kappamaag-crypto/Calcul`

Исходный файл содержит результаты blockcheck2 для большого набора
доменов; здесь сохранены только уникальные рабочие стратегии и их
частота появления.

