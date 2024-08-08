colorscheme habamax

augroup transparent_background
    autocmd VimEnter * hi Normal ctermbg=NONE
    autocmd VimEnter * hi clear VertSplit
    autocmd VimEnter * hi clear StatusLine
    autocmd VimEnter * set nocursorline
augroup END
