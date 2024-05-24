augroup envrc_ft
  au!
  autocmd BufNewFile,BufRead envrc.* set syntax=sh
augroup END

augroup env_ft
  au!
  autocmd BufNewFile,BufRead .env set syntax=sh
  autocmd BufNewFile,BufRead .env.* set syntax=sh
augroup END
