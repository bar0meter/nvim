
return {
	packs = {
		GH("nvim-lua/plenary.nvim"),
		GH("nvim-telescope/telescope.nvim"),
		GH("nvim-telescope/telescope-fzf-native.nvim"),
	},
	setup = function()
		require("telescope").setup({
			defaults = {},
			extensions = {
				fzf = {},
			},
			pickers = {
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = { "node_modules", ".git" },
					hidden = true,
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
	end,
}
