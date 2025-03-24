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

let g:startify_session_number = 5
let g:startify_session_sort = 1
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_session_delete_buffers = 0
let g:startify_change_to_vcs_root = 1

call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'border': 'single',
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'border': 'Normal',
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#F06929'}]),
      \ },
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ })))

