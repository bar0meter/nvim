return {
	packs = {
		GH("ajmwagar/vim-deus"),
		GH("EdenEast/nightfox.nvim"),
		GH("rebelot/kanagawa.nvim"),
		GH("mofiqul/vscode.nvim"),
		GH("ellisonleao/gruvbox.nvim")
	},
	setup = function()
		require("gruvbox").setup({
			bold = false,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
		})

		vim.cmd.colorscheme("gruvbox")
	end,
}
