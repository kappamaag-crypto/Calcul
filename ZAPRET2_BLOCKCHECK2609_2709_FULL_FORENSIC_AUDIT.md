# ZAPRET2 BLOCKCHECK 2609 → 2709 — FULL FORENSIC AUDIT

**Дата:** 2026-09-27  
**Raw source:** `blockcheck2609_FULL.log` blob `d42227bdc262c4437e4d1f78e28369c41075b3d6`; `blockcheck2709.log` blob `f1413839059d5f86b2856aa6ddc62b2e7ed38bb3`.

## Executive conclusion

Raw audit of both logs, not a summary-only review.

**Most strongly corroborated classes:** `HC` = http_hostcase, `TS` = TLS1.3 tcpseg+drop, `QF` = QUIC fake_default_quic repeats=11.

**Useful targeted class:** `ME` = http_methodeol. It has many candidate AVAILABLE results, but much fewer explicit `working strategy found` records.

**Candidate only:** `HF` = fake_default_http + tcp_ts=-1000. It has many AVAILABLE results but **zero explicit working-found records in both logs**.

**Fallback:** `TF`, `QI`.  
**Special/advanced:** `TC`, `TL`.

**Telegram:** neither 2609 nor 2709 contains an explicit working-found strategy for Telegram domains. Therefore these two logs do not provide a ready proven Telegram bypass.

## 1. Evidence hierarchy

A = explicit line `!!!!! curl_test_*: working strategy found ... !!!!!`.

B = a concrete candidate block that ends in `!!!!! AVAILABLE !!!!!`.

C = COVERAGE summary `X/N`.

D = runtime validation on the MikroTik/OpenWrt router.

A is stronger than B; B is stronger than C for domain-specific decisions. D is separate and must be tested on hAP.

## 2. Raw size

| |2609|2709|
|---|---:|---:|
|Lines|34,569|70,258|
|Domain sections|140|301|
|Unique domains|140|296|
|Explicit FOUND records|239|518|
|Unique domains with FOUND|104|221|

2709 has 301 sections but 296 unique domains because five domains repeat.

Both logs report Cygwin/Windows + WinDivert, curl 8.10.1, custom mode, force scan. Both also report DNS mismatch for rutracker.org against 8.8.8.8 and a Cloudflare DoH server. These are properties of the blockcheck environment, not proof of equivalent DNS on hAP.

## 3. Exact strategy catalogue

|Code|Class|Exact desync expression|Decision|
|---|---|---|---|
|HC|http_hostcase|`--payload=http_req --lua-desync=http_hostcase`|CORE|
|ME|http_methodeol|`--payload=http_req --lua-desync=http_methodeol`|TARGETED|
|HF|fake_default_http|`--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000`|CANDIDATE|
|TS|TLS1.3 tcpseg|`--payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop`|CORE|
|TF|fake_default_tls|`--payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000`|FALLBACK|
|TC|TLS12 complex|`--payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2`|SPECIAL|
|QF|QUIC fake|`--payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11`|CORE|
|QI|QUIC ipfrag|`--payload quic_initial --lua-desync=send:ipfrag --lua-desync=drop`|SPECIAL|
|TL|TLS luaexec pattern|`--payload tls_client_hello --lua-desync=luaexec:code=desync.pat=tls_mod(fake_default_tls,'rnd,rndsni,dupsid,padencap',desync.reasm_data) --lua-desync=tcpseg:pos=0,-1:seqovl=#pat:seqovl_pattern=pat --lua-desync=drop`|ADVANCED|

### Statistics

|Code|2609 CAND-A rec/dom|2609 FOUND rec/dom|2709 CAND-A rec/dom|2709 FOUND rec/dom|
|---|---:|---:|---:|---:|
|HC|0/0|84/84|0/0|160/157|
|ME|0/0|11/11|0/0|43/42|
|HF|0/0|0/0|0/0|0/0|
|TS|0/0|90/90|0/0|191/189|
|TF|0/0|11/10|0/0|12/12|
|TC|0/0|0/0|0/0|2/2|
|QF|0/0|42/42|0/0|108/107|
|QI|0/0|1/1|0/0|2/2|
|TL|0/0|0/0|0/0|0/0|

## 4. COVERAGE summary from raw

### 2609

```
140 sections; explicit FOUND 239
84 explicit HC
11 explicit ME
90 explicit TS
11 explicit TF
42 explicit QF
1 explicit QI
```

Raw log COVERAGE tail:
```
92/140 : curl_test_https_tls13 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop
84/140 : curl_test_http ipv4 : working without bypass
84/140 : curl_test_http ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_hostcase
80/140 : curl_test_http3 ipv4 : winws2 not working
77/140 : curl_test_https_tls12 ipv4 : working without bypass
74/140 : curl_test_http ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
70/140 : curl_test_https_tls13 ipv4 : working without bypass
42/140 : curl_test_http3 ipv4 : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
31/140 : curl_test_https_tls13 ipv4 : winws2 not working
28/140 : curl_test_http ipv4 : winws2 not working
26/140 : curl_test_http3 ipv4 : working without bypass
26/140 : curl_test_http3 ipv4 : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=send:ipfrag --lua-desync=drop
17/140 : curl_test_https_tls13 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
17/140 : curl_test_https_tls12 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
17/140 : curl_test_http3 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
17/140 : curl_test_http ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
9/140 : curl_test_https_tls12 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
2/140 : curl_test_https_tls13 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
```

### 2709

```
301 sections; explicit FOUND 518
160 explicit HC
43 explicit ME
191 explicit TS
12 explicit TF
2 explicit TC
108 explicit QF
2 explicit QI
```

Raw log COVERAGE tail:
```
160/301 : curl_test_http ipv4 : working without bypass
160/301 : curl_test_http ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_hostcase
150/301 : curl_test_https_tls12 ipv4 : working without bypass
149/301 : curl_test_http ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
147/301 : curl_test_http3 ipv4 : winws2 not working
143/301 : curl_test_https_tls13 ipv4 : working without bypass
108/301 : curl_test_http3 ipv4 : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
70/301 : curl_test_http3 ipv4 : working without bypass
70/301 : curl_test_http3 ipv4 : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=send:ipfrag --lua-desync=drop
64/301 : curl_test_https_tls13 ipv4 : winws2 not working
54/301 : curl_test_http ipv4 : winws2 not working
44/301 : curl_test_https_tls13 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
44/301 : curl_test_https_tls12 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
44/301 : curl_test_http3 ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
44/301 : curl_test_http ipv4 : test aborted, no reason to continue. curl code 6: could not resolve host
10/301 : curl_test_https_tls12 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
2/301 : curl_test_https_tls13 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000
2/301 : curl_test_https_tls12 ipv4 : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
```

## 5. Explicit working inventory — every FOUND domain

### 2609

**HC:** `youtube.com`, `www.youtube.com`, `youtube.ru`, `youtu.be`, `youtubei.googleapis.com`, `youtube.googleapis.com`, `googleapis.com`, `torrents.ru`, `tapochek.net`, `x.com`, `tiktok.com`, `twitch.tv`, `www.twitch.tv`, `discord.com`, `discordapp.com`, `discord.gg`, `discord.media`, `discordcdn.com`, `discord-attachments-uploads-prd.storage.googleapis.com`, `discordactivities.com`, `www.whatsapp.com`, `whatsapp.net`, `api.whatsapp.com`, `reddit.com`, `www.reddit.com`, `github.com`, `www.github.com`, `api.github.com`, `raw.githubusercontent.com`, `spotify.com`, `soundcloud.com`, `sndcdn.com`, `a-v2.sndcdn.com`, `style.sndcdn.com`, `assets.web.soundcloud.cloud`, `playback.media-streaming.soundcloud.cloud`, `google.com`, `www.google.com`, `accounts.google.com`, `play.google.com`, `googleusercontent.com`, `gstatic.com`, `cloudflare.com`, `www.cloudflare.com`, `cloudflare-dns.com`, `api.devices.cloudflare.com`, `connectivity.cloudflareclient.com`, `notifications.cloudflareclient.com`, `cloudflareportal.com`, `cloudflareok.com`, `cloudflarecp.com`, `steamcommunity.com`, `store.steampowered.com`, `api.steampowered.com`, `steampowered.com`, `www.epicgames.com`, `discordstatus.com`, `microsoft.com`, `www.microsoft.com`, `account.microsoft.com`, `live.com`, `outlook.com`, `outlook.office.com`, `office.com`, `office365.com`, `www.office365.com`, `teams.microsoft.com`, `teams.live.com`, `skype.com`, `onedrive.com`, `www.onedrive.com`, `www.microsoft365.com`, `cloud.microsoft`, `portal.azure.com`, `xbox.com`, `www.xbox.com`, `visualstudio.com`, `dev.azure.com`, `ea.com`, `www.ea.com`, `blizzard.com`, `www.playstation.com`, `nintendo.com`, `www.nintendo.com`

**ME:** `rutracker.org`, `rustorka.com`, `rutor.info`, `nnmclub.to`, `www.instagram.com`, `facebook.com`, `twitter.com`, `graph.facebook.com`, `medium.com`, `linkedin.com`, `www.linkedin.com`

