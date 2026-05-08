return {
	packs = {
		GH("nvim-tree/nvim-web-devicons"),
		GH("nvim-lualine/lualine.nvim"),
	},
	setup = function()
		require("nvim-web-devicons").setup({ default = true })

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
