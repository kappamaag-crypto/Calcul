# strategy27 — полный доменный каталог blockcheck2 2609 → 2709

**Дата анализа:** 2026-09-27  
**Назначение:** сохранить полный raw-evidence mapping `домен → все explicit FOUND стратегии` из двух последних логов и вывести математически минимальное покрытие для последующей интеграции в OpenWrt/nfqws2 на MikroTik hAP ac lite.

## 1. Источники

- `blockcheck2609_FULL.log`
  - blob SHA: `d42227bdc262c4437e4d1f78e28369c41075b3d6`
  - 34,569 строк
  - 140 доменных секций
- `blockcheck2709.log`
  - blob SHA: `f1413839059d5f86b2856aa6ddc62b2e7ed38bb3`
  - 70,258 строк
  - 301 доменная секция
  - 296 уникальных доменов внутри самого 2709
- Объединение двух raw-run: **297 уникальных тестовых целей**.

## 2. Правило evidence

**EXPLICIT FOUND** означает буквальную raw-запись:

```
working strategy found
```

В эту таблицу не смешиваются:
- COVERAGE;
- AVAILABLE без explicit FOUND;
- `working without bypass`;
- `winws2 not working`;
- `test aborted`.

Поэтому данная матрица показывает именно **найденные рабочие стратегии**, а не все стратегии, которые blockcheck2 перебирал.

## 3. Полный каталог стратегий

| ID | Класс | Название | Exact command logic |
|---|---|---|---|
| S1 / HC | HTTP | http_hostcase | `--payload=http_req --lua-desync=http_hostcase` |
| S2 / ME | HTTP | http_methodeol | `--payload=http_req --lua-desync=http_methodeol` |
| C1 / HF | HTTP candidate | fake_default_http + tcp_ts=-1000 | `--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000` |
| S3 / TS | TLS1.3 | tcpseg + drop | `--payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop` |
| S4 / TF | TLS | fake_default_tls + tcp_ts=-1000 | `--payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000` |
| S5 / TC | TLS1.2 special | tcp_md5 + tls_mod + multisplit | `--payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2` |
| S6 / QF | QUIC | fake_default_quic repeats=11 | `--payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11` |
| S7 / QI | QUIC special | send ipfrag + drop | `--payload quic_initial --lua-desync=send:ipfrag --lua-desync=drop` |

### Статус каждой стратегии

- **HC:** explicit FOUND в 2609 и 2709.
- **ME:** explicit FOUND в 2609 и 2709.
- **TS:** explicit FOUND в 2609 и 2709.
- **TF:** explicit FOUND в 2609 и 2709.
- **TC:** explicit FOUND только в 2709, 2 записи.
- **QF:** explicit FOUND в 2609 и 2709.
- **QI:** explicit FOUND в 2609 и 2709.
- **HF:** **не explicit FOUND**. Это отдельный HIGH-COVERAGE candidate: 74/140 в 2609 и 149/301 в 2709.

## 4. Raw FOUND statistics

| Метрика | 2609 | 2709 | Объединение |
|---|---:|---:|---:|
| Доменные секции | 140 | 301 | 297 unique tested |
| Explicit FOUND records | 239 | 518 | 757 |
| Unique domains with ≥1 FOUND | 104 | 221 | 225 |
| Tested unique domains without explicit FOUND | — | — | 72 |

### Уникальные домены с explicit FOUND по strategy class

| Strategy | Unique domains |
|---|---:|
| HC | 159 |
| ME | 44 |
| HF | 0 |
| TS | 194 |
| TF | 15 |
| TC | 2 |
| QF | 111 |
| QI | 2 |

Распределение по числу FOUND-классов на домен:
- 1 strategy classes: 34 domains
- 2 strategy classes: 88 domains
- 3 strategy classes: 95 domains
- 4 strategy classes: 8 domains

## 5. ПОЛНАЯ ТАБЛИЦА: каждый тестовый домен → все найденные стратегии

**Обозначения:**
- HC = http_hostcase
- ME = http_methodeol
- HF = high-coverage candidate, не explicit FOUND
- TS = tcpseg + drop
- TF = fake_default_tls + tcp_ts=-1000
- TC = special TLS1.2
- QF = fake_default_quic repeats=11
- QI = QUIC ipfrag + drop

