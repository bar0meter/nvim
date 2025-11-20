call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'dense-analysis/ale'
Plug 'ibhagwan/fzf-lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ajmwagar/vim-deus'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'diepm/vim-rest-console'
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'diepm/vim-rest-console'
Plug 'stevearc/oil.nvim'

call plug#end()

" Disable netrw (using oil.nvim instead)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set tabstop=4                   " Number of spaces that a <Tab> counts for
set shiftwidth=4                " Number of spaces to use for each step of indent
set softtabstop=4               " Number of spaces for <Tab> in insert mode
set expandtab                   " Use spaces instead of tabs
set smarttab                    " Insert shiftwidth spaces at start of line
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set belloff=all
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set nowritebackup
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set mouse=a 			" allow to scroll in the preview and other actions
set mousemoveevent
set clipboard+=unnamedplus
set signcolumn=yes

filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection

" Force tab settings for all filetypes (override any ftplugin settings)

" allow to scroll in the preview and other actions
set mouse=a
" enable mousemoveevent
set mousemoveevent

let mapleader = ","

colorscheme deus

" Keybindings
" Map jk to <Esc>
inoremap jk <Esc>

" Using Ctrl-Z to save buffer
nnoremap <C-Z> :update<CR>

nnoremap <Leader>e :quit<CR>

nnoremap <Leader>w :bw<CR>

" Oil.nvim file explorer
nnoremap - <cmd>lua require('oil').open()<CR>

nnoremap <C-j> :cnext<CR>
nnoremap <C-n> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
nnoremap <C-p> :cprevious<CR>

" Toggle quickfix window
function! ToggleQuickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <leader>qq :call ToggleQuickfix()<CR>

nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

map <C-c> "+y

" ==================== FZF-Lua ====================
nnoremap <Leader>l <cmd>lua require('fzf-lua').files()<CR>
nnoremap <Leader>ff <cmd>lua require('fzf-lua').live_grep()<CR>
nnoremap <Leader>b <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <Leader>pws <cmd>lua require('fzf-lua').grep_cword()<CR>
nnoremap <Leader>pWs <cmd>lua require('fzf-lua').grep_cWORD()<CR>

xmap <Leader>c  <Plug>Commentary
nmap <Leader>c  <Plug>Commentary
map <Leader>c  <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine

" ==================== Lua Plugin Configuration ====================
lua << EOF
-- Add luarocks paths for rest.nvim dependencies
package.path = package.path .. ';' .. '/Users/ag/.luarocks/share/lua/5.4/?.lua'
package.path = package.path .. ';' .. '/Users/ag/.luarocks/share/lua/5.4/?/init.lua'
package.cpath = package.cpath .. ';' .. '/Users/ag/.luarocks/lib/lua/5.4/?.so'

-- Fzf-lua configuration
local fzf_ok, fzf = pcall(require, 'fzf-lua')
if fzf_ok then
  fzf.setup({
    fzf_opts = {
      ['--layout'] = 'reverse-list',  -- Prompt at bottom
    },
  })
end

-- Fidget.nvim configuration (LSP progress notifications)
local fidget_ok, fidget = pcall(require, "fidget")
if fidget_ok then
  fidget.setup({})
end

-- Nuclear option: force tab settings every 100ms for JS/TS files
local function enforce_tabs()
  local ft = vim.bo.filetype
  if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
    if vim.bo.tabstop ~= 4 or vim.bo.shiftwidth ~= 4 or vim.bo.softtabstop ~= 4 then
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.softtabstop = 4
      vim.bo.expandtab = true
      vim.bo.smarttab = true
    end
  end
end

-- Run enforcement on a timer
local timer = vim.loop.new_timer()
timer:start(100, 100, vim.schedule_wrap(enforce_tabs))

-- Oil.nvim configuration (file explorer)
local oil_ok, oil = pcall(require, "oil")
if oil_ok then
  oil.setup({
    default_file_explorer = true,
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 30,
      border = "rounded",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
  })

  -- Create :Oil command
  vim.api.nvim_create_user_command('Oil', function(opts)
    oil.open(opts.args ~= "" and opts.args or nil)
  end, { nargs = '?', complete = 'dir', desc = 'Open oil file explorer' })
end

-- LSP configuration using lspconfig
-- Temporarily disable vim.notify to suppress deprecation warnings
local old_notify = vim.notify
vim.notify = function() end

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if lspconfig_ok then
  -- Setup capabilities for all servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Lua LSP
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  })

  -- Go LSP
  lspconfig.gopls.setup({
    capabilities = capabilities,
  })

  -- Python LSP
  lspconfig.pyright.setup({
    capabilities = capabilities,
  })

  -- TypeScript/JavaScript LSP
  lspconfig.vtsls.setup({
    capabilities = capabilities,
  })

  -- Rust LSP
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          command = "clippy"
        },
      },
    },
  })
end

-- Restore vim.notify
vim.notify = old_notify

-- LSP keymaps (set on LspAttach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    local fzf_ok, fzf = pcall(require, 'fzf-lua')

    -- gd: Go to definition
    if fzf_ok then
        vim.keymap.set('n', 'gd', function() fzf.lsp_definitions({ jump_to_single = 1 }) end, opts)

        -- gI: Go to implementation
        vim.keymap.set('n', 'gI', function() fzf.lsp_implementations({ jump_to_single = 1 }) end, opts)

        -- gr: Go to references
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)

        -- <Leader>ca: Code actions
        vim.keymap.set('n', '<Leader>ca', fzf.lsp_code_actions, opts)
        vim.keymap.set('v', '<Leader>ca', fzf.lsp_code_actions, opts)

        -- Additional useful keymaps
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

        -- Diagnostics navigation
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

        -- <Leader>dd: Document diagnostics
        vim.keymap.set('n', '<Leader>dd', fzf.diagnostics_document, opts)

        -- ds: Document symbols
        vim.keymap.set('n', 'ds', fzf.lsp_document_symbols, opts)

        -- Additional fzf-lua LSP keymaps if available
        -- <Leader>ws: Workspace symbols
        vim.keymap.set('n', '<Leader>ws', fzf.lsp_workspace_symbols, opts)

        -- <Leader>da: All workspace diagnostics
        vim.keymap.set('n', '<Leader>da', fzf.diagnostics_workspace, opts)
    end
  end,
})

-- LSP servers are now managed through mason-lspconfig handlers above
-- No need for manual vim.lsp.config or vim.lsp.enable
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

EOF

augroup indent
    autocmd!
    " Force tab settings on VimEnter
    autocmd VimEnter * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    " Force tab settings on every FileType change
    autocmd FileType * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    " Force tab settings on buffer read
    autocmd BufRead,BufNewFile * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    " Force tab settings after LSP attaches (catches LSP formatters)
    autocmd LspAttach * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    " Force tab settings on buffer enter (catches any late overrides)
    autocmd BufEnter * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    " Extra aggressive for JS/TS files
    autocmd FileType javascript,typescript,javascriptreact,typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
    autocmd BufRead,BufNewFile *.js,*.ts,*.jsx,*.tsx setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
augroup end
