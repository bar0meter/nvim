set nofoldenable
set foldmethod=marker
set nostartofline

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

" autocmd BufWinLeave * !echo -e "\033[6 q"
" autocmd BufWinLeave * !echo -e "\e[0 q"
" autocmd VimLeave * silent !echo -ne "\e[6 q"
autocmd WinLeave * silent !printf '\033[6 q'


set encoding=utf-8
