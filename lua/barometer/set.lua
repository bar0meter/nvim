vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"
vim.opt.isfname:append "@-@"

vim.opt.updatetime = 50
vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- move winbar text to the center
-- vim.opt.winbar = "%=%{expand('%:p:h:t')}/%t%="
-- vim.opt.winbar = "%=%f%="

-- vim.cmd [[
--     set listchars=tab:⭲\ ,trail:~,extends:>,precedes:<,space:·
--     set list
--     hi Whitespace guifg=#505050
--     hi NonText guifg=#505050
-- ]]

-- vim.cmd [[
--     set list
--     set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
-- ]]

-- vim.cmd [[
--     set list
--     set listchars+=eol:↲
-- ]]
