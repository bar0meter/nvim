return {
	"tpope/vim-commentary",

	config = function()
		vim.keymap.set("", "<Leader>c", "<Plug>Commentary", {})
		vim.keymap.set("n", "<Leader>cc", "<Plug>CommentaryLine", {})
	end,
}
