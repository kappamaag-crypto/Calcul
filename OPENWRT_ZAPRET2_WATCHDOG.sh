#!/bin/sh
# Conservative Zapret2 watchdog for OpenWrt 25.12.x / hAP ac lite (64 MiB)
# --check = read-only check; --once = check + recovery decision; --daemon = periodic loop.
#
# Recovery rules:
# - USB-backed logging must be writable at /mnt/data/zapret2-watchdog.
# - Two consecutive structural/functional failures are required.
# - Upstream/DNS failure never triggers a Zapret2 restart.
# - Maximum 2 automatic restarts per 15 minutes; minimum 5 minutes between restarts.
# - Automatic restart is blocked below 4096 KiB MemAvailable.
# - No continuous tcpdump and no Zapret2 configuration edits.

PATH='/usr/sbin:/usr/bin:/sbin:/bin'

SERVICE='/etc/init.d/zapret2'
TABLE_FAMILY='inet'
TABLE_NAME='zapret2'
PROCESS='nfqws2'
EXPECTED_PROCS=2
MAIN_QNUM=300
WG_QNUM=65300
WAN_IF='phy0-sta0'
LAN_IF='br-lan'

LOG_ROOT='/mnt/data/zapret2-watchdog'
LOG_FILE="$LOG_ROOT/watchdog.log"
STATE_FILE="$LOG_ROOT/state"
EVENT_DIR="$LOG_ROOT/events"
LOCK_DIR='/var/run/zapret2-watchdog.lock'

INTERVAL=90
FAIL_REQUIRED=2
RESTART_WINDOW=900
MAX_RESTARTS=2
COOLDOWN=300
MIN_AVAIL_KB=4096
KEEP_EVENTS=20
LOG_MAX_BYTES=131072

BASELINE_URL='https://example.com/'
TARGET_URL='https://www.youtube.com/'
PROBE_TIMEOUT=7

setup() {
    mkdir -p "$EVENT_DIR" 2>/dev/null || return 1
    touch "$LOG_FILE" "$STATE_FILE" 2>/dev/null || return 1
}

log() {
    msg="$*"
    printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$msg" >> "$LOG_FILE" 2>/dev/null || true
    logger -t zapret2-watchdog -- "$msg" 2>/dev/null || true
}

trim_log() {
    [ -f "$LOG_FILE" ] || return 0
    size="$(wc -c < "$LOG_FILE" 2>/dev/null || echo 0)"
    case "$size" in ''|*[!0-9]*) return 0 ;; esac
    [ "$size" -le "$LOG_MAX_BYTES" ] || {
        tail -n 1000 "$LOG_FILE" > "$LOG_FILE.tmp" 2>/dev/null &&
        mv -f "$LOG_FILE.tmp" "$LOG_FILE" 2>/dev/null || rm -f "$LOG_FILE.tmp"
    }
}

lock() {
    mkdir "$LOCK_DIR" 2>/dev/null || exit 0
    trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT INT TERM
}

count_procs() {
    pidof "$PROCESS" 2>/dev/null | awk '{print NF}'
}

avail_kb() {
    awk '/^MemAvailable:/ {print $2; exit}' /proc/meminfo 2>/dev/null
}

probe() {
    curl -4 -sS -o /dev/null --connect-timeout 3 --max-time "$PROBE_TIMEOUT" "$1" >/dev/null 2>&1
}

service_status() {
    "$SERVICE" status 2>&1
}

nft_dump() {
    nft list table "$TABLE_FAMILY" "$TABLE_NAME" 2>&1
}

nft_ok() {
    out="$1"
    printf '%s\n' "$out" | grep -q 'set zapret {' || return 1
    printf '%s\n' "$out" | grep -q 'elements = { "'$WAN_IF'" }' || return 1
    printf '%s\n' "$out" | grep -q 'elements = { "'$LAN_IF'" }' || return 1
    printf '%s\n' "$out" | grep -q 'tcp dport { 80,443 }' || return 1
    printf '%s\n' "$out" | grep -q 'udp dport 443' || return 1
    printf '%s\n' "$out" | grep -q 'queue flags bypass to '$MAIN_QNUM || return 1
    printf '%s\n' "$out" | grep -q 'queue flags bypass to '$WG_QNUM || return 1
    return 0
}

