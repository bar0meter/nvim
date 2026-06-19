return {
	packs = {
		GH("lewis6991/gitsigns.nvim"),
		GH("pwntester/octo.nvim")
	},
	setup = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})

		require("octo").setup({
			file_panel = {
				icons = function(name, _ext)
					return require("mini.icons").get("file", name)
				end,
			},
		})

		-- Surface Octo's GitHub actions in the fuzzymenu.
		local ok, fzm = pcall(require, "fuzzymenu")
		if ok then
			local function octo(args)
				return function()
					vim.cmd("Octo " .. args)
				end
			end
			fzm.add({
				{ category = "GitHub", name = "List pull requests", run = octo("pr list") },
				{ category = "GitHub", name = "Search pull requests", run = octo("pr search") },
				{ category = "GitHub", name = "Create pull request", run = octo("pr create") },
				{ category = "GitHub", name = "Start PR review", run = octo("review start") },
				{ category = "GitHub", name = "Resume PR review", run = octo("review resume") },
				{ category = "GitHub", name = "List issues", run = octo("issue list") },
				{ category = "GitHub", name = "Create issue", run = octo("issue create") },
				{ category = "GitHub", name = "Search issues", run = octo("issue search") },
				{ category = "GitHub", name = "Repo overview", run = octo("repo view") },
				{ category = "GitHub", name = "Global search", run = octo("search") },
			})
		end
	end,
}
