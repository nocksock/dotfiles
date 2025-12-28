#!/usr/bin/env bash

# Elgato Key Light control for Waybar
# API endpoint for the Elgato Key Light
LIGHT_IP="192.168.178.122"
LIGHT_PORT="9123"
API_URL="http://${LIGHT_IP}:${LIGHT_PORT}/elgato/lights"

# Get current light state from API
get_state() {
    curl -s "$API_URL" 2>/dev/null
}

# Parse JSON field (simple jq-free parsing)
parse_json() {
    local json="$1"
    local field="$2"
    echo "$json" | grep -o "\"$field\":[0-9]*" | head -n1 | cut -d':' -f2
}

# Set light state
set_state() {
    local on="$1"
    local brightness="$2"
    local temperature="$3"

    local payload="{\"lights\":[{\"on\":${on},\"brightness\":${brightness},\"temperature\":${temperature}}],\"numberOfLights\":1}"
    curl -s -X PUT -H "Content-Type: application/json" -d "$payload" "$API_URL" >/dev/null 2>&1
}

# Display current state as JSON for waybar
display_state() {
    local state=$(get_state)

    if [ -z "$state" ]; then
        # Light is unreachable
        echo '{"text":"🔌","tooltip":"Key Light offline","class":"offline"}'
        return
    fi

    local on=$(parse_json "$state" "on")
    local brightness=$(parse_json "$state" "brightness")
    local temperature=$(parse_json "$state" "temperature")

    # Convert temperature from Elgato scale (143-344) to Kelvin (2900-7000)
    # Formula: kelvin = 1000000 / temperature
    local kelvin=$((1000000 / temperature))

    local icon="🔅"
    local class="off"
    local status="Off"

    if [ "$on" = "1" ]; then
        icon="💡"
        class="on"
        status="On"
    fi

    local tooltip="Key Light: ${status}\nBrightness: ${brightness}%\nTemperature: ${kelvin}K"

    echo "{\"text\":\"${icon}\",\"tooltip\":\"${tooltip}\",\"class\":\"${class}\"}"
}

# Toggle light on/off
toggle() {
    local state=$(get_state)

    if [ -z "$state" ]; then
        return 1
    fi

    local on=$(parse_json "$state" "on")
    local brightness=$(parse_json "$state" "brightness")
    local temperature=$(parse_json "$state" "temperature")

    # Default values if brightness/temp are not set
    [ -z "$brightness" ] && brightness=20
    [ -z "$temperature" ] && temperature=250

    if [ "$on" = "1" ]; then
        set_state 0 "$brightness" "$temperature"
    else
        set_state 1 "$brightness" "$temperature"
    fi
}

# Adjust temperature (warmer = lower kelvin = higher elgato value)
adjust_temperature() {
    local direction="$1"
    local state=$(get_state)

    if [ -z "$state" ]; then
        return 1
    fi

    local on=$(parse_json "$state" "on")
    local brightness=$(parse_json "$state" "brightness")
    local temperature=$(parse_json "$state" "temperature")

    [ -z "$on" ] && on=1
    [ -z "$brightness" ] && brightness=20
    [ -z "$temperature" ] && temperature=250

    local step=20

    if [ "$direction" = "warmer" ]; then
        temperature=$((temperature + step))
        [ $temperature -gt 344 ] && temperature=344
    elif [ "$direction" = "cooler" ]; then
        temperature=$((temperature - step))
        [ $temperature -lt 143 ] && temperature=143
    fi

    set_state "$on" "$brightness" "$temperature"
}

# Set brightness to specific value
set_brightness() {
    local target_brightness="$1"
    local state=$(get_state)

    if [ -z "$state" ]; then
        return 1
    fi

    local on=$(parse_json "$state" "on")
    local brightness=$(parse_json "$state" "brightness")
    local temperature=$(parse_json "$state" "temperature")

    # Ensure light is on when setting brightness
    [ -z "$on" ] && on=1
    [ -z "$temperature" ] && temperature=250

    # Validate brightness range (0-100)
    if [ "$target_brightness" -lt 0 ]; then
        target_brightness=0
    elif [ "$target_brightness" -gt 100 ]; then
        target_brightness=100
    fi

    set_state "$on" "$target_brightness" "$temperature"
}

# Set temperature to specific value (in Kelvin)
set_temperature() {
    local target_kelvin="$1"
    local state=$(get_state)

    if [ -z "$state" ]; then
        return 1
    fi

    local on=$(parse_json "$state" "on")
    local brightness=$(parse_json "$state" "brightness")
    local temperature=$(parse_json "$state" "temperature")

    # Ensure light is on when setting temperature
    [ -z "$on" ] && on=1
    [ -z "$brightness" ] && brightness=20

    # Convert Kelvin to Elgato scale
    # Formula: elgato_temp = 1000000 / kelvin
    # Elgato range: 143 (7000K) to 344 (2900K)
    local elgato_temp=$((1000000 / target_kelvin))

    # Validate Elgato temperature range (143-344)
    if [ "$elgato_temp" -lt 143 ]; then
        elgato_temp=143
    elif [ "$elgato_temp" -gt 344 ]; then
        elgato_temp=344
    fi

    set_state "$on" "$brightness" "$elgato_temp"
}

# Main command dispatcher
case "$1" in
    toggle)
        toggle
        ;;
    temp-warmer)
        adjust_temperature warmer
        ;;
    temp-cooler)
        adjust_temperature cooler
        ;;
    set-brightness)
        set_brightness "$2"
        ;;
    set-temperature)
        set_temperature "$2"
        ;;
    *)
        display_state
        ;;
esac
