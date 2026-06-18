return {
	packs = {
		GH("lewis6991/gitsigns.nvim"),
		GH("pwntester/octo.nvim")
	},
	setup = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})

		require("octo").setup({
			file_panel = {
				icons = function(name, _ext)
					return require("mini.icons").get("file", name)
				end,
			},
		})
	end,
}
