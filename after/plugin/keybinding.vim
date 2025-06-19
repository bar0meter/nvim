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

nnoremap <leader>dd :Telescope diagnostics bufnr=0<CR>
nnoremap <leader>xx :Telescope<CR>

nnoremap <leader>zz :lua vim.diagnostic.open_float()<CR>

nnoremap <leader>, :Telescope<CR>

nnoremap <leader>ga :AdvancedGitSearch<CR>
vmap <silent> <leader>ga :AdvancedGitSearch<CR>

