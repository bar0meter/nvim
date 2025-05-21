let g:gruvbox_contrast_dark = "medium"
colorscheme rose-pine-moon

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

augroup Transparency
    autocmd!
    autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi NonText guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi NormalFloat guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi TelescopeNormal guibg=NONE ctermbg=NONE
    autocmd VimEnter * hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
augroup end
