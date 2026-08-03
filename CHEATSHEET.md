# Dotfiles Cheat Sheet

`Mod` is `Mod4`, usually the Super or Windows key.

## i3 Basics

| Binding | Action |
| --- | --- |
| `Mod+Return` | Open kitty |
| `Mod+b` | Open Firefox ESR |
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
| `Mod+u` | Unified control center |
| `Mod+Shift+/` | Search this cheat sheet |
| `Mod+o` | Notes menu |
| `Mod+Shift+o` | Quick note |
| `Mod+m` | Media controller |
| `Mod+Shift+m` | Radio menu |
| `Mod+p` | Monitor layout menu, including scaling |
| `Mod+Shift+p` | Monitor scaling menu |
| `Mod+Shift+i` | Keyboard layout menu |
| `Mod+Shift+w` | Network menu |
| `Mod+Shift+b` | Bluetooth menu |
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
| `Mod+Control+m` | Toggle output mute |
| `Mod+Control+-` | Volume down 5% |
| `Mod+Control+=` | Volume up 5% |
| `Mod+Control+Shift+m` | Toggle mic mute |

## Media

| Binding | Action |
| --- | --- |
| `Mod+m` | Media controller |
| `Mod+Control+,` | Previous track |
| `Mod+Control+Space` | Play or pause active media player |
| `Mod+Control+p` | Pause active media player |
| `Mod+Control+.` | Next track |
| `Mod+Control+s` | Stop playback |

When music is playing, the status bar media block appears. Browser playback is labelled with only the site domain. Left click toggles play/pause, middle click or scroll up skips next, right click opens the media menu, and scroll down goes previous.

## Radio

Radio entries are configured in local-only `~/.config/i3/radio-stations.tsv` as `Name<TAB>Stream or playlist URL`. YouTube playlist URLs work through `mpv` and `yt-dlp` and are launched audio-only. The repo template is `radio/stations.tsv.example`.

| Binding | Action |
| --- | --- |
| `Mod+Shift+m` | Open radio menu |

The status bar radio block appears while radio is playing. Left or right click opens the radio menu; middle click stops radio. Media next/previous controls move through playlist entries when radio is the active playback context.

## Notes

Notes are stored as Markdown under `~/.local/share/notes`.

| Binding | Action |
| --- | --- |
| `Mod+o` | Open notes menu |
| `Mod+Shift+o` | Append a quick note to today's daily note |

## Screenshots

| Binding | Action |
| --- | --- |
| `Mod+Control+a` | Copy selected area screenshot |
| `Mod+Control+f` | Copy full screenshot |
| `Mod+Control+w` | Copy focused window screenshot |
| `Mod+Control+Shift+a` | Save selected area screenshot |
| `Mod+Control+Shift+f` | Save full screenshot |
| `Mod+Control+Shift+w` | Save focused window screenshot |

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

## kitty

| Binding | Action |
| --- | --- |
| `Ctrl+c` | Copy selection, or interrupt when nothing is selected |
| `Ctrl+v` | Paste from clipboard |
| `Ctrl+Shift+c` | Copy to clipboard |
| `Ctrl+Shift+v` | Paste from clipboard |
| `Ctrl+Shift+Enter` | New kitty window in current cwd |
| `Ctrl+Shift+t` | New kitty tab in current cwd |
| `Ctrl+Shift+w` | Close kitty window |
| `Ctrl+Shift+q` | Close kitty tab |
| `Ctrl+Shift+Left` | Previous kitty tab |
| `Ctrl+Shift+Right` | Next kitty tab |
| `Ctrl+Shift+,` | Move kitty tab backward |
| `Ctrl+Shift+.` | Move kitty tab forward |
| `Ctrl+Shift+r` | Rename kitty tab |
| `Ctrl+Shift+e` | Open URL with hints |
| `Ctrl+Shift+s` | Show scrollback |
| `Ctrl+Shift+\` | Vertical split in current cwd |
| `Ctrl+Shift+-` | Horizontal split in current cwd |
