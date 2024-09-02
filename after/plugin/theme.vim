colorscheme vscode

augroup TransparentBackground
    autocmd VimEnter * hi clear StatusLine
augroup END

augroup WinbarBackground
    autocmd VimEnter * hi WinBar guibg=#D4D3D3
    autocmd VimEnter * hi WinBar guifg=#1e1e1e gui=bold cterm=bold
augroup END

" https://superuser.com/questions/921920/display-trailing-spaces-in-vim
augroup HighlightTrailingWhitespace
    autocmd vimenter * hi ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

augroup VscodeTheme
    autocmd vimenter * hi @variable guifg=#D4D3D3
    autocmd vimenter * hi @field guifg=#D4D3D3
    autocmd vimenter * hi @constant guifg=#D4D3D3
    autocmd vimenter * hi @constructor guifg=#D4D3D3
    autocmd vimenter * hi @type guifg=#D4D3D3
    autocmd vimenter * hi @type.builtin guifg=#4EC9B0
    autocmd vimenter * hi @attribute guifg=#4EC9B0
    autocmd vimenter * hi @method guifg=#DCDCAA
    autocmd vimenter * hi @keyword guifg=#C586C0
    autocmd vimenter * hi @keyword.operator guifg=#C586C0
    autocmd vimenter * hi @keyword.function guifg=#569cd6
    " autocmd vimenter * hi MsgArea guibg=#D4D3D3 guifg=#1e1e1e gui=bold
    autocmd vimenter * hi MsgArea guibg=#1f1f1f guifg=#1f1f1f gui=bold " disable message area
augroup END
