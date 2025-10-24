vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.have_nerd_font = false

vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = false

vim.opt.laststatus = 3

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.inccommand = "split"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 10

vim.opt.cursorcolumn = false

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "no"
vim.opt.isfname:append "@-@"

vim.opt.shada = { "'10", "<0", "s10", "h" }

vim.opt.updatetime = 50

vim.opt.termguicolors = true

vim.opt.syntax = "off"

vim.opt.swapfile = false

vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

-- https://www.reddit.com/r/neovim/comments/vaimyr/how_to_set_folding_method_permanently/
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jJ", "<Esc>")
vim.keymap.set("i", "jJ", "<Esc>")
vim.keymap.set("i", "JJ", "<Esc>")
vim.keymap.set("i", "jJ", "<Esc>")
vim.keymap.set("i", "jK", "<Esc>")
vim.keymap.set("i", "JK", "<Esc>")

vim.keymap.set("n", "<Leader>e", "<Cmd>quit<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>bw<CR>")
vim.keymap.set("n", "<Leader>qw", "<Cmd>bufdo bd<CR>")

vim.keymap.set("n", "<Leader>tr", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<Leader>te", "<Cmd>tabclose<CR>")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.bs = "2"

vim.opt.shortmess:append "I"

-- List chars
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "↲", extends = "❯", precedes = "❮" }

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    -- os.execute "tput cnorm" -- Restore normal cursor
    os.execute "printf '\\e[5 q'" -- Alternative method
  end,
})

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  "tpope/vim-sleuth",
  { import = "custom.plugins" },
  "gurpreetatwal/vim-avro",
}

vim.opt.fillchars:append "eob: "
