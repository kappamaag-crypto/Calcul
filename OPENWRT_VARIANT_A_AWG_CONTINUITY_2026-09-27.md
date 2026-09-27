# Proton AmneziaWG 3.1 Continuity Record — 2026-09-27

User explicitly reopened the Proton/AmneziaWG experiment branch and requested continued parameter experiments.

## Scope
- Isolated interface: proton_awg_pad, auto=0.
- Endpoint: Proton US-FREE#130, 194.180.33.20:51820.
- No default route, PBR, full-router VPN, DNS replacement, or broad firewall changes.
- proton_awg_test remains frozen.
- proton_wg_ctl remains separate baseline/control.

## Results
1. ContentPadding only: UP; 0 B RX / 31524 B TX; no handshake.
2. Baseline AWG: UP; 0 B RX / 296 B TX; no handshake.
3. S1/S2/S3/S4 = 15/15/8/4: UP; 0 B RX / 163 B TX; no handshake.
4. J only, Jc=3 Jmin=10 Jmax=50: UP; 0 B RX / 487 B TX; no handshake.
4 follow-up J+S/random: no valid random result; od is unavailable on this BusyBox build.
5. Full profile attempt with broad ranges: interface did not instantiate; local configuration/validation failure, not handshake evidence.
6. Full valid AWG 3.1 profile: interface UP with I1-I5, Jc=6, Jmin=40, Jmax=200, S1=72,S2=56,S3=32,S4=16, H1=1,H2=2,H3=3,H4=4, ContentPaddingAddition=10-50, RandomTrailers=on, DisableCookies=on, timing ranges. Result after 10 s: 0 B RX / 2.56 KiB TX; no handshake.

## Independent evidence
Native WireGuard to the same Proton endpoint/key pair previously produced no handshake / 0 RX. Earlier bounded tcpdump on phy0-sta0 observed outbound UDP to 194.180.33.20:51820 with no return packets.

## Status
PROTON / AMNEZIAWG EXPERIMENT BRANCH = IN_PROGRESS, explicitly reopened by user.
TESTS 1-4 = negative handshake observations.
TEST 5 = invalid/local setup failure.
TEST 6 = FAILED to establish handshake (0 RX).

Header Protection is not enabled because no Proton HeaderProtectionKey is available. Do not treat H1-H4 alone as Header Protection.

Installed packages:
- amneziawg-tools-3.1.20260812-r1
- kmod-amneziawg-6.12.94.3.1.20260906-r1

Next experiments remain isolated and change one meaningful variable at a time.
