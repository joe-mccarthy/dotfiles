# My Dot Files

General configuration for my machine, managed with GNU Stow.

## Install

```sh
git clone <repo-url> ~/.dots
cd ~/.dots
./init.sh
```

`init.sh` installs missing Debian/Ubuntu apt packages for the desktop setup, then runs:

```sh
stow -d ~/.dots -t ~ --restow .
```

To only restow files without installing packages:

```sh
./init.sh --no-install
```

## i3 Setup

The i3 desktop config now lives in this repo:

- `.config/i3/` for i3 config and wallpaper path
- `.config/i3status/` for bar status config
- `.config/dunst/` for notifications
- `.config/rofi/` for the launcher theme
- `.config/picom/` for compositor settings
- `.local/bin/i3-*` and `.local/bin/i3status-wrapper` for helper scripts

The current setup includes rofi launcher modes, dunst notifications, screenshots, power menu, lock screen polish, picom compositor, monitor layout switching, wallpaper startup, UK keyboard layout, kitty terminal, and the customised i3bar/i3status display.

Monitor layouts are handled by `.local/bin/i3-monitor-layout`. Use `$mod+p` or the display key to open the layout menu. Startup runs the `auto` layout, which uses the laptop display by itself when undocked and makes the external display primary when one is connected.

The network segment in `.local/bin/i3status-wrapper` currently uses this machine's wired and wireless interface names. Update `wifi_if` and `lan_if` there if the names differ on another machine.