**TS:** `youtu.be`, `googleapis.com`, `rutracker.org`, `rustorka.com`, `nnmclub.to`, `tapochek.net`, `www.instagram.com`, `facebook.com`, `x.com`, `twitter.com`, `twitch.tv`, `www.twitch.tv`, `discord.com`, `discordapp.com`, `discord.gg`, `discord.media`, `discordcdn.com`, `discord-attachments-uploads-prd.storage.googleapis.com`, `discordactivities.com`, `www.whatsapp.com`, `whatsapp.net`, `api.whatsapp.com`, `graph.facebook.com`, `reddit.com`, `www.reddit.com`, `github.com`, `www.github.com`, `api.github.com`, `raw.githubusercontent.com`, `medium.com`, `linkedin.com`, `www.linkedin.com`, `spotify.com`, `soundcloud.com`, `sndcdn.com`, `a-v2.sndcdn.com`, `style.sndcdn.com`, `assets.web.soundcloud.cloud`, `playback.media-streaming.soundcloud.cloud`, `google.com`, `www.google.com`, `accounts.google.com`, `play.google.com`, `googleusercontent.com`, `gstatic.com`, `cloudflare.com`, `www.cloudflare.com`, `api.cloudflare.com`, `api.devices.cloudflare.com`, `engage.cloudflareclient.com`, `connectivity.cloudflareclient.com`, `notifications.cloudflareclient.com`, `cloudflareportal.com`, `cloudflareok.com`, `cloudflarecp.com`, `steamcommunity.com`, `store.steampowered.com`, `steampowered.com`, `epicgames.com`, `www.epicgames.com`, `discordstatus.com`, `microsoft.com`, `www.microsoft.com`, `login.microsoftonline.com`, `account.microsoft.com`, `live.com`, `outlook.com`, `outlook.office.com`, `office.com`, `www.office.com`, `office365.com`, `www.office365.com`, `teams.microsoft.com`, `teams.live.com`, `skype.com`, `onedrive.com`, `sharepoint.com`, `microsoft365.com`, `www.microsoft365.com`, `cloud.microsoft`, `azure.com`, `portal.azure.com`, `windows.com`, `xbox.com`, `www.xbox.com`, `visualstudio.com`, `dev.azure.com`, `ea.com`, `www.ea.com`, `www.nintendo.com`

**TF:** `www.twitch.tv`, `cloudflare-dns.com`, `outlook.com`, `outlook.office.com`, `office365.com`, `www.office365.com`, `onedrive.com`, `www.onedrive.com`, `www.onedrive.com`, `www.microsoft365.com`, `azure.com`

**QF:** `youtube.com`, `www.youtube.com`, `youtube.ru`, `youtu.be`, `youtubei.googleapis.com`, `youtube.googleapis.com`, `googleapis.com`, `rutracker.org`, `rustorka.com`, `facebook.com`, `twitch.tv`, `www.twitch.tv`, `discord.com`, `discordapp.com`, `discord-attachments-uploads-prd.storage.googleapis.com`, `www.whatsapp.com`, `whatsapp.net`, `api.whatsapp.com`, `graph.facebook.com`, `reddit.com`, `www.reddit.com`, `medium.com`, `linkedin.com`, `www.linkedin.com`, `spotify.com`, `google.com`, `www.google.com`, `accounts.google.com`, `play.google.com`, `googleusercontent.com`, `gstatic.com`, `cloudflare.com`, `www.cloudflare.com`, `cloudflare-dns.com`, `www.epicgames.com`, `discordstatus.com`, `outlook.office.com`, `www.microsoft365.com`, `www.xbox.com`, `ea.com`, `www.ea.com`, `www.nintendo.com`

**QI:** `sharepoint.com`

### 2709

**HC:** `chatgpt.com`, `openai.com`, `api.openai.com`, `ws.chatgpt.com`, `oaistatic.com`, `anthropic.com`, `gemini.google.com`, `ai.google.dev`, `generativelanguage.googleapis.com`, `copilot.microsoft.com`, `bing.com`, `copilot.com`, `perplexity.ai`, `api.perplexity.ai`, `grok.com`, `x.ai`, `api.x.ai`, `mistral.ai`, `chat.mistral.ai`, `api.mistral.ai`, `deepseek.com`, `chat.deepseek.com`, `api.deepseek.com`, `meta.ai`, `qwenchat.ai`, `kimi.com`, `moonshot.ai`, `poe.com`, `character.ai`, `huggingface.co`, `replicate.com`, `together.ai`, `cohere.com`, `ai21.com`, `stability.ai`, `youtube.com`, `www.youtube.com`, `m.youtube.com`, `youtu.be`, `youtubei.googleapis.com`, `youtube.googleapis.com`, `s.ytimg.com`, `i.ytimg.com`, `googleapis.com`, `netflix.com`, `www.netflix.com`, `twitch.tv`, `www.twitch.tv`, `vimeo.com`, `vimeocdn.com`, `api.vimeo.com`, `i.vimeocdn.com`, `f.vimeocdn.com`, `dmcdn.net`, `tiktok.com`, `www.tiktok.com`, `tiktokv.com`, `rumble.com`, `www.rumble.com`, `kick.com`, `www.kick.com`, `hdrzk.org`, `youtube.ru`, `torrents.ru`, `tapochek.net`, `connect.facebook.net`, `x.com`, `www.x.com`, `tiktok.com`, `www.tiktok.com`, `discord.com`, `discordapp.com`, `discord.gg`, `discord.media`, `discordcdn.com`, `cdn.discordapp.com`, `media.discordapp.net`, `discord-attachments-uploads-prd.storage.googleapis.com`, `discordactivities.com`, `api.whatsapp.com`, `v.whatsapp.net`, `reddit.com`, `www.reddit.com`, `old.reddit.com`, `oauth.reddit.com`, `gateway.reddit.com`, `redd.it`, `github.com`, `www.github.com`, `api.github.com`, `raw.githubusercontent.com`, `avatars.githubusercontent.com`, `objects.githubusercontent.com`, `camo.githubusercontent.com`, `gist.github.com`, `media.licdn.com`, `spotify.com`, `open.spotify.com`, `api.spotify.com`, `soundcloud.com`, `www.soundcloud.com`, `sndcdn.com`, `a-v2.sndcdn.com`, `style.sndcdn.com`, `assets.web.soundcloud.cloud`, `playback.media-streaming.soundcloud.cloud`, `google.com`, `www.google.com`, `accounts.google.com`, `googleapis.com`, `gstatic.com`, `googleusercontent.com`, `fonts.googleapis.com`, `fonts.gstatic.com`, `play.google.com`, `cloudflare.com`, `www.cloudflare.com`, `cloudflare-dns.com`, `api.devices.cloudflare.com`, `connectivity.cloudflareclient.com`, `notifications.cloudflareclient.com`, `cloudflareportal.com`, `cloudflareok.com`, `cloudflarecp.com`, `warp.plus`, `cloudflareclient.com`, `steamcommunity.com`, `store.steampowered.com`, `api.steampowered.com`, `steampowered.com`, `cdn.steamstatic.com`, `www.epicgames.com`, `discordstatus.com`, `microsoft.com`, `www.microsoft.com`, `account.microsoft.com`, `live.com`, `outlook.com`, `outlook.office.com`, `office.com`, `office365.com`, `www.office365.com`, `teams.microsoft.com`, `teams.live.com`, `skype.com`, `onedrive.com`, `www.onedrive.com`, `www.microsoft365.com`, `cloud.microsoft`, `portal.azure.com`, `xbox.com`, `www.xbox.com`, `visualstudio.com`, `dev.azure.com`, `ea.com`, `www.ea.com`, `blizzard.com`, `www.playstation.com`, `nintendo.com`, `www.nintendo.com`

**ME:** `www.dailymotion.com`, `streamable.com`, `rezka.ag`, `hdrezka.co`, `rezka-ua.tv`, `hdrezka.tv`, `hdrezka.me`, `hdrezka.one`, `hdrezka.info`, `hq.hdrezka.info`, `hdrezka.website`, `rezka.io`, `hdrezka.run`, `hdrezka.sh`, `hdrezka.ink`, `hdrezka.zone`, `rutracker.org`, `rustorka.com`, `nnmclub.to`, `instagram.com`, `www.instagram.com`, `i.instagram.com`, `scontent.cdninstagram.com`, `scontent.xx.fbcdn.net`, `fbcdn.net`, `m.facebook.com`, `graph.facebook.com`, `fbsbx.com`, `twitter.com`, `api.twitter.com`, `abs.twimg.com`, `pbs.twimg.com`, `video.twimg.com`, `t.co`, `graph.facebook.com`, `medium.com`, `www.medium.com`, `cdn-images-1.medium.com`, `cdn-images-2.medium.com`, `linkedin.com`, `www.linkedin.com`, `api.linkedin.com`, `googleadservices.com`

