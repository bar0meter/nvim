return {
	packs = {
		GH("ellisonleao/gruvbox.nvim"),
		GH("sainnhe/everforest"),
		GH("ajmwagar/vim-deus"),
		GH("AlexvZyl/nordic.nvim"),
		GH("gbprod/nord.nvim"),
		GH("kepano/flexoki-neovim"),
	},
	setup = function()
		-- Default options:
		require("gruvbox").setup({
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
		})
		vim.cmd.colorscheme("flexoki-light")
	end,
}
