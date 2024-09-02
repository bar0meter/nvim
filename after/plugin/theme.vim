colorscheme habamax
augroup TransparentBackground
    autocmd VimEnter * hi Normal guibg=none ctermbg=none
    autocmd VimEnter * hi clear StatusLine
augroup END
