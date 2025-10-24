#!/usr/bin/env bash
set -euo pipefail
BANNER_DIR="/etc/greetd/banners"
ASCII="$BANNER_DIR/basedos.txt"
if command -v lolcat >/dev/null 2>&1; then
cat "$ASCII" | lolcat -F 0.2 -S 0.2
else
cat "$ASCII"
fi
