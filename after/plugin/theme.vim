colorscheme solarized

" make gutter less annoying
hi SignColumn ctermbg=NONE
hi Normal ctermbg=NONE guibg=NONE
hi StatusLine cterm=NONE ctermbg=Black ctermfg=Blue
hi StatusLineNC cterm=NONE ctermbg=Black ctermfg=Green

set nocursorline
hi TelescopeSelection ctermbg=Black


au FileType * set nocursorline
au FileType * hi TelescopeSelection ctermbg=Black
au FileType * hi Normal ctermbg=NONE guibg=NONE
au FileType * hi StatusLine cterm=NONE ctermbg=Black ctermfg=Blue
au FileType * hi StatusLineNC cterm=NONE ctermbg=Black ctermfg=Green