**TS:** `chatgpt.com`, `openai.com`, `chat.openai.com`, `api.openai.com`, `ws.chatgpt.com`, `oaistatic.com`, `anthropic.com`, `api.anthropic.com`, `claudeusercontent.com`, `gemini.google.com`, `ai.google.dev`, `generativelanguage.googleapis.com`, `copilot.microsoft.com`, `bing.com`, `copilot.com`, `perplexity.ai`, `api.perplexity.ai`, `grok.com`, `x.ai`, `api.x.ai`, `mistral.ai`, `chat.mistral.ai`, `api.mistral.ai`, `deepseek.com`, `api.deepseek.com`, `meta.ai`, `qwen.ai`, `moonshot.ai`, `poe.com`, `character.ai`, `huggingface.co`, `replicate.com`, `together.ai`, `cohere.com`, `ai21.com`, `stability.ai`, `youtu.be`, `s.ytimg.com`, `i.ytimg.com`, `googleapis.com`, `www.netflix.com`, `netflix.net`, `netflix.ca`, `twitch.tv`, `www.twitch.tv`, `vimeo.com`, `www.vimeo.com`, `api.vimeo.com`, `dailymotion.com`, `www.dailymotion.com`, `rumble.com`, `www.rumble.com`, `www.kick.com`, `hdrezka.ag`, `rezka.ag`, `hdrezka.co`, `rezka-ua.tv`, `hdrzk.org`, `hdrezka.tv`, `hdrezka.me`, `hdrezka.website`, `rezka.io`, `hdrezka.run`, `hdrezka.sh`, `hdrezka.zone`, `rutracker.org`, `rustorka.com`, `nnmclub.to`, `tapochek.net`, `instagram.com`, `www.instagram.com`, `i.instagram.com`, `scontent.cdninstagram.com`, `scontent.xx.fbcdn.net`, `fbcdn.net`, `m.facebook.com`, `graph.facebook.com`, `connect.facebook.net`, `fbsbx.com`, `x.com`, `www.x.com`, `twitter.com`, `api.twitter.com`, `abs.twimg.com`, `pbs.twimg.com`, `video.twimg.com`, `t.co`, `discord.com`, `discordapp.com`, `discord.gg`, `discord.media`, `discordcdn.com`, `cdn.discordapp.com`, `media.discordapp.net`, `discord-attachments-uploads-prd.storage.googleapis.com`, `discordactivities.com`, `api.whatsapp.com`, `graph.facebook.com`, `v.whatsapp.net`, `reddit.com`, `www.reddit.com`, `old.reddit.com`, `oauth.reddit.com`, `gateway.reddit.com`, `redditmedia.com`, `github.com`, `www.github.com`, `api.github.com`, `raw.githubusercontent.com`, `avatars.githubusercontent.com`, `objects.githubusercontent.com`, `camo.githubusercontent.com`, `gist.github.com`, `medium.com`, `www.medium.com`, `cdn-images-1.medium.com`, `cdn-images-2.medium.com`, `www.linkedin.com`, `api.linkedin.com`, `media.licdn.com`, `spotify.com`, `open.spotify.com`, `api.spotify.com`, `soundcloud.com`, `www.soundcloud.com`, `sndcdn.com`, `a-v2.sndcdn.com`, `style.sndcdn.com`, `assets.web.soundcloud.cloud`, `playback.media-streaming.soundcloud.cloud`, `google.com`, `www.google.com`, `accounts.google.com`, `googleapis.com`, `gstatic.com`, `googleusercontent.com`, `googleadservices.com`, `google-analytics.com`, `fonts.googleapis.com`, `fonts.gstatic.com`, `play.google.com`, `cloudflare.com`, `www.cloudflare.com`, `cloudflare-dns.com`, `api.cloudflare.com`, `api.devices.cloudflare.com`, `engage.cloudflareclient.com`, `connectivity.cloudflareclient.com`, `notifications.cloudflareclient.com`, `cloudflareportal.com`, `cloudflareok.com`, `cloudflarecp.com`, `warp.plus`, `cloudflareclient.com`, `steamcommunity.com`, `store.steampowered.com`, `steampowered.com`, `cdn.steamstatic.com`, `www.epicgames.com`, `epicgames.dev`, `discordstatus.com`, `microsoft.com`, `www.microsoft.com`, `login.microsoftonline.com`, `account.microsoft.com`, `live.com`, `outlook.com`, `outlook.office.com`, `office.com`, `www.office.com`, `office365.com`, `www.office365.com`, `teams.microsoft.com`, `teams.live.com`, `skype.com`, `onedrive.com`, `www.onedrive.com`, `sharepoint.com`, `microsoft365.com`, `www.microsoft365.com`, `cloud.microsoft`, `azure.com`, `portal.azure.com`, `windows.com`, `xbox.com`, `www.xbox.com`, `visualstudio.com`, `dev.azure.com`, `ea.com`, `www.ea.com`, `www.nintendo.com`

**TF:** `claude.ai`, `api.perplexity.ai`, `cloudflare.com`, `epicgames.com`, `outlook.com`, `outlook.office.com`, `office365.com`, `www.office365.com`, `teams.live.com`, `onedrive.com`, `www.onedrive.com`, `www.microsoft365.com`

**TC:** `hdrzk.org`, `media.licdn.com`

**QF:** `openai.com`, `api.openai.com`, `ws.chatgpt.com`, `oaistatic.com`, `claude.ai`, `anthropic.com`, `claudeusercontent.com`, `gemini.google.com`, `ai.google.dev`, `generativelanguage.googleapis.com`, `copilot.microsoft.com`, `perplexity.ai`, `api.perplexity.ai`, `grok.com`, `mistral.ai`, `api.mistral.ai`, `poe.com`, `character.ai`, `huggingface.co`, `replicate.com`, `together.ai`, `ai21.com`, `youtube.com`, `www.youtube.com`, `m.youtube.com`, `youtu.be`, `youtubei.googleapis.com`, `youtube.googleapis.com`, `s.ytimg.com`, `i.ytimg.com`, `googleapis.com`, `twitch.tv`, `www.twitch.tv`, `vimeo.com`, `www.vimeo.com`, `api.vimeo.com`, `www.dailymotion.com`, `tiktokv.com`, `rumble.com`, `www.rumble.com`, `kick.com`, `www.kick.com`, `hdrezka.co`, `hdrezka.tv`, `rezka.io`, `hdrezka.run`, `hdrezka.ink`, `hdrezka.zone`, `youtube.ru`, `rutracker.org`, `rustorka.com`, `nnmclub.to`, `instagram.com`, `i.instagram.com`, `scontent.cdninstagram.com`, `scontent.xx.fbcdn.net`, `fbcdn.net`, `m.facebook.com`, `graph.facebook.com`, `fbsbx.com`, `discord.com`, `discordapp.com`, `cdn.discordapp.com`, `media.discordapp.net`, `discord-attachments-uploads-prd.storage.googleapis.com`, `reddit.com`, `www.reddit.com`, `old.reddit.com`, `oauth.reddit.com`, `gateway.reddit.com`, `redditmedia.com`, `redd.it`, `medium.com`, `www.medium.com`, `cdn-images-1.medium.com`, `cdn-images-2.medium.com`, `linkedin.com`, `www.linkedin.com`, `api.linkedin.com`, `media.licdn.com`, `spotify.com`, `open.spotify.com`, `api.spotify.com`, `google.com`, `www.google.com`, `accounts.google.com`, `googleapis.com`, `gstatic.com`, `googleusercontent.com`, `googleadservices.com`, `google-analytics.com`, `fonts.googleapis.com`, `fonts.gstatic.com`, `play.google.com`, `cloudflare.com`, `www.cloudflare.com`, `cloudflare-dns.com`, `warp.plus`, `cdn.steamstatic.com`, `www.epicgames.com`, `discordstatus.com`, `outlook.office.com`, `teams.live.com`, `www.microsoft365.com`, `www.xbox.com`, `ea.com`, `www.ea.com`, `www.nintendo.com`

**QI:** `connect.facebook.net`, `sharepoint.com`

## 6. Duplicates

2609: no duplicate domain sections.

2709 duplicate domain sections:
- `tiktok.com`: lines 31008
- `www.tiktok.com`: lines 31194
- `graph.facebook.com`: lines 36944
- `googleapis.com`: lines 47956
- `googlevideo.com`: lines 48642

The five duplicates are `googlevideo.com`, `googleapis.com`, `tiktok.com`, `www.tiktok.com`, `graph.facebook.com`. They must not be counted as five extra unique domains.

## 7. Contradictions / discrepancies

### ME
2609: candidate AVAILABLE 0 unique domains vs explicit FOUND 11.  
2709: candidate AVAILABLE 0 unique domains vs explicit FOUND 42.

### HF
2609: candidate AVAILABLE 0 unique domains; explicit FOUND 0.  
2709: candidate AVAILABLE 0 unique domains; explicit FOUND 0.

### TS
2609: 0 candidate domains vs 90 FOUND domains.  
2709: 0 candidate domains vs 189 FOUND domains.

