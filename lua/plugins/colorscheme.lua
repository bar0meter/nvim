local deus = {
	"ajmwagar/vim-deus",
}

local gruvbox = {
	"ellisonleao/gruvbox.nvim",
	config = function()
		require("gruvbox").setup({
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
		})
	end,
}

return {
	deus,
	gruvbox,
}
