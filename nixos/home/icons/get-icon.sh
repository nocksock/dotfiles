#!/usr/bin/env nix-shell
#! nix-shell -i bash -p wget htmlq curl

set -euo pipefail

url="$1"
hostname=$(echo "$url" | sed -E 's|https?://([^/]+).*|\1|')
html=$(curl -sL "$url")

icon_path=$(echo "$html" | htmlq 'link[rel*="apple-touch-icon"][sizes="180x180"]' --attribute href || \
           echo "$html" | htmlq 'link[rel*="apple-touch-icon"][sizes="152x152"]' --attribute href || \
           echo "$html" | htmlq 'link[rel*="apple-touch-icon"]' --attribute href | head -n1 || true)
icon_path=$(echo "$icon_path" | cut -d'?' -f1)
ext=${icon_path##*.}
output="${hostname}.${ext}"

if [ -z "$icon_path" ]; then
    echo "Error: Could not find apple-touch-icon"
    exit 1
fi

wget -q --show-progress -O "$output" "$hostname$icon_path"
