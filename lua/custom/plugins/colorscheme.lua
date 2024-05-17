local gruvbox = {
	"gruvbox-community/gruvbox",
	name = "gruvbox",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme gruvbox")
	end,
}

return gruvbox
