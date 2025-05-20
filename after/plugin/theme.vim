let g:gruvbox_contrast_dark = "medium"
colorscheme gruvbox

" https://superuser.com/questions/921920/display-trailing-spaces-in-vim
" augroup HighlightTrailingWhitespace
"     autocmd vimenter * hi ExtraWhitespace ctermbg=red guibg=red
"     match ExtraWhitespace /\s\+$/
"     autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"     autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"     autocmd InsertEnter * match ExtraWhitespace /\s\+$/
"     autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"    autocmd BufWinLeave * call clearmatches()
" augroup END

augroup NoCursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * set nocursorline
    autocmd WinLeave * set cursorline
augroup END

