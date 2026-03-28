return {
	"nvim-mini/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- enhanced, a and i keybinds
		require("mini.ai").setup()

		-- auto pairs
		require("mini.pairs").setup()

		-- access to surround keymaps sa,sd,sc etc
		require("mini.surround").setup()

		require("mini.jump").setup()
	end,
}
