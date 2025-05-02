filetype plugin indent on
syntax enable

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tamago324/lir.nvim'
Plug 'mhinz/vim-startify'
Plug 'ibhagwan/fzf-lua'
Plug 'harjotgill/fuzzy-menu.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'voldikss/vim-floaterm'
Plug 'voldikss/fzf-floaterm'
Plug 'voldikss/coc-floaterm'

Plug 'github/copilot.vim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim'

Plug 'pwntester/octo.nvim'
Plug 'gelguy/wilder.nvim'

Plug 'harjotgill/CodeGPT.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'Yggdroot/indentLine'
Plug 'samoshkin/vim-mergetool'

call plug#end()

set belloff=all
set noerrorbells
set vb t_vb=
set clipboard=unnamedplus
set termguicolors
set undofile
set nu
set inccommand=split

set nofoldenable
set foldmethod=expr
set foldcolumn=0
set foldlevelstart=1
set foldexpr='nvim_treesitter#foldexpr()'
set foldtext=''

set tabstop=2       " The width of a TAB is set to 4.
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 4.
set shiftwidth=2    " Indents will have a width of 4
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set ignorecase
set smartcase

" allow to scroll in the preview and other actions
set mouse=a
" enable mousemoveevent
set mousemoveevent

let mapleader = ","

colorscheme gruvbox-material

" Keybindings
" Map jk to <Esc>
inoremap jk <Esc>

" Using Ctrl-Z to save buffer
nnoremap <C-Z> :update<CR>

nnoremap <Leader>e :quit<CR>

nnoremap <Leader>w :bw<CR>

nnoremap <C-j> :cnext<CR>
nnoremap <C-n> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
nnoremap <C-p> :cprevious<CR>

nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

map <C-c> "+y

nnoremap <Leader>l :Telescope find_files<CR>
nnoremap <Leader>ff :Telescope live_grep<CR>
nnoremap <Leader>b :Telescope <CR>
nnoremap <Leader>dd :CocFzfList diagnostics --current-buf<CR>
nnoremap <Leader>ds :CocFzfList outline<CR>

xmap <Leader>c  <Plug>Commentary
nmap <Leader>c  <Plug>Commentary
map <Leader>c  <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine

nmap <silent> <Leader>xx <Plug>(Fzm)
vmap <silent> <Leader>xx <Plug>(FzmVisual)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>ca :call CocAction("codeAction")<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"¦
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

let g:diagnostic_window_size = 3

" IndentLines
set list
set listchars=tab:\¦\ 
let g:indentLine_fileTypeExclude = ['startify', 'floaterm', 'coc-explorer', 'coctree', 'json']

" Floaterms
let g:ft_float_width = 0.9
let g:ft_float_height = 0.9
let g:ft_window_height = 0.9
let g:ft_window_width = 0.9

let g:fzf_floaterm_newentries = {
  \ '+zsh' : {
    \ 'title': 'Zsh Shell (bottom window)',
    \ 'height': 0.25,
    \ 'wintype': 'split',
    \ 'cmd': 'zsh' },
  \ '+bash' : {
    \ 'title': 'Zsh Shell (vertical window)',
    \ 'width': 0.40,
    \ 'wintype': 'vsplit',
    \ 'cmd': 'zsh' },
  \ }

let g:floaterm_autohide = 2

let g:floaterm_title = ' Floaterm'
autocmd FileType floaterm tnoremap <silent><expr> <ESC> (&filetype == "floaterm") ? "<C-\><C-n>:FloatermHide<CR>" : "<ESC>"

function! FloatermExists() abort
  for bufnr in range(1, bufnr('$'))
    if bufexists(bufnr) && getbufvar(bufnr, '&filetype') ==# 'floaterm'
      return 1
    endif
  endfor
  return 0
endfunction

function! ToggleFloaterm()
  if FloatermExists()
    execute 'FloatermToggle'
  else
    execute 'FloatermNew --cmd=zsh --height=0.25 --wintype=split'
  endif
