return {
	packs = {
		GH("stevearc/conform.nvim"),
		GH("NMAC427/guess-indent.nvim"),
	},
	setup = function()
		require("guess-indent").setup({})

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
