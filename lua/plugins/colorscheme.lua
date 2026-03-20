local deus = {
	"ajmwagar/vim-deus",
	lazy = false,
	priority = 1000,
}

local tokyonight = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd.colorscheme("tokyonight-night")
	end,
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
}
