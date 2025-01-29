colorscheme gruvbuddy

" https://superuser.com/questions/921920/display-trailing-spaces-in-vim
augroup HighlightTrailingWhitespace
    autocmd vimenter * hi ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

" gruvbox dark hard
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast="hard"
