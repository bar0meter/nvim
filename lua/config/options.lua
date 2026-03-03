vim.g.mapleader = ","
vim.g.editorconfig = false
vim.o.mouse = ""

vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = false
vim.o.relativenumber = false
vim.o.cursorline = false

vim.o.completeopt = "menu,menuone,noselect,preview"
vim.o.pumheight = 10
vim.o.winborder = "rounded"
vim.o.showmode = false

vim.o.signcolumn = "no"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.scrolloff = 8

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wrap = false
vim.o.breakindent = true

vim.o.colorcolumn = "0"

vim.opt.cmdheight = 0

-- vim.opt.winbar = "%=%{expand('%:p:h:t')}/%t%="
vim.opt.winbar = "%=%f%="

vim.diagnostic.config({ virtual_text = true })

vim.o.laststatus = 0

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
