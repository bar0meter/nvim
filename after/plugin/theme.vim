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


highlight! NormalFloat guibg=#1f2335  " Choose a slightly lighter background than default
  highlight! FloatBorder guibg=#1f2335 guifg=#1f2335
