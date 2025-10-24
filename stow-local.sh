#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)/packages"
for pkg in "$@"; do
echo "[+] Restowing $pkg"
stow -R -t "$HOME" "$pkg"
done
