# ZAPRET2 PRIMARY / BACKUP MATRIX — 2609 + 2709

Статус: **DONE — evidence matrix prepared; router configuration unchanged by this artifact.**

## Правило

Backup считается резервом только внутри того же L7 traffic class и только при отдельном **EXPLICIT FOUND** для того же домена.

Группы: HTTP = ME/HC (HF отдельно, candidate-only); TLS = TS/TF/TC; QUIC = QF/QI.

## Итог

- 225 уникальных доменов имеют хотя бы один EXPLICIT FOUND.
- 191 домен имеет 2+ различных FOUND profile IDs.
- **16 доменов имеют 2 FOUND внутри одного traffic class; все 16 — TLS.**
- HTTP same-class backup: 0.
- QUIC same-class backup: 0.
- HF: 0 EXPLICIT FOUND → не допускается как primary/backup.

## Same-class backup candidates

| Domain | Traffic class | Primary | Backup 1 | Evidence |
|---|---|---|---|---|
| `api.perplexity.ai` | TLS | **TS** | **TF** | TS:2709, TF:2709 |
| `azure.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609 |
| `cloudflare-dns.com` | TLS | **TS** | **TF** | TS:2709, TF:2609 |
| `cloudflare.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2709 |
| `epicgames.com` | TLS | **TS** | **TF** | TS:2609, TF:2709 |
| `hdrzk.org` | TLS | **TS** | **TC** | TS:2709, TC:2709 |
| `media.licdn.com` | TLS | **TS** | **TC** | TS:2709, TC:2709 |
| `office365.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `onedrive.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `outlook.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `outlook.office.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `teams.live.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2709 |
| `www.microsoft365.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `www.office365.com` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609+2709 |
| `www.onedrive.com` | TLS | **TS** | **TF** | TS:2709, TF:2609+2709 |
| `www.twitch.tv` | TLS | **TS** | **TF** | TS:2609+2709, TF:2609 |

## Full per-domain matrix

