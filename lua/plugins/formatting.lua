local disable_format_ft = {
	typescript = true,
	typescriptreact = true,
	javascript = true,
	javascriptreact = true,
}

return {
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype

				-- Disable format on save for these filetypes
				if disable_format_ft[ft] then
					return false
				end

				return {
					timeout_ms = 8000,
					lsp_format = "fallback",
				}
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				graphql = { "prettierd" },
				go = { "goimports", "gofmt" },
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
