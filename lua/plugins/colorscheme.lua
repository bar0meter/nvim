local deus = {
	"ajmwagar/vim-deus",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("deus")
	end,
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

return {
	deus,
	tokyonight,
	nightfox,
	vscode,
}
