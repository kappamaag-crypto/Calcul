# ZAPRET2 strategy27 — ready-to-upload circular backups

Evidence basis: blockcheck2609_FULL.log + blockcheck2709.log.

## Contents

- 14 TLS domains with TS → TF backup.
- 2 TLS domains with TS → TC backup.
- Exclusion list for moving those 16 domains out of the ordinary TS-primary hostlist.
- Self-contained installer: install-strategy27-circular-backups.sh.

## Deployment model

For each selected host:

TS primary → one detected failure → TF/TC backup → final.

The existing ME/HC/TS/QF architecture and autohostlist fallback are preserved. No DNS, routing, VPN, PBR, QNUM or MODE_FILTER changes are made.

## Evidence status

This package is EVIDENCE-BACKED / NOT_VALIDATED_ON_HAP. It intentionally does not run HTTPS checks or other runtime tests.

The installer makes rollback copies before changing /opt/zapret2/config and strategy27-ts.txt.

HF is excluded because it has no explicit working strategy found records.

## On the hAP

Upload this directory to the router, then run:

```sh
cd /path/to/ZAPRET2_CIRCULAR_READY_2609_2709
./install-strategy27-circular-backups.sh
/etc/init.d/zapret2 restart
```

The script only installs the files, moves the 16 domains out of the ordinary TS hostlist, inserts the two circular TLS profiles and reports the rollback points. It does not perform a runtime service test.

## Exact circular profiles

### TS → TF

```text
--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts-circular-tf.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:strategy=2:final --new
```

### TS → TC

```text
--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts-circular-tc.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1:strategy=2 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1:strategy=2 --lua-desync=multisplit:pos=2:strategy=2:final --new
```
