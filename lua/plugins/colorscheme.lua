local deus = {
	"ajmwagar/vim-deus",
}

local solarized = {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function(_, opts)
		vim.o.termguicolors = true
		vim.o.background = "dark"
		require("solarized").setup({
			on_highlights = nil,
			on_colors = nil,
			palette = "solarized", -- solarized (default) | selenized
			variant = "winter", -- "spring" | "summer" | "autumn" | "winter" (default)
			error_lens = {
				text = false,
				symbol = false,
			},
			styles = {
				enabled = true,
				types = {},
				parameters = {},
				comments = { italic = false, bold = false },
				functions = { italic = false },
				strings = {},
				keywords = {},
				variables = {},
				constants = {},
			},
			plugins = {
				treesitter = true,
				lspconfig = true,
				navic = true,
				cmp = true,
				indentblankline = true,
				neotree = true,
				nvimtree = true,
				whichkey = true,
				dashboard = true,
				gitsigns = true,
				telescope = true,
				noice = true,
				hop = true,
				ministatusline = true,
				minitabline = true,
				ministarter = true,
				minicursorword = true,
				notify = true,
				rainbowdelimiters = true,
				bufferline = true,
				lazy = true,
				rendermarkdown = true,
				ale = true,
				coc = true,
				leap = true,
				alpha = true,
				yanky = true,
				gitgutter = true,
				mason = true,
				flash = true,
			},
		})
	end,
}

local gruvbox = {
	"ellisonleao/gruvbox.nvim",
	config = function()
		require("gruvbox").setup({
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
		})
	end,
}

local gruvbox_material = {
	"sainnhe/gruvbox-material",
}

local everforest = {
	"neanias/everforest-nvim",
}

return {
	deus,
	gruvbox,
	gruvbox_material,
	everforest,
	solarized,
}
