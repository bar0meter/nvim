
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

return {
	packs = {
		GH("nvim-treesitter/nvim-treesitter"),
	},
	setup = function()
		local ts = require("nvim-treesitter")
		ts.install(languages, { summary = false })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end,
		})
	end,
}
