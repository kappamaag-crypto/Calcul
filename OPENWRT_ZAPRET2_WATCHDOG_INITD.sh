#!/bin/sh /etc/rc.common

USE_PROCD=1
START=99
STOP=01

PROG='/usr/bin/zapret2-watchdog'
NAME='zapret2-watchdog'

start_service() {
    [ -x "$PROG" ] || {
        logger -t "$NAME" "BLOCKED: $PROG is missing or not executable"
        return 1
    }

    procd_open_instance
    procd_set_param command "$PROG" --daemon
    procd_set_param respawn 3600 5 5
    procd_set_param stdout 1
    procd_set_param stderr 1
    procd_close_instance
}

stop_service() {
    # The watchdog handles TERM/INT through its lock cleanup trap.
    return 0
}
