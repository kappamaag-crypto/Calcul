# Proton WG/AWG Freeze — 2026-09-27

## User directive
The user explicitly requested: record all current WG/AWG work and STOP work on WG/AWG until the user gives a new instruction.

## Freeze status
- Proton WG/AWG branch: **FROZEN / BLOCKED BY USER**
- Do not start new WG/AWG experiments.
- Do not change AWG parameters.
- Do not change Proton WireGuard configuration.
- Do not change routing/PBR/firewall for WG/AWG.
- Do not resume the branch implicitly from old context.

## Tests completed after reopening
- TEST 7: AWG TEST 6 parameters with Proton RO-FREE#23 peer. Interface UP; 0 B RX; TX increased; no handshake.
- TEST 8: temporarily added UDP/51820 to zapret2 NFQWS2_PORTS_UDP and added:
  --filter-udp=51820 --filter-l7=wireguard --payload=wireguard_initiation --lua-desync=fake:repeats=1
  zapret2 started successfully; UDP/51820 was inserted into qnum 300. AWG still had 0 B RX.
- TEST 9: restored /opt/zapret2/config from /opt/zapret2/config.bak. Verified NFQWS2_PORTS_UDP=443 and no UDP/51820 rule. zapret2 restarted successfully. AWG again had 0 B RX / 1.29 KiB TX after 20 s.

## Control conclusion
TEST 8 vs TEST 9 produced the same AWG handshake result: **0 B received**. The temporary zapret2 UDP/51820 rule therefore did not produce a successful handshake and is not retained.

Current zapret2 state is the pre-TEST-8 configuration:
- NFQWS2_PORTS_UDP=443
- TCP 80/443 processing unchanged
- UDP 443 processing unchanged
- qnum 65300 existing WireGuard-pattern processing unchanged
- No UDP/51820 addition retained.

## Proton/AWG evidence accumulated
- Native Proton WireGuard control interface proton_wg_ctl: no handshake / 0 RX.
- Earlier bounded tcpdump on phy0-sta0 observed outbound UDP to Proton endpoint 194.180.33.20:51820 with no return packets.
- AWG isolated interface proton_awg_pad: repeated negative handshake results.
- Proton RO-FREE#23 endpoint used in TEST 7-9: 146.70.246.98:51820.
- Header Protection was not enabled because no Proton HeaderProtectionKey is available.
- Old proton_awg_test remains frozen and must not be used as evidence against Proton/AWG because its historical key configuration was malformed.

## Resume condition
Resume WG/AWG work only after an explicit new user instruction. When resumed, first consult the master plan, master prompt, glossary, and this freeze record; do not repeat completed tests unless the user explicitly requests a rerun.
