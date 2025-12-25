return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		scroll = { ---@class snacks.scroll.Config
			---@field animate snacks.animate.Config|{}
			---@field animate_repeat snacks.animate.Config|{}|{delay:number}

			animate = {
				duration = { step = 15, total = 250 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 400, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		indent = {
			priority = 1,
			enabled = false, -- enable indent guides
			char = "│",
			only_scope = false, -- only show indent guides of the scope
			only_current = false, -- only show indent guides in the current window
			hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
		},
		-- animate scopes. Enabled by default for Neovim >= 0.10
		-- Works on older versions but has to trigger redraws during animation.
		---@class snacks.indent.animate: snacks.animate.Config
		---@field enabled? boolean
		--- * out: animate outwards from the cursor
		--- * up: animate upwards from the cursor
		--- * down: animate downwards from the cursor
		--- * up_down: animate up or down based on the cursor position
		---@field style? "out"|"up_down"|"down"|"up"
		animate = {
			enabled = vim.fn.has("nvim-0.10") == 1,
			style = "out",
			easing = "linear",
			duration = {
				step = 20, -- ms per step
				total = 500, -- maximum duration
			},
		},
		terminal = {
			enabled = true,
			win = {
				style = "float",
				width = 0.9,
				height = 0.9,
				border = "rounded",
				backdrop = 60,
				zindex = 50,
				wo = {
					winblend = 10,
				},
			},
		},
	},
}
