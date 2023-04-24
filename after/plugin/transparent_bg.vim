augroup TransparentBg
    autocmd vimenter * hi Comment cterm=italic gui=italic
    "autocmd vimenter * hi netrwDir guifg=#5eacd3
    """"""" transparent bg
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    """""""For Vim<8, replace EndOfBuffer by NonText
    autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd vimenter * hi EndOfBuffer guifg=#71797E ctermfg=245

    autocmd vimenter * hi ColorColumn ctermbg=0 guibg=grey
    autocmd vimenter * hi SignColumn guibg=none
    autocmd vimenter * hi CursorLineNR guibg=None
    autocmd vimenter * hi qfFileName guifg=#aed75f

    autocmd vimenter * hi StatusLine ctermbg=0 cterm=NONE
    autocmd vimenter * hi StatusLine ctermbg=none cterm=bold

    autocmd vimenter * hi clear SignColumn
    autocmd vimenter * hi clear StatusLine

    autocmd vimenter * hi clear LineNr
    autocmd vimenter * hi Comment guifg=#71797E
    " autocmd vimenter * hi LineNr guifg=#5eacd3

    autocmd vimenter * hi SignColumn guibg=none
    autocmd vimenter * hi CursorLineNR guibg=None
    autocmd vimenter * hi Normal guibg=none
    autocmd vimenter * hi clear TelescopeNormal
    autocmd vimenter * hi clear TelescopeBorder
    autocmd vimenter * hi TelescopeBorder guifg=#5eacd

    autocmd vimenter * hi Pmenu guibg=NONE ctermbg=NONE
    autocmd vimenter * hi WhichKeyFloat ctermbg=NONE guibg=NONE

    autocmd vimenter * hi MatchParen cterm=bold ctermbg=NONE ctermfg=15 term=standout

    autocmd vimenter * hi VertSplit cterm=NONE ctermbg=NONE

    autocmd vimenter * hi Search ctermfg=15 cterm=NONE term=standout ctermbg=NONE
    autocmd vimenter * hi VertSplit cterm=NONE ctermbg=Black ctermfg=Green

augroup END
