" Line number gutter
set numberwidth=3

set title
set titlestring=%t
set titleold=

" Save history
set history=10000
set viminfo+=:10000

""" Terminal
" Treat undercurl as underline.
set t_Cs= t_Ce=


set nrformats-=octal


set encoding=utf-8

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)


" autocmd VimLeave * silent !echo -ne "\e[6 q"

" augroup fix_cursor_shape
"   au!
"   autocmd VimLeave * call system('printf "\e[5 q" > $TTY')
"   autocmd VimLeave * silent !echo -ne "\e[5 q"
" augroup END

augroup FixCursorShape
  autocmd!
  " autocmd VimLeave * call system('tput cnorm') " Restore normal cursor
  autocmd VimLeave * silent !printf "\e[5 q"  " Alternative method
augroup END
