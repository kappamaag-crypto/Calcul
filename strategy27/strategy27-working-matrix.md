# strategy27 — FULL WORKING ACTIVATION MATRIX — 2026-09-27

## Status
**ACTIVE CANDIDATE:** HC/HTTP + TS/TLS. **ME:** excluded, NOT_PROVEN. **QF:** excluded, BLOCKED for live QUIC. Existing `MODE_FILTER=autohostlist` remains fallback.

## Logic
`domain + traffic class → exact HC/TS when present → existing autohostlist fallback otherwise`

| # | Domain | Raw FOUND | HTTP | TLS | QUIC | Evidence |
|---:|---|---|---|---|---|---|
| 1 | `1.1.1.1` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 2 | `a-v2.sndcdn.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 3 | `abs.twimg.com` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 4 | `account.microsoft.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 5 | `accounts.google.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 6 | `ai.google.dev` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 7 | `ai21.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 8 | `anthropic.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 9 | `api.anthropic.com` | TS | fallback | TS exact | fallback | TS:2709 |
| 10 | `api.cloudflare.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 11 | `api.deepseek.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 12 | `api.devices.cloudflare.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 13 | `api.epicgames.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 14 | `api.github.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 15 | `api.linkedin.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 16 | `api.mistral.ai` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 17 | `api.openai.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 18 | `api.perplexity.ai` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; TF:2709; QF:2709 |
| 19 | `api.spotify.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 20 | `api.steampowered.com` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 21 | `api.telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 22 | `api.twitter.com` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 23 | `api.vimeo.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 24 | `api.whatsapp.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609 |
| 25 | `api.x.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 26 | `assets.web.soundcloud.cloud` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 27 | `audio4.spotifycdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 28 | `avatars.githubusercontent.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 29 | `azure.com` | TS, TF | fallback | TS exact | fallback | TS:2609+2709; TF:2609 |
| 30 | `azureedge.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 31 | `azurefd.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 32 | `b-graph.facebook.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 33 | `battle.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 34 | `bing.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 35 | `blizzard.com` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 36 | `bytefcdn-oversea.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 37 | `byteoversea.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 38 | `camo.githubusercontent.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 39 | `cdn-images-1.medium.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 40 | `cdn-images-2.medium.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 41 | `cdn-telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 42 | `cdn.discordapp.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 43 | `cdn.steamstatic.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 44 | `cdninstagram.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 45 | `character.ai` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 46 | `chat.deepseek.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 47 | `chat.mistral.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 48 | `chat.openai.com` | TS | fallback | TS exact | fallback | TS:2709 |
| 49 | `chatgpt.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 50 | `claude.ai` | TF, QF | fallback | fallback | QF / BLOCKED | TF:2709; QF:2709 |
| 51 | `claudeusercontent.com` | TS, QF | fallback | TS exact | QF / BLOCKED | TS:2709; QF:2709 |
| 52 | `cloud.microsoft` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 53 | `cloudflare-dns.com` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2709; TF:2609; QF:2609+2709 |
| 54 | `cloudflare.com` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; TF:2709; QF:2609+2709 |
| 55 | `cloudflareclient.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 56 | `cloudflarecp.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 57 | `cloudflareok.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 58 | `cloudflareportal.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 59 | `cohere.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 60 | `connect.facebook.net` | HC, TS, QI | HC exact | TS exact | fallback | HC:2709; TS:2709; QI:2709 |
| 61 | `connectivity.cloudflareclient.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 62 | `copilot.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 63 | `copilot.microsoft.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 64 | `core.telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 65 | `dailymotion.com` | TS | fallback | TS exact | fallback | TS:2709 |
| 66 | `dailymotionapi.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 67 | `deepseek.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 68 | `desktop.telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 69 | `dev.azure.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 70 | `discord-activities.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 71 | `discord-attachments-uploads-prd.storage.googleapis.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 72 | `discord.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 73 | `discord.gg` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 74 | `discord.media` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 75 | `discordactivities.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 76 | `discordapp.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 77 | `discordapp.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 78 | `discordcdn.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 79 | `discordstatus.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 80 | `dmcdn.net` | HC | HC exact | fallback | fallback | HC:2709 |
| 81 | `ea.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 82 | `engage.cloudflareclient.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 83 | `epicgames.com` | TS, TF | fallback | TS exact | fallback | TS:2609; TF:2709 |
| 84 | `epicgames.dev` | TS | fallback | TS exact | fallback | TS:2709 |
| 85 | `epicgamescdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 86 | `f.vimeocdn.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 87 | `facebook.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609; TS:2609; QF:2609 |
| 88 | `fbcdn.net` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 89 | `fbsbx.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 90 | `fonts.googleapis.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 91 | `fonts.gstatic.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 92 | `gateway.reddit.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 93 | `gemini.google.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 94 | `generativelanguage.googleapis.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 95 | `ggpht.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 96 | `gist.github.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 97 | `github.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 98 | `githubassets.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 99 | `githubusercontent.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 100 | `google-analytics.com` | TS, QF | fallback | TS exact | QF / BLOCKED | TS:2709; QF:2709 |
| 101 | `google.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 102 | `googleadservices.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 103 | `googleapis.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 104 | `googleusercontent.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 105 | `googlevideo.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 106 | `graph.facebook.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 107 | `graph.instagram.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 108 | `grok.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 109 | `gstatic.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 110 | `gvt1.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 111 | `gvt2.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 112 | `hdrezka.ac` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 113 | `hdrezka.ag` | TS | fallback | TS exact | fallback | TS:2709 |
| 114 | `hdrezka.co` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 115 | `hdrezka.cx` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 116 | `hdrezka.info` | ME | fallback | fallback | fallback | ME:2709 |
| 117 | `hdrezka.ink` | ME, QF | fallback | fallback | QF / BLOCKED | ME:2709; QF:2709 |
| 118 | `hdrezka.live` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 119 | `hdrezka.me` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 120 | `hdrezka.no` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 121 | `hdrezka.one` | ME | fallback | fallback | fallback | ME:2709 |
| 122 | `hdrezka.run` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 123 | `hdrezka.sh` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 124 | `hdrezka.tv` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 125 | `hdrezka.website` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 126 | `hdrezka.zone` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 127 | `hdrzk.org` | HC, TS, TC | HC exact | TS exact | fallback | HC:2709; TS:2709; TC:2709 |
| 128 | `hq.hdrezka.info` | ME | fallback | fallback | fallback | ME:2709 |
| 129 | `huggingface.co` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 130 | `i.instagram.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 131 | `i.vimeocdn.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 132 | `i.ytimg.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 133 | `ibytedtos.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 134 | `ibytedtos.com.akamaized.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 135 | `instagram.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 136 | `jtvnw.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 137 | `kick.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2709; QF:2709 |
| 138 | `kickcdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 139 | `kimi.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 140 | `kinozal.tv` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 141 | `linkedin.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609; QF:2609+2709 |
| 142 | `live.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 143 | `llama.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 144 | `login.live.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 145 | `login.microsoftonline.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 146 | `m.facebook.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 147 | `m.youtube.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2709; QF:2709 |
| 148 | `media.discordapp.net` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 149 | `media.licdn.com` | HC, TS, TC, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; TC:2709; QF:2709 |
| 150 | `medium.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 151 | `meta.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 152 | `microsoft.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 153 | `microsoft365.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 154 | `microsoftonline.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 155 | `mistral.ai` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 156 | `moonshot.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 157 | `muscdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 158 | `muscdn.com.akamaized.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 159 | `netflix.ca` | TS | fallback | TS exact | fallback | TS:2709 |
| 160 | `netflix.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 161 | `netflix.net` | TS | fallback | TS exact | fallback | TS:2709 |
| 162 | `nflxext.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 163 | `nflximg.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 164 | `nflximg.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 165 | `nflxvideo.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 166 | `nintendo.com` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 167 | `nnm-club.name` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 168 | `nnmclub.to` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2709 |
| 169 | `notifications.cloudflareclient.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 170 | `oaistatic.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 171 | `oaiusercontent.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 172 | `oauth.reddit.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 173 | `objects.githubusercontent.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 174 | `office.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 175 | `office365.com` | HC, TS, TF | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 176 | `old.reddit.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 177 | `onedrive.com` | HC, TS, TF | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 178 | `open.spotify.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 179 | `openai.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 180 | `outlook.com` | HC, TS, TF | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 181 | `outlook.office.com` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; TF:2609+2709; QF:2609+2709 |
| 182 | `pbs.twimg.com` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 183 | `perplexity.ai` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 184 | `play.google.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 185 | `playback.media-streaming.soundcloud.cloud` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 186 | `playstation.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 187 | `poe.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 188 | `portal.azure.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 189 | `qwen.ai` | TS | fallback | TS exact | fallback | TS:2709 |
| 190 | `qwenchat.ai` | HC | HC exact | fallback | fallback | HC:2709 |
| 191 | `raw.githubusercontent.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 192 | `redd.it` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2709; QF:2709 |
| 193 | `reddit.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 194 | `redditmedia.com` | TS, QF | fallback | TS exact | QF / BLOCKED | TS:2709; QF:2709 |
| 195 | `replicate.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 196 | `rezka-ua.tv` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 197 | `rezka.ag` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 198 | `rezka.io` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 199 | `rumble.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 200 | `rustorka.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 201 | `rutor.info` | ME | fallback | fallback | fallback | ME:2609 |
| 202 | `rutracker.org` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 203 | `s.ytimg.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 204 | `scontent.cdninstagram.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 205 | `scontent.xx.fbcdn.net` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 206 | `sharepoint.com` | TS, QI | fallback | TS exact | fallback | TS:2609+2709; QI:2609+2709 |
| 207 | `sharepointonline.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 208 | `skype.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 209 | `sndcdn.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 210 | `soundcloud.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 211 | `spotify.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 212 | `spotifycdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 213 | `stability.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 214 | `static.hdrezka.ag` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 215 | `static.microsoft` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 216 | `steamcommunity.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 217 | `steamcontent.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 218 | `steampowered.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 219 | `steamstatic.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 220 | `store.steampowered.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 221 | `streamable.com` | ME | fallback | fallback | fallback | ME:2709 |
| 222 | `style.sndcdn.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 223 | `t.co` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 224 | `t.me` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 225 | `tapochek.net` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 226 | `teams.live.com` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; TF:2709; QF:2709 |
| 227 | `teams.microsoft.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 228 | `telegram-cdn.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 229 | `telegram.me` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 230 | `telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 231 | `tiktok.com` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 232 | `tiktokcdn.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 233 | `tiktokv.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2709; QF:2709 |
| 234 | `together.ai` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 235 | `torrents.ru` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 236 | `ttvnw.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 237 | `twitch.tv` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 238 | `twitchcdn.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 239 | `twitter.com` | ME, TS | fallback | TS exact | fallback | ME:2609+2709; TS:2609+2709 |
| 240 | `usercontent.microsoft` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 241 | `v.whatsapp.net` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 242 | `video.twimg.com` | ME, TS | fallback | TS exact | fallback | ME:2709; TS:2709 |
| 243 | `vimeo.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 244 | `vimeocdn.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 245 | `visualstudio.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 246 | `wa.me` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 247 | `warp.plus` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 248 | `web.telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 249 | `web.whatsapp.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 250 | `whatsapp-cdn.net` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 251 | `whatsapp.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 252 | `whatsapp.net` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609; TS:2609; QF:2609 |
| 253 | `windows.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 254 | `windowsupdate.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 255 | `ws.chatgpt.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 256 | `www.cloudflare.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 257 | `www.dailymotion.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 258 | `www.ea.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 259 | `www.epicgames.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 260 | `www.facebook.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 261 | `www.github.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 262 | `www.google.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 263 | `www.instagram.com` | ME, TS | fallback | TS exact | fallback | ME:2609+2709; TS:2609+2709 |
| 264 | `www.kick.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 265 | `www.linkedin.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2609+2709; TS:2609+2709; QF:2609+2709 |
| 266 | `www.medium.com` | ME, TS, QF | fallback | TS exact | QF / BLOCKED | ME:2709; TS:2709; QF:2709 |
| 267 | `www.microsoft.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 268 | `www.microsoft365.com` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; TF:2609+2709; QF:2609+2709 |
| 269 | `www.netflix.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 270 | `www.nintendo.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 271 | `www.office.com` | TS | fallback | TS exact | fallback | TS:2609+2709 |
| 272 | `www.office365.com` | HC, TS, TF | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709; TF:2609+2709 |
| 273 | `www.onedrive.com` | HC, TS, TF | HC exact | TS exact | fallback | HC:2609+2709; TS:2709; TF:2609+2709 |
| 274 | `www.playstation.com` | HC | HC exact | fallback | fallback | HC:2609+2709 |
| 275 | `www.reddit.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 276 | `www.rumble.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2709; TS:2709; QF:2709 |
| 277 | `www.soundcloud.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 278 | `www.telegram.org` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 279 | `www.tiktok.com` | HC | HC exact | fallback | fallback | HC:2709 |
| 280 | `www.twitch.tv` | HC, TS, TF, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; TF:2609; QF:2609+2709 |
| 281 | `www.vimeo.com` | TS, QF | fallback | TS exact | QF / BLOCKED | TS:2709; QF:2709 |
| 282 | `www.whatsapp.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609; TS:2609; QF:2609 |
| 283 | `www.x.com` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 284 | `www.xbox.com` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 285 | `www.youtube.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2609+2709; QF:2609+2709 |
| 286 | `x.ai` | HC, TS | HC exact | TS exact | fallback | HC:2709; TS:2709 |
| 287 | `x.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 288 | `xbox.com` | HC, TS | HC exact | TS exact | fallback | HC:2609+2709; TS:2609+2709 |
| 289 | `xboxlive.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 290 | `xboxservices.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 291 | `youtu.be` | HC, TS, QF | HC exact | TS exact | QF / BLOCKED | HC:2609+2709; TS:2609+2709; QF:2609+2709 |
| 292 | `youtube.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2609+2709; QF:2609+2709 |
| 293 | `youtube.googleapis.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2609+2709; QF:2609+2709 |
| 294 | `youtube.ru` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2609+2709; QF:2609+2709 |
| 295 | `youtubei.googleapis.com` | HC, QF | HC exact | fallback | QF / BLOCKED | HC:2609+2709; QF:2609+2709 |
| 296 | `ytimg.com` | **NONE** | fallback | fallback | fallback | NO FOUND |
| 297 | `zero-trust-client.cloudflare.com` | **NONE** | fallback | fallback | fallback | NO FOUND |

## Exact profiles
### HC / HTTP
`--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/strategy27-hc.txt --payload=http_req --lua-desync=http_hostcase --new`

### TS / TLS
`--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts.txt --payload=tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop --new`

## Exclusions
- ME: 44 domains, NOT_PROVEN; not activated.
- QF: 111 domains, live effectiveness BLOCKED; not activated.
- TF/TC/QI: evidence preserved, not activated in this matrix.
- HF: candidate only; not explicit FOUND.

## Runtime boundary
HC and TS are runtime-verified at representative traffic-class level, not individually for all 297 rows. This matrix is the complete activation/evidence map, not a 297-domain live test. No DNS, routing, VPN, PBR, QNUM or MODE_FILTER changes are implied.