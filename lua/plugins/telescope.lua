return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	keys = {
		{ "<leader>sf", "<cmd>Telescope find_files<cr>" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			defaults = {},
			extensions = {
				fzf = {},
				["ui-select"] = {},
			},
			pickers = {
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = { "node_modules", ".git" },
					hidden = true,
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")

		local telescope_builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>l", function()
			telescope_builtin.find_files({
				file_ignore_patterns = { "^./.git/", "^node_modules/" },
				prompt_title = "[S]earch [F]iles",
				find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--sort", "accessed" },
			})
		end, { desc = "[S]earch [F]iles" })

		vim.keymap.set("n", "<leader>ss", telescope_builtin.builtin, { desc = "[S]earch [S]elect Telescope" })

		vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

		vim.keymap.set("n", "<leader>ff", function()
			telescope_builtin.live_grep({
				prompt_title = "[S]earch by [G]rep",
			})
		end, { desc = "[S]earch by [G]rep" })

		vim.keymap.set("n", "<leader>dd", function()
			telescope_builtin.diagnostics({
				prompt_title = "[S]earch [D]iagnostics",
			})
		end, { desc = "[S]earch [D]iagnostics" })

		vim.keymap.set("n", "<leader>sr", telescope_builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set(
			"n",
			"<leader>s.",
			telescope_builtin.oldfiles,
			{ desc = '[S]earch Recent Files ("." for repeat)' }
		)

		vim.keymap.set("n", "<leader>b", function()
			telescope_builtin.buffers({
				prompt_title = "[ ] Find existing buffers",
			})
		end, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>gt", function()
			telescope_builtin.git_files({
				prompt_title = "Ignore tests folder",
				file_ignore_patterns = {
					"tests",
					"functional_tests",
					"snapshots",
					".github",
					"codegen",
					"node_modules",
				},
			})
		end, { desc = "[Ignore tests]" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>ss", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			telescope_builtin.current_buffer_fuzzy_find({})
		end, { desc = "[/] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>ps", function()
			telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>sf", function()
			telescope_builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			telescope_builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			telescope_builtin.grep_string({ search = word })
		end)

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
