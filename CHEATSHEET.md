# Dotfiles Cheat Sheet

`Mod` is `Mod4`, usually the Super or Windows key.

## i3 Basics

| Binding | Action |
| --- | --- |
| `Mod+Return` | Open kitty |
| `Mod+b` | Open qutebrowser |
| `Mod+Shift+f` | Open Thunar |
| `Mod+Shift+q` | Close focused window |
| `Mod+Shift+x` | Lock screen |
| `Mod+Shift+Return` | Toggle scratchpad terminal in focused cwd |
| `Mod+Shift+e` | Power menu |
| `Mod+Shift+c` | Reload i3 config |
| `Mod+Shift+r` | Restart i3 in place |

## Launchers And Menus

| Binding | Action |
| --- | --- |
| `Mod+d` | App launcher |
| `Mod+Shift+d` | Run command launcher |
| `Mod+Tab` | Window switcher |
| `Mod+F12` | Unified control center |
| `Mod+F11` | Search this cheat sheet |
| `Mod+p` | Monitor layout menu, including scaling |
| `Mod+Shift+p` | Monitor scaling menu |
| `XF86Display` | Monitor layout menu |
| `Mod+Shift+i` | Keyboard layout menu |
| `XF86Keyboard` | Keyboard layout menu |
| `Mod+Shift+w` | Network menu |
| `XF86WLAN` | Network menu |
| `Mod+Shift+b` | Bluetooth menu |
| `XF86Bluetooth` | Bluetooth menu |
| `Mod+Shift+a` | Audio device menu |

## Clipboard And Notifications

| Binding | Action |
| --- | --- |
| `Mod+c` | Search clipboard history and copy selection |
| `Mod+Control+v` | Pick clipboard item and paste it |
| `Mod+Shift+v` | Open CopyQ window |
| `Mod+Control+c` | Clipboard actions menu |
| `Mod+n` | Close latest notification |
| `Mod+Shift+n` | Close all notifications |
| `Mod+Control+n` | Pop notification history |
| `Mod+Shift+Control+n` | Pause or resume notifications |
| `Mod+Alt+n` | Notification menu |

## Audio

| Binding | Action |
| --- | --- |
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle output mute |
| `XF86AudioMicMute` | Toggle mic mute |
| `Mod+F1` | Toggle output mute |
| `Mod+F2` | Volume down 5% |
| `Mod+F3` | Volume up 5% |
| `Mod+Shift+F10` | Toggle mic mute |

## Screenshots

| Binding | Action |
| --- | --- |
| `Print` | Copy selected area screenshot |
| `Shift+Print` | Copy full screenshot |
| `Control+Print` | Copy focused window screenshot |
| `Mod+Print` | Save selected area screenshot |
| `Mod+Shift+Print` | Save full screenshot |
| `Mod+Control+Print` | Save focused window screenshot |

## Windows

| Binding | Action |
| --- | --- |
| `Mod+j` or `Mod+Left` | Focus left |
| `Mod+k` or `Mod+Down` | Focus down |
| `Mod+l` or `Mod+Up` | Focus up |
| `Mod+;` or `Mod+Right` | Focus right |
| `Mod+Shift+j` or `Mod+Shift+Left` | Move window left |
| `Mod+Shift+k` or `Mod+Shift+Down` | Move window down |
| `Mod+Shift+l` or `Mod+Shift+Up` | Move window up |
| `Mod+Shift+;` or `Mod+Shift+Right` | Move window right |
| `Mod+h` | Split horizontally |
| `Mod+v` | Split vertically |
| `Mod+f` | Toggle fullscreen |
| `Mod+s` | Stacking layout |
| `Mod+w` | Tabbed layout |
| `Mod+e` | Toggle split layout |
| `Mod+Shift+Space` | Toggle floating |
| `Mod+Space` | Toggle focus between tiling and floating |
| `Mod+a` | Focus parent container |
| `Mod+r` | Enter resize mode |

In resize mode:

| Binding | Action |
| --- | --- |
| `j` or `Left` | Shrink width |
| `k` or `Down` | Grow height |
| `l` or `Up` | Shrink height |
| `;` or `Right` | Grow width |
| `Return`, `Escape`, or `Mod+r` | Leave resize mode |

## Workspaces

| Binding | Action |
| --- | --- |
| `Mod+1` ... `Mod+0` | Switch to workspace 1 ... 10 |
| `Mod+Shift+1` ... `Mod+Shift+0` | Move focused window to workspace 1 ... 10 |

## qutebrowser Quick Start

Open qutebrowser with `Mod+b`.

qutebrowser is keyboard-first and mode-based:

| Mode | Use |
| --- | --- |
| Normal | Navigate pages, tabs, links, and commands |
| Insert | Type into web forms |
| Command | Run commands after pressing `:` |
| Hint | Select links by typing labels after pressing `f` |
| Passthrough | Send keys directly to the page |

Press `Esc` to return to normal mode.

## qutebrowser Custom Bindings

These are set in `.config/qutebrowser/config.py`.

| Binding | Action |
| --- | --- |
| `Ctrl+l` | Open URL/search prompt |
| `Ctrl+t` | Open URL/search prompt in a new tab |
| `Ctrl+w` | Close current tab |
| `Ctrl+Shift+t` | Reopen closed tab |
| `Ctrl+r` | Reload |
| `Ctrl+Shift+r` | Force reload |
| `Ctrl+f` | Search in page |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Alt+Left` | Back |
| `Alt+Right` | Forward |
| `Ctrl+=` | Zoom in |
| `Ctrl+-` | Zoom out |
| `Ctrl+0` | Reset zoom |
| `xx` | Toggle statusbar |

## qutebrowser Defaults Worth Knowing

| Binding | Action |
| --- | --- |
| `:` | Command prompt |
| `o` | Open URL/search in current tab |
| `O` | Edit current URL before opening |
| `t` | Open URL/search in new tab |
| `d` | Close tab |
| `u` | Reopen closed tab |
| `J` | Previous tab |
| `K` | Next tab |
| `H` | Back |
| `L` | Forward |
| `r` | Reload |
| `/` | Search in page |
| `n` | Next search match |
| `N` | Previous search match |
| `f` | Hint links in current tab |
| `F` | Hint links in a new tab |
| `yy` | Yank current URL |
| `p` | Open clipboard URL in current tab |
| `P` | Open clipboard URL in new tab |
| `i` | Enter insert mode |
| `Ctrl+v` | Enter passthrough mode |
| `Esc` | Return to normal mode |

## qutebrowser Commands

Type commands after `:`.

| Command | Action |
| --- | --- |
| `:open example.com` | Open a URL or search |
| `:open -t example.com` | Open a URL or search in a new tab |
| `:tab-close` | Close the current tab |
| `:undo` | Reopen the last closed tab |
| `:back` / `:forward` | Navigate history |
| `:reload` / `:reload -f` | Reload or force reload |
| `:download` | Start a download for the current URL |
| `:bookmark-add` | Bookmark current page |
| `:set` | Inspect or change settings |
| `:config-source` | Reload qutebrowser config |
| `:help` | Open help |
| `:quit` | Quit qutebrowser |

Downloads go to `~/Downloads`. External editing opens `kitty` with `nvim`.
