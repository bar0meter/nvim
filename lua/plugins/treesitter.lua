local treesitter = { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	opts = {},
	config = function()
		local ts = require("nvim-treesitter")

		local languages = {
			"bash",
			"diff",
			"djot",
			"elixir",
			"erlang",
			"gleam",
			"html",
			"javascript",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"rust",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}

		ts.install(languages, { summary = false })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				-- syntax highlighting, provided by Neovim
				vim.treesitter.start()
				-- folds, provided by Neovim
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				-- indentation, provided by nvim-treesitter
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

return {
	treesitter,
}