### QF
2609: 0 candidate domains vs 42 FOUND domains.  
2709: 0 candidate domains vs 107 FOUND domains.

The strong correlation for TS/QF is materially different from HF and ME, so they should not receive the same evidence label.

## 8. 2609 → 2709 domain population

- 2609 unique: 140
- 2709 unique: 296
- overlap: 139
- only 2609: 1
- only 2709: 157

### Only 2609
`1.1.1.1`

### Only 2709
`abs.twimg.com`, `ai.google.dev`, `ai21.com`, `anthropic.com`, `api.anthropic.com`, `api.deepseek.com`, `api.epicgames.com`, `api.linkedin.com`, `api.mistral.ai`, `api.openai.com`, `api.perplexity.ai`, `api.spotify.com`, `api.twitter.com`, `api.vimeo.com`, `api.x.ai`, `audio4.spotifycdn.com`, `avatars.githubusercontent.com`, `b-graph.facebook.com`, `bing.com`, `bytefcdn-oversea.com`, `byteoversea.com`, `camo.githubusercontent.com`, `cdn-images-1.medium.com`, `cdn-images-2.medium.com`, `cdn-telegram.org`, `cdn.discordapp.com`, `cdn.steamstatic.com`, `character.ai`, `chat.deepseek.com`, `chat.mistral.ai`, `chat.openai.com`, `chatgpt.com`, `claude.ai`, `claudeusercontent.com`, `cloudflareclient.com`, `cohere.com`, `connect.facebook.net`, `copilot.com`, `copilot.microsoft.com`, `core.telegram.org`, `dailymotion.com`, `dailymotionapi.com`, `deepseek.com`, `desktop.telegram.org`, `dmcdn.net`, `epicgames.dev`, `epicgamescdn.com`, `f.vimeocdn.com`, `fbsbx.com`, `fonts.googleapis.com`, `fonts.gstatic.com`, `gateway.reddit.com`, `gemini.google.com`, `generativelanguage.googleapis.com`, `ggpht.com`, `gist.github.com`, `githubassets.com`, `githubusercontent.com`, `google-analytics.com`, `googleadservices.com`, `graph.instagram.com`, `grok.com`, `gvt2.com`, `hdrezka.ac`, `hdrezka.ag`, `hdrezka.co`, `hdrezka.cx`, `hdrezka.info`, `hdrezka.ink`, `hdrezka.live`, `hdrezka.me`, `hdrezka.no`, `hdrezka.one`, `hdrezka.run`, `hdrezka.sh`, `hdrezka.tv`, `hdrezka.website`, `hdrezka.zone`, `hdrzk.org`, `hq.hdrezka.info`, `huggingface.co`, `i.vimeocdn.com`, `i.ytimg.com`, `ibytedtos.com`, `ibytedtos.com.akamaized.net`, `kick.com`, `kickcdn.com`, `kimi.com`, `llama.com`, `m.facebook.com`, `m.youtube.com`, `media.discordapp.net`, `media.licdn.com`, `meta.ai`, `mistral.ai`, `moonshot.ai`, `muscdn.com`, `muscdn.com.akamaized.net`, `netflix.ca`, `netflix.com`, `netflix.net`, `nflxext.com`, `nflximg.com`, `nflximg.net`, `nflxvideo.net`, `oaistatic.com`, `oaiusercontent.com`, `oauth.reddit.com`, `objects.githubusercontent.com`, `old.reddit.com`, `open.spotify.com`, `openai.com`, `pbs.twimg.com`, `perplexity.ai`, `poe.com`, `qwen.ai`, `qwenchat.ai`, `redd.it`, `redditmedia.com`, `replicate.com`, `rezka-ua.tv`, `rezka.ag`, `rezka.io`, `rumble.com`, `s.ytimg.com`, `scontent.xx.fbcdn.net`, `spotifycdn.com`, `stability.ai`, `static.hdrezka.ag`, `steamstatic.com`, `streamable.com`, `t.co`, `telegram-cdn.org`, `tiktokcdn.com`, `tiktokv.com`, `together.ai`, `twitchcdn.net`, `v.whatsapp.net`, `video.twimg.com`, `vimeo.com`, `vimeocdn.com`, `wa.me`, `warp.plus`, `web.telegram.org`, `whatsapp-cdn.net`, `ws.chatgpt.com`, `www.dailymotion.com`, `www.facebook.com`, `www.kick.com`, `www.medium.com`, `www.netflix.com`, `www.rumble.com`, `www.soundcloud.com`, `www.tiktok.com`, `www.vimeo.com`, `www.x.com`, `x.ai`

## 9. Telegram

2609: `telegram.org`, `www.telegram.org`, `t.me`, `telegram.me`, `api.telegram.org`.  
2709 adds `core.telegram.org`, `web.telegram.org`, `desktop.telegram.org`, `cdn-telegram.org`, `telegram-cdn.org`.

No explicit FOUND records for Telegram in either log. `telegram.org` and `api.telegram.org` show HTTP timeout/UNAVAILABLE in the raw sections. This means these logs do not supply a proven Telegram strategy.

## 10. AI

2709 greatly expands the AI inventory: OpenAI/ChatGPT, Anthropic/Claude, Gemini/Google AI, Copilot/Bing, Perplexity, xAI/Grok, Mistral, DeepSeek, Meta AI/Llama, Qwen, Kimi/Moonshot, Poe, Character, HuggingFace, Replicate, Together, Cohere, AI21, Stability.

The dominant explicit pattern for many major AI hostnames is **HC + TS + QF**, but individual API/asset hosts often have a subset. Do not collapse all subdomains into one rule solely by brand.

## 11. Video + HDRezka

2709 expands YouTube/CDN, Netflix, Twitch, Vimeo, Dailymotion, TikTok, Rumble, Kick, Streamable and many assets.

HDRezka is scanned as a large family only in 2709. It does **not** have one universal class:
- ME is common on several hdrezka/rezka hostnames.
- TS and QF appear on subsets.
- `hdrzk.org` also has the new TC class.

A concrete raw example is `hdrezka.co`: baseline HTTP timeout; HC timeout; ME AVAILABLE and explicit FOUND; fake-default-http gives suspicious redirect to `ufanet.ru/blocking.html`.

## 12. Full domain/section matrix — 2609

Baseline: A=AVAILABLE, U=UNAVAILABLE, D=aborted/DNS, U/S=suspicious redirect. CAND-A lists raw candidate AVAILABLE codes. FOUND lists only explicit working-found codes.

