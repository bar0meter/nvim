local gruvbox = {
	"gruvbox-community/gruvbox",
}

-- Lua
local gruvbuddy = {
	"tjdevries/colorbuddy.nvim",
}

local vscode = {
	"Mofiqul/vscode.nvim",
	config = function()
		require("vscode").setup({
			transparent = false,
			italic_comments = false,
			underline_links = false,
			disable_nvimtree_bg = true,
		})
	end,
}

return {
	gruvbox,
	vscode,
}
