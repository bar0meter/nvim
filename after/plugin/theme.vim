colorscheme onedark

" augroup TransparentBackground
"     autocmd VimEnter * hi Normal ctermbg=none guibg=none
" augroup END

" augroup WinbarBackground
"     autocmd VimEnter * hi WinBar guibg=#D4D3D3
"     autocmd VimEnter * hi WinBar guifg=#1e1e1e gui=bold cterm=bold
" augroup END

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

" Gruvbox rwxrob
" base default color changes (gruvbox dark friendly)
" hi StatusLine ctermfg=grey ctermbg=NONE
" hi StatusLineNC ctermfg=grey ctermbg=NONE
" hi Normal ctermbg=NONE
" hi Special ctermfg=cyan
" hi LineNr ctermfg=grey ctermbg=NONE
" hi SpecialKey ctermfg=grey ctermbg=NONE
" hi ModeMsg ctermfg=grey cterm=NONE ctermbg=NONE
" hi MoreMsg ctermfg=grey ctermbg=NONE
" hi NonText ctermfg=grey ctermbg=NONE
" hi vimGlobal ctermfg=grey ctermbg=NONE
" hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
" hi Error ctermbg=234 ctermfg=darkred cterm=NONE
" hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
" hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
" hi Search ctermbg=236 ctermfg=darkred
" hi vimTodo ctermbg=236 ctermfg=darkred
" hi Todo ctermbg=236 ctermfg=darkred
" hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
" hi MatchParen ctermbg=236 ctermfg=darkred

" " color overrides
" au FileType * hi StatusLine ctermfg=grey ctermbg=NONE
" au FileType * hi StatusLineNC ctermfg=grey ctermbg=NONE
" au FileType * hi Normal ctermbg=NONE
" au FileType * hi Special ctermfg=cyan
" au FileType * hi LineNr ctermfg=grey ctermbg=NONE
" au FileType * hi SpecialKey ctermfg=grey ctermbg=NONE
" au FileType * hi ModeMsg ctermfg=grey cterm=NONE ctermbg=NONE
" au FileType * hi MoreMsg ctermfg=grey ctermbg=NONE
" au FileType * hi NonText ctermfg=grey ctermbg=NONE
" au FileType * hi vimGlobal ctermfg=grey ctermbg=NONE
" au FileType * hi goComment ctermfg=grey ctermbg=NONE
" au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
" au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
" au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
" au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
" au FileType * hi Search ctermbg=236 ctermfg=darkred
" au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
" au FileType * hi Todo ctermbg=236 ctermfg=darkred
" au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
" au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
" au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
" au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
" au FileType markdown,pandoc set tw=0
" au FileType markdown,pandoc set wrap
" au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
" au FileType yaml set sw=2
" au FileType bash set sw=2
" au FileType c set sw=8
" au FileType markdown,pandoc noremap j gj
" au FileType markdown,pandoc noremap k gk
" au FileType sh set noet
