local deus = {
	"ajmwagar/vim-deus",
	lazy = false,
	priority = 1000,
}

local everforest = {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
}

local sonokai = {
	"sainnhe/sonokai",
	lazy = false,
	priority = 1000,
}

local edge = {
	"sainnhe/edge",
	lazy = false,
	priority = 1000,
}

local tokyonight = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
}

local vscode = {
	"Mofiqul/vscode.nvim",
}

local nightfox = {
	"EdenEast/nightfox.nvim",
}

local rosepine = {
	"rose-pine/neovim",
}

local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
}

local gruvbox = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}

local gruvbox_flat = {
	"eddyekofo94/gruvbox-flat.nvim",
	lazy = false,
	priority = 1000,
}

return {
	deus,
	tokyonight,
	nightfox,
	vscode,
	rosepine,
	catppuccin,
	gruvbox,
	gruvbox_flat,
	everforest,
	edge,
	sonokai,
}