health() {
    HEALTH_STATE='HEALTHY'
    HEALTH_REASON='none'

    svc="$(service_status)"
    svc_ok=0
    printf '%s\n' "$svc" | grep -q 'running' && svc_ok=1

    pc="$(count_procs)"
    pc_ok=0
    [ "$pc" = "$EXPECTED_PROCS" ] && pc_ok=1

    nft="$(nft_dump)"
    nft_good=0
    nft_ok "$nft" && nft_good=1

    base_ok=0
    probe "$BASELINE_URL" && base_ok=1

    target_ok=0
    [ "$base_ok" -eq 1 ] && probe "$TARGET_URL" && target_ok=1

    a="$(avail_kb)"
    a_out='unknown'
    [ -n "$a" ] && a_out="$a"
    HEALTH_DETAIL="nfqws2=$pc/$EXPECTED_PROCS service=$svc_ok nft=$nft_good baseline=$base_ok youtube=$target_ok avail_kb=$a_out"

    if [ "$svc_ok" -ne 1 ] || [ "$pc_ok" -ne 1 ] || [ "$nft_good" -ne 1 ]; then
        HEALTH_STATE='STRUCTURAL_FAIL'
        HEALTH_REASON='SERVICE_OR_PROCESS_OR_NFTABLES'
    elif [ "$base_ok" -ne 1 ]; then
        HEALTH_STATE='UPSTREAM_FAIL'
        HEALTH_REASON='UPSTREAM_OR_DNS'
    elif [ "$target_ok" -ne 1 ]; then
        HEALTH_STATE='FUNCTIONAL_FAIL'
        HEALTH_REASON='YOUTUBE_PROBE'
    fi
}

snapshot() {
    tag="$1"
    file="$EVENT_DIR/$(date '+%Y-%m-%d_%H-%M-%S')_$tag.log"
    {
        echo "timestamp=$(date '+%Y-%m-%d %H:%M:%S')"
        echo "state=$HEALTH_STATE"
        echo "reason=$HEALTH_REASON"
        echo "detail=$HEALTH_DETAIL"
        echo "--- service ---"
        service_status
        echo "--- nfqws2 ---"
        ps w 2>&1 | grep '[n]fqws2' || true
        echo "--- nftables ---"
        nft_dump
        echo "--- memory ---"
        free -m 2>&1
        echo "--- vm ---"
        printf 'min_free_kbytes='; cat /proc/sys/vm/min_free_kbytes 2>/dev/null || true
        printf 'swappiness='; cat /proc/sys/vm/swappiness 2>/dev/null || true
        echo "--- swap ---"
        cat /proc/swaps 2>&1
        echo "--- sockstat ---"
        cat /proc/net/sockstat 2>&1
        echo "--- OOM/dmesg ---"
        dmesg 2>&1 | grep -Ei 'oom|out of memory|killed process|nfqws2|hostapd' | tail -n 30 || true
        echo "--- logread ---"
        logread 2>&1 | tail -n 80 || true
    } > "$file" 2>&1
    printf '%s\n' "$file"
}