| # | Домен | Все explicit FOUND strategy | Evidence |
|---:|---|---|---|
| 1 | `1.1.1.1` | **NONE** | NO FOUND |
| 2 | `a-v2.sndcdn.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 3 | `abs.twimg.com` | ME, TS | ME:2709; TS:2709 |
| 4 | `account.microsoft.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 5 | `accounts.google.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 6 | `ai.google.dev` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 7 | `ai21.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 8 | `anthropic.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 9 | `api.anthropic.com` | TS | TS:2709 |
| 10 | `api.cloudflare.com` | TS | TS:2609+2709 |
| 11 | `api.deepseek.com` | HC, TS | HC:2709; TS:2709 |
| 12 | `api.devices.cloudflare.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 13 | `api.epicgames.com` | **NONE** | NO FOUND |
| 14 | `api.github.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 15 | `api.linkedin.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 16 | `api.mistral.ai` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 17 | `api.openai.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 18 | `api.perplexity.ai` | HC, TS, TF, QF | HC:2709; TS:2709; TF:2709; QF:2709 |
| 19 | `api.spotify.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 20 | `api.steampowered.com` | HC | HC:2609+2709 |
| 21 | `api.telegram.org` | **NONE** | NO FOUND |
| 22 | `api.twitter.com` | ME, TS | ME:2709; TS:2709 |
| 23 | `api.vimeo.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 24 | `api.whatsapp.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609 |
| 25 | `api.x.ai` | HC, TS | HC:2709; TS:2709 |
| 26 | `assets.web.soundcloud.cloud` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 27 | `audio4.spotifycdn.com` | **NONE** | NO FOUND |
| 28 | `avatars.githubusercontent.com` | HC, TS | HC:2709; TS:2709 |
| 29 | `azure.com` | TS, TF | TS:2609+2709; TF:2609 |
| 30 | `azureedge.net` | **NONE** | NO FOUND |
| 31 | `azurefd.net` | **NONE** | NO FOUND |
| 32 | `b-graph.facebook.com` | **NONE** | NO FOUND |
| 33 | `battle.net` | **NONE** | NO FOUND |
| 34 | `bing.com` | HC, TS | HC:2709; TS:2709 |
| 35 | `blizzard.com` | HC | HC:2609+2709 |
| 36 | `bytefcdn-oversea.com` | **NONE** | NO FOUND |
| 37 | `byteoversea.com` | **NONE** | NO FOUND |
| 38 | `camo.githubusercontent.com` | HC, TS | HC:2709; TS:2709 |
| 39 | `cdn-images-1.medium.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 40 | `cdn-images-2.medium.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 41 | `cdn-telegram.org` | **NONE** | NO FOUND |
| 42 | `cdn.discordapp.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 43 | `cdn.steamstatic.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 44 | `cdninstagram.com` | **NONE** | NO FOUND |
| 45 | `character.ai` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 46 | `chat.deepseek.com` | HC | HC:2709 |
| 47 | `chat.mistral.ai` | HC, TS | HC:2709; TS:2709 |
| 48 | `chat.openai.com` | TS | TS:2709 |
| 49 | `chatgpt.com` | HC, TS | HC:2709; TS:2709 |
| 50 | `claude.ai` | TF, QF | TF:2709; QF:2709 |
| 51 | `claudeusercontent.com` | TS, QF | TS:2709; QF:2709 |
| 52 | `cloud.microsoft` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 53 | `cloudflare-dns.com` | HC, TS, TF, QF | HC:2609+2709; TS:2709; TF:2609; QF:2609+2709 |
| 54 | `cloudflare.com` | HC, TS, TF, QF | HC:2609+2709; TS:2609+2709; TF:2709; QF:2609+2709 |
| 55 | `cloudflareclient.com` | HC, TS | HC:2709; TS:2709 |
| 56 | `cloudflarecp.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 57 | `cloudflareok.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 58 | `cloudflareportal.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 59 | `cohere.com` | HC, TS | HC:2709; TS:2709 |
| 60 | `connect.facebook.net` | HC, TS, QI | HC:2709; TS:2709; QI:2709 |
| 61 | `connectivity.cloudflareclient.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 62 | `copilot.com` | HC, TS | HC:2709; TS:2709 |
| 63 | `copilot.microsoft.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 64 | `core.telegram.org` | **NONE** | NO FOUND |
| 65 | `dailymotion.com` | TS | TS:2709 |
| 66 | `dailymotionapi.com` | **NONE** | NO FOUND |
| 67 | `deepseek.com` | HC, TS | HC:2709; TS:2709 |
| 68 | `desktop.telegram.org` | **NONE** | NO FOUND |
| 69 | `dev.azure.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 70 | `discord-activities.com` | **NONE** | NO FOUND |
| 71 | `discord-attachments-uploads-prd.storage.googleapis.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 72 | `discord.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 73 | `discord.gg` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 74 | `discord.media` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 75 | `discordactivities.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 76 | `discordapp.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 77 | `discordapp.net` | **NONE** | NO FOUND |
| 78 | `discordcdn.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 79 | `discordstatus.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 80 | `dmcdn.net` | HC | HC:2709 |
| 81 | `ea.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 82 | `engage.cloudflareclient.com` | TS | TS:2609+2709 |
| 83 | `epicgames.com` | TS, TF | TS:2609; TF:2709 |
| 84 | `epicgames.dev` | TS | TS:2709 |
| 85 | `epicgamescdn.com` | **NONE** | NO FOUND |
| 86 | `f.vimeocdn.com` | HC | HC:2709 |
| 87 | `facebook.com` | ME, TS, QF | ME:2609; TS:2609; QF:2609 |
| 88 | `fbcdn.net` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 89 | `fbsbx.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 90 | `fonts.googleapis.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 91 | `fonts.gstatic.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 92 | `gateway.reddit.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 93 | `gemini.google.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 94 | `generativelanguage.googleapis.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 95 | `ggpht.com` | **NONE** | NO FOUND |
| 96 | `gist.github.com` | HC, TS | HC:2709; TS:2709 |
| 97 | `github.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 98 | `githubassets.com` | **NONE** | NO FOUND |
| 99 | `githubusercontent.com` | **NONE** | NO FOUND |
| 100 | `google-analytics.com` | TS, QF | TS:2709; QF:2709 |
| 101 | `google.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 102 | `googleadservices.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 103 | `googleapis.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 104 | `googleusercontent.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 105 | `googlevideo.com` | **NONE** | NO FOUND |
| 106 | `graph.facebook.com` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 107 | `graph.instagram.com` | **NONE** | NO FOUND |
| 108 | `grok.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 109 | `gstatic.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 110 | `gvt1.com` | **NONE** | NO FOUND |
| 111 | `gvt2.com` | **NONE** | NO FOUND |
| 112 | `hdrezka.ac` | **NONE** | NO FOUND |
| 113 | `hdrezka.ag` | TS | TS:2709 |
| 114 | `hdrezka.co` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 115 | `hdrezka.cx` | **NONE** | NO FOUND |
| 116 | `hdrezka.info` | ME | ME:2709 |
| 117 | `hdrezka.ink` | ME, QF | ME:2709; QF:2709 |
| 118 | `hdrezka.live` | **NONE** | NO FOUND |
| 119 | `hdrezka.me` | ME, TS | ME:2709; TS:2709 |
| 120 | `hdrezka.no` | **NONE** | NO FOUND |
| 121 | `hdrezka.one` | ME | ME:2709 |
| 122 | `hdrezka.run` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 123 | `hdrezka.sh` | ME, TS | ME:2709; TS:2709 |
| 124 | `hdrezka.tv` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 125 | `hdrezka.website` | ME, TS | ME:2709; TS:2709 |
| 126 | `hdrezka.zone` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 127 | `hdrzk.org` | HC, TS, TC | HC:2709; TS:2709; TC:2709 |
| 128 | `hq.hdrezka.info` | ME | ME:2709 |
| 129 | `huggingface.co` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 130 | `i.instagram.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 131 | `i.vimeocdn.com` | HC | HC:2709 |
| 132 | `i.ytimg.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 133 | `ibytedtos.com` | **NONE** | NO FOUND |
| 134 | `ibytedtos.com.akamaized.net` | **NONE** | NO FOUND |
| 135 | `instagram.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 136 | `jtvnw.net` | **NONE** | NO FOUND |
| 137 | `kick.com` | HC, QF | HC:2709; QF:2709 |
| 138 | `kickcdn.com` | **NONE** | NO FOUND |
| 139 | `kimi.com` | HC | HC:2709 |
| 140 | `kinozal.tv` | **NONE** | NO FOUND |
| 141 | `linkedin.com` | ME, TS, QF | ME:2609+2709; TS:2609; QF:2609+2709 |
| 142 | `live.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 143 | `llama.com` | **NONE** | NO FOUND |
| 144 | `login.live.com` | **NONE** | NO FOUND |
| 145 | `login.microsoftonline.com` | TS | TS:2609+2709 |
| 146 | `m.facebook.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 147 | `m.youtube.com` | HC, QF | HC:2709; QF:2709 |
| 148 | `media.discordapp.net` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 149 | `media.licdn.com` | HC, TS, TC, QF | HC:2709; TS:2709; TC:2709; QF:2709 |
| 150 | `medium.com` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 151 | `meta.ai` | HC, TS | HC:2709; TS:2709 |
| 152 | `microsoft.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 153 | `microsoft365.com` | TS | TS:2609+2709 |
| 154 | `microsoftonline.com` | **NONE** | NO FOUND |
| 155 | `mistral.ai` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 156 | `moonshot.ai` | HC, TS | HC:2709; TS:2709 |
| 157 | `muscdn.com` | **NONE** | NO FOUND |
| 158 | `muscdn.com.akamaized.net` | **NONE** | NO FOUND |
| 159 | `netflix.ca` | TS | TS:2709 |
| 160 | `netflix.com` | HC | HC:2709 |
| 161 | `netflix.net` | TS | TS:2709 |
| 162 | `nflxext.com` | **NONE** | NO FOUND |
| 163 | `nflximg.com` | **NONE** | NO FOUND |
| 164 | `nflximg.net` | **NONE** | NO FOUND |
| 165 | `nflxvideo.net` | **NONE** | NO FOUND |
| 166 | `nintendo.com` | HC | HC:2609+2709 |
| 167 | `nnm-club.name` | **NONE** | NO FOUND |
| 168 | `nnmclub.to` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2709 |
| 169 | `notifications.cloudflareclient.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 170 | `oaistatic.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 171 | `oaiusercontent.com` | **NONE** | NO FOUND |
| 172 | `oauth.reddit.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 173 | `objects.githubusercontent.com` | HC, TS | HC:2709; TS:2709 |
| 174 | `office.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 175 | `office365.com` | HC, TS, TF | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 176 | `old.reddit.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 177 | `onedrive.com` | HC, TS, TF | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 178 | `open.spotify.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 179 | `openai.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 180 | `outlook.com` | HC, TS, TF | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 181 | `outlook.office.com` | HC, TS, TF, QF | HC:2609+2709; TS:2609+2709; TF:2609+2709; QF:2609+2709 |
| 182 | `pbs.twimg.com` | ME, TS | ME:2709; TS:2709 |
| 183 | `perplexity.ai` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 184 | `play.google.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 185 | `playback.media-streaming.soundcloud.cloud` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 186 | `playstation.com` | **NONE** | NO FOUND |
| 187 | `poe.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 188 | `portal.azure.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 189 | `qwen.ai` | TS | TS:2709 |
| 190 | `qwenchat.ai` | HC | HC:2709 |
| 191 | `raw.githubusercontent.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 192 | `redd.it` | HC, QF | HC:2709; QF:2709 |
| 193 | `reddit.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 194 | `redditmedia.com` | TS, QF | TS:2709; QF:2709 |
| 195 | `replicate.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 196 | `rezka-ua.tv` | ME, TS | ME:2709; TS:2709 |
| 197 | `rezka.ag` | ME, TS | ME:2709; TS:2709 |
| 198 | `rezka.io` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 199 | `rumble.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 200 | `rustorka.com` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 201 | `rutor.info` | ME | ME:2609 |
| 202 | `rutracker.org` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 203 | `s.ytimg.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 204 | `scontent.cdninstagram.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 205 | `scontent.xx.fbcdn.net` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 206 | `sharepoint.com` | TS, QI | TS:2609+2709; QI:2609+2709 |
| 207 | `sharepointonline.com` | **NONE** | NO FOUND |
| 208 | `skype.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 209 | `sndcdn.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 210 | `soundcloud.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 211 | `spotify.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 212 | `spotifycdn.com` | **NONE** | NO FOUND |
| 213 | `stability.ai` | HC, TS | HC:2709; TS:2709 |
| 214 | `static.hdrezka.ag` | **NONE** | NO FOUND |
| 215 | `static.microsoft` | **NONE** | NO FOUND |
| 216 | `steamcommunity.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 217 | `steamcontent.com` | **NONE** | NO FOUND |
| 218 | `steampowered.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 219 | `steamstatic.com` | **NONE** | NO FOUND |
| 220 | `store.steampowered.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 221 | `streamable.com` | ME | ME:2709 |
| 222 | `style.sndcdn.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 223 | `t.co` | ME, TS | ME:2709; TS:2709 |
| 224 | `t.me` | **NONE** | NO FOUND |
| 225 | `tapochek.net` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 226 | `teams.live.com` | HC, TS, TF, QF | HC:2609+2709; TS:2609+2709; TF:2709; QF:2709 |
| 227 | `teams.microsoft.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 228 | `telegram-cdn.org` | **NONE** | NO FOUND |
| 229 | `telegram.me` | **NONE** | NO FOUND |
| 230 | `telegram.org` | **NONE** | NO FOUND |
| 231 | `tiktok.com` | HC | HC:2609+2709 |
| 232 | `tiktokcdn.com` | **NONE** | NO FOUND |
| 233 | `tiktokv.com` | HC, QF | HC:2709; QF:2709 |
| 234 | `together.ai` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 235 | `torrents.ru` | HC | HC:2609+2709 |
| 236 | `ttvnw.net` | **NONE** | NO FOUND |
| 237 | `twitch.tv` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 238 | `twitchcdn.net` | **NONE** | NO FOUND |
| 239 | `twitter.com` | ME, TS | ME:2609+2709; TS:2609+2709 |
| 240 | `usercontent.microsoft` | **NONE** | NO FOUND |
| 241 | `v.whatsapp.net` | HC, TS | HC:2709; TS:2709 |
| 242 | `video.twimg.com` | ME, TS | ME:2709; TS:2709 |
| 243 | `vimeo.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 244 | `vimeocdn.com` | HC | HC:2709 |
| 245 | `visualstudio.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 246 | `wa.me` | **NONE** | NO FOUND |
| 247 | `warp.plus` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 248 | `web.telegram.org` | **NONE** | NO FOUND |
| 249 | `web.whatsapp.com` | **NONE** | NO FOUND |
| 250 | `whatsapp-cdn.net` | **NONE** | NO FOUND |
| 251 | `whatsapp.com` | **NONE** | NO FOUND |
| 252 | `whatsapp.net` | HC, TS, QF | HC:2609; TS:2609; QF:2609 |
| 253 | `windows.com` | TS | TS:2609+2709 |
| 254 | `windowsupdate.com` | **NONE** | NO FOUND |
| 255 | `ws.chatgpt.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 256 | `www.cloudflare.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 257 | `www.dailymotion.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 258 | `www.ea.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 259 | `www.epicgames.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 260 | `www.facebook.com` | **NONE** | NO FOUND |
| 261 | `www.github.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 262 | `www.google.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 263 | `www.instagram.com` | ME, TS | ME:2609+2709; TS:2609+2709 |
| 264 | `www.kick.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 265 | `www.linkedin.com` | ME, TS, QF | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 266 | `www.medium.com` | ME, TS, QF | ME:2709; TS:2709; QF:2709 |
| 267 | `www.microsoft.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 268 | `www.microsoft365.com` | HC, TS, TF, QF | HC:2609+2709; TS:2609+2709; TF:2609+2709; QF:2609+2709 |
| 269 | `www.netflix.com` | HC, TS | HC:2709; TS:2709 |
| 270 | `www.nintendo.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 271 | `www.office.com` | TS | TS:2609+2709 |
| 272 | `www.office365.com` | HC, TS, TF | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 273 | `www.onedrive.com` | HC, TS, TF | HC:2609+2709; TS:2709; TF:2609+2709 |
| 274 | `www.playstation.com` | HC | HC:2609+2709 |
| 275 | `www.reddit.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 276 | `www.rumble.com` | HC, TS, QF | HC:2709; TS:2709; QF:2709 |
| 277 | `www.soundcloud.com` | HC, TS | HC:2709; TS:2709 |
| 278 | `www.telegram.org` | **NONE** | NO FOUND |
| 279 | `www.tiktok.com` | HC | HC:2709 |
| 280 | `www.twitch.tv` | HC, TS, TF, QF | HC:2609+2709; TS:2609+2709; TF:2609; QF:2609+2709 |
| 281 | `www.vimeo.com` | TS, QF | TS:2709; QF:2709 |
| 282 | `www.whatsapp.com` | HC, TS, QF | HC:2609; TS:2609; QF:2609 |
| 283 | `www.x.com` | HC, TS | HC:2709; TS:2709 |
| 284 | `www.xbox.com` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 285 | `www.youtube.com` | HC, QF | HC:2609+2709; QF:2609+2709 |
| 286 | `x.ai` | HC, TS | HC:2709; TS:2709 |
| 287 | `x.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 288 | `xbox.com` | HC, TS | HC:2609+2709; TS:2609+2709 |
| 289 | `xboxlive.com` | **NONE** | NO FOUND |
| 290 | `xboxservices.com` | **NONE** | NO FOUND |
| 291 | `youtu.be` | HC, TS, QF | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 292 | `youtube.com` | HC, QF | HC:2609+2709; QF:2609+2709 |
| 293 | `youtube.googleapis.com` | HC, QF | HC:2609+2709; QF:2609+2709 |
| 294 | `youtube.ru` | HC, QF | HC:2609+2709; QF:2609+2709 |
| 295 | `youtubei.googleapis.com` | HC, QF | HC:2609+2709; QF:2609+2709 |
| 296 | `ytimg.com` | **NONE** | NO FOUND |
| 297 | `zero-trust-client.cloudflare.com` | **NONE** | NO FOUND |

## 6. Домены без explicit FOUND

Всего: **72** из 297 тестовых целей.

- `1.1.1.1`
- `api.epicgames.com`
- `api.telegram.org`
- `audio4.spotifycdn.com`
- `azureedge.net`
- `azurefd.net`
- `b-graph.facebook.com`
- `battle.net`
- `bytefcdn-oversea.com`
- `byteoversea.com`
- `cdn-telegram.org`
- `cdninstagram.com`
- `core.telegram.org`
- `dailymotionapi.com`
- `desktop.telegram.org`
- `discord-activities.com`
- `discordapp.net`
- `epicgamescdn.com`
- `ggpht.com`
- `githubassets.com`
- `githubusercontent.com`
- `googlevideo.com`
- `graph.instagram.com`
- `gvt1.com`
- `gvt2.com`
- `hdrezka.ac`
- `hdrezka.cx`
- `hdrezka.live`
- `hdrezka.no`
- `ibytedtos.com`
- `ibytedtos.com.akamaized.net`
- `jtvnw.net`
- `kickcdn.com`
- `kinozal.tv`
- `llama.com`
- `login.live.com`
- `microsoftonline.com`
- `muscdn.com`
- `muscdn.com.akamaized.net`
- `nflxext.com`
- `nflximg.com`
- `nflximg.net`
- `nflxvideo.net`
- `nnm-club.name`
- `oaiusercontent.com`
- `playstation.com`
- `sharepointonline.com`
- `spotifycdn.com`
- `static.hdrezka.ag`
- `static.microsoft`
- `steamcontent.com`
- `steamstatic.com`
- `t.me`
- `telegram-cdn.org`
- `telegram.me`
- `telegram.org`
- `tiktokcdn.com`
- `ttvnw.net`
- `twitchcdn.net`
- `usercontent.microsoft`
- `wa.me`
- `web.telegram.org`
- `web.whatsapp.com`
- `whatsapp-cdn.net`
- `whatsapp.com`
- `windowsupdate.com`
- `www.facebook.com`
- `www.telegram.org`
- `xboxlive.com`
- `xboxservices.com`
- `ytimg.com`
- `zero-trust-client.cloudflare.com`

Эти домены не следует искусственно привязывать к стратегии только потому, что похожие домены имеют FOUND.

## 7. Минимальное точное покрытие explicit-FOUND доменов

Задача set-cover:
> выбрать минимальное число отдельных strategy-классов, объединение доменов которых покрывает все 225 уникальных домена с хотя бы одной explicit FOUND-стратегией.

**Математический минимум = 4 strategy classes.**

Минимальные решения:
- HC + ME + TS + TF
- HC + ME + TS + QF

Два эквивалентных минимальных решения существуют:
- HC + ME + TS + QF
- HC + ME + TS + TF

Это **математический минимум покрытия evidence-доменов**, а не доказательство, что на hAP достаточно ровно четырёх runtime-профилей для всех приложений.

Причина осторожности: blockcheck-result относится к конкретному L7-протоколу. HTTP FOUND не является TLS FOUND, TLS FOUND не является QUIC FOUND.

## 8. Практический минимальный каркас для hAP

Для дальнейшего controlled runtime validation выбран структурно простой 4-profile каркас:

### Profile P1 — HTTP ME
L7: HTTP, TCP/80
Strategy: `http_methodeol`
Hostlist: домены, для которых ME найден.

Количество доменов: 44

### Profile P2 — HTTP HC
L7: HTTP, TCP/80
Strategy: `http_hostcase`
Hostlist: домены, где HC найден **и ME не найден**, чтобы не создавать неопределённый overlap между двумя HTTP-профилями.

Количество доменов: 159

### Profile P3 — TLS TS
L7: TLS, TCP/443
Strategy: `tcpseg:pos=0,-1:seqovl=1 + drop`
Hostlist: все домены, для которых TS найден.

Количество доменов: 194

### Profile P4 — QUIC QF
L7: QUIC, UDP/443
Strategy: `fake_default_quic:repeats=11`
Hostlist: все домены, для которых QF найден.

Количество доменов: 111

### Почему здесь 4 профиля, а не 1

HC и ME — две разные HTTP стратегии. TS — TLS strategy. QF — QUIC strategy. Их нельзя считать одной и той же стратегией только потому, что часть доменов имеет несколько FOUND.

В nfqws2 разные мультистратегии разделяются профилями через `--new`, а hostlist используется как фильтр; профиль с autohostlist имеет отдельную семантику. Поэтому минимальный evidence-cover нельзя реализовать одним глобальным desync без изменения логики выбранных стратегий. Официальная документация zapret2 подтверждает модель multiple profiles + hostlists.  
https://github.com/bol-van/zapret2/blob/master/docs/readme.md

## 9. Важное ограничение минимального каркаса

Этот 4-profile каркас **не означает**, что TF/QI/TC больше не нужны.

Они остаются доказанными fallback/special вариантами:

- TF — TLS fallback;
- QI — QUIC special fallback;
- TC — специальная TLS1.2 стратегия;
- HF — high-coverage HTTP candidate без explicit FOUND.

До runtime-проверки на hAP нельзя удалять их из evidence-базы и нельзя объявлять P1–P4 универсальными.

## 10. Hostlist overlap policy

Для текущего 4-profile каркаса:

1. ME получает HTTP-домены с найденным ME.
2. HC получает только HTTP-домены с HC и **без ME**.
3. TS получает все домены с TS.
4. QF получает все домены с QF.

Это только стартовая deterministic assignment. Она не отменяет исходную полную матрицу: домен, у которого найдено несколько стратегий, по-прежнему сохраняет все результаты в таблице выше.

## 11. Список доменов по минимальным профилям

### P1 — ME
- `abs.twimg.com`
- `api.linkedin.com`
- `api.twitter.com`
- `cdn-images-1.medium.com`
- `cdn-images-2.medium.com`
- `facebook.com`
- `fbcdn.net`
- `fbsbx.com`
- `googleadservices.com`
- `graph.facebook.com`
- `hdrezka.co`
- `hdrezka.info`
- `hdrezka.ink`
- `hdrezka.me`
- `hdrezka.one`
- `hdrezka.run`
- `hdrezka.sh`
- `hdrezka.tv`
- `hdrezka.website`
- `hdrezka.zone`
- `hq.hdrezka.info`
- `i.instagram.com`
- `instagram.com`
- `linkedin.com`
- `m.facebook.com`
- `medium.com`
- `nnmclub.to`
- `pbs.twimg.com`
- `rezka-ua.tv`
- `rezka.ag`
- `rezka.io`
- `rustorka.com`
- `rutor.info`
- `rutracker.org`
- `scontent.cdninstagram.com`
- `scontent.xx.fbcdn.net`
- `streamable.com`
- `t.co`
- `twitter.com`
- `video.twimg.com`
- `www.dailymotion.com`
- `www.instagram.com`
- `www.linkedin.com`
- `www.medium.com`

### P2 — HC-only (HC без ME)
- `a-v2.sndcdn.com`
- `account.microsoft.com`
- `accounts.google.com`
- `ai.google.dev`
- `ai21.com`
- `anthropic.com`
- `api.deepseek.com`
- `api.devices.cloudflare.com`
- `api.github.com`
- `api.mistral.ai`
- `api.openai.com`
- `api.perplexity.ai`
- `api.spotify.com`
- `api.steampowered.com`
- `api.vimeo.com`
- `api.whatsapp.com`
- `api.x.ai`
- `assets.web.soundcloud.cloud`
- `avatars.githubusercontent.com`
- `bing.com`
- `blizzard.com`
- `camo.githubusercontent.com`
- `cdn.discordapp.com`
- `cdn.steamstatic.com`
- `character.ai`
- `chat.deepseek.com`
- `chat.mistral.ai`
- `chatgpt.com`
- `cloud.microsoft`
- `cloudflare-dns.com`
- `cloudflare.com`
- `cloudflareclient.com`
- `cloudflarecp.com`
- `cloudflareok.com`
- `cloudflareportal.com`
- `cohere.com`
- `connect.facebook.net`
- `connectivity.cloudflareclient.com`
- `copilot.com`
- `copilot.microsoft.com`
- `deepseek.com`
- `dev.azure.com`
- `discord-attachments-uploads-prd.storage.googleapis.com`
- `discord.com`
- `discord.gg`
- `discord.media`
- `discordactivities.com`
- `discordapp.com`
- `discordcdn.com`
- `discordstatus.com`
- `dmcdn.net`
- `ea.com`
- `f.vimeocdn.com`
- `fonts.googleapis.com`
- `fonts.gstatic.com`
- `gateway.reddit.com`
- `gemini.google.com`
- `generativelanguage.googleapis.com`
- `gist.github.com`
- `github.com`
- `google.com`
- `googleapis.com`
- `googleusercontent.com`
- `grok.com`
- `gstatic.com`
- `hdrzk.org`
- `huggingface.co`
- `i.vimeocdn.com`
- `i.ytimg.com`
- `kick.com`
- `kimi.com`
- `live.com`
- `m.youtube.com`
- `media.discordapp.net`
- `media.licdn.com`
- `meta.ai`
- `microsoft.com`
- `mistral.ai`
- `moonshot.ai`
- `netflix.com`
- `nintendo.com`
- `notifications.cloudflareclient.com`
- `oaistatic.com`
- `oauth.reddit.com`
- `objects.githubusercontent.com`
- `office.com`
- `office365.com`
- `old.reddit.com`
- `onedrive.com`
- `open.spotify.com`
- `openai.com`
- `outlook.com`
- `outlook.office.com`
- `perplexity.ai`
- `play.google.com`
- `playback.media-streaming.soundcloud.cloud`
- `poe.com`
- `portal.azure.com`
- `qwenchat.ai`
- `raw.githubusercontent.com`
- `redd.it`
- `reddit.com`
- `replicate.com`
- `rumble.com`
- `s.ytimg.com`
- `skype.com`
- `sndcdn.com`
- `soundcloud.com`
- `spotify.com`
- `stability.ai`
- `steamcommunity.com`
- `steampowered.com`
- `store.steampowered.com`
- `style.sndcdn.com`
- `tapochek.net`
- `teams.live.com`
- `teams.microsoft.com`
- `tiktok.com`
- `tiktokv.com`
- `together.ai`
- `torrents.ru`
- `twitch.tv`
- `v.whatsapp.net`
- `vimeo.com`
- `vimeocdn.com`
- `visualstudio.com`
- `warp.plus`
- `whatsapp.net`
- `ws.chatgpt.com`
- `www.cloudflare.com`
- `www.ea.com`
- `www.epicgames.com`
- `www.github.com`
- `www.google.com`
- `www.kick.com`
- `www.microsoft.com`
- `www.microsoft365.com`
- `www.netflix.com`
- `www.nintendo.com`
- `www.office365.com`
- `www.onedrive.com`
- `www.playstation.com`
- `www.reddit.com`
- `www.rumble.com`
- `www.soundcloud.com`
- `www.tiktok.com`
- `www.twitch.tv`
- `www.whatsapp.com`
- `www.x.com`
- `www.xbox.com`
- `www.youtube.com`
- `x.ai`
- `x.com`
- `xbox.com`
- `youtu.be`
- `youtube.com`
- `youtube.googleapis.com`
- `youtube.ru`
- `youtubei.googleapis.com`

### P3 — TS
- `a-v2.sndcdn.com`
- `abs.twimg.com`
- `account.microsoft.com`
- `accounts.google.com`
- `ai.google.dev`
- `ai21.com`
- `anthropic.com`
- `api.anthropic.com`
- `api.cloudflare.com`
- `api.deepseek.com`
- `api.devices.cloudflare.com`
- `api.github.com`
- `api.linkedin.com`
- `api.mistral.ai`
- `api.openai.com`
- `api.perplexity.ai`
- `api.spotify.com`
- `api.twitter.com`
- `api.vimeo.com`
- `api.whatsapp.com`
- `api.x.ai`
- `assets.web.soundcloud.cloud`
- `avatars.githubusercontent.com`
- `azure.com`
- `bing.com`
- `camo.githubusercontent.com`
- `cdn-images-1.medium.com`
- `cdn-images-2.medium.com`
- `cdn.discordapp.com`
- `cdn.steamstatic.com`
- `character.ai`
- `chat.mistral.ai`
- `chat.openai.com`
- `chatgpt.com`
- `claudeusercontent.com`
- `cloud.microsoft`
- `cloudflare-dns.com`
- `cloudflare.com`
- `cloudflareclient.com`
- `cloudflarecp.com`
- `cloudflareok.com`
- `cloudflareportal.com`
- `cohere.com`
- `connect.facebook.net`
- `connectivity.cloudflareclient.com`
- `copilot.com`
- `copilot.microsoft.com`
- `dailymotion.com`
- `deepseek.com`
- `dev.azure.com`
- `discord-attachments-uploads-prd.storage.googleapis.com`
- `discord.com`
- `discord.gg`
- `discord.media`
- `discordactivities.com`
- `discordapp.com`
- `discordcdn.com`
- `discordstatus.com`
- `ea.com`
- `engage.cloudflareclient.com`
- `epicgames.com`
- `epicgames.dev`
- `facebook.com`
- `fbcdn.net`
- `fbsbx.com`
- `fonts.googleapis.com`
- `fonts.gstatic.com`
- `gateway.reddit.com`
- `gemini.google.com`
- `generativelanguage.googleapis.com`
- `gist.github.com`
- `github.com`
- `google-analytics.com`
- `google.com`
- `googleadservices.com`
- `googleapis.com`
- `googleusercontent.com`
- `graph.facebook.com`
- `grok.com`
- `gstatic.com`
- `hdrezka.ag`
- `hdrezka.co`
- `hdrezka.me`
- `hdrezka.run`
- `hdrezka.sh`
- `hdrezka.tv`
- `hdrezka.website`
- `hdrezka.zone`
- `hdrzk.org`
- `huggingface.co`
- `i.instagram.com`
- `i.ytimg.com`
- `instagram.com`
- `linkedin.com`
- `live.com`
- `login.microsoftonline.com`
- `m.facebook.com`
- `media.discordapp.net`
- `media.licdn.com`
- `medium.com`
- `meta.ai`
- `microsoft.com`
- `microsoft365.com`
- `mistral.ai`
- `moonshot.ai`
- `netflix.ca`
- `netflix.net`
- `nnmclub.to`
- `notifications.cloudflareclient.com`
- `oaistatic.com`
- `oauth.reddit.com`
- `objects.githubusercontent.com`
- `office.com`
- `office365.com`
- `old.reddit.com`
- `onedrive.com`
- `open.spotify.com`
- `openai.com`
- `outlook.com`
- `outlook.office.com`
- `pbs.twimg.com`
- `perplexity.ai`
- `play.google.com`
- `playback.media-streaming.soundcloud.cloud`
- `poe.com`
- `portal.azure.com`
- `qwen.ai`
- `raw.githubusercontent.com`
- `reddit.com`
- `redditmedia.com`
- `replicate.com`
- `rezka-ua.tv`
- `rezka.ag`
- `rezka.io`
- `rumble.com`
- `rustorka.com`
- `rutracker.org`
- `s.ytimg.com`
- `scontent.cdninstagram.com`
- `scontent.xx.fbcdn.net`
- `sharepoint.com`
- `skype.com`
- `sndcdn.com`
- `soundcloud.com`
- `spotify.com`
- `stability.ai`
- `steamcommunity.com`
- `steampowered.com`
- `store.steampowered.com`
- `style.sndcdn.com`
- `t.co`
- `tapochek.net`
- `teams.live.com`
- `teams.microsoft.com`
- `together.ai`
- `twitch.tv`
- `twitter.com`
- `v.whatsapp.net`
- `video.twimg.com`
- `vimeo.com`
- `visualstudio.com`
- `warp.plus`
- `whatsapp.net`
- `windows.com`
- `ws.chatgpt.com`
- `www.cloudflare.com`
- `www.dailymotion.com`
- `www.ea.com`
- `www.epicgames.com`
- `www.github.com`
- `www.google.com`
- `www.instagram.com`
- `www.kick.com`
- `www.linkedin.com`
- `www.medium.com`
- `www.microsoft.com`
- `www.microsoft365.com`
- `www.netflix.com`
- `www.nintendo.com`
- `www.office.com`
- `www.office365.com`
- `www.onedrive.com`
- `www.reddit.com`
- `www.rumble.com`
- `www.soundcloud.com`
- `www.twitch.tv`
- `www.vimeo.com`
- `www.whatsapp.com`
- `www.x.com`
- `www.xbox.com`
- `x.ai`
- `x.com`
- `xbox.com`
- `youtu.be`

### P4 — QF
- `accounts.google.com`
- `ai.google.dev`
- `ai21.com`
- `anthropic.com`
- `api.linkedin.com`
- `api.mistral.ai`
- `api.openai.com`
- `api.perplexity.ai`
- `api.spotify.com`
- `api.vimeo.com`
- `api.whatsapp.com`
- `cdn-images-1.medium.com`
- `cdn-images-2.medium.com`
- `cdn.discordapp.com`
- `cdn.steamstatic.com`
- `character.ai`
- `claude.ai`
- `claudeusercontent.com`
- `cloudflare-dns.com`
- `cloudflare.com`
- `copilot.microsoft.com`
- `discord-attachments-uploads-prd.storage.googleapis.com`
- `discord.com`
- `discordapp.com`
- `discordstatus.com`
- `ea.com`
- `facebook.com`
- `fbcdn.net`
- `fbsbx.com`
- `fonts.googleapis.com`
- `fonts.gstatic.com`
- `gateway.reddit.com`
- `gemini.google.com`
- `generativelanguage.googleapis.com`
- `google-analytics.com`
- `google.com`
- `googleadservices.com`
- `googleapis.com`
- `googleusercontent.com`
- `graph.facebook.com`
- `grok.com`
- `gstatic.com`
- `hdrezka.co`
- `hdrezka.ink`
- `hdrezka.run`
- `hdrezka.tv`
- `hdrezka.zone`
- `huggingface.co`
- `i.instagram.com`
- `i.ytimg.com`
- `instagram.com`
- `kick.com`
- `linkedin.com`
- `m.facebook.com`
- `m.youtube.com`
- `media.discordapp.net`
- `media.licdn.com`
- `medium.com`
- `mistral.ai`
- `nnmclub.to`
- `oaistatic.com`
- `oauth.reddit.com`
- `old.reddit.com`
- `open.spotify.com`
- `openai.com`
- `outlook.office.com`
- `perplexity.ai`
- `play.google.com`
- `poe.com`
- `redd.it`
- `reddit.com`
- `redditmedia.com`
- `replicate.com`
- `rezka.io`
- `rumble.com`
- `rustorka.com`
- `rutracker.org`
- `s.ytimg.com`
- `scontent.cdninstagram.com`
- `scontent.xx.fbcdn.net`
- `spotify.com`
- `teams.live.com`
- `tiktokv.com`
- `together.ai`
- `twitch.tv`
- `vimeo.com`
- `warp.plus`
- `whatsapp.net`
- `ws.chatgpt.com`
- `www.cloudflare.com`
- `www.dailymotion.com`
- `www.ea.com`
- `www.epicgames.com`
- `www.google.com`
- `www.kick.com`
- `www.linkedin.com`
- `www.medium.com`
- `www.microsoft365.com`
- `www.nintendo.com`
- `www.reddit.com`
- `www.rumble.com`
- `www.twitch.tv`
- `www.vimeo.com`
- `www.whatsapp.com`
- `www.xbox.com`
- `www.youtube.com`
- `youtu.be`
- `youtube.com`
- `youtube.googleapis.com`
- `youtube.ru`
- `youtubei.googleapis.com`

## 12. Домены с несколькими explicit FOUND стратегиями

Такие домены особенно важны для дальнейшей проверки fallback/overlap:

- `a-v2.sndcdn.com` → HC, TS
- `abs.twimg.com` → ME, TS
- `account.microsoft.com` → HC, TS
- `accounts.google.com` → HC, TS, QF
- `ai.google.dev` → HC, TS, QF
- `ai21.com` → HC, TS, QF
- `anthropic.com` → HC, TS, QF
- `api.deepseek.com` → HC, TS
- `api.devices.cloudflare.com` → HC, TS
- `api.github.com` → HC, TS
- `api.linkedin.com` → ME, TS, QF
- `api.mistral.ai` → HC, TS, QF
- `api.openai.com` → HC, TS, QF
- `api.perplexity.ai` → HC, TS, TF, QF
- `api.spotify.com` → HC, TS, QF
- `api.twitter.com` → ME, TS
- `api.vimeo.com` → HC, TS, QF
- `api.whatsapp.com` → HC, TS, QF
- `api.x.ai` → HC, TS
- `assets.web.soundcloud.cloud` → HC, TS
- `avatars.githubusercontent.com` → HC, TS
- `azure.com` → TS, TF
- `bing.com` → HC, TS
- `camo.githubusercontent.com` → HC, TS
- `cdn-images-1.medium.com` → ME, TS, QF
- `cdn-images-2.medium.com` → ME, TS, QF
- `cdn.discordapp.com` → HC, TS, QF
- `cdn.steamstatic.com` → HC, TS, QF
- `character.ai` → HC, TS, QF
- `chat.mistral.ai` → HC, TS
- `chatgpt.com` → HC, TS
- `claude.ai` → TF, QF
- `claudeusercontent.com` → TS, QF
- `cloud.microsoft` → HC, TS
- `cloudflare-dns.com` → HC, TS, TF, QF
- `cloudflare.com` → HC, TS, TF, QF
- `cloudflareclient.com` → HC, TS
- `cloudflarecp.com` → HC, TS
- `cloudflareok.com` → HC, TS
- `cloudflareportal.com` → HC, TS
- `cohere.com` → HC, TS
- `connect.facebook.net` → HC, TS, QI
- `connectivity.cloudflareclient.com` → HC, TS
- `copilot.com` → HC, TS
- `copilot.microsoft.com` → HC, TS, QF
- `deepseek.com` → HC, TS
- `dev.azure.com` → HC, TS
- `discord-attachments-uploads-prd.storage.googleapis.com` → HC, TS, QF
- `discord.com` → HC, TS, QF
- `discord.gg` → HC, TS
- `discord.media` → HC, TS
- `discordactivities.com` → HC, TS
- `discordapp.com` → HC, TS, QF
- `discordcdn.com` → HC, TS
- `discordstatus.com` → HC, TS, QF
- `ea.com` → HC, TS, QF
- `epicgames.com` → TS, TF
- `facebook.com` → ME, TS, QF
- `fbcdn.net` → ME, TS, QF
- `fbsbx.com` → ME, TS, QF
- `fonts.googleapis.com` → HC, TS, QF
- `fonts.gstatic.com` → HC, TS, QF
- `gateway.reddit.com` → HC, TS, QF
- `gemini.google.com` → HC, TS, QF
- `generativelanguage.googleapis.com` → HC, TS, QF
- `gist.github.com` → HC, TS
- `github.com` → HC, TS
- `google-analytics.com` → TS, QF
- `google.com` → HC, TS, QF
- `googleadservices.com` → ME, TS, QF
- `googleapis.com` → HC, TS, QF
- `googleusercontent.com` → HC, TS, QF
- `graph.facebook.com` → ME, TS, QF
- `grok.com` → HC, TS, QF
- `gstatic.com` → HC, TS, QF
- `hdrezka.co` → ME, TS, QF
- `hdrezka.ink` → ME, QF
- `hdrezka.me` → ME, TS
- `hdrezka.run` → ME, TS, QF
- `hdrezka.sh` → ME, TS
- `hdrezka.tv` → ME, TS, QF
- `hdrezka.website` → ME, TS
- `hdrezka.zone` → ME, TS, QF
- `hdrzk.org` → HC, TS, TC
- `huggingface.co` → HC, TS, QF
- `i.instagram.com` → ME, TS, QF
- `i.ytimg.com` → HC, TS, QF
- `instagram.com` → ME, TS, QF
- `kick.com` → HC, QF
- `linkedin.com` → ME, TS, QF
- `live.com` → HC, TS
- `m.facebook.com` → ME, TS, QF
- `m.youtube.com` → HC, QF
- `media.discordapp.net` → HC, TS, QF
- `media.licdn.com` → HC, TS, TC, QF
- `medium.com` → ME, TS, QF
- `meta.ai` → HC, TS
- `microsoft.com` → HC, TS
- `mistral.ai` → HC, TS, QF
- `moonshot.ai` → HC, TS
- `nnmclub.to` → ME, TS, QF
- `notifications.cloudflareclient.com` → HC, TS
- `oaistatic.com` → HC, TS, QF
- `oauth.reddit.com` → HC, TS, QF
- `objects.githubusercontent.com` → HC, TS
- `office.com` → HC, TS
- `office365.com` → HC, TS, TF
- `old.reddit.com` → HC, TS, QF
- `onedrive.com` → HC, TS, TF
- `open.spotify.com` → HC, TS, QF
- `openai.com` → HC, TS, QF
- `outlook.com` → HC, TS, TF
- `outlook.office.com` → HC, TS, TF, QF
- `pbs.twimg.com` → ME, TS
- `perplexity.ai` → HC, TS, QF
- `play.google.com` → HC, TS, QF
- `playback.media-streaming.soundcloud.cloud` → HC, TS
- `poe.com` → HC, TS, QF
- `portal.azure.com` → HC, TS
- `raw.githubusercontent.com` → HC, TS
- `redd.it` → HC, QF
- `reddit.com` → HC, TS, QF
- `redditmedia.com` → TS, QF
- `replicate.com` → HC, TS, QF
- `rezka-ua.tv` → ME, TS
- `rezka.ag` → ME, TS
- `rezka.io` → ME, TS, QF
- `rumble.com` → HC, TS, QF
- `rustorka.com` → ME, TS, QF
- `rutracker.org` → ME, TS, QF
- `s.ytimg.com` → HC, TS, QF
- `scontent.cdninstagram.com` → ME, TS, QF
- `scontent.xx.fbcdn.net` → ME, TS, QF
- `sharepoint.com` → TS, QI
- `skype.com` → HC, TS
- `sndcdn.com` → HC, TS
- `soundcloud.com` → HC, TS
- `spotify.com` → HC, TS, QF
- `stability.ai` → HC, TS
- `steamcommunity.com` → HC, TS
- `steampowered.com` → HC, TS
- `store.steampowered.com` → HC, TS
- `style.sndcdn.com` → HC, TS
- `t.co` → ME, TS
- `tapochek.net` → HC, TS
- `teams.live.com` → HC, TS, TF, QF
- `teams.microsoft.com` → HC, TS
- `tiktokv.com` → HC, QF
- `together.ai` → HC, TS, QF
- `twitch.tv` → HC, TS, QF
- `twitter.com` → ME, TS
- `v.whatsapp.net` → HC, TS
- `video.twimg.com` → ME, TS
- `vimeo.com` → HC, TS, QF
- `visualstudio.com` → HC, TS
- `warp.plus` → HC, TS, QF
- `whatsapp.net` → HC, TS, QF
- `ws.chatgpt.com` → HC, TS, QF
- `www.cloudflare.com` → HC, TS, QF
- `www.dailymotion.com` → ME, TS, QF
- `www.ea.com` → HC, TS, QF
- `www.epicgames.com` → HC, TS, QF
- `www.github.com` → HC, TS
- `www.google.com` → HC, TS, QF
- `www.instagram.com` → ME, TS
- `www.kick.com` → HC, TS, QF
- `www.linkedin.com` → ME, TS, QF
- `www.medium.com` → ME, TS, QF
- `www.microsoft.com` → HC, TS
- `www.microsoft365.com` → HC, TS, TF, QF
- `www.netflix.com` → HC, TS
- `www.nintendo.com` → HC, TS, QF
- `www.office365.com` → HC, TS, TF
- `www.onedrive.com` → HC, TS, TF
- `www.reddit.com` → HC, TS, QF
- `www.rumble.com` → HC, TS, QF
- `www.soundcloud.com` → HC, TS
- `www.twitch.tv` → HC, TS, TF, QF
- `www.vimeo.com` → TS, QF
- `www.whatsapp.com` → HC, TS, QF
- `www.x.com` → HC, TS
- `www.xbox.com` → HC, TS, QF
- `www.youtube.com` → HC, QF
- `x.ai` → HC, TS
- `x.com` → HC, TS
- `xbox.com` → HC, TS
- `youtu.be` → HC, TS, QF
- `youtube.com` → HC, QF
- `youtube.googleapis.com` → HC, QF
- `youtube.ru` → HC, QF
- `youtubei.googleapis.com` → HC, QF

## 13. Домены, где explicit FOUND только один

### TS only (14)
- `api.anthropic.com`
- `api.cloudflare.com`
- `chat.openai.com`
- `dailymotion.com`
- `engage.cloudflareclient.com`
- `epicgames.dev`
- `hdrezka.ag`
- `login.microsoftonline.com`
- `microsoft365.com`
- `netflix.ca`
- `netflix.net`
- `qwen.ai`
- `windows.com`
- `www.office.com`

### HC only (15)
- `api.steampowered.com`
- `blizzard.com`
- `chat.deepseek.com`
- `dmcdn.net`
- `f.vimeocdn.com`
- `i.vimeocdn.com`
- `kimi.com`
- `netflix.com`
- `nintendo.com`
- `qwenchat.ai`
- `tiktok.com`
- `torrents.ru`
- `vimeocdn.com`
- `www.playstation.com`
- `www.tiktok.com`

### ME only (5)
- `hdrezka.info`
- `hdrezka.one`
- `hq.hdrezka.info`
- `rutor.info`
- `streamable.com`

## 14. Что НЕ следует переносить буквально из WinDivert/winws2

Не переносить на OpenWrt эти Windows interception selectors:

```
--wf-l3=ipv4
--wf-tcp-out=80
--wf-tcp-out=443
--wf-udp-out=443
```

На hAP переносится payload/desync-логика, а interception остаётся в существующей OpenWrt/nfqws2/NFQUEUE архитектуре.

## 15. Следующий этап

**Без изменения роутера:**
1. сопоставить P1–P4 с текущим `NFQWS2_OPT`;
2. определить точные hostlist-файлы и порядок профилей;
3. проверить текущий MODE_FILTER/autohostlist interaction;
4. сделать backup;
5. только затем runtime-test по одному профилю.

Не включать HF/TF/TC/QI одновременно с P1–P4.

## 16. Final evidence state

- Raw 2609/2709 полностью сохранены в репозитории.
- Полная доменная матрица сохранена в этом файле.
- Explicit FOUND и COVERAGE не смешиваются.
- Минимальное математическое evidence-cover: **4 strategy classes**.
- Runtime validation on hAP: **NOT_STARTED**.
- Universal status: **NOT_ESTABLISHED**.
- Router configuration changed by this document: **NO**.

## 17. Upstream technical reference

Официальный zapret2 описывает multi-profile model с `--new`, hostlists и L7-фильтрацией:
https://github.com/bol-van/zapret2/blob/master/docs/readme.md


## 18. S2 — OpenWrt/nfqws2 translation map (DESIGN ONLY)

Дата: 2026-09-27

S2 переводит proven blockcheck2 payload/desync logic в синтаксис текущего zapret2/nfqws2. Windows-only interception selectors из raw log не переносится.

Официальный `zapret2/config.default` использует `NFQWS2_OPT` с отдельными профилями через `--new`, L7 filters и hostlists; такой же принцип применяем здесь. citeturn474984search0turn474984search5

### 18.1. Четыре профиля минимального evidence-cover

Математически минимальный set-cover для 225 explicit-FOUND доменов допускает 4 класса. Для hAP в качестве стартового профиля принимается:

1. **P1 / HTTP-ME** — `http_methodeol`
2. **P2 / HTTP-HC** — `http_hostcase`
3. **P3 / TLS-TS** — `tcpseg:pos=0,-1:seqovl=1 + drop`
4. **P4 / QUIC-QF** — `fake_default_quic:repeats=11`

Это evidence-cover, а не runtime-гарантия.

### 18.2. Exact nfqws2 profile templates

**P1 — HTTP ME**

```
--filter-tcp=80 --filter-l7=http
--hostlist=/etc/zapret2/strategy27/strategy27-me.txt
--payload=http_req
--lua-desync=http_methodeol
--new
```

**P2 — HTTP HC**

```
--filter-tcp=80 --filter-l7=http
--hostlist=/etc/zapret2/strategy27/strategy27-hc.txt
--payload=http_req
--lua-desync=http_hostcase
--new
```

**P3 — TLS TS**

```
--filter-tcp=443 --filter-l7=tls
--hostlist=/etc/zapret2/strategy27/strategy27-ts.txt
--payload=tls_client_hello
--lua-desync=tcpseg:pos=0,-1:seqovl=1
--lua-desync=drop
--new
```

**P4 — QUIC QF**

```
--filter-udp=443 --filter-l7=quic
--hostlist=/etc/zapret2/strategy27/strategy27-qf.txt
--payload=quic_initial
--lua-desync=fake:blob=fake_default_quic:repeats=11
```

Синтаксис сохраняет L7/payload/desync из raw evidence и меняет только механизм interception/hostlist под nfqws2.

### 18.3. Deterministic hostlist assignment

Чтобы не дублировать два HTTP-профиля для одного и того же домена:

- `strategy27-me.txt`: **44** домена с explicit FOUND ME.
- `strategy27-hc.txt`: **159** доменов с explicit FOUND HC и **без** explicit FOUND ME (то есть HC-without-ME, а не «только HC»).
- `strategy27-ts.txt`: **194** домена с explicit FOUND TS.
- `strategy27-qf.txt`: **111** домена с explicit FOUND QF.

Такое распределение оставляет все исходные multi-strategy результаты в полной matrix, но для HTTP выбирает deterministic primary: ME имеет приоритет над HC.

### 18.4. Exact hostlist membership source

Доменные списки должны быть сгенерированы только из explicit FOUND matrix `strategy27.md`, без добавления доменов «по памяти» или по похожему имени.

P1 ME:
```
abs.twimg.com\napi.linkedin.com\napi.twitter.com\ncdn-images-1.medium.com\ncdn-images-2.medium.com\nfacebook.com\nfbcdn.net\nfbsbx.com\ngoogleadservices.com\ngraph.facebook.com\nhdrezka.co\nhdrezka.info\nhdrezka.ink\nhdrezka.me\nhdrezka.one\nhdrezka.run\nhdrezka.sh\nhdrezka.tv\nhdrezka.website\nhdrezka.zone\nhq.hdrezka.info\ni.instagram.com\ninstagram.com\nlinkedin.com\nm.facebook.com\nmedium.com\nnnmclub.to\npbs.twimg.com\nrezka-ua.tv\nrezka.ag\nrezka.io\nrustorka.com\nrutor.info\nrutracker.org\nscontent.cdninstagram.com\nscontent.xx.fbcdn.net\nstreamable.com\nt.co\ntwitter.com\nvideo.twimg.com\nwww.dailymotion.com\nwww.instagram.com\nwww.linkedin.com\nwww.medium.com
```

P2 HC-only:
```
a-v2.sndcdn.com\naccount.microsoft.com\naccounts.google.com\nai.google.dev\nai21.com\nanthropic.com\napi.deepseek.com\napi.devices.cloudflare.com\napi.github.com\napi.mistral.ai\napi.openai.com\napi.perplexity.ai\napi.spotify.com\napi.steampowered.com\napi.vimeo.com\napi.whatsapp.com\napi.x.ai\nassets.web.soundcloud.cloud\navatars.githubusercontent.com\nbing.com\nblizzard.com\ncamo.githubusercontent.com\ncdn.discordapp.com\ncdn.steamstatic.com\ncharacter.ai\nchat.deepseek.com\nchat.mistral.ai\nchatgpt.com\ncloud.microsoft\ncloudflare-dns.com\ncloudflare.com\ncloudflareclient.com\ncloudflarecp.com\ncloudflareok.com\ncloudflareportal.com\ncohere.com\nconnect.facebook.net\nconnectivity.cloudflareclient.com\ncopilot.com\ncopilot.microsoft.com\ndeepseek.com\ndev.azure.com\ndiscord-attachments-uploads-prd.storage.googleapis.com\ndiscord.com\ndiscord.gg\ndiscord.media\ndiscordactivities.com\ndiscordapp.com\ndiscordcdn.com\ndiscordstatus.com\ndmcdn.net\nea.com\nf.vimeocdn.com\nfonts.googleapis.com\nfonts.gstatic.com\ngateway.reddit.com\ngemini.google.com\ngenerativelanguage.googleapis.com\ngist.github.com\ngithub.com\ngoogle.com\ngoogleapis.com\ngoogleusercontent.com\ngrok.com\ngstatic.com\nhdrzk.org\nhuggingface.co\ni.vimeocdn.com\ni.ytimg.com\nkick.com\nkimi.com\nlive.com\nm.youtube.com\nmedia.discordapp.net\nmedia.licdn.com\nmeta.ai\nmicrosoft.com\nmistral.ai\nmoonshot.ai\nnetflix.com\nnintendo.com\nnotifications.cloudflareclient.com\noaistatic.com\noauth.reddit.com\nobjects.githubusercontent.com\noffice.com\noffice365.com\nold.reddit.com\nonedrive.com\nopen.spotify.com\nopenai.com\noutlook.com\noutlook.office.com\nperplexity.ai\nplay.google.com\nplayback.media-streaming.soundcloud.cloud\npoe.com\nportal.azure.com\nqwenchat.ai\nraw.githubusercontent.com\nredd.it\nreddit.com\nreplicate.com\nrumble.com\ns.ytimg.com\nskype.com\nsndcdn.com\nsoundcloud.com\nspotify.com\nstability.ai\nsteamcommunity.com\nsteampowered.com\nstore.steampowered.com\nstyle.sndcdn.com\ntapochek.net\nteams.live.com\nteams.microsoft.com\ntiktok.com\ntiktokv.com\ntogether.ai\ntorrents.ru\ntwitch.tv\nv.whatsapp.net\nvimeo.com\nvimeocdn.com\nvisualstudio.com\nwarp.plus\nwhatsapp.net\nws.chatgpt.com\nwww.cloudflare.com\nwww.ea.com\nwww.epicgames.com\nwww.github.com\nwww.google.com\nwww.kick.com\nwww.microsoft.com\nwww.microsoft365.com\nwww.netflix.com\nwww.nintendo.com\nwww.office365.com\nwww.onedrive.com\nwww.playstation.com\nwww.reddit.com\nwww.rumble.com\nwww.soundcloud.com\nwww.tiktok.com\nwww.twitch.tv\nwww.whatsapp.com\nwww.x.com\nwww.xbox.com\nwww.youtube.com\nx.ai\nx.com\nxbox.com\nyoutu.be\nyoutube.com\nyoutube.googleapis.com\nyoutube.ru\nyoutubei.googleapis.com
```

P3 TS:
```
a-v2.sndcdn.com\nabs.twimg.com\naccount.microsoft.com\naccounts.google.com\nai.google.dev\nai21.com\nanthropic.com\napi.anthropic.com\napi.cloudflare.com\napi.deepseek.com\napi.devices.cloudflare.com\napi.github.com\napi.linkedin.com\napi.mistral.ai\napi.openai.com\napi.perplexity.ai\napi.spotify.com\napi.twitter.com\napi.vimeo.com\napi.whatsapp.com\napi.x.ai\nassets.web.soundcloud.cloud\navatars.githubusercontent.com\nazure.com\nbing.com\ncamo.githubusercontent.com\ncdn-images-1.medium.com\ncdn-images-2.medium.com\ncdn.discordapp.com\ncdn.steamstatic.com\ncharacter.ai\nchat.mistral.ai\nchat.openai.com\nchatgpt.com\nclaudeusercontent.com\ncloud.microsoft\ncloudflare-dns.com\ncloudflare.com\ncloudflareclient.com\ncloudflarecp.com\ncloudflareok.com\ncloudflareportal.com\ncohere.com\nconnect.facebook.net\nconnectivity.cloudflareclient.com\ncopilot.com\ncopilot.microsoft.com\ndailymotion.com\ndeepseek.com\ndev.azure.com\ndiscord-attachments-uploads-prd.storage.googleapis.com\ndiscord.com\ndiscord.gg\ndiscord.media\ndiscordactivities.com\ndiscordapp.com\ndiscordcdn.com\ndiscordstatus.com\nea.com\nengage.cloudflareclient.com\nepicgames.com\nepicgames.dev\nfacebook.com\nfbcdn.net\nfbsbx.com\nfonts.googleapis.com\nfonts.gstatic.com\ngateway.reddit.com\ngemini.google.com\ngenerativelanguage.googleapis.com\ngist.github.com\ngithub.com\ngoogle-analytics.com\ngoogle.com\ngoogleadservices.com\ngoogleapis.com\ngoogleusercontent.com\ngraph.facebook.com\ngrok.com\ngstatic.com\nhdrezka.ag\nhdrezka.co\nhdrezka.me\nhdrezka.run\nhdrezka.sh\nhdrezka.tv\nhdrezka.website\nhdrezka.zone\nhdrzk.org\nhuggingface.co\ni.instagram.com\ni.ytimg.com\ninstagram.com\nlinkedin.com\nlive.com\nlogin.microsoftonline.com\nm.facebook.com\nmedia.discordapp.net\nmedia.licdn.com\nmedium.com\nmeta.ai\nmicrosoft.com\nmicrosoft365.com\nmistral.ai\nmoonshot.ai\nnetflix.ca\nnetflix.net\nnnmclub.to\nnotifications.cloudflareclient.com\noaistatic.com\noauth.reddit.com\nobjects.githubusercontent.com\noffice.com\noffice365.com\nold.reddit.com\nonedrive.com\nopen.spotify.com\nopenai.com\noutlook.com\noutlook.office.com\npbs.twimg.com\nperplexity.ai\nplay.google.com\nplayback.media-streaming.soundcloud.cloud\npoe.com\nportal.azure.com\nqwen.ai\nraw.githubusercontent.com\nreddit.com\nredditmedia.com\nreplicate.com\nrezka-ua.tv\nrezka.ag\nrezka.io\nrumble.com\nrustorka.com\nrutracker.org\ns.ytimg.com\nscontent.cdninstagram.com\nscontent.xx.fbcdn.net\nsharepoint.com\nskype.com\nsndcdn.com\nsoundcloud.com\nspotify.com\nstability.ai\nsteamcommunity.com\nsteampowered.com\nstore.steampowered.com\nstyle.sndcdn.com\nt.co\ntapochek.net\nteams.live.com\nteams.microsoft.com\ntogether.ai\ntwitch.tv\ntwitter.com\nv.whatsapp.net\nvideo.twimg.com\nvimeo.com\nvisualstudio.com\nwarp.plus\nwhatsapp.net\nwindows.com\nws.chatgpt.com\nwww.cloudflare.com\nwww.dailymotion.com\nwww.ea.com\nwww.epicgames.com\nwww.github.com\nwww.google.com\nwww.instagram.com\nwww.kick.com\nwww.linkedin.com\nwww.medium.com\nwww.microsoft.com\nwww.microsoft365.com\nwww.netflix.com\nwww.nintendo.com\nwww.office.com\nwww.office365.com\nwww.onedrive.com\nwww.reddit.com\nwww.rumble.com\nwww.soundcloud.com\nwww.twitch.tv\nwww.vimeo.com\nwww.whatsapp.com\nwww.x.com\nwww.xbox.com\nx.ai\nx.com\nxbox.com\nyoutu.be
```

P4 QF:
```
accounts.google.com\nai.google.dev\nai21.com\nanthropic.com\napi.linkedin.com\napi.mistral.ai\napi.openai.com\napi.perplexity.ai\napi.spotify.com\napi.vimeo.com\napi.whatsapp.com\ncdn-images-1.medium.com\ncdn-images-2.medium.com\ncdn.discordapp.com\ncdn.steamstatic.com\ncharacter.ai\nclaude.ai\nclaudeusercontent.com\ncloudflare-dns.com\ncloudflare.com\ncopilot.microsoft.com\ndiscord-attachments-uploads-prd.storage.googleapis.com\ndiscord.com\ndiscordapp.com\ndiscordstatus.com\nea.com\nfacebook.com\nfbcdn.net\nfbsbx.com\nfonts.googleapis.com\nfonts.gstatic.com\ngateway.reddit.com\ngemini.google.com\ngenerativelanguage.googleapis.com\ngoogle-analytics.com\ngoogle.com\ngoogleadservices.com\ngoogleapis.com\ngoogleusercontent.com\ngraph.facebook.com\ngrok.com\ngstatic.com\nhdrezka.co\nhdrezka.ink\nhdrezka.run\nhdrezka.tv\nhdrezka.zone\nhuggingface.co\ni.instagram.com\ni.ytimg.com\ninstagram.com\nkick.com\nlinkedin.com\nm.facebook.com\nm.youtube.com\nmedia.discordapp.net\nmedia.licdn.com\nmedium.com\nmistral.ai\nnnmclub.to\noaistatic.com\noauth.reddit.com\nold.reddit.com\nopen.spotify.com\nopenai.com\noutlook.office.com\nperplexity.ai\nplay.google.com\npoe.com\nredd.it\nreddit.com\nredditmedia.com\nreplicate.com\nrezka.io\nrumble.com\nrustorka.com\nrutracker.org\ns.ytimg.com\nscontent.cdninstagram.com\nscontent.xx.fbcdn.net\nspotify.com\nteams.live.com\ntiktokv.com\ntogether.ai\ntwitch.tv\nvimeo.com\nwarp.plus\nwhatsapp.net\nws.chatgpt.com\nwww.cloudflare.com\nwww.dailymotion.com\nwww.ea.com\nwww.epicgames.com\nwww.google.com\nwww.kick.com\nwww.linkedin.com\nwww.medium.com\nwww.microsoft365.com\nwww.nintendo.com\nwww.reddit.com\nwww.rumble.com\nwww.twitch.tv\nwww.vimeo.com\nwww.whatsapp.com\nwww.xbox.com\nwww.youtube.com\nyoutu.be\nyoutube.com\nyoutube.googleapis.com\nyoutube.ru\nyoutubei.googleapis.com
```

### 18.5. Why TF/QI/TC/HF are not in the first four profiles

- **TF**: explicit FOUND, but low coverage; remains TLS fallback candidate.
- **QI**: explicit FOUND, very small domain set; remains QUIC special fallback.
- **TC**: explicit FOUND only twice in 2709; remains TLS1.2 special case.
- **HF**: high COVERAGE, but no explicit FOUND; remains candidate only.

Они не удаляются из evidence-base.

### 18.6. MODE_FILTER interaction

S2 does not authorize changing the currently working `MODE_FILTER=autohostlist`. The translation map is deliberately independent of that setting.

Before activation, determine whether the current init script will combine explicit `--hostlist=...` with the selected `MODE_FILTER`; this must be checked against the installed zapret2 version/config renderer before runtime change.

The upstream config notes that `<HOSTLIST>` and `<HOSTLIST_NOAUTO>` are mode-dependent placeholders, while explicit hostlist paths can also be used. citeturn474984search0turn474984search1

### 18.7. Resource/safety policy for hAP

Do not activate all seven strategies together. The first controlled experiment should modify one profile at a time and preserve rollback.

P4 QF is restricted to the explicit QF hostlist because QUIC fake repeats=11 affects UDP/443 and should not become a global UDP rule on the 64 MB hAP.

P3 TS is similarly restricted to the explicit TS hostlist; do not convert it into a global TCP/443 rule without runtime evidence.

### 18.8. S2 completion criteria

S2 is considered **DONE (design)** when:
- all seven explicit FOUND strategy classes are mapped to nfqws2 syntax;
- the four-profile evidence-cover is defined;
- hostlist scope is deterministic;
- no Windows-only `--wf-*` selectors remain in the templates;
- runtime activation is still separated from design.

S2: **DONE / DESIGN ONLY**. Router configuration changed: **NO**.


## 19. Synchronization with OPENWRT_VARIANT_A_MASTER_PLAN.md — 2026-09-27

This Strategy Master Plan is subordinate to the main project plan for router-wide state. The main plan remains authoritative for hardware, network, DNS, storage, VPN/PBR branches, memory policy, watchdog state, and all router-changing safety gates.

### Current synchronized status

- Manual blockcheck strategy discovery from `blockcheck2609_FULL.log` + `blockcheck2709.log`: **DONE FOR CURRENT EVIDENCE**.
- S1 merged evidence/domain matrix: **DONE** in `strategy27.md`.
- S2 OpenWrt/nfqws2 translation design: **DONE / DESIGN ONLY**.
- S3 live Zapret2 backup: **NOT_STARTED**.
- S4 single-strategy hAP runtime validation: **NOT_STARTED**.
- S5 TCP composite validation: **NOT_STARTED**.
- S6 QUIC validation: **NOT_STARTED**.
- S7 four-service hAP validation: **NOT_STARTED**.
- Final universal profile: **NOT_ESTABLISHED**.
- Telegram Zapret2-only: **NOT_FOUND_IN_SUPPLIED_RUNS / existing main-plan scope remains BLOCKED**.

### Main-plan invariants inherited by Strategy Work

- Archer C20 v4 remains the main router; hAP ac lite remains downstream.
- Current working Zapret2 configuration must be preserved until a controlled runtime experiment proves a change.
- `MODE_FILTER=autohostlist` is not changed by the S2 design.
- DNS, PBR, VPN, routing and broad firewall policy are outside S2.
- No strategy is promoted to universal from blockcheck evidence alone.
- One meaningful runtime variable/change at a time; rollback before experiments.
- Memory/watchdog safety gates from the main plan remain mandatory.

### Persistent custom-list location

Strategy27 hostlists are designed for `/etc/zapret2/strategy27/`, not generated `/opt/zapret2/ipset/` content. The directory must be created only during S3/S4 preparation after the live configuration and rollback path are verified.

### Handoff

The next action is S3: read-only capture of the current live Zapret2 configuration and creation/verification of a rollback backup. No strategy27 hostlists or NFQWS2 profile changes are to be activated before that gate.


## 2026-09-27 — S4 INSTALLED RENDERER AUDIT

Read-only audit of the installed hAP renderer completed.

Observed:
- `/opt/zapret2/common/list.sh` contains `<HOSTLIST>` and `<HOSTLIST_NOAUTO>`.
- In `MODE_FILTER=autohostlist`, `<HOSTLIST>` expands to normal hostlists plus auto-learning parameters and `--hostlist-auto`.
- In the same mode, `<HOSTLIST_NOAUTO>` expands to normal hostlists plus `--hostlist=$HOSTLIST_AUTO`.
- `/opt/zapret2/init.d/openwrt/zapret2` passes the rendered argument string into `nfqws2`; `--new` remains the profile separator.
- No runtime change, restart, stop, or start was performed.

Interpretation:
- `<HOSTLIST_NOAUTO>` is not an exact-only selector under the current autohostlist mode.
- The two-level architecture therefore requires explicit separation of exact domains from the fallback auto profile.
- Exact specialized profiles remain hostlist/protocol scoped.
- Unknown domains retain the current autohostlist fallback.

Status:
- S4 renderer audit: **DONE**
- S4 exact-hostlist runtime validation: **NOT_STARTED**
