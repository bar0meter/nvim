return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
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
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
