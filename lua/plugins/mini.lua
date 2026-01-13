return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		-- enhanced, a and i keybinds
		require("mini.ai").setup()

		-- auto pairs
		require("mini.pairs").setup()

		-- access to surround keymaps sa,sd,sc etc
		require("mini.surround").setup()

		-- replace gitsigns
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {
					add = "┃",
					change = "┃",
					delete = "_",
				},
			},
		})

		require("mini.jump").setup()
	end,
}
