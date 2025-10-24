#!/usr/bin/env bash
set -euo pipefail


# 1) ensure stow
if ! command -v stow >/dev/null 2>&1; then
echo "[+] Installing GNU Stow (needs sudo)"
if command -v dnf >/dev/null 2>&1; then
sudo dnf -y install stow
elif command -v pacman >/dev/null 2>&1; then
sudo pacman -S --noconfirm stow
else
echo "Please install GNU stow manually" && exit 1
fi
fi


REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR/packages"


# 2) backup any conflicting files before stowing
backup() {
local target="$1"; shift || true
if [ -e "$target" ] && [ ! -L "$target" ]; then
local ts="$(date +%Y%m%d-%H%M%S)"
mkdir -p "$HOME/.dotfiles_backup/$ts"
mv "$target" "$HOME/.dotfiles_backup/$ts/" && \
echo "[~] Backed up $target -> ~/.dotfiles_backup/$ts/"
fi
}


# Backup common targets
backup "$HOME/.config/hypr"
backup "$HOME/.config/waybar"
backup "$HOME/.config/rofi"


# 3) stow user packages
for pkg in hypr waybar rofi scripts; do
echo "[+] Stowing $pkg"
stow -t "$HOME" "$pkg"
done


echo "[i] System packages (greetd, tlp) require sudo and will be stowed separately:"
echo " sudo stow -t / greetd tlp"
