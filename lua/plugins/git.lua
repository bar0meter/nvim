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

			-- Git history/navigation via Telescope and hunk actions via gitsigns.
			local builtin = require("telescope.builtin")
			local gs = require("gitsigns")
			fzm.add({
				{ category = "Git", name = "Status", run = builtin.git_status },
				{ category = "Git", name = "Commits (repo)", run = builtin.git_commits },
				{ category = "Git", name = "Commits (buffer)", run = builtin.git_bcommits },
				{ category = "Git", name = "Branches", run = builtin.git_branches },
				{ category = "Git", name = "Stash", run = builtin.git_stash },
				{ category = "Git", name = "Toggle line blame", run = gs.toggle_current_line_blame },
				{ category = "Git", name = "Diff this", run = function() gs.diffthis() end },
				{ category = "Git", name = "Preview hunk", run = gs.preview_hunk },
				{ category = "Git", name = "Stage hunk", run = gs.stage_hunk },
				{ category = "Git", name = "Reset hunk", run = gs.reset_hunk },
			})
		end
	end,
}
