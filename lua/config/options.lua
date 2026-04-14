vim.g.mapleader = ","
vim.g.editorconfig = false
vim.o.mouse = ""

vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = false

vim.o.completeopt = "menu,menuone,noinsert,popup"
vim.o.pumheight = 10
vim.o.pumborder = "rounded"
vim.o.pummaxwidth = 60
vim.o.winborder = "rounded"
vim.o.showmode = false

vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.scrolloff = 8

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

vim.o.colorcolumn = "0"
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.wo.foldtext = ""

local arrows = require("icons").arrows
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldclose = arrows.right,
	foldopen = arrows.down,
	foldsep = " ",
	foldinner = " ",
	msgsep = "─",
}

vim.opt.cmdheight = 0

vim.diagnostic.config({ virtual_text = true })

vim.o.laststatus = 3

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
