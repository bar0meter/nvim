
return {
	packs = {
		GH("folke/todo-comments.nvim"),
	},
	setup = function()
		require("todo-comments").setup({ signs = false })
	end,
}