endfunction

nmap <Leader>ft :call ToggleFloaterm()<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <Leader>qq :call ToggleQuickFix()<cr>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_global_extensions = [
      \ 'coc-highlight', 
      \ 'coc-go', 
      \ 'coc-explorer', 
      \ 'coc-pairs', 
      \ 'coc-yank', 
      \ 'coc-html',
      \ 'coc-yaml',
      \ 'coc-sql',
      \ 'coc-pyright',
      \ 'coc-json',
      \ 'coc-clangd',
      \ 'coc-webview',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-markdownlint',
      \ 'coc-reveal',
      \ 'coc-swagger',
      \ 'coc-toml',
      \ 'coc-markmap', 
      \ 'coc-diagnostic',
      \ 'coc-prettier',
      \ 'coc-marketplace',
      \ 'coc-vimlsp',
      \ 'coc-protobuf',
      \ 'coc-postfix',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-lua',
      \ 'coc-snippets',
      \ 'coc-ltex',
      \ 'coc-symbol-line',
      \ 'coc-java',
      \ 'coc-vale',
      \ 'coc-prisma'
      \ ]

augroup coc_actions
  autocmd!
  " add missing go imports on save
  autocmd BufWritePre *.ts,*.js,*.go silent! call CocAction('organizeImport')
  autocmd BufWritePre *.ts,*.js,*.go silent! call CocAction('format')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:airline#extensions#coc#show_coc_status = 0
