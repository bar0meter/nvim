return {
	packs = {
		GH("tpope/vim-commentary"),
		GH("nvim-mini/mini.nvim"),
		GH("stevearc/conform.nvim"),
	},
	setup = function()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.jump").setup()

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				graphql = { "prettierd" },
				go = { "goimports", "gofmt" },
				typescript = { "oxlint", "biome" },
				javascript = { "oxlint", "biome" },
				typescriptreact = { "oxlint", "biome" },
				javascriptreact = { "oxlint", "biome" },
			},
			format_on_save = {},
		})
	end,
}
