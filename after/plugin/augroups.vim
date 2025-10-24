augroup NoCursorline
  autocmd!
  autocmd FileType netrw setlocal nocursorline
  autocmd BufEnter * setlocal nocursorline
augroup end

augroup vscode
  autocmd!
  autocmd BufEnter * hi clear StatusLine
augroup end

augroup HighlightTrailingWhitespace
    autocmd vimenter * hi ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END
