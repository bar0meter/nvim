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

local tokyonight = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			-- use the night style
			style = "night",
			transparent = true,
			-- disable italic for functions
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = false },
				keywords = { italic = false },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			-- Change the "hint" color to the "orange" color, and make the "error" color bright red
		})
	end,
}

return {
	gruvbox,
	nightfox,
	catppuccin,
	tokyonight,
}
