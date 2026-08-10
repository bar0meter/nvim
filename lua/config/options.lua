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
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.showtabline = 2

vim.o.inccommand = "split"
vim.o.cursorline = true

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

vim.o.swapfile = false

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

vim.o.list = true
vim.opt.listchars = { eol = "↵", tab = "  " }

vim.opt.cmdheight = 0

vim.diagnostic.config({ virtual_text = true })

vim.o.laststatus = 3

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.title = true
vim.o.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
