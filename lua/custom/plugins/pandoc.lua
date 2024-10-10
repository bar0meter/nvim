return {
	"vim-pandoc/vim-pandoc",
	dependencies = {
		"rwxrob/vim-pandoc-syntax-simple",
	},
	config = function()
		vim.cmd([[
			let g:pandoc#formatting#mode = 'h' " A'
			let g:pandoc#formatting#textwidth = 72
		]])
	end,
}
