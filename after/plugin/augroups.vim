augroup NoCursorline
  autocmd!
  autocmd FileType netrw setlocal nocursorline
  autocmd BufEnter * setlocal nocursorline
augroup end