prune_events() {
    n=0
    for f in $(ls -1t "$EVENT_DIR"/*.log 2>/dev/null); do
        n=$((n + 1))
        [ "$n" -le "$KEEP_EVENTS" ] || rm -f "$f"
    done
}

recent_restarts() {
    cutoff=$(( $(date +%s) - RESTART_WINDOW ))
    awk -v c="$cutoff" '$1 >= c {n++} END {print n+0}' "$STATE_FILE" 2>/dev/null
}

last_restart() {
    tail -n 1 "$STATE_FILE" 2>/dev/null | awk '{print $1}'
}

restart_allowed() {
    a="$(avail_kb)"
    case "$a" in
        ''|*[!0-9]*) ;;
        *) [ "$a" -ge "$MIN_AVAIL_KB" ] || { BLOCK='LOW_MEMORY'; return 1; } ;;
    esac

    n="$(recent_restarts)"
    [ "$n" -lt "$MAX_RESTARTS" ] || { BLOCK='MAX_RESTARTS'; return 1; }

    last="$(last_restart)"
    case "$last" in
        ''|*[!0-9]*) ;;
        *)
            now="$(date +%s)"
            [ $((now - last)) -ge "$COOLDOWN" ] || { BLOCK='COOLDOWN'; return 1; }
            ;;
    esac
    return 0
}

recover() {
    restart_allowed || {
        log "AUTO_RECOVERY_BLOCKED reason=$BLOCK health=$HEALTH_REASON detail=$HEALTH_DETAIL"
        snapshot blocked
        return 2
    }

    before="$(snapshot pre-restart)"
    log "ZAPRET2_AUTO_RESTART reason=$HEALTH_REASON detail=$HEALTH_DETAIL snapshot=$before restart=STARTED"

    "$SERVICE" restart > "$LOG_ROOT/restart-last.out" 2>&1
    rc=$?
    echo "$(date +%s) $rc" >> "$STATE_FILE"

    if [ "$rc" -ne 0 ]; then
        log "ZAPRET2_AUTO_RESTART reason=$HEALTH_REASON restart=FAILED rc=$rc output=$LOG_ROOT/restart-last.out"
        snapshot post-restart-failed
        prune_events
        return 1
    fi

    sleep 2
    health
    after="$(snapshot post-restart)"
    if [ "$HEALTH_STATE" = 'HEALTHY' ]; then
        log "ZAPRET2_AUTO_RESTART restart=DONE postcheck=PASS snapshot=$after"
        prune_events
        return 0
    fi

    log "ZAPRET2_AUTO_RESTART restart=DONE postcheck=FAIL post_reason=$HEALTH_REASON snapshot=$after"
    prune_events
    return 1
}

once() {
    health
    case "$HEALTH_STATE" in
        HEALTHY|UPSTREAM_FAIL)
            rm -f /tmp/zapret2-watchdog.streak
            if [ "$HEALTH_STATE" = 'HEALTHY' ]; then
                log "HEALTH state=HEALTHY $HEALTH_DETAIL"
            else
                log "HEALTH state=UPSTREAM_FAIL reason=$HEALTH_REASON $HEALTH_DETAIL action=NO_RESTART"
            fi
            ;;
        STRUCTURAL_FAIL|FUNCTIONAL_FAIL)
            streak="$(cat /tmp/zapret2-watchdog.streak 2>/dev/null || echo 0)"
            streak=$((streak + 1))
            printf '%s\n' "$streak" > /tmp/zapret2-watchdog.streak
            log "HEALTH state=$HEALTH_STATE reason=$HEALTH_REASON streak=$streak/$FAIL_REQUIRED $HEALTH_DETAIL"
            if [ "$streak" -ge "$FAIL_REQUIRED" ]; then
                rm -f /tmp/zapret2-watchdog.streak
                recover
            fi
            ;;
    esac
    trim_log
}

main() {
    lock
    setup || {
        echo 'state=BLOCKED reason=USB_LOG_UNAVAILABLE' >&2
        exit 2
    }

    mode="$1"
    [ -n "$mode" ] || mode='--check'

    case "$mode" in
        --check)
            health
            echo "state=$HEALTH_STATE reason=$HEALTH_REASON $HEALTH_DETAIL"
            ;;
        --once)
            once
            ;;
        --daemon)
            while :; do
                once
                sleep "$INTERVAL"
            done
            ;;
        *)
            echo "usage: $0 --check|--once|--daemon" >&2
            exit 64
            ;;
    esac
}

main "$@"