let airline#extensions#coc#error_symbol = ''
let airline#extensions#coc#warning_symbol = ''

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git*" --glob "!node_modules/*" --glob "!dist/*"'

" - Popup window (center of the current window)
let g:fzf_layout = exists('$TMUX') ? {'tmux': '-p90%,80%'} : {'window': { 'width': 0.9, 'height': 0.9, 'relative': v:true }}

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! FzfTagsCurrWord()
  let currWord = expand('<cword>')
  if len(currWord) > 0
    call fzf#vim#tags({'options': '-q ' . currWord})
  else
    execute ':Tags'
  endif
endfunction


let g:fzf_preview_window = ['right:50%', 'ctrl-\']

" Wilder
" Default keys
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

" Startify
let g:startify_session_number = 5
let g:startify_session_sort = 1
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_session_delete_buffers = 0
let g:startify_change_to_vcs_root = 1

" fzf mappings
call fuzzymenu#AddAll({
      \ '󰋜 Main Menu': {'exec': 'Startify'},
      \ ' Find Files': {'exec': 'Files'},
      \ ' Git Files': {'exec': 'GFiles'},
      \ 'ﮦ Sessions': {'exec': 'call OpenSessions()'},
      \ ' Save Session': {'exec': 'SSave'},
      \ ' Colors': {'exec': 'Colors'},
      \ ' Lines': {'exec': 'BLines'},
      \ '󰌨 Buffers': {'exec': 'Buffers'},
      \ ' Tabs & Windows': {'exec': 'Windows'},
      \ ' Marks': {'exec': 'Marks'},
      \ '󰈞 Pattern': {'exec': 'RG'},
      \ ' Filetypes': {'exec': 'Filetypes'},
      \ ' Commands': {'exec': 'Commands'},
      \ ' Key Maps': {'exec': 'Maps'},
      \ ' Snippets': {'exec': 'Snippets'},
      \ ' Help Tags': {'exec': 'Helptags'},
      \ ' Command History': {'exec': 'History:'},
      \ ' Search History': {'exec': 'History/'},
      \ ' Terminals': {'exec': 'Floaterms'},
      \ ' Undotree': {'exec': 'MundoToggle'},
      \ ' IndentLines': {'exec': 'IndentLinesToggle'},
      \ ' ANSI Escape': {'exec': 'AnsiEsc'},
      \ ' Update Plugins': {'exec': 'PlugUpdate'},
      \ ' Update Coc Extensions': {'exec': 'CocUpdate'},
      \ ' Unicode Symbols': {'exec': 'call unicode#Fuzzy()'},
    \ },
    \ {'after': 'call fuzzymenu#InsertModeIfNvim()', 'tags': ['tools']})

" Coc menu
call fuzzymenu#AddAll({
      \ ' Diagnostics (Workspace)': {'exec': 'CocFzfList diagnostics'},
      \ ' Diagnostics (Buffer)': {'exec': 'call ToggleDiagnostics()'},
      \ ' Coc Actions': {'exec': 'call CocActionAsync("codeAction")'},
      \ ' Coc Commands': {'exec': 'CocCommand'},
      \ '󰌵 CodeLens Actions': {'exec': 'call CocActionAsync("codeLensAction")'},
      \ '󰉼 Format': {'exec': 'CocCommand editor.action.formatDocument'},
      \ '󰉋 File Explorer': {'exec': 'CocCommand explorer'},
      \ '󰈈 Outline Sidebar': {'exec': 'call OutlineToggle()'},
      \ '󰅴 Goto Definition': {'exec': 'call CocActionAsync("jumpDefinition")'},
      \ '󰅴 Goto Implementation': {'exec': 'call CocActionAsync("jumpImplementation")'},
      \ '󰅴 Goto References': {'exec': 'call CocActionAsync("jumpReferences")'},
      \ '󱖖 Incoming Calls': {'exec': 'CocCommand document.showIncomingCalls'},
      \ '󱖔 Outgoing Calls': {'exec': 'CocCommand document.showOutgoingCalls'},
      \ ' Documentation': {'exec': 'call ShowDocumentation()'},
      \ ' Coc Lists': {'exec': 'CocFzfList'},
      \ '󰐱 Coc Extensions': {'exec': 'CocFzfList extensions'},
      \ '󰣖 Coc Services': {'exec': 'CocFzfList services'},
      \ ' Coc Config': {'exec': 'CocConfig'},
      \ '󰜉 Coc Restart': {'exec': 'CocRestart'},
      \ '󰣖 Coc Completion Sources': {'exec': 'CocFzfList sources'},
      \ ' Coc LSP Logs': {'exec': 'CocCommand workspace.showOutput'},
      \ ' Coc Logs': {'exec': 'CocInfo'},
      \ '󰈈 Outline Navigator': {'exec': 'CocFzfList outline'},
      \ '󰑕 Rename': {'exec': 'CocRename'},
      \ ' Organize Imports': {'exec': 'CocCommand editor.action.organizeImport'},
      \ '󰆒 Yank History (Clipboard)': {'exec': 'CocFzfList yank'},
      \ '󰈙 Render Swagger/OpenAPI spec': {'exec': 'CocCommand swagger.render'},
      \ '󰊤 GitHub Browser': {'exec': 'GBrowse'},
    \ },
    \ {'tags': ['coc'],
    \ 'for': {'exists': 'g:coc_enabled'}})

call fuzzymenu#AddAll({
      \ ' Markdown Preview': {'exec': 'CocCommand markdown-preview-enhanced.openPreview'}, 
      \ ' Markdown Map': {'exec': 'CocCommand markmap.watch'}, 
      \ ' Markdown Generate Slides': {'exec': 'CocCommand reveal.it'}, 
      \ },
      \ {'for': {'ft': 'md', 'exists': 'g:coc_enabled'}, 'tags': ['markdown', 'coc']})

call fuzzymenu#AddAll({
        \ '󰟓 AddTags Struct': {'exec': 'CocCommand go.tags.add.prompt'},
        \ '󰟓 AddTags Line': {'exec': 'CocCommand go.tags.add.line'},
        \ '󰟓 ClearTags Struct': {'exec': 'CocCommand go.tags.clear'},
        \ '󰟓 ClearTags Line': {'exec': 'CocCommand go.tags.clear.line'},
        \ '󰟓 RemoveTags Struct': {'exec': 'CocCommand go.tags.remove.prompt'},
        \ '󰟓 RemoveTags Line': {'exec': 'CocCommand go.tags.remove.line'},
        \ '󰟓 Generate Tests Exported': {'exec': 'CocCommand go.tests.generate.exported'},
        \ '󰟓 Generate Tests File': {'exec': 'CocCommand go.tests.generate.file'},
        \ '󰟓 Generate Tests Function': {'exec': 'CocCommand go.tests.generate.function'},
        \ '󰟓 Mod Tidy': {'exec': 'CocCommand go.gopls.tidy'},
        \ '󰟓 Generate Interface': {'exec': 'CocCommand go.impl.cursor'},
        \ '󰟓 Play (launch in browser)': {'exec': 'CocCommand go.playground'},
        \ '󰟓 Toggle Test/Code': {'exec': 'CocCommand go.test.toggle'},
      \ },
      \ {'for': {'ft': 'go', 'exists': 'g:coc_enabled'}, 'tags':['go', 'coc']})

call fuzzymenu#Add(' Setup GitHub Copilot', {'normal': ':Copilot setup'}, {'tags': ['github']})
call fuzzymenu#Add(' GitHub Copilot Solutions', {'exec': 'Copilot panel'}, {'tags': ['github']})

call fuzzymenu#AddAll({
  \ ' Diff (git diff)': {'exec': 'Gdiffsplit'},
  \ ' Blame (git blame)': {'exec': 'Git blame'},
  \ '󱓍 Read (git checkout)': {'exec': 'Gread'},
  \ '󱣪 Write (git add)': {'exec': 'Gwrite'},
  \ '󰆴 Delete (git rm)': {'exec': 'GDelete'},
  \ '󰜘 Commit (git commit)': {'exec': 'Git commit'},
  \ '󰓂 Pull (git pull)': {'exec': 'Git pull'},
  \ '󰘭 Push (git push)': {'exec': 'Git push'},
  \ '󰳐 Commits (git log)': {'exec': 'BCommits'},
  \ ' Status (git status)': {'exec': 'GFiles?'},
  \ ' Stash (git stash)': {'exec': 'GStashList'},
  \ },
  \ {'for': {'exists': 'g:loaded_fugitive'}, 'tags': ['git']})

call fuzzymenu#Add('󰳐 Commits for range (git log)', {'visual': ':BCommits' }, {'for': {'exists': 'g:loaded_fugitive'}, 'tags': ['visual', 'git']})

call fuzzymenu#Add(' Mergetool', {'exec': 'MergetoolToggle'}, {'tags': ['mergetool']})
call fuzzymenu#AddAll({
  \ ' Mergetool Layout Merge, Remote': {'exec': 'MergetoolToggleLayout mr'},
  \ ' Mergetool Layout Base, Merge, Remote': {'exec': 'MergetoolToggleLayout mr,b'},
  \ ' Mergetool Exchange Left': {'exec': 'MergetoolDiffExchangeLeft'},
  \ ' Mergetool Exchange Right': {'exec': 'MergetoolDiffExchangeRight'},
  \ ' Mergetool Exchange Down': {'exec': 'MergetoolDiffExchangeDown'},
  \ ' Mergetool Exchange Up': {'exec': 'MergetoolDiffExchangeUp'},
  \ ' Mergetool Prefer Local': {'exec': 'MergetoolPreferLocal'},
  \ ' Mergetool Prefer Remote': {'exec': 'MergetoolPreferRemote'},
  \ },
  \ {'for': {'exists': 'g:merging'}, 'tags': ['mergetool']})

" Octo
if has('nvim')
  call fuzzymenu#AddAll({
    \ ' PR List': {'exec': 'Octo pr list'},
    \ ' PR Search': {'exec': 'Octo pr search'},
    \ ' Gist List': {'exec': 'Octo gist list'},
    \ '󰊤 GitHub Search': {'exec': 'Octo search'},
    \ '󰊤 Issues List': {'exec': 'Octo issue list'},
    \ '󰊤 Issues Search': {'exec': 'Octo issue search'},
    \ '󰊤 Octo': {'exec': 'Octo actions'},
    \ },
    \ {'tags': ['octo', 'github']})
endif

" vim cheat-sheet link
call fuzzymenu#Add(' Vim Cheat-sheet (Browser)', {'exec': 'OpenBrowser https://vim.rtorr.com'}, {'tags': ['vim']})

" basic options
call fuzzymenu#Add(' Case-sensitive searches', {'exec': 'set noignorecase'}, {'tags': ['vim']})
call fuzzymenu#Add(' Case-insensitive searches', {'exec': 'set ignorecase'}, {'tags': ['vim']})
call fuzzymenu#Add(' Hide line numbers', {'exec': 'set nonumber'}, {'tags': ['vim']})
call fuzzymenu#Add(' Show line numbers', {'exec': 'set number'}, {'tags': ['vim']})
call fuzzymenu#Add(' Hide whitespace characters', {'exec': 'set nolist'}, {'tags': ['vim']})
call fuzzymenu#Add(' Show whitespace characters', {'exec': 'set list'}, {'tags': ['vim']})
call fuzzymenu#Add(' Undo', {'normal': 'u'}, {'tags': ['vim']})
call fuzzymenu#Add(' Redo', {'normal': "\<c-r>"}, {'tags': ['vim']})
call fuzzymenu#Add(' Quit (exit) all', {'exec': 'qa'}, {'tags': ['vim']})
call fuzzymenu#Add(' Quit (exit) all without saving', {'exec': 'qa!'}, {'tags': ['vim']})
call fuzzymenu#Add(' Write (save) and quit (exit) all', {'exec': 'wqa'}, {'tags': ['vim']})
call fuzzymenu#Add(' Write (save) current buffer', {'exec': 'w'}, {'tags': ['vim']})
call fuzzymenu#Add(' Write (save) all', {'exec': 'wa'}, {'tags': ['vim']})

" common editor features
call fuzzymenu#Add(' New Tab', {'exec': 'tabnew'}, {'tags': ['vim']})
call fuzzymenu#Add(' Close Window', {'exec': 'close'}, {'tags': ['vim']})
call fuzzymenu#Add(' New buffer', {'exec': 'new'}, {'tags': ['vim']})
call fuzzymenu#Add(' Delete buffer (close file)', {'exec': 'bd'}, {'tags': ['vim']})
call fuzzymenu#Add(' Delete buffer (close file) WITHOUT saving', {'exec': 'bd!'}, {'tags': ['vim']})
call fuzzymenu#Add(' Vertical split', {'exec': 'vs'}, {'tags': ['vim']})
call fuzzymenu#Add(' Horizontal split', {'exec': 'sp'}, {'tags': ['vim']})
call fuzzymenu#Add(' Select all', {'normal': 'ggVG'}, {'tags': ['vim']})
call fuzzymenu#Add(' Find word under cursor', {'normal': '*'}, {'tags': ['vim']})
call fuzzymenu#Add(' Next match', {'normal': 'n'}, {'tags': ['vim']})
call fuzzymenu#Add(' Previous match', {'normal': 'N'}, {'tags': ['vim']})
call fuzzymenu#Add(' Repeat (last normal mode operation)', {'normal': '.'}, {'tags': ['vim']})
call fuzzymenu#Add(' Repeat (last :command)', {'normal': '@:'}, {'tags': ['vim']})
call fuzzymenu#Add(' Open file under cursor', {'normal': 'gf'}, {'tags': ['vim']})
call fuzzymenu#Add(' Browse to link under cursor', {'normal': 'gx'}, {'tags': ['vim']})
call fuzzymenu#Add(' Jumps', {'exec': 'jumps'}, {'tags': ['vim']})
call fuzzymenu#Add(' Jump Next', {'normal': "\<c-i>"}, {'tags': ['vim']})
call fuzzymenu#Add(' Jump Back', {'normal': "\<c-o>"}, {'tags': ['vim']})
call fuzzymenu#Add(' Close all buffers', {'exec': 'bufdo bd!'}, {'tags': ['vim']})

" normal mode for incomplete functions
call fuzzymenu#Add(' Find', {'normal': '/'}, {'tags': ['vim']})

call fuzzymenu#Add(' Next match', {'normal': 'n'}, {'tags': ['vim']})
call fuzzymenu#Add(' Previous match', {'normal': 'N'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace next match', {'normal': ':s//'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace in file', {'normal': ':%s//'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace in open buffers', {'normal': ':bufdo :%s//'}, {'tags': ['vim']})

call fuzzymenu#Add(' Put (paste)', {'normal': 'p'}, {'tags': ['vim']})

call fuzzymenu#Add('󰚩 ChatGPT Chat', {'exec': ':call NormalExecWithArgs("Chat", [["Instructions", 1]])'}, {'tags': ['chatgpt']})
    " ChatGPT visual selection
    call fuzzymenu#AddAll({
      \ '󰚩 ChatGPT Completion': {'visual': ':call VisualExec("Chat completion")' },
      \ '󰚩 ChatGPT Explain': {'visual': ':call VisualExec("Chat explain")' },
      \ '󰚩 ChatGPT Debug': {'visual': ':call VisualExec("Chat debug")' },
      \ '󰚩 ChatGPT Document': {'visual': ':call VisualExec("Chat doc")' },
      \ '󰚩 ChatGPT Optimize': {'visual': ':call VisualExec("Chat opt")' },
      \ '󰚩 ChatGPT Add Tests': {'visual': ':call VisualExec("Chat tests")' },
      \ '󰚩 ChatGPT Refactor': {'visual': ':call VisualExec("Chat refactor")' },
      \ '󰚩 ChatGPT Simplify': {'visual': ':call VisualExec("Chat simplify")' },
      \ '󰚩 ChatGPT Fix': {'visual': ':call VisualExec("Chat fix")' },
      \ '󰚩 ChatGPT Summarize': {'visual': ':call VisualExec("Chat summarize")' },
      \ '󰚩 ChatGPT Grammar': {'visual': ':call VisualExec("Chat grammar")' },
      \ '󰚩 ChatGPT Question': {'visual': ':call VisualExecWithArgs("Chat question", [["Question", 1]])' },
      \ '󰚩 ChatGPT Edit With Instructions': {'visual': ':call VisualExecWithArgs("Chat code_edit", [["Instructions", 1]])' },
      \ },
      \ {'tags': ['visual','chatgpt']})

lua << EOF
require("bufferline").setup {
      options = {
        separator_style = "slant",
      },
    }
local loaded, lir = pcall(require, "lir")
if not loaded then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local actions = require("lir.actions")
lir.setup({
	show_hidden_files = true,
	mappings = {
		["<CR>"] = actions.edit,
		["-"] = actions.up,
		["K"] = actions.mkdir,
		["N"] = actions.newfile,
		["R"] = actions.rename,
		["Y"] = actions.yank_path,
		["D"] = actions.delete,
		["."] = actions.toggle_show_hidden,
	},
})

vim.api.nvim_create_user_command("Lir", function()
	local directory = vim.fn.expand("%:p:h")
	vim.cmd.edit({
		args = { directory },
	})
end, {})

vim.keymap.set("n", "-", ":edit %:h<CR>", { noremap = true })

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

require"octo".setup({
  picker = "fzf-lua"
})

require("telescope").setup {
  defaults = {
      file_ignore_patterns = {
        "node_modules/",
        "%.git/",
        "dist/",
        "target/"
      },
    },
    pickers = {
      find_files = {
        hidden = true, -- show hidden files
      },
    },
}
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>pws", function()
  local word = vim.fn.expand "<cword>"
  builtin.grep_string { search = word }
end)
vim.keymap.set("n", "<leader>pWs", function()
  local word = vim.fn.expand "<cWORD>"
  builtin.grep_string { search = word }
end)
vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "[S]earch [N]eovim files" })
EOF