|#|line|occ|domain|HTTP|TLS12|TLS13|QUIC|CAND-A|FOUND|
|---:|---:|---:|---|---|---|---|---|---|---|
|1|61|1|youtube.com|A|U|U|U|—|HC+QF|
|2|448|1|www.youtube.com|A|U|U|U|—|HC+QF|
|3|869|1|youtube.ru|A|U|U|A|—|HC+QF|
|4|1103|1|youtu.be|A|U|U|U|—|HC+QF+TS|
|5|1337|1|googlevideo.com|U/S|U|U|U|—|—|
|6|1871|1|ytimg.com|U|U|U|U|—|—|
|7|1893|1|youtubei.googleapis.com|A|U|U|U|—|HC+QF|
|8|2484|1|youtube.googleapis.com|A|U|U|A|—|HC+QF|
|9|3076|1|googleapis.com|A|A|A|A|—|HC+QF+TS|
|10|3310|1|gvt1.com|U|U|U|U|—|—|
|11|3332|1|rutracker.org|U|U|U|U|—|ME+QF+TS|
|12|3521|1|rustorka.com|U|U|U|U|—|ME+QF+TS|
|13|3710|1|rutor.info|U|U|U|U|—|ME|
|14|3878|1|nnmclub.to|U|U|U|U|—|ME+TS|
|15|4056|1|nnm-club.name|U|U|U|U|—|—|
|16|4225|1|kinozal.tv|U|U|U|U|—|—|
|17|4388|1|torrents.ru|A|U|U|U|—|HC|
|18|4586|1|tapochek.net|A|A|A|U|—|HC+TS|
|19|4820|1|instagram.com|U|U|U|U|—|—|
|20|4969|1|www.instagram.com|U|U|U|U|—|ME+TS|
|21|5171|1|i.instagram.com|U|U|U|U|—|—|
|22|5334|1|cdninstagram.com|U|U|U|U|—|—|
|23|5356|1|scontent.cdninstagram.com|U|U|U|U|—|—|
|24|5512|1|fbcdn.net|U|U|U|U|—|—|
|25|5668|1|facebook.com|U|U|U|U|—|ME+QF+TS|
|26|5869|1|x.com|A|U|U|U|—|HC+TS|
|27|6073|1|twitter.com|U|U|U|U|—|ME+TS|
|28|6241|1|tiktok.com|U|U|A|U|—|HC|
|29|6478|1|twitch.tv|A|A|A|A|—|HC+QF+TS|
|30|6865|1|www.twitch.tv|A|A|A|A|—|HC+QF+TF+TS|
|31|7253|1|ttvnw.net|U|U|U|U|—|—|
|32|7275|1|jtvnw.net|U|U|U|U|—|—|
|33|7297|1|discord.com|U|U|U|U|—|HC+QF+TS|
|34|7509|1|discordapp.com|A|U|U|U|—|HC+QF+TS|
|35|7768|1|discordapp.net|U|U|U|U|—|—|
|36|7790|1|discord.gg|A|A|A|U|—|HC+TS|
|37|8078|1|discord.media|A|A|A|U|—|HC+TS|
|38|8359|1|discordcdn.com|U|A|A|U|—|HC+TS|
|39|8603|1|discord-attachments-uploads-prd.storage.googleapis.com|A|U|U|U|—|HC+QF+TS|
|40|9164|1|discord-activities.com|U|U|U|U|—|—|
|41|9186|1|discordactivities.com|A|A|A|U|—|HC+TS|
|42|9406|1|telegram.org|U|U|U|U|—|—|
|43|9605|1|www.telegram.org|U|U|U|U|—|—|
|44|9774|1|t.me|U|U|U|U|—|—|
|45|9936|1|telegram.me|U|U|U|U|—|—|
|46|10105|1|api.telegram.org|U|U|U|U|—|—|
|47|10274|1|whatsapp.com|U|U|U|U|—|—|
|48|10441|1|www.whatsapp.com|A|U|U|U|—|HC+QF+TS|
|49|10645|1|web.whatsapp.com|U|U|U|U|—|—|
|50|10807|1|whatsapp.net|A|A|U|A|—|HC+QF+TS|
|51|11036|1|api.whatsapp.com|A|U|U|U|—|HC+QF+TS|
|52|11240|1|graph.facebook.com|U|U|U|U|—|ME+QF+TS|
|53|11441|1|reddit.com|A|U|U|A|—|HC+QF+TS|
|54|11641|1|www.reddit.com|A|A|A|A|—|HC+QF+TS|
|55|12018|1|github.com|A|A|A|U|—|HC+TS|
|56|12250|1|www.github.com|A|U|A|U|—|HC+TS|
|57|12445|1|api.github.com|A|A|A|U|—|HC+TS|
|58|12682|1|raw.githubusercontent.com|A|A|A|U|—|HC+TS|
|59|13069|1|medium.com|U|U|U|U|—|ME+QF+TS|
|60|13258|1|linkedin.com|U|U|U|U|—|ME+QF+TS|
|61|13426|1|www.linkedin.com|U|U|U|U|—|ME+QF+TS|
|62|13615|1|spotify.com|A|A|A|A|—|HC+QF+TS|
|63|13847|1|soundcloud.com|A|U|U|U|—|HC+TS|
|64|14084|1|sndcdn.com|A|A|A|U|—|HC+TS|
|65|14351|1|a-v2.sndcdn.com|A|A|A|U|—|HC+TS|
|66|14618|1|style.sndcdn.com|A|U|A|U|—|HC+TS|
|67|14851|1|assets.web.soundcloud.cloud|A|A|A|U|—|HC+TS|
|68|15118|1|playback.media-streaming.soundcloud.cloud|A|A|A|U|—|HC+TS|
|69|15385|1|google.com|A|A|A|A|—|HC+QF+TS|
|70|15619|1|www.google.com|A|A|A|A|—|HC+QF+TS|
|71|16210|1|accounts.google.com|A|A|A|A|—|HC+QF+TS|
|72|16444|1|play.google.com|A|U|U|U|—|HC+QF+TS|
|73|16903|1|googleusercontent.com|A|A|A|A|—|HC+QF+TS|
|74|17137|1|gstatic.com|A|U|A|A|—|HC+QF+TS|
|75|17366|1|cloudflare.com|A|A|A|A|—|HC+QF+TS|
|76|17591|1|www.cloudflare.com|A|A|A|A|—|HC+QF+TS|
|77|17817|1|cloudflare-dns.com|A|A|A|A|—|HC+QF+TF|
|78|18103|1|1.1.1.1|U|U|U|U|—|—|
|79|18125|1|api.cloudflare.com|U|A|A|U|—|TS|
|80|18377|1|api.devices.cloudflare.com|A|A|A|U|—|HC+TS|
|81|18602|1|engage.cloudflareclient.com|U|U|U|U|—|TS|
|82|18773|1|connectivity.cloudflareclient.com|A|U|U|U|—|HC+TS|
|83|18968|1|zero-trust-client.cloudflare.com|U|U|U|U|—|—|
|84|18991|1|notifications.cloudflareclient.com|A|U|A|U|—|HC+TS|
|85|19180|1|cloudflareportal.com|A|A|A|U|—|HC+TS|
|86|19406|1|cloudflareok.com|A|A|U|U|—|HC+TS|
|87|19605|1|cloudflarecp.com|A|U|A|U|—|HC+TS|
|88|19804|1|steamcommunity.com|A|A|U|U|—|HC+TS|
|89|20001|1|store.steampowered.com|A|A|A|U|—|HC+TS|
|90|20230|1|api.steampowered.com|A|A|A|U|—|HC|
|91|20582|1|steamcontent.com|U|U|U|U|—|—|
|92|20604|1|steampowered.com|A|A|A|U|—|HC+TS|
|93|20838|1|epicgames.com|U/S|A|A|U|—|TS|
|94|21174|1|www.epicgames.com|A|A|A|A|—|HC+QF+TS|
|95|21399|1|discordstatus.com|A|A|A|A|—|HC+QF+TS|
|96|21666|1|microsoft.com|A|A|A|U|—|HC+TS|
|97|21900|1|www.microsoft.com|A|A|U|U|—|HC+TS|
|98|22095|1|login.microsoftonline.com|U/S|A|A|U|—|TS|
|99|22589|1|microsoftonline.com|U|U|U|U|—|—|
|100|22611|1|account.microsoft.com|A|A|A|U|—|HC+TS|
|101|22845|1|live.com|A|A|A|U|—|HC+TS|
|102|23079|1|login.live.com|U/S|A|U|U|—|—|
|103|23520|1|outlook.com|A|A|A|U|—|HC+TF+TS|
|104|24190|1|outlook.office.com|A|A|A|A|—|HC+QF+TF+TS|
|105|24589|1|office.com|A|A|A|U|—|HC+TS|
|106|24818|1|www.office.com|U|A|A|U|—|TS|
|107|25053|1|office365.com|A|A|A|U|—|HC+TF+TS|
|108|25338|1|www.office365.com|A|A|A|U|—|HC+TF+TS|
|109|25623|1|teams.microsoft.com|A|A|A|U|—|HC+TS|
|110|25908|1|teams.live.com|A|A|A|U|—|HC+TS|
|111|26188|1|skype.com|A|A|U|U|—|HC+TS|
|112|26619|1|onedrive.com|A|A|A|U|—|HC+TF+TS|
|113|26856|1|www.onedrive.com|A|A|A|U|—|HC+TF|
|114|27094|1|sharepoint.com|U/S|A|A|A|—|QI+TS|
|115|27380|1|sharepointonline.com|U|U|U|U|—|—|
|116|27557|1|microsoft365.com|U/S|A|A|U|—|TS|
|117|27786|1|www.microsoft365.com|A|A|A|A|—|HC+QF+TF+TS|
|118|28185|1|cloud.microsoft|A|U|A|U|—|HC+TS|
|119|28618|1|static.microsoft|U|U|U|U|—|—|
|120|28640|1|usercontent.microsoft|U|U|U|U|—|—|
|121|28662|1|azure.com|U/S|U|A|U|—|TF+TS|
|122|28987|1|portal.azure.com|A|A|A|U|—|HC+TS|
|123|29221|1|azureedge.net|U|U|U|U|—|—|
|124|29243|1|windows.com|U/S|A|A|U|—|TS|
|125|29680|1|windowsupdate.com|U|U|U|U|—|—|
|126|29702|1|xbox.com|A|A|A|U|—|HC+TS|
|127|30140|1|www.xbox.com|A|A|A|A|—|HC+QF+TS|
|128|30374|1|xboxlive.com|U/S|U|U|U|—|—|
|129|30857|1|xboxservices.com|U|U|U|U|—|—|
|130|30879|1|visualstudio.com|A|A|A|U|—|HC+TS|
|131|31164|1|dev.azure.com|A|A|A|U|—|HC+TS|
|132|31449|1|azurefd.net|U|U|U|U|—|—|
|133|31471|1|ea.com|A|A|A|A|—|HC+QF+TS|
|134|31705|1|www.ea.com|A|A|A|A|—|HC+QF+TS|
|135|31939|1|battle.net|U/S|A|U|U|—|—|
|136|32194|1|blizzard.com|A|A|U|U|—|HC|
|137|32449|1|playstation.com|U/S|A|U|U|—|—|
|138|32710|1|www.playstation.com|A|A|U|U|—|HC|
|139|32929|1|nintendo.com|A|A|U|U|—|HC|
|140|33151|1|www.nintendo.com|A|A|A|A|—|HC+QF+TS|

## 13. Full domain/section matrix — 2709

