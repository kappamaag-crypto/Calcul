#!/bin/sh
# strategy27 permanent activation with automatic rollback.
# Scope: replace ONLY NFQWS2_OPT; preserve current MODE_FILTER/QNUM/DNS/routing/VPN/PBR/firewall settings.
# Profiles: ME + HC + TS + QF, followed by the CURRENT NFQWS2_OPT body as the existing fallback.
# Rollback: restore the exact pre-change /opt/zapret2/config if restart/status/HTTPS health fails.

set -eu

CFG=/opt/zapret2/config
BASE=/etc/zapret2/strategy27
STAMP=$(date +%Y%m%d-%H%M%S)
BACKUP="/opt/zapret2/config.strategy27-pre-$STAMP"
TMP="/tmp/zapret2-strategy27-config-$STAMP"
OLDOPT="/tmp/zapret2-strategy27-oldopt-$STAMP"
STARTLOG="/tmp/zapret2-strategy27-start-$STAMP"
RESTORELOG="/tmp/zapret2-strategy27-restore-$STAMP"

fail() { echo "ACTIVATION_FAILED: $*"; exit 1; }

[ -f "$CFG" ] || fail "missing $CFG"
for f in strategy27-me.txt strategy27-hc.txt strategy27-ts.txt strategy27-qf.txt; do
  [ -f "$BASE/$f" ] || fail "missing $BASE/$f"
done

cp -a "$CFG" "$BACKUP"
echo "BACKUP=$BACKUP"

# Extract current NFQWS2_OPT body. This body is preserved verbatim as the fallback.
awk '
  BEGIN { inopt=0; found=0 }
  /^NFQWS2_OPT="/ {
    inopt=1; found=1
    line=$0
    sub(/^NFQWS2_OPT="/, "", line)
    if (line != "") {
      if (line ~ /"([[:space:]]*)$/) sub(/"([[:space:]]*)$/, "", line)
      if (line != "") print line
    }
    next
  }
  inopt && /^"[[:space:]]*$/ { inopt=0; next }
  inopt { print; next }
  END { if (!found) exit 2 }
' "$CFG" > "$OLDOPT" || fail "could not extract NFQWS2_OPT"

# Replace ONLY NFQWS2_OPT.
awk -v oldopt="$OLDOPT" '
  BEGIN { inopt=0; injected=0 }
  /^NFQWS2_OPT="/ {
    print "NFQWS2_OPT=\""
    print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/strategy27-me.txt --payload=http_req --lua-desync=http_methodeol --new"
    print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/strategy27-hc.txt --payload=http_req --lua-desync=http_hostcase --new"
    print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/strategy27-ts.txt --payload=tls_client_hello --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop --new"
    print "--filter-udp=443 --filter-l7=quic --hostlist=/etc/zapret2/strategy27/strategy27-qf.txt --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11"
    while ((getline line < oldopt) > 0) print line
    close(oldopt)
    print "\""
    inopt=1; injected=1
    next
  }
  inopt && /^"[[:space:]]*$/ { inopt=0; next }
  inopt { next }
  { print }
  END { if (!injected) exit 3 }
' "$CFG" > "$TMP" || fail "could not build new config"

# Atomic-ish replacement of the config file, then controlled restart.
cp "$TMP" "$CFG"

if ! /etc/init.d/zapret2 restart >"$STARTLOG" 2>&1; then
  echo "RESTART_FAILED -> automatic rollback"
  cp -a "$BACKUP" "$CFG"
  /etc/init.d/zapret2 restart >"$RESTORELOG" 2>&1 || true
  cat "$STARTLOG"
  exit 2
fi

if ! /etc/init.d/zapret2 status >/dev/null 2>&1; then
  echo "SERVICE_STATUS_FAILED -> automatic rollback"
  cp -a "$BACKUP" "$CFG"
  /etc/init.d/zapret2 restart >"$RESTORELOG" 2>&1 || true
  cat "$RESTORELOG"
  exit 3
fi

# Minimal ordinary-HTTPS regression gate.
if ! wget -4 -qO "/tmp/zapret2-strategy27-health-$STAMP" -T 10 https://example.com; then
  echo "HTTPS_HEALTH_FAILED -> automatic rollback"
  cp -a "$BACKUP" "$CFG"
  /etc/init.d/zapret2 restart >"$RESTORELOG" 2>&1 || true
  cat "$RESTORELOG"
  exit 4
fi

for f in strategy27-me.txt strategy27-hc.txt strategy27-ts.txt strategy27-qf.txt; do
  grep -q "$f" "$CFG" || fail "$f not persisted in NFQWS2_OPT"
done

echo "ACTIVATION=SUCCESS"
echo "CONFIG=$CFG"
echo "ROLLBACK_POINT=$BACKUP"
echo "HEALTH=example.com HTTPS OK"
