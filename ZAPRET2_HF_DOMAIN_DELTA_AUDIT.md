# ZAPRET2 HF — DOMAIN DELTA AUDIT 2609 → 2709

**Дата:** 2026-09-27  
**Статус:** **BLOCKED / EXACT SOURCE EXTRACTION REQUIRED**  
**Назначение:** определить точные HF-домены из blockcheck2609_FULL.log + blockcheck2709.log и вычислить, что HF реально добавляет сверх уже активных HTTP-профилей ME/HC.

## 1. HF profile

Exact HTTP candidate:

~~~text
--payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000
~~~

В текущей классификации проекта HF = **CANDIDATE ONLY**.

Критическое правило evidence:
- EXPLICIT FOUND = буквальная raw-запись working strategy found;
- HF не имеет ни одного explicit FOUND в 2609 или 2709;
- поэтому HF нельзя переводить в ACTIVE только на основании aggregate coverage.

## 2. Raw-source statistics currently established

### 2609

Source:
- blockcheck2609_FULL.log
- blob SHA: d42227bdc262c4437e4d1f78e28369c41075b3d6
- 34,569 lines
- 140 domain sections

HF aggregate coverage:
- **74/140**

### 2709

Source:
- blockcheck2709.log
- blob SHA: f1413839059d5f86b2856aa6ddc62b2e7ed38bb3
- 70,258 lines
- 301 domain sections
- 296 unique domains inside this run

HF aggregate coverage:
- **149/301**

Important:
- 74/140 and 149/301 are **aggregate log coverage counters**;
- they are not an exact HF hostlist;
- they must not be treated as 74 or 149 distinct new domains without per-domain extraction;
- 2709 contains five duplicate domain sections.

## 3. Already-active exact HTTP sets

The current strategy27 domain catalog gives:

### ME

- 44 unique tested domains.

Exact logic:

~~~text
--payload=http_req --lua-desync=http_methodeol
~~~

### HC

- 159 unique tested domains.

Exact logic:

~~~text
--payload=http_req --lua-desync=http_hostcase
~~~

### ME ∩ HC

In the current 297-domain unified strategy27 catalog:
- **intersection = 0**
- ME and HC are disjoint at the unique-domain classification level.

Therefore current exact HTTP coverage represented by ME + HC is:

- **44 + 159 = 203 unique tested domains**

This is the existing exact HTTP layer, before considering the autohostlist fallback.

## 4. 2709-specific active HTTP coverage

Within the 2709 evidence:
- HC = 160 explicit FOUND domains
- ME = 42 explicit FOUND domains
- current unified classification keeps these strategy classes disjoint at the unique-domain level

Thus:
- active exact HTTP domain classes represented in 2709 = **202 unique domains**

HF aggregate coverage is 149/301 sections.

Because 149 < 202, the aggregate counters alone cannot establish that HF adds any new domain beyond ME/HC.

## 5. What is known about HF ∩ ME/HC

The exact per-domain HF set could not be recovered from the currently accessible derived artifacts.

Current derived files expose:
- aggregate HF counters;
- the full ME/HC/TS/QF explicit-FOUND matrix;
- the final 297-domain strategy27 catalog;
- the 2609/2709 forensic audit.

They do **not** contain the per-domain list of every raw HF candidate/AVAILABLE result.

Attempts to obtain the raw log contents through the repository connector return an empty body for these oversized .log blobs, including when line ranges are requested.

Therefore the following sets are presently **UNKNOWN**, not empty:

~~~text
H2609 = exact domains with HF candidate coverage in blockcheck2609
H2709 = exact domains with HF candidate coverage in blockcheck2709

H2609 ∩ (ME ∪ HC)
H2709 ∩ (ME ∪ HC)

H2609 \ (ME ∪ HC)
H2709 \ (ME ∪ HC)
~~~

## 6. What can already be concluded

The evidence currently supports these statements:

1. HF has substantial observed aggregate coverage:
   - 2609: 74/140
   - 2709: 149/301

2. HF has **zero explicit FOUND records** in the project's current classification.

3. ME + HC already provide:
   - 203 unique exact HTTP domains in the merged 297-domain strategy27 catalog.

4. Therefore HF's aggregate coverage does **not** prove additional production coverage.

5. It is impossible to truthfully state an exact HF-new-domain count until the raw per-domain HF matches are extracted.

6. No router configuration change is justified by this audit alone.

## 7. Required exact operation when raw logs are accessible

For each domain section in both raw logs:

1. identify the domain;
2. locate the exact HF command;
3. record the immediate result/status exactly as logged;
4. keep 2609 and 2709 provenance separately;
5. deduplicate domains within and across runs;
6. join against the exact ME and HC sets;
7. calculate:

~~~text
HF_ALL
HF ∩ ME
HF ∩ HC
HF ∩ (ME ∪ HC)
HF_ONLY = HF \ (ME ∪ HC)

HF_ONLY_2609
HF_ONLY_2709
HF_SHARED
HF_2609_NOT_2709
HF_2709_NOT_2609
~~~

## 8. Promotion gate

HF remains:

**CANDIDATE ONLY / NOT ACTIVATED**

Promotion requires both:
- exact per-domain evidence showing meaningful unique coverage beyond ME/HC;
- separate hAP runtime evidence demonstrating improvement.

No FOUND or ACTIVE label should be assigned merely from 74/140 or 149/301.

## 9. Current architecture remains unchanged

~~~text
ME exact
HC exact
TS exact
QF exact
    ↓
existing autohostlist fallback
~~~

HF is not inserted into the permanent layer by this audit.

## 10. Evidence references

- strategy27.md — full 297-domain explicit-FOUND catalog and ME/HC mapping.
- ZAPRET2_BLOCKCHECK2609_2709_FULL_FORENSIC_AUDIT.md — merged forensic audit and aggregate HF coverage.
- ZAPRET2_BLOCKCHECK2709_EVIDENCE.md — 2709 aggregate evidence summary.
- Raw sources:
  - blockcheck2609_FULL.log
  - blockcheck2709.log

**Final status:** exact HF domain delta = **BLOCKED pending direct raw-log per-domain extraction**. This is a source-access limitation, not a negative HF result.