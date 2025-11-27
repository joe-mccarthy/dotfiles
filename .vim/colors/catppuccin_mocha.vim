" Catppuccin Mocha – simple Vim colorscheme (no plugins, no variables)
" File: ~/.vim/colors/catppuccin_mocha.vim

hi clear
if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "catppuccin_mocha"

" Base UI
hi Normal       guifg=#cdd6f4 guibg=#1e1e2e ctermfg=NONE ctermbg=NONE
hi CursorLine                 guibg=#242437 ctermbg=NONE
hi CursorColumn               guibg=#242437 ctermbg=NONE
hi CursorLineNr guifg=#f9e2af guibg=#242437
hi LineNr       guifg=#a6adc8 guibg=#1e1e2e
hi VertSplit    guifg=#313244 guibg=#1e1e2e ctermfg=NONE
hi StatusLine   guifg=#11111b guibg=#89b4fa ctermfg=NONE ctermbg=NONE
hi StatusLineNC guifg=#a6adc8 guibg=#181825 ctermfg=NONE ctermbg=NONE
hi Pmenu        guifg=#cdd6f4 guibg=#181825 ctermfg=NONE ctermbg=NONE
hi PmenuSel     guifg=#11111b guibg=#89b4fa ctermfg=NONE ctermbg=NONE
hi Visual                     guibg=#3b3d57 ctermbg=NONE
hi Search       guifg=#11111b guibg=#f9e2af ctermfg=NONE ctermbg=NONE
hi IncSearch    guifg=#11111b guibg=#fab387 ctermfg=NONE ctermbg=NONE
hi MatchParen   guifg=#fab387 guibg=NONE    ctermfg=NONE

" Syntax
hi Comment      guifg=#6c7086 gui=italic    ctermfg=NONE
hi Constant     guifg=#fab387               ctermfg=NONE
hi String       guifg=#a6e3a1               ctermfg=NONE
hi Character    guifg=#a6e3a1               ctermfg=NONE
hi Number       guifg=#fab387               ctermfg=NONE
hi Boolean      guifg=#fab387               ctermfg=NONE
hi Float        guifg=#fab387               ctermfg=NONE

hi Identifier   guifg=#94e2d5               ctermfg=NONE
hi Function     guifg=#89b4fa               ctermfg=NONE

hi Statement    guifg=#b4befe               ctermfg=NONE
hi Conditional  guifg=#b4befe               ctermfg=NONE
hi Repeat       guifg=#b4befe               ctermfg=NONE
hi Label        guifg=#b4befe               ctermfg=NONE
hi Operator     guifg=#94e2d5               ctermfg=NONE
hi Keyword      guifg=#cba6f7               ctermfg=NONE
hi Exception    guifg=#f38ba8               ctermfg=NONE

hi PreProc      guifg=#f9e2af               ctermfg=NONE
hi Include      guifg=#f9e2af               ctermfg=NONE
hi Define       guifg=#f9e2af               ctermfg=NONE
hi Macro        guifg=#f9e2af               ctermfg=NONE

hi Type         guifg=#94e2d5               ctermfg=NONE
hi StorageClass guifg=#94e2d5               ctermfg=NONE
hi Structure    guifg=#94e2d5               ctermfg=NONE
hi Typedef      guifg=#94e2d5               ctermfg=NONE

hi Special      guifg=#89b4fa               ctermfg=NONE
hi SpecialChar  guifg=#89b4fa               ctermfg=NONE
hi Tag          guifg=#89b4fa               ctermfg=NONE
hi Delimiter    guifg=#a6adc8               ctermfg=NONE

hi Error        guifg=#11111b guibg=#f38ba8 ctermfg=NONE ctermbg=NONE
hi WarningMsg   guifg=#f9e2af               ctermfg=NONE
hi Todo         guifg=#f9e2af guibg=NONE gui=bold ctermfg=NONE

