syntax enable

 "faster scrolling
set ttyfast

set termguicolors
set t_Co=256
set t_ut=

set background=dark

let g:gruvbox_baby_background_color = 'dark'
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_italicize_comments = 0
let g:gruvbox_bold = 0

let g:tokyonight_style = "storm"
let g:tokyonight_italic_comments = 0
let g:tokyonight_transparent = 1
let g:tokyonight_transparent_sidebar = 0
let g:tokyonight_dark_sidebar = 0
let g:tokyonight_dark_float = 0

let g:transparent_sidebar=1
let g:transparent=1

let g:onedark_config = {
    \ 'style': 'darker',
\}

colorscheme catppuccin

highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl
highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl
highlight DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl

highlight TelescopeSelection gui=bold " selected item

highlight TelescopeSelection gui=bold
