nmap <C-p> :cprevious<CR>
nmap <C-n> :cnext<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>qq :call ToggleQuickFix()<CR>
