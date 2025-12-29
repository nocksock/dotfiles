#!/usr/bin/env bash

# NVIDIA GPU monitor for Waybar

# Check if GPU is accessible (runtime PM allows checking even when suspended)
check_gpu_accessible() {
    # Try to read power state - this works even when GPU is suspended
    [ -f /sys/bus/pci/devices/0000:c4:00.0/power/runtime_status ]
}

# Get runtime power management status
get_runtime_status() {
    cat /sys/bus/pci/devices/0000:c4:00.0/power/runtime_status 2>/dev/null || echo "unknown"
}

# Get GPU power draw (only works when GPU is active)
get_power_draw() {
    if command -v nvidia-smi &>/dev/null; then
        nvidia-offload nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits 2>/dev/null || echo "0"
    else
        echo "0"
    fi
}

# Get GPU utilization (only works when GPU is active)
get_gpu_utilization() {
    if command -v nvidia-smi &>/dev/null; then
        nvidia-offload nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "0"
    else
        echo "0"
    fi
}

# Display state as JSON for Waybar
display_state() {
    if ! check_gpu_accessible; then
        echo '{"text":"⚠️ GPU","tooltip":"NVIDIA GPU not accessible","class":"error"}'
        return
    fi
    
    local runtime_status=$(get_runtime_status)
    
    if [ "$runtime_status" = "suspended" ]; then
        # GPU is fully suspended (D3cold) - 0W
        local text="🟢 GPU"
        local tooltip="NVIDIA RTX 5070\nState: Suspended (D3cold)\nPower: 0W"
        local class="suspended"
    elif [ "$runtime_status" = "active" ]; then
        # GPU is active - check power draw
        local power=$(get_power_draw)
        local utilization=$(get_gpu_utilization)
        
        # Round power to whole number
        power=$(printf "%.0f" "$power")
        
        if [ "$power" -lt 10 ]; then
            # GPU active but idle (<10W)
            local text="🟡 ${power}W"
            local tooltip="NVIDIA RTX 5070\nState: Active (Idle)\nPower: ${power}W\nUtilization: ${utilization}%"
            local class="idle"
        else
            # GPU under load (≥10W)
            local text="🔴 ${power}W"
            local tooltip="NVIDIA RTX 5070\nState: Active (Load)\nPower: ${power}W\nUtilization: ${utilization}%"
            local class="active"
        fi
    else
        # Unknown state
        local text="⚪ GPU"
        local tooltip="NVIDIA RTX 5070\nState: Unknown ($runtime_status)"
        local class="unknown"
    fi
    
    echo "{\"text\":\"${text}\",\"tooltip\":\"${tooltip}\",\"class\":\"${class}\"}"
}

# Open nvidia-smi in terminal
show_nvidia_smi() {
    kitty --class=float.md -e nvidia-offload nvidia-smi -l 1 &
}

# Main command dispatcher
case "$1" in
    show)
        show_nvidia_smi
        ;;
    *)
        display_state
        ;;
esac
