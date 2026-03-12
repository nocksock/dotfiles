#!/usr/bin/env bash

# Mullvad VPN control for Waybar

# Get current VPN status
get_status() {
    mullvad status 2>/dev/null
}

# Convert country name to ISO code
country_to_code() {
    local country="$1"
    case "$country" in
        Sweden) echo "SE" ;;
        Germany) echo "DE" ;;
        Netherlands) echo "NL" ;;
        "United States"|USA) echo "US" ;;
        "United Kingdom"|UK) echo "GB" ;;
        Denmark) echo "DK" ;;
        Norway) echo "NO" ;;
        Finland) echo "FI" ;;
        Switzerland) echo "CH" ;;
        France) echo "FR" ;;
        Spain) echo "ES" ;;
        Italy) echo "IT" ;;
        Canada) echo "CA" ;;
        Australia) echo "AU" ;;
        Japan) echo "JP" ;;
        Singapore) echo "SG" ;;
        *) echo "??" ;;
    esac
}

# Parse connection state from status output
parse_connection_state() {
    local status="$1"
    echo "$status" | head -n1
}

# Parse country from "Visible location" line
parse_country() {
    local status="$1"
    local location_line=$(echo "$status" | grep "Visible location:")
    if [ -n "$location_line" ]; then
        # Extract country name (first word after "Visible location:")
        local country=$(echo "$location_line" | sed 's/.*Visible location:[[:space:]]*\([^,]*\).*/\1/')
        country_to_code "$country"
    else
        echo "??"
    fi
}

# Parse relay server name
parse_relay() {
    local status="$1"
    echo "$status" | grep "Relay:" | sed 's/.*Relay:[[:space:]]*//'
}

# Parse full location (country, city)
parse_location() {
    local status="$1"
    echo "$status" | grep "Visible location:" | sed 's/.*Visible location:[[:space:]]*//' | sed 's/\. IPv4:.*//'
}

# Parse IP address
parse_ip() {
    local status="$1"
    echo "$status" | grep "IPv4:" | sed 's/.*IPv4:[[:space:]]*//'
}

# Display current state as JSON for waybar
display_state() {
    local status=$(get_status)

    if [ -z "$status" ]; then
        # Mullvad daemon not running
        echo '{"text":"⚠️ ERR","tooltip":"Mullvad daemon not running","class":"error"}'
        return
    fi

    local state=$(parse_connection_state "$status")
    
    if [[ "$state" == "Connected"* ]]; then
        local country=$(parse_country "$status")
        local relay=$(parse_relay "$status")
        local location=$(parse_location "$status")
        local ip=$(parse_ip "$status")
        
        local text="🔒 ${country}"
        local tooltip="VPN: Connected\nRelay: ${relay}\nLocation: ${location}\nIP: ${ip}"
        
        echo "{\"text\":\"${text}\",\"tooltip\":\"${tooltip}\",\"class\":\"connected\"}"
    elif [[ "$state" == "Disconnected"* ]]; then
        local location=$(parse_location "$status")
        local ip=$(parse_ip "$status")
        
        local text="🔓 OFF"
        local tooltip="VPN: Disconnected\nVisible location: ${location}\nIP: ${ip}"
        
        echo "{\"text\":\"${text}\",\"tooltip\":\"${tooltip}\",\"class\":\"disconnected\"}"
    elif [[ "$state" == "Connecting"* ]]; then
        local text="! Connecting"
        
        echo "{\"text\":\"${text}\",\"class\":\"connecting\"}"
    else
        # Unknown state
        echo '{"text":"⚠️ ERR","tooltip":"Unknown VPN state","class":"error"}'
    fi
}

# Toggle VPN connection
toggle() {
    local status=$(get_status)
    
    if [ -z "$status" ]; then
        return 1
    fi
    
    local state=$(parse_connection_state "$status")
    
    if [[ "$state" == "Connected"* ]]; then
        mullvad disconnect >/dev/null 2>&1
    else
        mullvad connect >/dev/null 2>&1
    fi
}

# Connect to specific country
connect_to_country() {
    local country_code="$1"
    
    # Set relay location and connect
    mullvad relay set location "$country_code" >/dev/null 2>&1
    mullvad connect >/dev/null 2>&1
}

# Main command dispatcher
case "$1" in
    toggle)
        toggle
        ;;
    connect)
        connect_to_country "$2"
        ;;
    *)
        display_state
        ;;
esac
