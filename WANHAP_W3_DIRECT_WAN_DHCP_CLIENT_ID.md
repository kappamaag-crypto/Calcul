# WanHap W3 — Direct ISP WAN / DHCP Client ID evidence

Date: 2026-10-02
Status: **DONE**

## Scope

This record documents the controlled direct-WAN experiment on the MikroTik hAP ac lite with the ISP Ethernet cable connected directly to `eth1`. The TP-Link Archer C20 was not required for the experiment and was not used as an upstream path.

## Baseline before the discriminating change

OpenWrt:
- 25.12.5 r33051-f5dae5ece4
- target ath79/mikrotik
- hAP ac lite / mips_24kc

WAN:
- device: `eth1`
- MAC: `E2:0D:17:E0:73:A7`
- protocol: DHCP
- DHCP server: `10.1.48.57`
- lease before the change: `100.96.77.60`
- gateway: `100.96.0.1`

The MAC was the actual WAN MAC previously used by the TP-Link. MAC cloning alone did **not** restore Internet access.

With the default OpenWrt 25.12.5 DHCP behavior, `udhcpc` was launched with a DHCP Client Identifier (Option 61):

```
-x 0x3d:ff6f1799c8000466caeaee30844603a5937a1625ca68ba
```

The corresponding global DUID was:

```
network.globals.dhcp_default_duid='000466caeaee30844603a5937a1625ca68ba'
```

DHCP itself succeeded, but external IPv4/TCP traffic received no response. Controlled packet capture showed outbound ICMP and TCP SYN packets leaving `eth1` with no replies.

## Discriminating change

No package was installed and `dhcp.sh` was not patched.

The штатная netifd option was set:

```
uci set network.wan.sendclientid='none'
uci commit network
/etc/init.d/network reload
```

The resulting `udhcpc` command line contained:

```
udhcpc ... -C -R -O 121
```

and a direct command-line check confirmed:

```
NO DHCP CLIENT-ID OPTION
```

## Result

After DHCP reacquisition:

- WAN IP: `100.96.79.207/16`
- gateway: `100.96.0.1`
- default route: `default via 100.96.0.1 dev eth1`
- DHCP remained functional.
- `ping -c 3 -W 2 1.1.1.1`: **3/3 replies, 0% loss**
- average RTT: approximately **58.4 ms**
- `wget -qO- --timeout=5 https://1.1.1.1`: **RC=0**

Therefore direct ISP WAN on `eth1` is runtime-verified and usable when DHCP Client ID/Option 61 is disabled.

## Root-cause conclusion

The controlled A/B experiment establishes a strong causal result:

- default automatic DHCP Client ID present → DHCP lease obtained, but external traffic failed;
- Client ID disabled with штатный `sendclientid='none'` → new DHCP lease obtained and Internet immediately worked.

For this exact hAP/OpenWrt 25.12.5/Ufanet path, the automatic DHCP Client ID was the discriminating variable associated with the failure.

Do not revert `network.wan.sendclientid='none'` unless a new controlled experiment specifically requires it.

This does not claim that DHCP Option 61 is universally incompatible with Ufanet or all ISPs. It records the verified behavior of this exact router/software/provider path.

## Final relevant WAN configuration

```
network.wan.proto='dhcp'
network.wan.device='eth1'
network.wan.macaddr='e2:0d:17:e0:73:a7'
network.wan.sendclientid='none'
```

## Isolation / safety

No Zapret2, Deep Max Circular, AWG/WireGuard, DNS strategy, PBR, or unrelated LAN/Wi-Fi subsystem was changed as part of this experiment.

The Archer C20 remains excluded from the target architecture.

## Stage disposition

- W0 = **DONE**
- W1 = **DONE**
- W2 = **DONE**
- W3 = **DONE**
- W4 = **NOT_STARTED**

W4 is a separate stage: making direct ISP WAN the permanent primary path and disabling the temporary `phy0-sta0` uplink. It must not be marked DONE merely because W3 direct WAN is working.
