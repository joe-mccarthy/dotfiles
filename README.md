# My Dot Files

General configuration for my machine, managed with GNU Stow.

## Install

```sh
git clone <repo-url> ~/.dots
cd ~/.dots
./init.sh
```

Run `init.sh` as your normal user; it asks sudo only for apt and system changes. It installs missing Debian/Ubuntu apt packages from `packages/debian.txt`, refreshes the upstream user-local `yt-dlp` binary, then runs:

```sh
stow -d ~/.dots -t ~ --restow .
```

On a fresh GNOME install, `init.sh` also installs the i3 metapackage and Xorg session support first, so the login screen can offer an `i3` session.

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
- `.config/i3blocks/` for clickable bar status modules
- `.config/dunst/` for notifications
- `.config/rofi/` for the launcher and utility menu theme
- `.config/picom/` for compositor settings
- `.local/bin/i3-*` and `.local/bin/i3blocks-status` for helper scripts

The current setup includes curated i3 autostart, rofi launcher modes, a unified rofi control center, searchable keybinding help, a scratchpad terminal, Markdown notes, media controls, configurable internet radio, qutebrowser, CopyQ clipboard history, dunst notifications, screenshots, power menu, fast solid-color lock screen, picom compositor, monitor layout switching, keyboard layout switching, Bluetooth/network/audio helpers, wallpaper startup, GTK/Qt dark app theming, kitty terminal, and the customised i3bar/i3blocks display. The desktop shell, launcher, notifications, terminal, browser furniture, lock fallback, prompt, and status colours use Catppuccin Frappe with a mauve accent.

After the first install from GNOME, log out, select `i3` from the login screen session chooser, then log back in.

Clipboard history is handled by CopyQ with a rofi picker and no tray icon. Use `$mod+c` to search clipboard history and restore the selected item to the clipboard, `$mod+Control+v` to pick and paste an item immediately, `$mod+Shift+v` to open the full CopyQ window, and `$mod+Control+c` for clipboard actions such as delete item, pause, resume, clear, or quit.

The rofi control center is available with `$mod+F12`. It links the app launcher, window switcher, scratchpad terminal, keybinding help, notes, media controls, radio, monitor controls, keyboard layout, audio, network, Bluetooth, clipboard, notification, screenshot, Pomodoro timer, power, lock, and i3 reload actions. Use `$mod+F11` to search the cheat sheet directly, `$mod+Shift+Return` to toggle the floating scratchpad kitty terminal, `$mod+o` for Markdown notes, `$mod+m` for media controls, and `$mod+Shift+m` for radio. New scratchpad terminals start in the focused terminal's working directory when that can be detected.

Media controls use `playerctl` for MPRIS-compatible apps such as browsers, Spotify, and VLC. The i3blocks media block appears only while something is playing and supports click controls.

Radio uses `mpv`, with `yt-dlp` for YouTube, and local-only `~/.config/i3/radio-stations.tsv`. Add entries as `Name<TAB>Stream or playlist URL`; YouTube playlist URLs are launched audio-only. The repo only keeps `radio/stations.tsv.example`. YouTube changes often, so update `yt-dlp` if those entries stop resolving. The radio block appears only while radio is playing, and media next/previous controls step through playlist entries when radio is the active playback context.

Notes open in kitty with a terminal editor by default, preferring `nvim`, `vim`, then `vi`. Set `I3_NOTES_EDITOR` to override that.

Monitor layouts are handled by `.local/bin/i3-monitor-layout`. Use `$mod+p` or the display key to open the layout menu, including the monitor scaling submenu for active displays. `$mod+Shift+p` opens the scaling menu directly. Startup runs the `auto` layout, which uses the laptop display by itself when undocked and makes the external display primary when one is connected. i3bar is pinned to the current primary output.

Network and Bluetooth helpers are handled by `.local/bin/i3-network-menu` and `.local/bin/i3-bluetooth-menu`. Use `$mod+Shift+w` for network actions and `$mod+Shift+b` for Bluetooth actions.

Audio devices are handled by `.local/bin/i3-audio-menu`. Use `$mod+Shift+a` to switch output/input devices, mute, adjust volume, open `pavucontrol`, or show current audio status.

qutebrowser is the managed browser and default handler for HTTP, HTTPS, and HTML. Use `$mod+b` to open it. Its minimal chrome is themed with Catppuccin Frappe and JetBrains Mono, while web page fonts are left to the sites themselves.

Startup is intentionally curated by `.local/bin/i3-autostart` instead of running every GNOME autostart entry. It applies GTK/Qt theme environment, starts XSettings, and updates user dirs. Network and Bluetooth are controlled through the rofi helpers, so no network or Bluetooth tray icons are started.

GTK and Qt app styling uses Catppuccin Frappe, JetBrains Mono, Papirus-Dark icons, Bibata-Modern-Ice cursors, qt5ct/qt6ct, and Kvantum. `init.sh` can install the Catppuccin GTK theme, Qt theme files, icon theme, and cursor theme:

```sh
./init.sh --catppuccin-only
```

The shared theme env records the Catppuccin Frappe palette for scripts that can source it, while rofi, kitty, dunst, i3, i3blocks, and Starship keep explicit Frappe colours in their own config formats.

Keyboard layout switching is handled by `.local/bin/i3-keyboard-layout`. Use `$mod+Shift+i` to switch between the UK laptop layout and US external keyboard layout. The selected layout is saved in `.config/i3/keyboard-layout` and reapplied on i3 reload.

## Terminal Setup

Kitty uses JetBrains Mono, Catppuccin Frappe colours, subtle background opacity, powerline tabs, split-window keybindings, and terminal-friendly clipboard mappings. `Ctrl+c` copies selected text or interrupts when nothing is selected, and `Ctrl+v` pastes from the clipboard. Bash picks up terminal tools from `.bash_aliases`, including Starship, fzf, zoxide, direnv, eza, bat, btop, duf, procs, neovim, lazygit, and git shortcuts when those commands are installed.

VS Code is installed through apt as the `code` package. `init.sh` configures the Microsoft apt repository automatically before installing packages.

Install the terminal toolchain manually with:

```sh
sudo apt-get install starship eza bat fzf fd-find ripgrep btop zoxide direnv tree ncdu duf hyperfine shellcheck shfmt lazygit git-delta glow procs neovim tmux fastfetch fonts-jetbrains-mono fonts-powerline fonts-noto-color-emoji
```

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

Real secrets belong in `~/.config/secrets/env`; local radio stations belong in `~/.config/i3/radio-stations.tsv`. The repo only includes templates.
