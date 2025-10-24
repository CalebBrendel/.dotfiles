#!/usr/bin/env bash
term=""
for t in foot kitty alacritty wezterm gnome-terminal; do
  if command -v "$t" >/dev/null 2>&1; then term="$t"; break; fi
done

if [ -z "$term" ]; then
  setsid -f sh -c 'nmtui'
  exit 0
fi

case "$term" in
  foot)            setsid -f foot -e nmtui ;;
  kitty)           setsid -f kitty nmtui ;;
  alacritty)       setsid -f alacritty -e nmtui ;;
  wezterm)         setsid -f wezterm start -- nmtui ;;
  gnome-terminal)  setsid -f gnome-terminal -- nmtui ;;
esac
