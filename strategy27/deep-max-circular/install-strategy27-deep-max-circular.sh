#!/bin/sh
# ZAPRET2 DEEP MAX CIRCULAR installer
# Evidence: blockcheck2609_FULL.log + blockcheck2709.log
# No HAP runtime validation.
set -eu
STRAT_DIR=${STRAT_DIR:-/etc/zapret2/strategy27}
BASE="$STRAT_DIR/deep-circular"
CFG=${CFG:-/opt/zapret2/config}
SRC_DIR=${SRC_DIR:-$(CDPATH= cd -- "$(dirname "$0")" && pwd)}
STAMP=$(date +%Y%m%d-%H%M%S)
CFG_DIR=$(CDPATH= cd -- "$(dirname "$CFG")" && pwd)
BACKUP_CFG="$CFG_DIR/config.deep-max-circular-pre-$STAMP"
BACKUP_BASE="$STRAT_DIR/deep-circular-pre-$STAMP"
FAILED_BASE="$STRAT_DIR/deep-circular-failed-$STAMP"
TMP_BASE="$STRAT_DIR/.deep-circular.new-$STAMP"
TMP_CFG="$CFG_DIR/.deep-circular.config.new-$STAMP"
TMP_OLDOPT="/tmp/deep-max-oldopt-$STAMP"
TMP_OLDOPT_FILTERED="/tmp/deep-max-oldopt-filtered-$STAMP"
BASE_WAS_PRESENT=0
BASE_COMMITTED=0
CFG_COMMITTED=0
SUCCESS=0
fail() { echo "INSTALL_FAILED: $*" >&2; exit 1; }
rollback() {
    rc=$?
    [ "$SUCCESS" -eq 1 ] && return "$rc"
    echo "ROLLBACK=START" >&2
    if [ "$CFG_COMMITTED" -eq 1 ] && [ -f "$BACKUP_CFG" ]; then
        cp -a "$BACKUP_CFG" "$CFG" 2>/dev/null || true
    fi
    if [ "$BASE_COMMITTED" -eq 1 ]; then
        if [ "$BASE_WAS_PRESENT" -eq 1 ] && [ -d "$BACKUP_BASE" ]; then
            if [ -e "$BASE" ]; then mv "$BASE" "$FAILED_BASE" 2>/dev/null || true; fi
            mv "$BACKUP_BASE" "$BASE" 2>/dev/null || true
        elif [ "$BASE_WAS_PRESENT" -eq 0 ] && [ -e "$BASE" ]; then
            mv "$BASE" "$FAILED_BASE" 2>/dev/null || true
        fi
    fi
    rm -rf "$TMP_BASE" "$TMP_CFG" "$TMP_OLDOPT" "$TMP_OLDOPT_FILTERED" 2>/dev/null || true
    echo "ROLLBACK=COMPLETE" >&2
    [ -d "$FAILED_BASE" ] && echo "FAILED_INSTALL_PRESERVED=$FAILED_BASE" >&2 || true
    return "$rc"
}
trap rollback EXIT INT TERM
[ -f "$CFG" ] || fail "missing $CFG"
for f in strategy27-me.txt strategy27-hc.txt strategy27-ts.txt strategy27-qf.txt; do
    [ -f "$STRAT_DIR/$f" ] || fail "missing $STRAT_DIR/$f"
done
[ -d "$SRC_DIR/hostlists" ] || fail "missing $SRC_DIR/hostlists"
if grep -qF "$STRAT_DIR/deep-circular/" "$CFG"; then
    fail "deep-circular profile already present in $CFG"
