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
vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohl")
	-- close any floating windows (hover docs, etc.)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end)

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

-- Commentary
vim.keymap.set("x", "<Leader>c", "<Plug>Commentary", {})
vim.keymap.set("n", "<Leader>c", "<Plug>Commentary", {})
vim.keymap.set("n", "<Leader>cc", "<Plug>CommentaryLine", {})

-- Quickfix toggle
function ToggleQuickFix()
	local quickfix_windows = vim.fn.getwininfo()
	local is_quickfix_open = false

	for _, win_info in ipairs(quickfix_windows) do
		if win_info.quickfix == 1 then
			is_quickfix_open = true
			break
		end
	end

	if is_quickfix_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

vim.api.nvim_set_keymap("n", "<leader>qq", ":lua ToggleQuickFix()<CR>", { noremap = true, silent = true })

------------------------------------------------------
-- LSP keymaps (buffer-local, set on LspAttach)
------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
		-- grt (type_definition) and grx (codelens) are now built-in defaults in 0.12
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action()
		end, { buffer = ev.buf, noremap = true, silent = true })

		vim.keymap.set("n", "<leader>k", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end, opts)

		-- Accept completion with CR
		vim.keymap.set("i", "<CR>", function()
			if vim.fn.pumvisible() == 1 then
				return "<C-y>"
			end
			return "<CR>"
		end, { buffer = ev.buf, expr = true })
	end,
})

------------------------------------------------------
-- Telescope keymaps
------------------------------------------------------

vim.keymap.set("n", "<leader>l", function()
	require("telescope.builtin").find_files({
		file_ignore_patterns = { "^./.git/", "^node_modules/" },
		prompt_title = "[S]earch [F]iles",
		find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--sort", "accessed" },
	})
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>ss", function()
	require("telescope.builtin").current_buffer_fuzzy_find({})
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sw", function()
	require("telescope.builtin").grep_string()
end, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").live_grep({ prompt_title = "[S]earch by [G]rep" })
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>dd", function()
	require("telescope.builtin").diagnostics({ prompt_title = "[S]earch [D]iagnostics" })
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>sr", function()
	require("telescope.builtin").resume()
end, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", function()
	require("telescope.builtin").oldfiles()
end, { desc = '[S]earch Recent Files ("." for repeat)' })

vim.keymap.set("n", "<leader>b", function()
	require("telescope.builtin").buffers({ prompt_title = "[ ] Find existing buffers" })
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>gt", function()
	require("telescope.builtin").git_files({
		prompt_title = "Ignore tests folder",
		file_ignore_patterns = { "tests", "functional_tests", "snapshots", ".github", "codegen", "node_modules" },
	})
end, { desc = "[Ignore tests]" })

vim.keymap.set("n", "<leader>ps", function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, { desc = "[S]earch [/] in Open Files" })

vim.keymap.set("n", "<leader>pws", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end)
vim.keymap.set("n", "<leader>pWs", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
end)

vim.keymap.set("n", "<leader>sn", function()
	require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

------------------------------------------------------
-- Oil keymap
------------------------------------------------------

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Oil file manager" })

------------------------------------------------------
-- Snippet keymaps
------------------------------------------------------

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	require("luasnip").jump(1)
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	require("luasnip").jump(-1)
end)

------------------------------------------------------
-- Gopher keymaps
------------------------------------------------------

vim.keymap.set("n", "<leader>goat", ":GoTestAdd<cr>")
vim.keymap.set("n", "<leader>got", ":GoTestsAll<cr>")
vim.keymap.set("n", "<leader>goe", ":GoTestsExp<cr>")
vim.keymap.set("n", "<leader>goj", ":GoTagsAdd json<cr>")