|#|line|occ|domain|HTTP|TLS12|TLS13|QUIC|CAND-A|FOUND|
|---:|---:|---:|---|---|---|---|---|---|---|
|1|61|1|chatgpt.com|A|A|A|U|—|HC+TS|
|2|286|1|openai.com|A|A|A|A|—|HC+QF+TS|
|3|511|1|chat.openai.com|U/S|A|A|U|—|TS|
|4|736|1|api.openai.com|A|A|A|A|—|HC+QF+TS|
|5|961|1|ws.chatgpt.com|A|A|A|A|—|HC+QF+TS|
|6|1181|1|oaistatic.com|A|A|A|A|—|HC+QF+TS|
|7|1406|1|oaiusercontent.com|U|U|U|U|—|—|
|8|1428|1|claude.ai|U/S|A|A|A|—|QF+TF|
|9|1633|1|anthropic.com|A|A|A|A|—|HC+QF+TS|
|10|1837|1|api.anthropic.com|U|A|A|U|—|TS|
|11|2041|1|claudeusercontent.com|U/S|U|A|A|—|QF+TS|
|12|2223|1|gemini.google.com|A|A|A|A|—|HC+QF+TS|
|13|2814|1|ai.google.dev|A|A|A|A|—|HC+QF+TS|
|14|3048|1|generativelanguage.googleapis.com|A|A|A|A|—|HC+QF+TS|
|15|3637|1|copilot.microsoft.com|A|A|A|A|—|HC+QF+TS|
|16|3862|1|bing.com|A|A|A|U|—|HC+TS|
|17|4147|1|copilot.com|A|A|A|U|—|HC+TS|
|18|4381|1|perplexity.ai|A|A|A|A|—|HC+QF+TS|
|19|4606|1|api.perplexity.ai|A|A|A|A|—|HC+QF+TF+TS|
|20|4832|1|grok.com|A|A|A|A|—|HC+QF+TS|
|21|5057|1|x.ai|A|A|A|U|—|HC+TS|
|22|5282|1|api.x.ai|A|A|A|U|—|HC+TS|
|23|5507|1|mistral.ai|A|A|A|A|—|HC+QF+TS|
|24|5732|1|chat.mistral.ai|A|A|A|U|—|HC+TS|
|25|5999|1|api.mistral.ai|A|A|A|A|—|HC+QF+TS|
|26|6222|1|deepseek.com|A|A|A|U|—|HC+TS|
|27|6426|1|chat.deepseek.com|A|A|A|U|—|HC|
|28|6630|1|api.deepseek.com|A|A|A|U|—|HC+TS|
|29|6834|1|meta.ai|A|A|A|U|—|HC+TS|
|30|7071|1|llama.com|U|U|U|U|—|—|
|31|7266|1|qwen.ai|U/S|A|A|U|—|TS|
|32|7552|1|qwenchat.ai|A|U|U|U|—|HC|
|33|7775|1|kimi.com|A|A|A|U|—|HC|
|34|8009|1|moonshot.ai|A|A|A|U|—|HC+TS|
|35|8234|1|poe.com|A|A|U|A|—|HC+QF+TS|
|36|8433|1|character.ai|A|A|A|A|—|HC+QF+TS|
|37|8658|1|huggingface.co|A|A|A|A|—|HC+QF+TS|
|38|8925|1|replicate.com|A|A|U|A|—|HC+QF+TS|
|39|9124|1|together.ai|A|A|A|A|—|HC+QF+TS|
|40|9328|1|cohere.com|A|A|A|U|—|HC+TS|
|41|9527|1|ai21.com|A|A|A|A|—|HC+QF+TS|
|42|9753|1|stability.ai|A|U|U|U|—|HC+TS|
|43|10020|1|youtube.com|A|U|U|U|—|HC+QF|
|44|10407|1|www.youtube.com|A|U|U|U|—|HC+QF|
|45|10998|1|m.youtube.com|A|U|U|U|—|HC+QF|
|46|11232|1|youtu.be|A|U|U|U|—|HC+QF+TS|
|47|11619|1|youtubei.googleapis.com|A|U|U|U|—|HC+QF|
|48|12210|1|youtube.googleapis.com|A|U|U|A|—|HC+QF|
|49|12801|1|googlevideo.com|U/S|U|U|U|—|—|
|50|13284|1|ytimg.com|U|U|U|U|—|—|
|51|13306|1|s.ytimg.com|U|U|U|U|—|HC+QF+TS|
|52|13524|1|i.ytimg.com|A|U|U|U|—|HC+QF+TS|
|53|14064|1|ggpht.com|U|U|U|U|—|—|
|54|14086|1|googleapis.com|A|A|U|A|—|HC+QF+TS|
|55|14283|1|gvt1.com|U|U|U|U|—|—|
|56|14305|1|gvt2.com|U|U|U|U|—|—|
|57|14327|1|netflix.com|A|A|A|U|—|HC|
|58|14663|1|www.netflix.com|A|A|A|U|—|HC+TS|
|59|14948|1|netflix.net|U/S|U|A|U|—|TS|
|60|15347|1|netflix.ca|U/S|A|A|U|—|TS|
|61|15746|1|nflxvideo.net|U/S|U|U|U|—|—|
|62|16001|1|nflximg.net|U|U|U|U|—|—|
|63|16023|1|nflximg.com|U|U|U|U|—|—|
|64|16222|1|nflxext.com|U|U|U|U|—|—|
|65|16422|1|twitch.tv|A|U|A|A|—|HC+QF+TS|
|66|16710|1|www.twitch.tv|A|A|A|A|—|HC+QF+TS|
|67|17097|1|ttvnw.net|U|U|U|U|—|—|
|68|17119|1|jtvnw.net|U|U|U|U|—|—|
|69|17141|1|twitchcdn.net|U|U|U|U|—|—|
|70|17163|1|vimeo.com|A|A|U|A|—|HC+QF+TS|
|71|17362|1|www.vimeo.com|U/S|A|A|A|—|QF+TS|
|72|17585|1|vimeocdn.com|A|A|U|U|—|HC|
|73|17878|1|api.vimeo.com|A|A|A|A|—|HC+QF+TS|
|74|18103|1|i.vimeocdn.com|A|A|U|U|—|HC|
|75|18431|1|f.vimeocdn.com|A|A|U|U|—|HC|
|76|18758|1|dailymotion.com|U|U|U|U|—|TS|
|77|18934|1|www.dailymotion.com|U|U|U|U|—|ME+QF+TS|
|78|19165|1|dmcdn.net|A|U|U|U|—|HC|
|79|19439|1|dailymotionapi.com|U|U|U|U|—|—|
|80|19461|1|tiktok.com|A|A|A|U|—|HC|
|81|19705|1|www.tiktok.com|A|A|A|U|—|HC|
|82|20342|1|tiktokcdn.com|U|U|U|U|—|—|
|83|20364|1|tiktokv.com|A|A|A|A|—|HC+QF|
|84|20736|1|byteoversea.com|U|U|U|U|—|—|
|85|20758|1|bytefcdn-oversea.com|U|U|U|U|—|—|
|86|20780|1|ibytedtos.com|U|U|U|U|—|—|
|87|20802|1|ibytedtos.com.akamaized.net|U|U|U|U|—|—|
|88|20824|1|muscdn.com|U|U|U|U|—|—|
|89|20846|1|muscdn.com.akamaized.net|U|U|U|U|—|—|
|90|20868|1|rumble.com|A|U|U|U|—|HC+QF+TS|
|91|21063|1|www.rumble.com|A|U|U|A|—|HC+QF+TS|
|92|21247|1|kick.com|A|A|A|A|—|HC+QF|
|93|21467|1|www.kick.com|A|A|A|A|—|HC+QF+TS|
|94|21692|1|kickcdn.com|U|U|U|U|—|—|
|95|21714|1|streamable.com|U|U|U|U|—|ME|
|96|22005|1|hdrezka.ag|U|U|U|U|—|TS|
|97|22171|1|rezka.ag|U|U|U|U|—|ME+TS|
|98|22367|1|hdrezka.co|U|U|U|U|—|ME+QF+TS|
|99|22558|1|rezka-ua.tv|U|U|U|U|—|ME+TS|
|100|22729|1|hdrzk.org|A|A|A|U|—|HC+TC+TS|
|101|22934|1|hdrezka.tv|U|U|U|U|—|ME+QF+TS|
|102|23123|1|hdrezka.me|U|U|U|U|—|ME+TS|
|103|23287|1|hdrezka.ac|U|U|U|U|—|—|
|104|23309|1|hdrezka.one|U|U|U|U|—|ME|
|105|23516|1|hdrezka.info|U|U|U|U|—|ME|
|106|23705|1|hq.hdrezka.info|U|U|U|U|—|ME|
|107|23893|1|hdrezka.website|U|U|U|U|—|ME+TS|
|108|24064|1|hdrezka.live|U|U|U|U|—|—|
|109|24086|1|rezka.io|U|U|U|U|—|ME+QF+TS|
|110|24275|1|hdrezka.run|U|U|U|U|—|ME+QF+TS|
|111|24464|1|hdrezka.cx|U|U|U|U|—|—|
|112|24486|1|hdrezka.no|U|U|U|U|—|—|
|113|24508|1|hdrezka.sh|U|U|U|U|—|ME+TS|
|114|24679|1|hdrezka.ink|U|U|U|U|—|ME+QF|
|115|24868|1|hdrezka.zone|U|U|U|U|—|ME+QF+TS|
|116|25046|1|static.hdrezka.ag|U|U|U|U|—|—|
|117|25195|1|youtube.ru|A|U|U|A|—|HC+QF|
|118|25390|1|rutracker.org|U|U|U|U|—|ME+QF+TS|
|119|25579|1|rustorka.com|U|U|U|U|—|ME+QF+TS|
|120|25757|1|rutor.info|U|U|U|U|—|—|
|121|25955|1|nnmclub.to|U|U|U|U|—|ME+QF+TS|
|122|26144|1|nnm-club.name|U|U|U|U|—|—|
|123|26313|1|kinozal.tv|U|U|U|U|—|—|
|124|26476|1|torrents.ru|A|U|U|U|—|HC|
|125|26674|1|tapochek.net|A|U|U|U|—|HC+TS|
|126|26871|1|instagram.com|U|U|U|U|—|ME+QF+TS|
|127|27127|1|www.instagram.com|U|U|U|U|—|ME+TS|
|128|27328|1|i.instagram.com|U|U|U|U|—|ME+QF+TS|
|129|27507|1|cdninstagram.com|U|U|U|U|—|—|
|130|27529|1|scontent.cdninstagram.com|U|U|U|U|—|ME+QF+TS|
|131|27730|1|scontent.xx.fbcdn.net|U|U|U|U|—|ME+QF+TS|
|132|27909|1|fbcdn.net|U|U|U|U|—|ME+QF+TS|
|133|28110|1|facebook.com|U|U|U|U|—|—|
|134|28273|1|www.facebook.com|U|U|U|U|—|—|
|135|28436|1|m.facebook.com|U|U|U|U|—|ME+QF+TS|
|136|28637|1|graph.facebook.com|U|U|U|U|—|ME+QF+TS|
|137|28838|1|graph.instagram.com|U|U|U|U|—|—|
|138|29001|1|b-graph.facebook.com|U|U|U|U|—|—|
|139|29164|1|connect.facebook.net|A|U|A|A|—|HC+QI+TS|
|140|29364|1|fbsbx.com|U|U|U|U|—|ME+QF+TS|
|141|29565|1|x.com|A|U|U|U|—|HC+TS|
|142|29770|1|www.x.com|A|U|U|U|—|HC+TS|
|143|29952|1|twitter.com|U|U|U|U|—|ME+TS|
|144|30110|1|api.twitter.com|U|U|U|U|—|ME+TS|
|145|30299|1|abs.twimg.com|U|U|U|U|—|ME+TS|
|146|30497|1|pbs.twimg.com|U|U|U|U|—|ME+TS|
|147|30658|1|video.twimg.com|U|U|U|U|—|ME+TS|
|148|30847|1|t.co|U|U|U|U|—|ME+TS|
|149|31008|2|tiktok.com|U|U|A|U|—|HC|
|150|31194|2|www.tiktok.com|A|A|A|U|—|HC|
|151|31836|1|discord.com|A|U|U|U|—|HC+QF+TS|
|152|32094|1|discordapp.com|A|U|U|U|—|HC+QF+TS|
|153|32353|1|discordapp.net|U|U|U|U|—|—|
|154|32375|1|discord.gg|A|A|A|U|—|HC+TS|
|155|32663|1|discord.media|A|A|A|U|—|HC+TS|
|156|32949|1|discordcdn.com|A|A|A|U|—|HC+TS|
|157|33237|1|cdn.discordapp.com|A|A|U|U|—|HC+QF+TS|
|158|33495|1|media.discordapp.net|A|U|U|U|—|HC+QF+TS|
|159|33753|1|discord-attachments-uploads-prd.storage.googleapis.com|A|U|U|U|—|HC+QF+TS|
|160|34416|1|discord-activities.com|U|U|U|U|—|—|
|161|34438|1|discordactivities.com|A|A|A|U|—|HC+TS|
|162|34663|1|telegram.org|U|U|U|U|—|—|
|163|34840|1|www.telegram.org|U|U|U|U|—|—|
|164|35009|1|t.me|U|U|U|U|—|—|
|165|35178|1|telegram.me|U|U|U|U|—|—|
|166|35340|1|api.telegram.org|U|U|U|U|—|—|
|167|35502|1|core.telegram.org|U|U|U|U|—|—|
|168|35671|1|web.telegram.org|U|U|U|U|—|—|
|169|35840|1|desktop.telegram.org|U|U|U|U|—|—|
|170|36009|1|cdn-telegram.org|U|U|U|U|—|—|
|171|36031|1|telegram-cdn.org|U|U|U|U|—|—|
|172|36053|1|whatsapp.com|U|U|U|U|—|—|
|173|36222|1|www.whatsapp.com|U|U|U|U|—|—|
|174|36391|1|web.whatsapp.com|U|U|U|U|—|—|
|175|36553|1|whatsapp.net|U|U|U|U|—|—|
|176|36739|1|api.whatsapp.com|A|U|U|U|—|HC+TS|
|177|36944|2|graph.facebook.com|U|U|U|U|—|ME+QF+TS|
|178|37145|1|v.whatsapp.net|A|U|U|U|—|HC+TS|
|179|37349|1|wa.me|U|U|U|U|—|—|
|180|37543|1|whatsapp-cdn.net|U|U|U|U|—|—|
|181|37565|1|reddit.com|A|A|U|A|—|HC+QF+TS|
|182|37858|1|www.reddit.com|A|A|A|A|—|HC+QF+TS|
|183|38245|1|old.reddit.com|A|A|A|A|—|HC+QF+TS|
|184|38632|1|oauth.reddit.com|A|A|A|A|—|HC+QF+TS|
|185|39019|1|gateway.reddit.com|A|A|A|A|—|HC+QF+TS|
|186|39406|1|redditmedia.com|U/S|A|A|A|—|QF+TS|
|187|39793|1|redd.it|A|U|A|A|—|HC+QF|
|188|40176|1|github.com|A|A|A|U|—|HC+TS|
|189|40413|1|www.github.com|U|U|A|U|—|HC+TS|
|190|40594|1|api.github.com|A|A|A|U|—|HC+TS|
|191|40831|1|raw.githubusercontent.com|A|A|A|U|—|HC+TS|
|192|41216|1|githubusercontent.com|U|U|U|U|—|—|
|193|41238|1|avatars.githubusercontent.com|A|A|A|U|—|HC+TS|
|194|41624|1|objects.githubusercontent.com|A|A|A|U|—|HC+TS|
|195|41951|1|camo.githubusercontent.com|A|A|A|U|—|HC+TS|
|196|42338|1|gist.github.com|A|A|A|U|—|HC+TS|
|197|42575|1|githubassets.com|U|U|U|U|—|—|
|198|42597|1|medium.com|U|U|U|U|—|ME+QF+TS|
|199|42786|1|www.medium.com|U|U|U|U|—|ME+QF+TS|
|200|42975|1|cdn-images-1.medium.com|U|U|U|U|—|ME+QF+TS|
|201|43164|1|cdn-images-2.medium.com|U|U|U|U|—|ME+QF+TS|
|202|43353|1|linkedin.com|U|U|U|U|—|ME+QF|
|203|43522|1|www.linkedin.com|U|U|U|U|—|ME+QF+TS|
|204|43700|1|api.linkedin.com|U|U|U|U|—|ME+QF+TS|
|205|43889|1|media.licdn.com|A|A|A|A|—|HC+QF+TC+TS|
|206|44110|1|spotify.com|A|A|U|A|—|HC+QF+TS|
|207|44310|1|open.spotify.com|U|A|A|A|—|HC+QF+TS|
|208|44660|1|api.spotify.com|A|A|A|A|—|HC+QF+TS|
|209|44897|1|audio4.spotifycdn.com|U|U|U|U|—|—|
|210|44919|1|spotifycdn.com|U|U|U|U|—|—|
|211|44941|1|soundcloud.com|A|U|U|U|—|HC+TS|
|212|45178|1|www.soundcloud.com|A|U|U|U|—|HC+TS|
|213|45396|1|sndcdn.com|A|A|U|U|—|HC+TS|
|214|45629|1|a-v2.sndcdn.com|A|A|A|U|—|HC+TS|
|215|45891|1|style.sndcdn.com|A|A|A|U|—|HC+TS|
|216|46153|1|assets.web.soundcloud.cloud|A|A|U|U|—|HC+TS|
|217|46376|1|playback.media-streaming.soundcloud.cloud|A|A|A|U|—|HC+TS|
|218|46643|1|google.com|A|A|A|A|—|HC+QF+TS|
|219|47132|1|www.google.com|A|A|A|A|—|HC+QF+TS|
|220|47721|1|accounts.google.com|A|U|A|A|—|HC+QF+TS|
|221|47956|2|googleapis.com|A|A|A|A|—|HC+QF+TS|
|222|48190|1|gstatic.com|A|A|A|A|—|HC+QF+TS|
|223|48424|1|googleusercontent.com|U|A|A|A|—|HC+QF+TS|
|224|48642|2|googlevideo.com|U/S|U|U|U|—|—|
|225|49176|1|googleadservices.com|U|U|U|U|—|ME+QF+TS|
|226|49374|1|google-analytics.com|U/S|A|A|A|—|QF+TS|
|227|49609|1|fonts.googleapis.com|A|U|A|A|—|HC+QF+TS|
|228|49806|1|fonts.gstatic.com|A|A|A|A|—|HC+QF+TS|
|229|50040|1|play.google.com|A|U|U|U|—|HC+QF+TS|
|230|50497|1|cloudflare.com|A|A|A|A|—|HC+QF+TF+TS|
|231|50718|1|www.cloudflare.com|A|A|A|A|—|HC+QF+TS|
|232|50943|1|cloudflare-dns.com|A|A|A|A|—|HC+QF+TS|
|233|51223|1|api.cloudflare.com|U|U|A|U|—|TS|
|234|51466|1|api.devices.cloudflare.com|A|A|A|U|—|HC+TS|
|235|51691|1|engage.cloudflareclient.com|U|U|U|U|—|TS|
|236|51861|1|connectivity.cloudflareclient.com|A|U|U|U|—|HC+TS|
|237|52056|1|zero-trust-client.cloudflare.com|U|U|U|U|—|—|
|238|52078|1|notifications.cloudflareclient.com|A|A|A|U|—|HC+TS|
|239|52298|1|cloudflareportal.com|U|U|A|U|—|HC+TS|
|240|52474|1|cloudflareok.com|A|A|A|U|—|HC+TS|
|241|52694|1|cloudflarecp.com|A|A|A|U|—|HC+TS|
|242|52919|1|warp.plus|A|A|A|A|—|HC+QF+TS|
|243|53210|1|cloudflareclient.com|A|A|A|U|—|HC+TS|
|244|53435|1|steamcommunity.com|A|A|A|U|—|HC+TS|
|245|53669|1|store.steampowered.com|A|A|A|U|—|HC+TS|
|246|53903|1|api.steampowered.com|A|A|A|U|—|HC|
|247|54254|1|steamcontent.com|U|U|U|U|—|—|
|248|54276|1|steampowered.com|A|A|A|U|—|HC+TS|
|249|54510|1|cdn.steamstatic.com|A|A|A|A|—|HC+QF+TS|
|250|54795|1|steamstatic.com|U|U|U|U|—|—|
|251|54817|1|epicgames.com|U/S|U|A|U|—|TF|
|252|55079|1|www.epicgames.com|A|A|A|A|—|HC+QF+TS|
|253|55304|1|api.epicgames.com|U|U|U|U|—|—|
|254|55326|1|epicgames.dev|U/S|A|A|U|—|TS|
|255|55662|1|epicgamescdn.com|U|U|U|U|—|—|
|256|55684|1|discordstatus.com|A|A|A|A|—|HC+QF+TS|
|257|55951|1|microsoft.com|A|A|A|U|—|HC+TS|
|258|56186|1|www.microsoft.com|A|A|A|U|—|HC+TS|
|259|56420|1|login.microsoftonline.com|U/S|A|A|U|—|TS|
|260|56916|1|microsoftonline.com|U|U|U|U|—|—|
|261|56938|1|account.microsoft.com|A|U|A|U|—|HC+TS|
|262|57135|1|live.com|A|A|A|U|—|HC+TS|
|263|57369|1|login.live.com|U/S|A|U|U|—|—|
|264|57864|1|outlook.com|A|A|U|U|—|HC+TF+TS|
|265|58523|1|outlook.office.com|A|A|A|A|—|HC+QF+TF+TS|
|266|58922|1|office.com|A|A|A|U|—|HC+TS|
|267|59156|1|www.office.com|U|A|A|U|—|TS|
|268|59390|1|office365.com|A|A|A|U|—|HC+TF+TS|
|269|59675|1|www.office365.com|U|A|A|U|—|HC+TF+TS|
|270|59937|1|teams.microsoft.com|A|A|A|U|—|HC+TS|
|271|60222|1|teams.live.com|U|A|A|A|—|HC+QF+TF+TS|
|272|60748|1|skype.com|A|A|A|U|—|HC+TS|
|273|61186|1|onedrive.com|A|A|A|U|—|HC+TF+TS|
|274|61423|1|www.onedrive.com|A|A|A|U|—|HC+TF+TS|
|275|61655|1|sharepoint.com|U/S|A|A|A|—|QI+TS|
|276|61940|1|sharepointonline.com|U|U|U|U|—|—|
|277|62139|1|microsoft365.com|U/S|A|A|U|—|TS|
|278|62373|1|www.microsoft365.com|A|A|A|A|—|HC+QF+TF+TS|
|279|62772|1|cloud.microsoft|A|A|A|U|—|HC+TS|
|280|63209|1|static.microsoft|U|U|U|U|—|—|
|281|63231|1|usercontent.microsoft|U|U|U|U|—|—|
|282|63253|1|azure.com|U/S|A|A|U|—|TS|
|283|63691|1|portal.azure.com|A|A|A|U|—|HC+TS|
|284|63925|1|azureedge.net|U|U|U|U|—|—|
|285|63947|1|windows.com|U/S|A|A|U|—|TS|
|286|64384|1|windowsupdate.com|U|U|U|U|—|—|
|287|64406|1|xbox.com|A|U|A|U|—|HC+TS|
|288|64730|1|www.xbox.com|A|A|A|A|—|HC+QF+TS|
|289|64964|1|xboxlive.com|U/S|U|U|U|—|—|
|290|65443|1|xboxservices.com|U|U|U|U|—|—|
|291|65465|1|visualstudio.com|A|A|A|U|—|HC+TS|
|292|65750|1|dev.azure.com|A|A|A|U|—|HC+TS|
|293|66035|1|azurefd.net|U|U|U|U|—|—|
|294|66057|1|ea.com|A|A|A|A|—|HC+QF+TS|
|295|66291|1|www.ea.com|A|A|A|A|—|HC+QF+TS|
|296|66525|1|battle.net|U/S|A|U|U|—|—|
|297|66780|1|blizzard.com|A|A|U|U|—|HC|
|298|67035|1|playstation.com|U/S|A|U|U|—|—|
|299|67296|1|www.playstation.com|A|A|U|U|—|HC|
|300|67515|1|nintendo.com|A|A|U|U|—|HC|
|301|67735|1|www.nintendo.com|A|A|A|A|—|HC+QF+TS|

