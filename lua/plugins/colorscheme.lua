local deus = {
	"ajmwagar/vim-deus",
	lazy = true,
}

local everforest = {
	"sainnhe/everforest",
	lazy = true,
}

local sonokai = {
	"sainnhe/sonokai",
	lazy = true,
}

local edge = {
	"sainnhe/edge",
	lazy = true,
}

local tokyonight = {
	"folke/tokyonight.nvim",
	lazy = true,
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
	lazy = true,
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