| Domain | HTTP P | HTTP B1 | HTTP B2 | TLS P | TLS B1 | TLS B2 | QUIC P | QUIC B1 | QUIC B2 | All FOUND IDs |
|---|---|---|---|---|---|---|---|---|---|---|
| `a-v2.sndcdn.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `abs.twimg.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `account.microsoft.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `accounts.google.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `ai.google.dev` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `ai21.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `anthropic.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.anthropic.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `api.cloudflare.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `api.deepseek.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `api.devices.cloudflare.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `api.github.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `api.linkedin.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `api.mistral.ai` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.openai.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.perplexity.ai` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `api.spotify.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.steampowered.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `api.twitter.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `api.vimeo.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.whatsapp.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `api.x.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `assets.web.soundcloud.cloud` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `avatars.githubusercontent.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `azure.com` | — | — | — | `TS` | `TF` | — | — | — | — | `TF,TS` |
| `bing.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `blizzard.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `camo.githubusercontent.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cdn-images-1.medium.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `cdn-images-2.medium.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `cdn.discordapp.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `cdn.steamstatic.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `character.ai` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `chat.deepseek.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `chat.mistral.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `chat.openai.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `chatgpt.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `claude.ai` | — | — | — | `TF` | — | — | `QF` | — | — | `TF,QF` |
| `claudeusercontent.com` | — | — | — | `TS` | — | — | `QF` | — | — | `TS,QF` |
| `cloud.microsoft` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cloudflare-dns.com` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `cloudflare.com` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `cloudflareclient.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cloudflarecp.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cloudflareok.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cloudflareportal.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `cohere.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `connect.facebook.net` | `HC` | — | — | `TS` | — | — | `QI` | — | — | `HC,TS,QI` |
| `connectivity.cloudflareclient.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `copilot.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `copilot.microsoft.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `dailymotion.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `deepseek.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `dev.azure.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `discord-attachments-uploads-prd.storage.googleapis.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `discord.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `discord.gg` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `discord.media` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `discordactivities.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `discordapp.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `discordcdn.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `discordstatus.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `dmcdn.net` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `ea.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `engage.cloudflareclient.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `epicgames.com` | — | — | — | `TS` | `TF` | — | — | — | — | `TF,TS` |
| `epicgames.dev` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `f.vimeocdn.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `facebook.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `fbcdn.net` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `fbsbx.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `fonts.googleapis.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `fonts.gstatic.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `gateway.reddit.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `gemini.google.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `generativelanguage.googleapis.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `gist.github.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `github.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `google-analytics.com` | — | — | — | `TS` | — | — | `QF` | — | — | `TS,QF` |
| `google.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `googleadservices.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `googleapis.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `googleusercontent.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `graph.facebook.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `grok.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `gstatic.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `hdrezka.ag` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `hdrezka.co` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `hdrezka.info` | `ME` | — | — | — | — | — | — | — | — | `ME` |
| `hdrezka.ink` | `ME` | — | — | — | — | — | `QF` | — | — | `ME,QF` |
| `hdrezka.me` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `hdrezka.one` | `ME` | — | — | — | — | — | — | — | — | `ME` |
| `hdrezka.run` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `hdrezka.sh` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `hdrezka.tv` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `hdrezka.website` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `hdrezka.zone` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `hdrzk.org` | `HC` | — | — | `TS` | `TC` | — | — | — | — | `HC,TC,TS` |
| `hq.hdrezka.info` | `ME` | — | — | — | — | — | — | — | — | `ME` |
| `huggingface.co` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `i.instagram.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `i.vimeocdn.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `i.ytimg.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `instagram.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `kick.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `kimi.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `linkedin.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `live.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `login.microsoftonline.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `m.facebook.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `m.youtube.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `media.discordapp.net` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `media.licdn.com` | `HC` | — | — | `TS` | `TC` | — | `QF` | — | — | `HC,TC,TS,QF` |
| `medium.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `meta.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `microsoft.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `microsoft365.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `mistral.ai` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `moonshot.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `netflix.ca` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `netflix.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `netflix.net` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `nintendo.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `nnmclub.to` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `notifications.cloudflareclient.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `oaistatic.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `oauth.reddit.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `objects.githubusercontent.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `office.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `office365.com` | `HC` | — | — | `TS` | `TF` | — | — | — | — | `HC,TF,TS` |
| `old.reddit.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `onedrive.com` | `HC` | — | — | `TS` | `TF` | — | — | — | — | `HC,TF,TS` |
| `open.spotify.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `openai.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `outlook.com` | `HC` | — | — | `TS` | `TF` | — | — | — | — | `HC,TF,TS` |
| `outlook.office.com` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `pbs.twimg.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `perplexity.ai` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `play.google.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `playback.media-streaming.soundcloud.cloud` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `poe.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `portal.azure.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `qwen.ai` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `qwenchat.ai` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `raw.githubusercontent.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `redd.it` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `reddit.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `redditmedia.com` | — | — | — | `TS` | — | — | `QF` | — | — | `TS,QF` |
| `replicate.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `rezka-ua.tv` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `rezka.ag` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `rezka.io` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `rumble.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `rustorka.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `rutor.info` | `ME` | — | — | — | — | — | — | — | — | `ME` |
| `rutracker.org` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `s.ytimg.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `scontent.cdninstagram.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `scontent.xx.fbcdn.net` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `sharepoint.com` | — | — | — | `TS` | — | — | `QI` | — | — | `TS,QI` |
| `skype.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `sndcdn.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `soundcloud.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `spotify.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `stability.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `steamcommunity.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `steampowered.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `store.steampowered.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `streamable.com` | `ME` | — | — | — | — | — | — | — | — | `ME` |
| `style.sndcdn.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `t.co` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `tapochek.net` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `teams.live.com` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `teams.microsoft.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `tiktok.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `tiktokv.com` | `HC` | — | — | — | — | `QF` | — | — | `HC,QF` |
| `together.ai` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `torrents.ru` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `twitch.tv` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `twitter.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `v.whatsapp.net` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `video.twimg.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `vimeo.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `vimeocdn.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `visualstudio.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `warp.plus` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `whatsapp.net` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `windows.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `ws.chatgpt.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.cloudflare.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.dailymotion.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `www.ea.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.epicgames.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.github.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `www.google.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.instagram.com` | `ME` | — | — | `TS` | — | — | — | — | — | `ME,TS` |
| `www.kick.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.linkedin.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `www.medium.com` | `ME` | — | — | `TS` | — | — | `QF` | — | — | `ME,TS,QF` |
| `www.microsoft.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `www.microsoft365.com` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `www.netflix.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `www.nintendo.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.office.com` | — | — | — | `TS` | — | — | — | — | — | `TS` |
| `www.office365.com` | `HC` | — | — | `TS` | `TF` | — | — | — | — | `HC,TF,TS` |
| `www.onedrive.com` | `HC` | — | — | `TS` | `TF` | — | — | — | — | `HC,TF,TS` |
| `www.playstation.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `www.reddit.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.rumble.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.soundcloud.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `www.tiktok.com` | `HC` | — | — | — | — | — | — | — | — | `HC` |
| `www.twitch.tv` | `HC` | — | — | `TS` | `TF` | — | `QF` | — | — | `HC,TF,TS,QF` |
| `www.vimeo.com` | — | — | — | `TS` | — | — | `QF` | — | — | `TS,QF` |
| `www.whatsapp.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.x.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `www.xbox.com` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `www.youtube.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `x.ai` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `x.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `xbox.com` | `HC` | — | — | `TS` | — | — | — | — | — | `HC,TS` |
| `youtu.be` | `HC` | — | — | `TS` | — | — | `QF` | — | — | `HC,TS,QF` |
| `youtube.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `youtube.googleapis.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `youtube.ru` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |
| `youtubei.googleapis.com` | `HC` | — | — | — | — | — | `QF` | — | — | `HC,QF` |

## Installation gate

1. Current evidence supports only one exact strategy per domain/L7 in most cases.
2. Where TLS has `TS + TF`, future primary/backup may be TS → TF, but TF remains DEFERRED until targeted hAP validation.
3. Where TLS has `TS + TC`, future primary/backup may be TS → TC; TC is a narrow TLS1.2 special fallback and remains DEFERRED/SKIPPED.
4. No same-class HTTP or QUIC backup is currently proven.
5. HF remains candidate-only and is excluded from installation until its evidence status is upgraded.
6. Cross-class FOUND (e.g. HC + TS + QF) means separate L7 profiles, not circular backups.

## Sources

Raw: `blockcheck2609_FULL.log` + `blockcheck2709.log`; criterion is literal `working strategy found`.
