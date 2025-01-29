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
