local lualine = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({})
	end,
}

local airline = {
	"vim-airline/vim-airline",
	dependencies = { "vim-airline/vim-airline-themes" },
	config = function()
		vim.cmd([[
			let g:airline_powerline_fonts = 1
			let g:airline#extensions#tabline#enabled = 1
		]])
	end,
}

return {
	airline,
}
