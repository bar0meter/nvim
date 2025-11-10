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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rest-nvim/rest.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'manoelcampos/xml2lua'
Plug 'nvim-neotest/nvim-nio'
Plug 'phelipetls/jsonpath.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
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
  fzf.setup({})
end

-- Treesitter configuration
local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if treesitter_ok then
  treesitter.setup({
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = false
    },
  })
end

-- Rest.nvim configuration
local rest_ok, rest = pcall(require, "rest-nvim")
if rest_ok then
  rest.setup({
    result = {
      show_url = true,
      show_http_info = true,
      show_headers = true,
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
        end
      },
    },
    jump_to_request = false,
    env_file = '.env',
    custom_dynamic_variables = {},
    yank_dry_run = true,
  })

  -- Rest.nvim keybindings
  vim.keymap.set('n', '<Leader>rr', '<Plug>RestNvim', { desc = 'Run request under cursor' })
  vim.keymap.set('n', '<Leader>rp', '<Plug>RestNvimPreview', { desc = 'Preview request cURL command' })
  vim.keymap.set('n', '<Leader>rl', '<Plug>RestNvimLast', { desc = 'Re-run last request' })
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

-- Mason configuration (LSP installer)
local mason_ok, mason = pcall(require, "mason")
if mason_ok then
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
  mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "gopls", "pyright", "vtsls" },
    automatic_installation = true,
  })
end

-- LSP configuration with keymaps
-- LSP keymaps (set on LspAttach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    local fzf_ok, fzf = pcall(require, 'fzf-lua')

    -- gd: Go to definition
    if fzf_ok then
      vim.keymap.set('n', 'gd', function() fzf.lsp_definitions({ jump_to_single = 1 }) end, opts)
    end

    -- gI: Go to implementation
    if fzf_ok then
      vim.keymap.set('n', 'gI', function() fzf.lsp_implementations({ jump_to_single = 1 }) end, opts)
    end

    -- gr: Go to references
    if fzf_ok then
      vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
    end

    -- <Leader>ca: Code actions
    if fzf_ok then
      vim.keymap.set('n', '<Leader>ca', fzf.lsp_code_actions, opts)
      vim.keymap.set('v', '<Leader>ca', fzf.lsp_code_actions, opts)
    end

    -- Additional useful keymaps
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

    -- Diagnostics navigation
    if fzf_ok then
      vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
    end

    -- <Leader>dd: Document diagnostics
    if fzf_ok then
      vim.keymap.set('n', '<Leader>dd', fzf.diagnostics_document, opts)
    end

    -- ds: Document symbols
    if fzf_ok then
      vim.keymap.set('n', 'ds', fzf.lsp_document_symbols, opts)
    end

    -- Additional fzf-lua LSP keymaps if available
    if fzf_ok then
      -- <Leader>ws: Workspace symbols
      vim.keymap.set('n', '<Leader>ws', fzf.lsp_workspace_symbols, opts)

      -- <Leader>da: All workspace diagnostics
      vim.keymap.set('n', '<Leader>da', fzf.diagnostics_workspace, opts)
    end
  end,
})

-- Setup LSP servers using the new vim.lsp.config API (Neovim 0.11+)
if vim.lsp.config then
  -- Use new API
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Lua
  vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  })

  -- Go
  vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    root_markers = { 'go.work', 'go.mod', '.git' },
    capabilities = capabilities,
  })

  -- Python
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
    capabilities = capabilities,
  })

  -- TypeScript/JavaScript
  vim.lsp.config('vtsls', {
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    capabilities = capabilities,
  })

  -- Enable LSP servers
  vim.lsp.enable({ 'lua_ls', 'gopls', 'pyright', 'vtsls' })
else
  -- Fall back to lspconfig for older Neovim versions
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")

  if lspconfig_ok then
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Lua
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

    -- Go
    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    -- Python
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })

    -- TypeScript/JavaScript
    lspconfig.vtsls.setup({
      capabilities = capabilities,
    })
  end
end
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
