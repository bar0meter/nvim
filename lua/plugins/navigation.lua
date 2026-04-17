
return {
	packs = {
		GH("Bekaboo/dropbar.nvim"),
	},
	setup = function()
		require("dropbar").setup({
			bar = {
				hover = true,
			},
		})
	end,
}
