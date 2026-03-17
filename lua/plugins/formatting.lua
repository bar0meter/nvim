vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

return {
	{
		"stevearc/conform.nvim",
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
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
