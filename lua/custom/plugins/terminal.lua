return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				shade_terminals = true,
				shade_filetypes = {},
				direction = "float",
				highlights = {
					NormalFloat = {
						ctermbg = 233,
					},
					border = "FloatBorder",
				},
				float_opts = {
					border = "none",
				},
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
			})
		end,
	},
}
