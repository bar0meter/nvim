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

local gruvbuddy = {
	"tjdevries/colorbuddy.nvim",
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

local solarized = {
	"altercation/vim-colors-solarized",
}

local everforest = {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- Optional; default configuration will be used if setup isn't called.
	config = function()
		require("everforest").setup({
			-- Your config here
			transparent_background_level = 2,
			disable_italic_comments = true,
			background = "hard",
			show_eob = false,
		})
	end,
}

local horizon = {
	"akinsho/horizon.nvim",
	config = function()
		require("horizon").setup({
			transparent = true,
		})
	end,
}

return {
	gruvbox,
	nightfox,
	catppuccin,
	tokyonight,
	gruvbuddy,
	solarized,
	everforest,
	horizon,
}
