#!/bin/sh
export PATH="$PATH:/usr/local/bin:/usr/bin"

/usr/bin/picom  &

/usr/bin/feh --bg-scale "$HOME/.config/wallpapers/ghibli-background-1.png" &

exec dwm
