let g:fuzzymenu_vim_config = '~/.vimrc_local'

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
      \ ' Unicode Symbols': {'exec': 'call unicode#Fuzzy()'},
    \ },
    \ {'after': 'call fuzzymenu#InsertModeIfNvim()', 'tags': ['tools']})

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

" normal mode for incomplete functions
call fuzzymenu#Add(' Find', {'normal': '/'}, {'tags': ['vim']})

call fuzzymenu#Add(' Next match', {'normal': 'n'}, {'tags': ['vim']})
call fuzzymenu#Add(' Previous match', {'normal': 'N'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace next match', {'normal': ':s//'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace in file', {'normal': ':%s//'}, {'tags': ['vim']})
call fuzzymenu#Add(' Replace in open buffers', {'normal': ':bufdo :%s//'}, {'tags': ['vim']})

call fuzzymenu#Add(' Put (paste)', {'normal': 'p'}, {'tags': ['vim']})

" Telescope enabled options
if has("nvim")
  call fuzzymenu#Add(' Tag Stack', {'exec': 'Telescope tagstack'}, {'tags': ['vim']})
  call fuzzymenu#Add(' Old Files', {'exec': 'Telescope oldfiles'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Vim Options', {'exec': 'Telescope vim_options'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Man Pages', {'exec': 'Telescope man_pages'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Symbols/Emojis', {'exec': 'Telescope symbols'}, {'tags': ['tools']})
  call fuzzymenu#Add('󰎟 Notification Center', {'exec': 'Telescope notify'}, {'tags': ['tools']})
  call fuzzymenu#Add(' AutoSave Toggle', {'exec': 'ASToggle'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Run Shell Command', {'exec': ':call NormalExecWithArgs("Sh", [["Command", 1]])'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Make Target', {'exec': ':call SelectMakeTarget()'}, {'tags': ['tools']})
  call fuzzymenu#Add(' Send Text to Terminal', {'exec': ':lua tmux.send_text_to()'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' Switch tmux Orientation', {'exec': ':lua tmux.switch_orientation()'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' Switch tmux Open As', {'exec': ':lua tmux.switch_open_as()'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' Kill All tmux Terms', {'exec': ':lua tmux.kill_all_terms()'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' Run Project tmux Terms', {'exec': ':lua tmux.run_project_terms()'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' List All tmux Terms', {'exec': 'Telescope tmux-awesome-manager list_terms'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' List Open tmux Terms', {'exec': 'Telescope tmux-awesome-manager list_open_terms'}, {'tags': ['tmux']})
  call fuzzymenu#Add(' Git Ship', {'exec': ':lua tmux.execute_command( { cmd = "git_ship; echo; echo; echo Done", name = "Git Ship" })'}, {'tags': ['tools']})
else
  call fuzzymenu#Add(' Tag Stack', {'exec': 'tags'}, {'tags': ['tools']})
endif
  if exists('$OPENAI_API_KEY') && has("nvim")
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
  endif
