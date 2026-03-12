#!/usr/bin/env bash

# AirPods Pro bluetooth control for Waybar

# MAC address of AirPods Pro
AIRPODS_MAC="14:28:76:CA:6D:01"

# Get device info from bluetoothctl
get_device_info() {
    bluetoothctl info "$AIRPODS_MAC" 2>/dev/null
}

# Check if device is connected
is_connected() {
    local info="$1"
    echo "$info" | grep -q "Connected: yes"
}

# Display current state as JSON for waybar
display_state() {
    local info=$(get_device_info)
    
    if [ -z "$info" ]; then
        # Device not found or bluetooth error
        echo '{"text":"󰟎","tooltip":"Bluetooth error or device not paired","class":"error"}'
        return
    fi
    
    if is_connected "$info"; then
        echo '{"text":"󰋋","tooltip":"AirPods Pro: Connected","class":"connected"}'
    else
        echo '{"text":"󰋋","tooltip":"AirPods Pro: Disconnected","class":"offline"}'
    fi
}

# Find AirPods audio sink ID
find_airpods_sink() {
    wpctl status | grep -i "airpods" | grep -oP '^\s+\*?\s+\K\d+' | head -1
}

# Get all active playback stream IDs  
get_playback_streams() {
    wpctl status | awk '/Audio/,/^Video/ {if (/Streams:/) flag=1; if (flag && /^\s+[0-9]+\./) print}' | grep -oP '^\s+\K\d+(?=\.)'
}

# Set AirPods as default audio output and move all streams
set_default_output() {
    local max_attempts=10
    local attempt=0
    
    # Wait for AirPods sink to appear (up to 5 seconds)
    while [ $attempt -lt $max_attempts ]; do
        local sink_id=$(find_airpods_sink)
        if [ -n "$sink_id" ]; then
            # Set as default for new streams
            wpctl set-default "$sink_id" >/dev/null 2>&1
            
            # Move all existing playback streams to AirPods
            # Using PipeWire's pw-cli to set the target node
            get_playback_streams | while read stream_id; do
                pw-cli set-param "$stream_id" Props '{ target.object = "'$sink_id'" }' >/dev/null 2>&1 || true
            done
            
            return 0
        fi
        sleep 0.5
        attempt=$((attempt + 1))
    done
    
    return 1
}

# Toggle connection
toggle() {
    local info=$(get_device_info)
    
    if [ -z "$info" ]; then
        return 1
    fi
    
    if is_connected "$info"; then
        bluetoothctl disconnect "$AIRPODS_MAC" >/dev/null 2>&1
    else
        bluetoothctl connect "$AIRPODS_MAC" >/dev/null 2>&1
        # Set as default output after connecting
        set_default_output &
    fi
}

# Main command dispatcher
case "$1" in
    toggle)
        toggle
        ;;
    *)
        display_state
        ;;
esac
