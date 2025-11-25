-- source and update neovim config
vim.keymap.set("n", "<leader>so", function()
	vim.cmd("update")
	vim.cmd("source $MYVIMRC")
end)

-- restart nvim and restore session
local session_file = vim.fn.stdpath("state") .. "/Session.vim"
vim.keymap.set("n", "<leader>re", function()
	vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
	vim.cmd("restart source " .. vim.fn.fnameescape(session_file))
end)

vim.keymap.set("i", "jk", "<Esc>")

-- Redo remap
vim.keymap.set("n", "U", "<C-r>")

-- after a search, press escape to clear highlights
vim.keymap.set("n", "<Esc>", ":nohl<CR>")

-- Swap between split buffers
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>")
vim.keymap.set("n", "<leader>rr", ":wincmd r<CR>")

vim.keymap.set("n", "<leader>w", ":bwipeout<CR>", { silent = false })
vim.keymap.set({ "n", "t" }, "<leader>e", ":quit<cr>")

-- Center buffer when progressing through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Move selection up and down
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

-- toggle inlayhints
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay Hints Enabled" or "Inlay Hints Disabled")
end)

vim.keymap.set("n", "-", "<cmd>lua require('oil').open()<CR>")

vim.keymap.set("x", "<Leader>c", "<Plug>Commentary", {})
vim.keymap.set("n", "<Leader>c", "<Plug>Commentary", {})
vim.keymap.set("n", "<Leader>cc", "<Plug>CommentaryLine", {})
