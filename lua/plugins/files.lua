
return {
	packs = {
		GH("stevearc/oil.nvim"),
		GH("refractalize/oil-git-status.nvim"),
	},
	setup = function()
		require("oil").setup({
			win_options = { signcolumn = "yes:2" },
			view_options = { show_hidden = true },
		})
		require("oil-git-status").setup({ show_ignored = false })
	end,
}
