local lualine = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "duskfox",
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
		})
	end,
}

return {}
