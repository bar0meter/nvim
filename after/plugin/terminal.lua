local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0
	end,
})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local terminals = {}

local function open_term()
	local opts = vim.tbl_deep_extend(
		"force",
		{ ft = "lazyterm", size = { width = 0.9, height = 0.9 }, backdrop = nil },
		{},
		{ persistent = true }
	)

	local termkey = vim.inspect({ cmd = "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

	if terminals[termkey] and terminals[termkey]:buf_valid() then
		terminals[termkey]:toggle()
	else
		terminals[termkey] = require("lazy.util").float_term(nil, opts)
		local buf = terminals[termkey].buf
		vim.b[buf].lazyterm_cmd = nil
		if opts.esc_esc == false then
			vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
		end
		if opts.ctrl_hjkl == false then
			vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
			vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
			vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
			vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
		end

		vim.api.nvim_create_autocmd("BufEnter", {
			buffer = buf,
			callback = function()
				vim.cmd.startinsert()
			end,
		})
	end

	return terminals[termkey]
end

vim.keymap.set("n", "<leader>st", open_term)
