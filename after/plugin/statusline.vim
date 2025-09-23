"Per session word count
let g:session_start_wordcount = 0

function! StartWordCountSession()
    let g:session_start_wordcount = wordcount().words
endfunction

function! GetSessionWordCount()
    let l:delta = wordcount().words - g:session_start_wordcount
    return "" . l:delta . ""
endfunction

"Status Line
set statusline=
set statusline+=%#StatusLine#
set statusline+=%=
set statusline+=\ %f
set statusline+=\ 
set statusline+=%#CursorLineNr#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#DiffAdd#
set statusline+=\ %l/%L
"set statusline+=\ [%c] 
set statusline+=\ [%{wordcount().words}] 
set statusline+=\ " "
set statusline+=%#DiffChange#
set statusline+=\ Sess:%{GetSessionWordCount()}
set statusline+=\ " "
