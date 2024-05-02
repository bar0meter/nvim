vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.have_nerd_font = false

vim.opt.number = false
vim.opt.relativenumber = false

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

vim.opt.cursorline = false

vim.opt.termguicolors = false

-- https://www.reddit.com/r/neovim/comments/vaimyr/how_to_set_folding_method_permanently/
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<Leader>e", "<Cmd>quit<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>bw<CR>")

vim.keymap.set("n", "<Leader>tr", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<Leader>te", "<Cmd>tabclose<CR>")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.bs = "2"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth",
	{ import = "custom.plugins" },
})

vim.cmd([[
	colorscheme evening
]])

vim.opt.fillchars:append("eob: ")
