# My Dot Files

General configuration for my machine, managed with GNU Stow.

## Install

```sh
git clone <repo-url> ~/.dots
cd ~/.dots
./init.sh
```

`init.sh` installs missing Debian/Ubuntu apt packages from `packages/debian.txt`, then runs:

```sh
stow -d ~/.dots -t ~ --restow .
```

To only restow files without installing packages:

```sh
./init.sh --no-install
```

To print the package manifest:

```sh
./init.sh --list-packages
```

## i3 Setup

The i3 desktop config now lives in this repo:

- `.config/i3/` for i3 config and wallpaper path
- `.config/i3status/` for bar status config
- `.config/dunst/` for notifications
- `.config/rofi/` for the launcher theme
- `.config/picom/` for compositor settings
- `.local/bin/i3-*` and `.local/bin/i3status-wrapper` for helper scripts

The current setup includes rofi launcher modes, dunst notifications, screenshots, power menu, lock screen polish, picom compositor, monitor layout switching, keyboard layout switching, Bluetooth/network helpers, wallpaper startup, kitty terminal, and the customised i3bar/i3status display.

Monitor layouts are handled by `.local/bin/i3-monitor-layout`. Use `$mod+p` or the display key to open the layout menu. Startup runs the `auto` layout, which uses the laptop display by itself when undocked and makes the external display primary when one is connected. i3bar is pinned to the current primary output.

Network and Bluetooth helpers are handled by `.local/bin/i3-network-menu` and `.local/bin/i3-bluetooth-menu`. Use `$mod+Shift+w` for network actions and `$mod+Shift+b` for Bluetooth actions.

Keyboard layout switching is handled by `.local/bin/i3-keyboard-layout`. Use `$mod+Shift+i` to switch between the UK laptop layout and US external keyboard layout. The selected layout is saved in `.config/i3/keyboard-layout` and reapplied on i3 reload.

## Terminal Setup

Kitty uses JetBrains Mono, a tinted wallpaper background, powerline tabs, and split-window keybindings. Bash picks up terminal tools from `.bash_aliases`, including Starship, fzf, zoxide, direnv, eza, bat, btop, duf, procs, neovim, lazygit, and git shortcuts when those commands are installed.

VS Code is installed through apt as the `code` package. `init.sh` configures the Microsoft apt repository automatically before installing packages.

Install the terminal toolchain manually with:

```sh
sudo apt-get install starship eza bat fzf fd-find ripgrep btop zoxide direnv tree ncdu duf hyperfine shellcheck shfmt lazygit git-delta glow procs neovim tmux fastfetch fonts-jetbrains-mono fonts-powerline fonts-noto-color-emoji
```

The network segment in `.local/bin/i3status-wrapper` currently uses this machine's wired and wireless interface names. Update `wifi_if` and `lan_if` there if the names differ on another machine.

## Backup And Restore

Restore instructions live in `RESTORE.md`. The package manifest lives in `packages/debian.txt`.

Use the backup helper before committing:

```sh
~/.local/bin/dots-backup check
```

Commit and push with:

```sh
~/.local/bin/dots-backup sync "Update dotfiles"
```

Real secrets belong in `~/.config/secrets/env`. The repo only includes `secrets/env.example`.
