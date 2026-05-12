return {
	packs = {
		GH("nvim-mini/mini.nvim"),
	},
	setup = function()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.jump").setup()
		require("mini.icons").setup()
		require("mini.statusline").setup({ use_icons = true })
		require("mini.tabline").setup()
		require("mini.completion").setup()
		require("mini.comment").setup()

		require("mini.files").setup({
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 30,
			},
			options = {
				use_as_default_explorer = true,
			},
		})

		vim.api.nvim_create_user_command("Files", function()
			local mini = require("mini.files")
			mini.open(vim.api.nvim_buf_get_name(0), true)
			mini.reveal_cwd()
		end, { desc = "Open mini.files" })

		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- `[` and `]` keys
				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "x", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			window = {
				delay = 250,
			},

			clues = {
				miniclue.gen_clues.square_brackets(),
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})

		local function pum_accept(fallback)
			return function()
				if vim.fn.pumvisible() == 0 then
					return fallback
				end
				if vim.fn.complete_info({ "selected" }).selected == -1 then
					return "<C-n><C-y>"
				end
				return "<C-y>"
			end
		end

		local opts = { expr = true, replace_keycodes = true }
		vim.keymap.set("i", "<CR>", pum_accept("<CR>"), opts)
		vim.keymap.set("i", "<Tab>", pum_accept("<Tab>"), opts)
		vim.keymap.set("i", "<C-y>", pum_accept("<C-y>"), opts)
	end,
}
