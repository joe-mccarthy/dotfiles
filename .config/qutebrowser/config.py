config.load_autoconfig(False)

palette = {
    "rosewater": "#f2d5cf",
    "flamingo": "#eebebe",
    "pink": "#f4b8e4",
    "mauve": "#ca9ee6",
    "red": "#e78284",
    "maroon": "#ea999c",
    "peach": "#ef9f76",
    "yellow": "#e5c890",
    "green": "#a6d189",
    "teal": "#81c8be",
    "sky": "#99d1db",
    "sapphire": "#85c1dc",
    "blue": "#8caaee",
    "lavender": "#babbf1",
    "text": "#c6d0f5",
    "subtext1": "#b5bfe2",
    "subtext0": "#a5adce",
    "overlay2": "#949cbb",
    "overlay1": "#838ba7",
    "overlay0": "#737994",
    "surface2": "#626880",
    "surface1": "#51576d",
    "surface0": "#414559",
    "base": "#303446",
    "mantle": "#292c3c",
    "crust": "#232634",
}

font = "JetBrains Mono"

# Browser chrome only. Do not set c.fonts.web.* so websites keep their own fonts.
c.fonts.default_family = font
c.fonts.default_size = "10pt"
c.fonts.completion.category = f"bold 10pt {font}"
c.fonts.completion.entry = f"10pt {font}"
c.fonts.contextmenu = f"10pt {font}"
c.fonts.downloads = f"10pt {font}"
c.fonts.hints = f"bold 10pt {font}"
c.fonts.keyhint = f"10pt {font}"
c.fonts.messages.error = f"10pt {font}"
c.fonts.messages.info = f"10pt {font}"
c.fonts.messages.warning = f"10pt {font}"
c.fonts.prompts = f"10pt {font}"
c.fonts.statusbar = f"10pt {font}"
c.fonts.tabs.selected = f"10pt {font}"
c.fonts.tabs.unselected = f"10pt {font}"

c.auto_save.session = True
c.confirm_quit = ["downloads"]
c.content.autoplay = False
c.content.notifications.enabled = False
c.downloads.location.directory = "~/Downloads"
c.editor.command = ["kitty", "-e", "nvim", "{file}", "-c", "normal {line}G{column0}l"]
c.session.lazy_restore = True
c.tabs.background = True
c.tabs.indicator.width = 0
c.tabs.padding = {"top": 6, "bottom": 6, "left": 10, "right": 10}
c.tabs.title.format = "{audio}{current_title}"
c.window.title_format = "{perc}{current_title}{title_sep}qutebrowser"

# Keybindings that make qutebrowser fit the rest of the desktop.
config.bind("<Ctrl-l>", "cmd-set-text -s :open")
config.bind("<Ctrl-t>", "cmd-set-text -s :open -t")
config.bind("<Ctrl-w>", "tab-close")
config.bind("<Ctrl-Shift-t>", "undo")
config.bind("<Ctrl-r>", "reload")
config.bind("<Ctrl-Shift-r>", "reload -f")
config.bind("<Ctrl-f>", "cmd-set-text /")
config.bind("<Ctrl-Tab>", "tab-next")
config.bind("<Ctrl-Shift-Tab>", "tab-prev")
config.bind("<Alt-Left>", "back")
config.bind("<Alt-Right>", "forward")
config.bind("<Ctrl-=>", "zoom-in")
config.bind("<Ctrl-->", "zoom-out")
config.bind("<Ctrl-0>", "zoom")
config.bind("xx", "config-cycle statusbar.show always never")

# Catppuccin Frappe for browser furniture only.
c.colors.completion.fg = palette["text"]
c.colors.completion.even.bg = palette["base"]
c.colors.completion.odd.bg = palette["mantle"]
c.colors.completion.category.fg = palette["mauve"]
c.colors.completion.category.bg = palette["crust"]
c.colors.completion.category.border.top = palette["crust"]
c.colors.completion.category.border.bottom = palette["surface0"]
c.colors.completion.item.selected.fg = palette["crust"]
c.colors.completion.item.selected.bg = palette["mauve"]
c.colors.completion.item.selected.border.top = palette["mauve"]
c.colors.completion.item.selected.border.bottom = palette["mauve"]
c.colors.completion.item.selected.match.fg = palette["crust"]
c.colors.completion.match.fg = palette["peach"]
c.colors.completion.scrollbar.fg = palette["surface2"]
c.colors.completion.scrollbar.bg = palette["base"]

