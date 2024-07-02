local gruvbox = {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	config = function()
		require("gruvbox").setup({
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = false,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})
	end,
}

local nightfox = {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	config = function()
		require("nightfox").setup()
	end,
}

local rose_pine = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = true,
			styles = {
				italic = false,
			},
		})
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

local dichromatic = {
	"romainl/vim-dichromatic",
}

local everforest = {
	"neanias/everforest-nvim",
	config = function()
		require("everforest").setup({
			transparent_background_level = 2,
		})
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

local solarized = {
	"altercation/vim-colors-solarized",
}

local sitruuna = {
	"eemed/sitruuna.vim",
}

local alabaster = {
	"p00f/alabaster.nvim",
}

local xcode = {
	"lunacookies/vim-colors-xcode",
}

return {
	gruvbox,
	nightfox,
	catppuccin,
	tokyonight,
	gruvbuddy,
	solarized,
	dichromatic,
	everforest,
	sitruuna,
	alabaster,
	xcode,
	rose_pine,
}
