vim.g.mapleader = ","
vim.g.have_nerd_font = true

vim.g.editorconfig = false
vim.o.mouse = "a"
vim.o.mousemoveevent = true

vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.signcolumn = "no"

vim.o.showtabline = 2

vim.o.inccommand = "split"
vim.o.cursorline = false

-- Completion.
vim.opt.wildignore:append({ ".DS_Store" })
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 15
vim.o.pumborder = "rounded"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

-- Folding.
vim.o.foldcolumn = "0"
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
