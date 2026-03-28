return {
	"olexsmir/gopher.nvim",
	ft = "go",
	build = function()
		vim.cmd.GoInstallDeps()
	end,
	keys = {
		{ "<leader>goat", ":GoTestAdd<cr>" },
		{ "<leader>got", ":GoTestsAll<cr>" },
		{ "<leader>goe", ":GoTestsExp<cr>" },
		{ "<leader>goj", ":GoTagsAdd json<cr>" },
	},
	---@module "gopher"
	---@type gopher.Config
	opts = {},
}
