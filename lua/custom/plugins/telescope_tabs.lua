return {
	"LukasPietzschmann/telescope-tabs",
	config = function()
		require("telescope").load_extension("telescope-tabs")
		require("telescope-tabs").setup({})

		vim.keymap.set("n", "<leader>tt", ":lua require('telescope-tabs').list_tabs()<CR>", {})
	end,
	dependencies = { "nvim-telescope/telescope.nvim" },
}