fi
mkdir -p "$TMP_BASE"
for f in "$SRC_DIR"/hostlists/*.txt; do
    [ -f "$f" ] || fail "no hostlists found"
    cp -f "$f" "$TMP_BASE/"
done
for f in "$TMP_BASE"/*.txt; do
    awk 'NF!=1 {exit 1}' "$f" || fail "malformed hostlist: $f"
    sort -u "$f" > "$f.sorted"
    cmp -s "$f" "$f.sorted" || fail "hostlist is not sorted/unique: $f"
    rm -f "$f.sorted"
done
awk 'BEGIN{inopt=0;found=0}
 /^NFQWS2_OPT="/ {
    inopt=1; found=1; line=$0; sub(/^NFQWS2_OPT="/,"",line)
    if(line!=""){if(line ~ /"[[:space:]]*$/) sub(/"[[:space:]]*$/,"",line); if(line!="") print line}
    next
 }
 inopt && /^"[[:space:]]*$/ {inopt=0; next}
 inopt {print; next}
 END{if(!found) exit 2}' "$CFG" > "$TMP_OLDOPT" || fail "cannot extract NFQWS2_OPT"
awk -v stratdir="$STRAT_DIR" '
 index($0,"--hostlist=" stratdir "/strategy27-me.txt")>0 {next}
 index($0,"--hostlist=" stratdir "/strategy27-hc.txt")>0 {next}
 index($0,"--hostlist=" stratdir "/strategy27-ts.txt")>0 {next}
 index($0,"--hostlist=" stratdir "/strategy27-qf.txt")>0 {next}
 index($0,stratdir "/deep-circular/")>0 {next}
 index($0,stratdir "/deep-circular-max/")>0 {next}
 {print}' "$TMP_OLDOPT" > "$TMP_OLDOPT_FILTERED"
cp -p "$CFG" "$TMP_CFG"
awk -v oldopt="$TMP_OLDOPT_FILTERED" '
BEGIN {inopt=0; injected=0}
/^NFQWS2_OPT="/ {
 print "NFQWS2_OPT=\"" 
 print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/deep-circular/http-hc-me-hf.txt --payload=http_req --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=http_hostcase:strategy=1 --lua-desync=http_methodeol:strategy=2 --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:strategy=3:final --new"
 print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/deep-circular/http-hc-me.txt --payload=http_req --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=http_hostcase:strategy=1 --lua-desync=http_methodeol:strategy=2:final --new"
 print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/deep-circular/http-hc-hf.txt --payload=http_req --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=http_hostcase:strategy=1 --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:strategy=2:final --new"
 print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/deep-circular/http-me-hf.txt --payload=http_req --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=http_methodeol:strategy=1 --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:strategy=2:final --new"
 print "--filter-tcp=80 --filter-l7=http --hostlist=/etc/zapret2/strategy27/deep-circular/http-me.txt --payload=http_req --lua-desync=http_methodeol --new"
 print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/deep-circular/tls-ts-tf-lx.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:strategy=2 --lua-desync=luaexec:code=desync.pat=tls_mod(fake_default_tls,'"'"'rnd,rndsni,dupsid,padencap'"'"',desync.reasm_data):strategy=3 --lua-desync=tcpseg:pos=0,-1:seqovl=#pat:seqovl_pattern=pat:strategy=3 --lua-desync=drop:strategy=3:final --new"
 print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/deep-circular/tls-ts-tc-lx.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1:strategy=2 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1:strategy=2 --lua-desync=multisplit:pos=2:strategy=2 --lua-desync=luaexec:code=desync.pat=tls_mod(fake_default_tls,'"'"'rnd,rndsni,dupsid,padencap'"'"',desync.reasm_data):strategy=3 --lua-desync=tcpseg:pos=0,-1:seqovl=#pat:seqovl_pattern=pat:strategy=3 --lua-desync=drop:strategy=3:final --new"
 print "--filter-tcp=443 --filter-l7=tls --hostlist=/etc/zapret2/strategy27/deep-circular/tls-ts-lx.txt --payload=tls_client_hello --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=tcpseg:pos=0,-1:seqovl=1:strategy=1 --lua-desync=drop:strategy=1 --lua-desync=luaexec:code=desync.pat=tls_mod(fake_default_tls,'"'"'rnd,rndsni,dupsid,padencap'"'"',desync.reasm_data):strategy=2 --lua-desync=tcpseg:pos=0,-1:seqovl=#pat:seqovl_pattern=pat:strategy=2 --lua-desync=drop:strategy=2:final --new"
 print "--filter-udp=443 --filter-l7=quic --hostlist=/etc/zapret2/strategy27/deep-circular/quic-qf-qi.txt --payload=quic_initial --lua-desync=circular:fails=1:retrans=1:reset --lua-desync=fake:blob=fake_default_quic:repeats=11:strategy=1 --lua-desync=send:ipfrag:strategy=2 --lua-desync=drop:strategy=2:final --new"
 print "--filter-udp=443 --filter-l7=quic --hostlist=/etc/zapret2/strategy27/deep-circular/quic-qf.txt --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=11 --new"
 print "--filter-udp=443 --filter-l7=quic --hostlist=/etc/zapret2/strategy27/deep-circular/quic-qi.txt --payload=quic_initial --lua-desync=send:ipfrag --lua-desync=drop --new"
 while((getline line < oldopt)>0) print line
 close(oldopt); print "\""; inopt=1; injected=1; next
}
inopt && /^"[[:space:]]*$/ {inopt=0; next}
inopt {next}
{print}
END{if(!injected) exit 3}' "$CFG" > "$TMP_CFG.body" || fail "cannot build new config"
cp -p "$TMP_CFG.body" "$TMP_CFG"
rm -f "$TMP_CFG.body"
grep -qF 'deep-circular/http-hc-me-hf.txt' "$TMP_CFG" || fail "HTTP deep profile missing"
grep -qF 'deep-circular/tls-ts-tf-lx.txt' "$TMP_CFG" || fail "TLS TS-TF-LX profile missing"
grep -qF 'deep-circular/quic-qf-qi.txt' "$TMP_CFG" || fail "QUIC deep profile missing"
! grep -qF "$STRAT_DIR/strategy27-me.txt" "$TMP_CFG" || fail "old ME profile leaked"
! grep -qF "$STRAT_DIR/strategy27-hc.txt" "$TMP_CFG" || fail "old HC profile leaked"
! grep -qF "$STRAT_DIR/strategy27-ts.txt" "$TMP_CFG" || fail "old TS profile leaked"
! grep -qF "$STRAT_DIR/strategy27-qf.txt" "$TMP_CFG" || fail "old QF profile leaked"
cp -a "$CFG" "$BACKUP_CFG"
if [ -e "$BASE" ]; then BASE_WAS_PRESENT=1; mv "$BASE" "$BACKUP_BASE"; fi
mv "$TMP_BASE" "$BASE"
BASE_COMMITTED=1
mv "$TMP_CFG" "$CFG"
CFG_COMMITTED=1
SUCCESS=1
rm -f "$TMP_OLDOPT" "$TMP_OLDOPT_FILTERED"
echo "INSTALL=SUCCESS"
echo "BACKUP_CONFIG=$BACKUP_CFG"
[ "$BASE_WAS_PRESENT" -eq 1 ] && echo "BACKUP_BASE=$BACKUP_BASE" || echo "BACKUP_BASE=NONE_PREVIOUSLY_ABSENT"
echo "HTTP_MAX_DEPTH=3"
echo "TLS_MAX_DEPTH=3 (TS->TF->LX or TS->TC->LX)"
echo "QUIC_MAX_DEPTH=2"
echo "LUAEXEC_LX_STATUS=TESTED_NOT_FOUND_LAST_RESORT"
echo "NOTE=NO_HAP_RUNTIME_TEST_PERFORMED"
echo "ACTION_REQUIRED=restart zapret2 to apply config"
