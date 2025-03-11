let g:gruvbox_contrast_dark = "hard"
colorscheme tokyonight

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

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi clear StatusLine
" hi LineNr guifg=#fabd2f
" hi LineNrAbove guifg=#7c6f64
" hi LineNrBelow guifg=#7c6f64

augroup NoCursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * set nocursorline
    autocmd WinLeave * set cursorline
augroup END
