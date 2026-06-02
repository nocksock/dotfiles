#!/usr/bin/env bash

# Caffeine - hypridle inhibitor for Waybar

PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/caffeine.pid"

# Check if inhibitor is active
is_active() {
    [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null
}

# Display current state as JSON for waybar
display_state() {
    if is_active; then
        echo '{"text":"󰅶","tooltip":"Caffeine: Active\nIdle inhibited","class":"active"}'
    else
        echo '{"text":"󰛊","tooltip":"Caffeine: Inactive\nIdle allowed","class":"inactive"}'
    fi
}

# Start the inhibitor
start_inhibitor() {
    if is_active; then
        return 0
    fi

    # Use systemd-inhibit to block idle (prevents screen lock/dpms/suspend)
    systemd-inhibit --what=idle --who=caffeine --why="User requested idle inhibition" \
        sleep infinity &
    echo $! > "$PIDFILE"
}

# Stop the inhibitor
stop_inhibitor() {
    if is_active; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm -f "$PIDFILE"
    fi
}

# Toggle inhibitor state
toggle() {
    if is_active; then
        stop_inhibitor
    else
        start_inhibitor
    fi
}

# Main command dispatcher
case "$1" in
    toggle)
        toggle
        ;;
    start)
        start_inhibitor
        ;;
    stop)
        stop_inhibitor
        ;;
    status)
        is_active && echo "active" || echo "inactive"
        ;;
    *)
        display_state
        ;;
esac