## 14. What really transfers to Zapret2/OpenWrt

The raw desync expressions are native zapret2-style Lua strategy components. The **Windows interception wrappers are not portable verbatim**.

Official references:
- https://github.com/bol-van/zapret2/blob/master/docs/readme.md
- https://github.com/bol-van/zapret2/blob/master/blockcheck2.d/standard/90-quic.sh
- https://github.com/bol-van/zapret2/blob/master/blockcheck2.d/standard/60-fake-hostfake.sh
- https://github.com/bol-van/zapret-win-bundle/blob/master/zapret-winws/lua/zapret-antidpi.lua

Official zapret2 uses Linux-oriented `--filter-tcp`, `--filter-udp`, `--filter-l7`, hostlists/ipsets and `--new`; the QUIC blockcheck tests `fake_default_quic` and ipfrag/drop. The official Lua implementation contains `http_hostcase` and `http_methodeol`.

Therefore:

**Transfer now at strategy-logic level:** HC, TS, QF.  
**Transfer as targeted/fallback:** ME, TF, QI.  
**Keep special/advanced:** TC, TL.  
**Do not call proven from these logs:** HF.

### Not portable literally

These Windows filter/bootstrap fragments:
`--wf-l3=ipv4`, `--wf-tcp-out=80,443`, `--wf-udp-out=443`.

On hAP they must be expressed through the actual OpenWrt/NFQWS2 Linux path, hostlists and netfilter filtering.

### Avoid global application on hAP

Do not automatically apply every strategy globally. In particular, TS on all 443 and QF on all UDP/443 can affect unrelated traffic and increase router load. TC/TL should remain targeted.

## 15. Final conclusion

The 2609 → 2709 evidence supports a layered targeted design rather than a giant universal strategy string.

**Primary evidence-backed classes:** HC + TS + QF.  
**Targeted fallback:** ME + TF + QI.  
**Special fallback:** TC.  
**Advanced candidate:** TL.  
**Unproven by explicit FOUND:** HF.  
**No proven Telegram strategy in either raw log.**

2709 is materially broader than 2609: 140 → 296 unique domains and 239 → 518 explicit FOUND records. The improvement is primarily expanded domain coverage plus a small number of new specialized strategy classes, not proof that all candidate AVAILABLE results are equally transferable.

**Project rule from this audit:** raw blockcheck evidence selects candidates; only hAP runtime validation promotes a candidate to router production configuration.
