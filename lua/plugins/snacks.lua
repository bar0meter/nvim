return {
	packs = {
		GH("folke/snacks.nvim"),
	},
	setup = function()
		require("snacks").setup({
			scroll = {
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
				animate_repeat = {
					delay = 400,
					duration = { step = 5, total = 50 },
					easing = "linear",
				},
				filter = function(buf)
					return vim.g.snacks_scroll ~= false
						and vim.b[buf].snacks_scroll ~= false
						and vim.bo[buf].buftype ~= "terminal"
				end,
			},
			indent = {
				priority = 1,
				enabled = true,
				char = "│",
				only_scope = false,
				only_current = false,
				hl = "SnacksIndent",
			},
			animate = {
				enabled = true,
				style = "out",
				easing = "linear",
				duration = {
					step = 20,
					total = 500,
				},
			},
		})
	end,
}
