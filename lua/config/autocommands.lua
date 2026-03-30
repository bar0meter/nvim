-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- show cursorline only in active window enable
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--  	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
--  	callback = function()
--  		vim.opt_local.cursorline = true
--  	end,
-- })

-- show cursorline only in active window disable
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
-- 	group = "active_cursorline",
-- 	callback = function()
-- 		vim.opt_local.cursorline = false
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil

		-- Built-in LSP completion (Neovim 0.12+)
		vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

		-- LSP keymaps
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
