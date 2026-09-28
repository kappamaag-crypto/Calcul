# ZAPRET2 DEEP MAX CIRCULAR — 2609 + 2709

HTTP: HC -> ME -> HF
TLS: TS -> TF -> TC -> LX(last-resort)
QUIC: QF -> QI

Evidence-backed successful maximum: HTTP 3 / TLS 2 / QUIC 2.
Operational maximum in this package: HTTP 3 / TLS 3 / QUIC 2, because LX is appended as the final tested-not-found TLS candidate.

LX had 0 AVAILABLE / 0 FOUND in both raw logs and is explicitly experimental.

Installer:
- staged hostlists;
- sorted/unique validation;
- removes old exact Strategy27 ME/HC/TS/QF lines from preserved fallback;
- automatic rollback after any post-modification failure;
- preserves failed new state for audit;
- no restart;
- no HAP runtime validation;
- no MODE_FILTER/QNUM/DNS/routing/VPN/PBR changes.

Archive SHA256:
63029e3a6821f079dc7544f1166713e65475fec2164d0cf16e9b88d47abc6dcc

Installer SHA256:
837a660ba4d8e713f84c2e3a3e3299f042b77b35500e44807e07117912d5b8c0
