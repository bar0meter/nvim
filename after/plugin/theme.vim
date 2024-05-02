augroup TransparentBackground
  autocmd VimEnter * hi clear LineNr
  autocmd VimEnter * set nocursorline
  autocmd VimEnter * hi EndOfBuffer ctermbg=236 guibg=#333333
augroup END
