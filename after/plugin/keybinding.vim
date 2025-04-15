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

nnoremap <leader>xx :Trouble diagnostics<CR>

nnoremap <leader>zz :lua vim.diagnostic.open_float()<CR>

nnoremap <leader>ac :ClaudeCode<CR>

nnoremap <leader>gg <cmd>Fzm<CR>
vmap <silent> <leader>gg <cmd>Fzm<CR>

nnoremap <leader>, :Telescope<CR>

nnoremap <leader>ga :AdvancedGitSearch<CR>
vmap <silent> <leader>ga :AdvancedGitSearch<CR>

