vim.g.mapleader = ","
vim.g.have_nerd_font = true

vim.g.editorconfig = false
vim.o.mouse = "a"
vim.o.mousemoveevent = true

vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = false
vim.o.relativenumber = false

vim.o.showtabline = 2

vim.o.inccommand = "split"
vim.o.cursorline = true

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Completion.
vim.opt.wildignore:append({ ".DS_Store" })
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 15
vim.o.pumborder = "rounded"

vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Set indentation defaults for all filetypes
vim.opt.tabstop = 4      -- Show tabs as 4 spaces
vim.opt.shiftwidth = 2   -- Indent using 2 spaces
vim.opt.softtabstop = 2  -- Number of spaces <Tab> counts for in insert mode
vim.opt.expandtab = true -- Use spaces instead of tabs

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

-- Folding.
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.wo.foldtext = ""

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

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
