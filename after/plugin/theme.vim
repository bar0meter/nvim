    " make gutter less annoying
    hi SignColumn ctermbg=NONE

    " base default color changes (gruvbox dark friendly)
    hi clear StatusLine
    hi clear StatusLineNC
    hi clear LineNr
    hi StatusLine ctermfg=darkgrey ctermbg=NONE
    hi StatusLineNC ctermfg=darkgrey ctermbg=NONE
    hi Normal ctermbg=NONE
    hi Special ctermfg=cyan
    hi LineNr ctermfg=darkgrey ctermbg=NONE
    hi SpecialKey ctermfg=black ctermbg=NONE
    hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
    hi MoreMsg ctermfg=black ctermbg=NONE
    hi NonText ctermfg=black ctermbg=NONE
    hi vimGlobal ctermfg=black ctermbg=NONE
    hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
    hi Error ctermbg=234 ctermfg=darkred cterm=NONE
    hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
    hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
    hi Search ctermbg=236 ctermfg=darkred
    hi vimTodo ctermbg=236 ctermfg=darkred
    hi Todo ctermbg=236 ctermfg=darkred
    hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
    hi MatchParen ctermbg=236 ctermfg=darkred

    " color overrides
    au FileType * hi Normal ctermbg=NONE
    au FileType * hi Special ctermfg=cyan
    au FileType * hi SpecialKey ctermfg=black ctermbg=NONE
    au FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
    au FileType * hi MoreMsg ctermfg=black ctermbg=NONE
    au FileType * hi NonText ctermfg=black ctermbg=NONE
    au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
    au FileType * hi goComment ctermfg=black ctermbg=NONE
    au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
    au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
    au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
    au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
    au FileType * hi Search ctermbg=236 ctermfg=darkred
    au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
    au FileType * hi Todo ctermbg=236 ctermfg=darkred
    au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
    au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
    au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
    au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
    au FileType markdown,pandoc set tw=0
    au FileType markdown,pandoc set wrap
    au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
    au FileType yaml set sw=2
    au FileType bash set sw=2
    au FileType c set sw=8
    au FileType markdown,pandoc noremap j gj
    au FileType markdown,pandoc noremap k gk
    au FileType sh set noet
