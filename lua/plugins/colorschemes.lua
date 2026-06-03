return {
	packs = {
		GH("ajmwagar/vim-deus"),
		GH("EdenEast/nightfox.nvim"),
		GH("rebelot/kanagawa.nvim"),
	},
	setup = function()
		vim.cmd.colorscheme("duskfox")
	end,
}
