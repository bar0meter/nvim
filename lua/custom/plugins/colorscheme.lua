local gruvbox = {
	"gruvbox-community/gruvbox",
	name = "gruvbox",
	priority = 1000,
}

local nightfox = {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	config = function()
		require("nightfox").setup()
		vim.cmd("colorscheme duskfox")
	end,
}

local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({})
	end,
}

return gruvbox
