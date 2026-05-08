return {
	packs = {
		GH("nvim-mini/mini.nvim"),
	},
	setup = function()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.jump").setup()
		require("mini.icons").setup()
		require("mini.statusline").setup({ use_icons = true })
		require("mini.tabline").setup()
		require("mini.completion").setup()

		local function pum_accept(fallback)
			return function()
				if vim.fn.pumvisible() == 0 then
					return fallback
				end
				if vim.fn.complete_info({ "selected" }).selected == -1 then
					return "<C-n><C-y>"
				end
				return "<C-y>"
			end
		end

		local opts = { expr = true, replace_keycodes = true }
		vim.keymap.set("i", "<CR>", pum_accept("<CR>"), opts)
		vim.keymap.set("i", "<Tab>", pum_accept("<Tab>"), opts)
		vim.keymap.set("i", "<C-y>", pum_accept("<C-y>"), opts)
	end,
}
