augroup TransparentBackground
  autocmd VimEnter * hi clear LineNr
  autocmd VimEnter * set nocursorline
  autocmd VimEnter * hi Normal ctermbg=none guibg=none
  autocmd VimEnter * hi EndOfBuffer ctermbg=none guibg=none
augroup END
