
return {
	packs = {
		{ src = GH("Saghen/blink.cmp"), version = vim.version.range("1") },
		GH("L3MON4D3/LuaSnip"),
		GH("rafamadriz/friendly-snippets"),
	},
	setup = function()
		require("blink.cmp").setup({
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" },
				["<C-\\>"] = { "hide", "fallback" },
				["<C-n>"] = { "select_next", "show" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			completion = {
				list = {
					selection = { preselect = false, auto_insert = true },
					max_items = 10,
				},
				menu = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					scrollbar = false,
					draw = {
						gap = 2,
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", "label_description", gap = 1 },
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				},
			},
			cmdline = { enabled = false },
			snippets = { preset = "luasnip" },
			sources = {
				default = function()
					local sources = { "lsp", "buffer" }
					local ok, node = pcall(vim.treesitter.get_node)

					if ok and node then
						if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
							table.insert(sources, "path")
						end
						if node:type() ~= "string" then
							table.insert(sources, "snippets")
						end
					end

					return sources
				end,
			},
			appearance = {
				kind_icons = require("icons").symbol_kinds,
			},
		})

		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")
		luasnip.setup({
			delete_check_events = "TextChanged",
			ext_opts = {
				[types.insertNode] = {
					unvisited = {
						virt_text = { { "|", "Conceal" } },
						virt_text_pos = "inline",
					},
				},
				[types.exitNode] = {
					unvisited = {
						virt_text = { { "|", "Conceal" } },
						virt_text_pos = "inline",
					},
				},
				[types.choiceNode] = {
					active = {
						virt_text = { { "(snippet) choice node", "LspInlayHint" } },
					},
				},
			},
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.add_snippets("go", require("snippets.go"))

		vim.keymap.set("i", "<C-r>s", function()
			require("luasnip.extras.otf").on_the_fly("s")
		end, { desc = "Insert on-the-fly snippet" })

		vim.keymap.set({ "i", "s" }, "<C-c>", function()
			if luasnip.choice_active() then
				require("luasnip.extras.select_choice")()
			end
		end, { desc = "Select snippet choice" })
	end,
}
