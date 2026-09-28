#!/bin/sh
# ZAPRET2 strategy27 same-class circular backups
# Evidence source: blockcheck2609_FULL.log + blockcheck2709.log
# Scope: ONLY TLS strategy hostlist + NFQWS2_OPT profile insertion.
# No DNS/routing/VPN/PBR/QNUM/MODE_FILTER changes.
# No HAP runtime/HTTPS validation is performed by this script.

set -eu

BASE=/etc/zapret2/strategy27
CFG=/opt/zapret2/config
SELF_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
STAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_CFG="/opt/zapret2/config.strategy27-circular-pre-$STAMP"
BACKUP_TS="/etc/zapret2/strategy27/strategy27-ts-pre-circular-$STAMP.txt"
TMP_TS="/tmp/strategy27-ts-$STAMP"
TMP_CFG="/tmp/strategy27-config-$STAMP"

TF_SRC="$SELF_DIR/strategy27-ts-circular-tf.txt"
TC_SRC="$SELF_DIR/strategy27-ts-circular-tc.txt"
EX_SRC="$SELF_DIR/strategy27-ts-circular-exclude.txt"
TF_DST="$BASE/strategy27-ts-circular-tf.txt"
TC_DST="$BASE/strategy27-ts-circular-tc.txt"
EX_DST="$BASE/strategy27-ts-circular-exclude.txt"
TS="$BASE/strategy27-ts.txt"

fail() { echo "INSTALL_FAILED: $*" >&2; exit 1; }

[ -f "$CFG" ] || fail "missing $CFG"
[ -f "$TS" ] || fail "missing $TS"
[ -f "$TF_SRC" ] || fail "missing $TF_SRC"
[ -f "$TC_SRC" ] || fail "missing $TC_SRC"
[ -f "$EX_SRC" ] || fail "missing $EX_SRC"

grep -qF -- '--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts.txt' "$CFG" || fail "active TS profile anchor not found in $CFG"
! grep -qF -- 'strategy27-ts-circular-tf.txt' "$CFG" || fail "circular TF profile already present"
! grep -qF -- 'strategy27-ts-circular-tc.txt' "$CFG" || fail "circular TC profile already present"

cp -a "$CFG" "$BACKUP_CFG"
cp -a "$TS" "$BACKUP_TS"

mkdir -p "$BASE"
cp -f "$TF_SRC" "$TF_DST"
cp -f "$TC_SRC" "$TC_DST"
cp -f "$EX_SRC" "$EX_DST"

# Remove the 16 backup domains from the ordinary TS-primary hostlist.
grep -Fxv -f "$EX_DST" "$TS" > "$TMP_TS"
removed=$(( $(wc -l < "$TS") - $(wc -l < "$TMP_TS") ))
[ "$removed" -eq 16 ] || {
  cp -a "$BACKUP_CFG" "$CFG"
  cp -a "$BACKUP_TS" "$TS"
  rm -f "$TMP_TS"
  fail "expected to move 16 TS domains, actually removed $removed"
}
cp -f "$TMP_TS" "$TS"

# Insert two mutually exclusive TLS circular profiles immediately before the ordinary TS profile.
awk '
BEGIN { inserted=0 }
/^--filter-tcp=443 --filter-l7=tls --hostlist=\/etc\/zapret2\/strategy27\/strategy27-ts.txt/ && !inserted {
  print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts-circular-tf.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:strategy=2:final --new"
  print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts-circular-tc.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1:strategy=2 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1:strategy=2 --lua-desync=multisplit:pos=2:strategy=2:final --new"
  inserted=1
}
{ print }
END { if (!inserted) exit 2 }
' "$CFG" > "$TMP_CFG" || {
  cp -a "$BACKUP_CFG" "$CFG"
  cp -a "$BACKUP_TS" "$TS"
  rm -f "$TMP_CFG" "$TMP_TS"
  fail "could not insert circular profiles"
}
cp -f "$TMP_CFG" "$CFG"

rm -f "$TMP_CFG" "$TMP_TS"

echo "INSTALL=SUCCESS"
echo "BACKUP_CONFIG=$BACKUP_CFG"
echo "BACKUP_TS=$BACKUP_TS"
echo "TS_MOVED=16"
echo "TF_DOMAINS=14"
echo "TC_DOMAINS=2"
echo "ACTION_REQUIRED=restart zapret2 to apply config"
echo "NOTE=No runtime validation performed by this script"
