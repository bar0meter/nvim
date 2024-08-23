return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup()

		vim.keymap.set("n", "<leader>tr", ":NvimTreeToggle<CR>", { desc = "[S]earch [D]iagnostics" })
	end,
}
