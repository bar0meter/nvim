local copilot = {
	"github/copilot.vim",
}

local supermaven = {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({})
	end,
}

return {
	copilot,
}
