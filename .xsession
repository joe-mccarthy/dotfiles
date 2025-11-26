#!/bin/sh
export PATH="$PATH:/usr/local/bin:/usr/bin"

picom  &
feh --bg-scale "$HOME/.config/wallpapers/ghibli-background-1.png" &
dwmblocks &

exec dwm
