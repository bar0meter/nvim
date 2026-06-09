return {
	packs = {
		GH("ajmwagar/vim-deus"),
		GH("EdenEast/nightfox.nvim"),
		GH("rebelot/kanagawa.nvim"),
		GH("mofiqul/vscode.nvim")
	},
	setup = function()
		vim.cmd.colorscheme("deus")
	end,
}
