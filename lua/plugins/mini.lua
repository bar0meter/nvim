return {
	packs = {
		GH("nvim-mini/mini.nvim"),
	},
	setup = function()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.jump").setup()
		require("mini.icons").setup()
		require("mini.statusline").setup({ use_icons = true })
		require("mini.tabline").setup()
	end,
}
