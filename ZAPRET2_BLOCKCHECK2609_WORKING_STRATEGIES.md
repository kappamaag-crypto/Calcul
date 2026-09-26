# Zapret2 — verified working strategies from blockcheck2609

**Source:** user-supplied `blockcheck2609.log`  
**Source date:** 2026-09-26  
**Test environment in source log:** Windows/Cygwin, WinDivert, `winws2`, IPv4  
**Purpose:** consolidate only strategies that blockcheck explicitly marked as `working strategy found`.

> **Important portability note**
>
> The source test was performed with **WinDivert/winws2 on Windows**, not with OpenWrt/nfqws2 on the MikroTik hAP ac lite. Therefore these are **verified working source strategies**, not yet a claim that the same exact command line is validated on the router. They should be treated as the candidate strategy set for the next controlled Zapret2 test.
>
> No TLS 1.2 strategy was found by this scan for the tested domains.

## 1. Exact strategies explicitly marked WORKING

### HTTP / TCP port 80

| Domains | Working strategy |
|---|---|
| youtube.com, youtube.ru | `--payload=http_req --lua-desync=http_hostcase` |
| instagram.com, rustorka.com, hdrezka.co | `--payload=http_req --lua-desync=http_methodeol` |

Exact source commands:

```text
winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_hostcase
winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_methodeol
```

### HTTPS / TLS 1.3 — TCP port 443

| Domains | Working strategy |
|---|---|
| instagram.com, rustorka.com, hdrezka.co | `--payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop` |

Exact source command:

```text
winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop
```

### QUIC / HTTP3 — UDP port 443

| Domains | Working strategy |
|---|---|
| youtube.com, youtube.ru, instagram.com, rustorka.com, hdrezka.co | `--payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11` |

Exact source command:

```text
winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
```

## 2. Strategies NOT included as working

The following were tested in the source log but did **not** receive a `working strategy found` result:

- TLS 1.2 candidates:
  - `fake:blob=fake_default_tls:tcp_ts=-1000`
  - `fake:blob=0x00000000:tcp_md5:repeats=1`
  - `fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1`
  - `multisplit:pos=2`
- TLS 1.3 candidates other than the explicitly working `tcpseg... + drop`:
  - `fake:blob=fake_default_tls:tcp_ts=-1000`
  - `luaexec:code=desync.pat=tls_mod(fake_default_tls,'rnd,rndsni,dupsid,padencap',desync.reasm_data)`
  - corresponding `tcpseg`/pattern chain
- QUIC candidate:
  - `send:ipfrag` + `drop`

These failed/unverified candidates are deliberately kept out of the working set.

## 3. Consolidated candidate set for Zapret2

For the current hAP ac lite project, the source evidence reduces to three distinct strategy primitives:

```text
HTTP:
  --payload=http_req --lua-desync=http_hostcase

HTTP alternative:
  --payload=http_req --lua-desync=http_methodeol

TLS 1.3:
  --payload tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop

QUIC:
  --payload quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11
```

### Current interpretation

- `http_hostcase` is the source-log winner for HTTP on YouTube.
- `http_methodeol` is the source-log winner for HTTP on Instagram/rustorka/hdrezka.
- The TLS 1.3 `tcpseg + drop` strategy is explicitly working for Instagram/rustorka/hdrezka.
- The QUIC fake/repeat strategy is explicitly working for all five tested domains.
- **No TLS 1.2 strategy was found** in this particular scan.
- These results are domain- and test-path-specific; they do not prove universal effectiveness.

## 4. Router safety status

This file is an **evidence/candidate file only**.

It does not authorize:
- replacing the current working Zapret2 configuration;
- enabling all strategies simultaneously;
- changing `MODE_FILTER`;
- changing QNUM;
- changing `SET_MAXELEM`;
- changing firewall/NFQUEUE rules;
- enabling a default VPN route;
- running a large strategy sweep on the hAP.

The hAP is a 64 MB RAM / MIPS 24Kc device, so strategy selection must remain bounded and evidence-driven.

## 5. Source evidence summary

The supplied blockcheck log explicitly reported these working results:

```text
youtube.com
  HTTP   -> http_hostcase
  QUIC   -> fake_default_quic:repeats=11

youtube.ru
  HTTP   -> http_hostcase
  QUIC   -> fake_default_quic:repeats=11

instagram.com
  HTTP   -> http_methodeol
  TLS13  -> tcpseg:pos=0,-1:seqovl=1 + drop
  QUIC   -> fake_default_quic:repeats=11

rustorka.com
  HTTP   -> http_methodeol
  TLS13  -> tcpseg:pos=0,-1:seqovl=1 + drop
  QUIC   -> fake_default_quic:repeats=11

hdrezka.co
  HTTP   -> http_methodeol
  TLS13  -> tcpseg:pos=0,-1:seqovl=1 + drop
  QUIC   -> fake_default_quic:repeats=11
```

## 6. Next validation gate

Before adopting any of these into the active OpenWrt Zapret2 configuration, validate the **Linux/nfqws2 syntax and behavior** on the hAP with one bounded strategy at a time.

Do not infer TLS 1.2 coverage from these results: the source scan found no working TLS 1.2 strategy.

**Status:** AVAILABLE_FOR_BUILD / NOT YET RUNTIME_VERIFIED ON HAP