c.colors.contextmenu.menu.bg = palette["base"]
c.colors.contextmenu.menu.fg = palette["text"]
c.colors.contextmenu.disabled.bg = palette["base"]
c.colors.contextmenu.disabled.fg = palette["overlay0"]
c.colors.contextmenu.selected.bg = palette["mauve"]
c.colors.contextmenu.selected.fg = palette["crust"]

c.colors.downloads.bar.bg = palette["base"]
c.colors.downloads.start.bg = palette["blue"]
c.colors.downloads.start.fg = palette["crust"]
c.colors.downloads.stop.bg = palette["green"]
c.colors.downloads.stop.fg = palette["crust"]
c.colors.downloads.error.bg = palette["red"]
c.colors.downloads.error.fg = palette["crust"]

c.colors.hints.bg = palette["yellow"]
c.colors.hints.fg = palette["crust"]
c.colors.hints.match.fg = palette["red"]
c.colors.keyhint.bg = palette["mantle"]
c.colors.keyhint.fg = palette["text"]
c.colors.keyhint.suffix.fg = palette["yellow"]

c.colors.messages.error.bg = palette["red"]
c.colors.messages.error.border = palette["red"]
c.colors.messages.error.fg = palette["crust"]
c.colors.messages.info.bg = palette["base"]
c.colors.messages.info.border = palette["mauve"]
c.colors.messages.info.fg = palette["text"]
c.colors.messages.warning.bg = palette["yellow"]
c.colors.messages.warning.border = palette["yellow"]
c.colors.messages.warning.fg = palette["crust"]

c.colors.prompts.bg = palette["base"]
c.colors.prompts.border = f"1px solid {palette['mauve']}"
c.colors.prompts.fg = palette["text"]
c.colors.prompts.selected.bg = palette["mauve"]
c.colors.prompts.selected.fg = palette["crust"]

c.colors.statusbar.normal.bg = palette["mantle"]
c.colors.statusbar.normal.fg = palette["text"]
c.colors.statusbar.command.bg = palette["base"]
c.colors.statusbar.command.fg = palette["text"]
c.colors.statusbar.insert.bg = palette["green"]
c.colors.statusbar.insert.fg = palette["crust"]
c.colors.statusbar.passthrough.bg = palette["blue"]
c.colors.statusbar.passthrough.fg = palette["crust"]
c.colors.statusbar.private.bg = palette["surface0"]
c.colors.statusbar.private.fg = palette["subtext1"]
c.colors.statusbar.progress.bg = palette["mauve"]
c.colors.statusbar.url.error.fg = palette["red"]
c.colors.statusbar.url.fg = palette["blue"]
c.colors.statusbar.url.hover.fg = palette["sky"]
c.colors.statusbar.url.success.http.fg = palette["green"]
c.colors.statusbar.url.success.https.fg = palette["green"]
c.colors.statusbar.url.warn.fg = palette["yellow"]

c.colors.tabs.bar.bg = palette["crust"]
c.colors.tabs.even.bg = palette["mantle"]
c.colors.tabs.even.fg = palette["subtext0"]
c.colors.tabs.odd.bg = palette["mantle"]
c.colors.tabs.odd.fg = palette["subtext0"]
c.colors.tabs.selected.even.bg = palette["mauve"]
c.colors.tabs.selected.even.fg = palette["crust"]
c.colors.tabs.selected.odd.bg = palette["mauve"]
c.colors.tabs.selected.odd.fg = palette["crust"]
c.colors.tabs.pinned.even.bg = palette["surface0"]
c.colors.tabs.pinned.even.fg = palette["text"]
c.colors.tabs.pinned.odd.bg = palette["surface0"]
c.colors.tabs.pinned.odd.fg = palette["text"]
c.colors.tabs.pinned.selected.even.bg = palette["lavender"]
c.colors.tabs.pinned.selected.even.fg = palette["crust"]
c.colors.tabs.pinned.selected.odd.bg = palette["lavender"]
c.colors.tabs.pinned.selected.odd.fg = palette["crust"]

c.colors.webpage.bg = palette["base"]
