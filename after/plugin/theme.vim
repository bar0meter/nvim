colorscheme everforest

" base default color changes (gruvbox dark friendly)
hi clear StatusLine
hi Normal ctermbg=NONE guibg=NONE
hi clear LineNr
hi LineNr ctermfg=8

" color overrides
au FileType * hi clear StatusLine 
au FileType * hi Normal ctermbg=NONE guibg=NONE
au FileType * hi clear LineNr
au FileType * hi LineNr ctermfg=8

