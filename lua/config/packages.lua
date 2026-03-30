-- Neovim 0.12+ built-in package management (vim.pack)

local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	-- Colorschemes
	gh("ellisonleao/gruvbox.nvim"),
	gh("folke/tokyonight.nvim"),
	gh("EdenEast/nightfox.nvim"),
	gh("Mofiqul/vscode.nvim"),
	gh("rose-pine/neovim"),
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	gh("ajmwagar/vim-deus"),
	gh("sainnhe/everforest"),
	gh("sainnhe/edge"),
	gh("sainnhe/sonokai"),

	-- LSP & Development
	gh("neovim/nvim-lspconfig"),
	gh("rachartier/tiny-code-action.nvim"),
	gh("folke/lazydev.nvim"),
	gh("b0o/SchemaStore.nvim"),
	gh("artemave/workspace-diagnostics.nvim"),

	-- Treesitter
	gh("nvim-treesitter/nvim-treesitter"),

	-- Navigation
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),

	-- File management
	gh("stevearc/oil.nvim"),
	gh("refractalize/oil-git-status.nvim"),

	-- Editing
	gh("tpope/vim-commentary"),
	gh("nvim-mini/mini.nvim"),
	gh("stevearc/conform.nvim"),
	gh("windwp/nvim-ts-autotag"),

	-- Snippets
	gh("L3MON4D3/LuaSnip"),
	gh("rafamadriz/friendly-snippets"),

	-- UI
	gh("folke/noice.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("folke/snacks.nvim"),
	gh("nvim-tree/nvim-web-devicons"),

	-- Language specific
	gh("olexsmir/gopher.nvim"),
	gh("diepm/vim-rest-console"),

	-- Misc
	gh("folke/todo-comments.nvim"),
}, { load = true })

------------------------------------------------------
-- Plugin configuration
------------------------------------------------------

-- Gruvbox (active colorscheme)
require("gruvbox").setup({
	italic = {
		strings = false,
		emphasis = false,
		comments = false,
		operators = false,
		folds = false,
	},
})
vim.cmd.colorscheme("gruvbox")

-- Treesitter
local ts = require("nvim-treesitter")
local languages = {
	"bash",
	"diff",
	"djot",
	"elixir",
	"erlang",
	"gleam",
	"html",
	"javascript",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"query",
	"rust",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}
ts.install(languages, { summary = false })

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

-- LSP (servers configured in lsp/ directory)
vim.lsp.enable({ "lua_ls", "gopls", "biome", "oxlint", "tsgo", "rust_analyzer", "yamlls", "jsonls", "bashls" })

-- Telescope
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

pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension("ui-select")

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>l", function()
	telescope_builtin.find_files({
		file_ignore_patterns = { "^./.git/", "^node_modules/" },
		prompt_title = "[S]earch [F]iles",
		find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--sort", "accessed" },
	})
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>ss", function()
	telescope_builtin.current_buffer_fuzzy_find({})
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>ff", function()
	telescope_builtin.live_grep({ prompt_title = "[S]earch by [G]rep" })
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>dd", function()
	telescope_builtin.diagnostics({ prompt_title = "[S]earch [D]iagnostics" })
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>sr", telescope_builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", telescope_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

vim.keymap.set("n", "<leader>b", function()
	telescope_builtin.buffers({ prompt_title = "[ ] Find existing buffers" })
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>gt", function()
	telescope_builtin.git_files({
		prompt_title = "Ignore tests folder",
		file_ignore_patterns = { "tests", "functional_tests", "snapshots", ".github", "codegen", "node_modules" },
	})
end, { desc = "[Ignore tests]" })

vim.keymap.set("n", "<leader>ps", function()
	telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>sf", function()
	telescope_builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, { desc = "[S]earch [/] in Open Files" })

vim.keymap.set("n", "<leader>pws", function()
	telescope_builtin.grep_string({ search = vim.fn.expand("<cword>") })
end)
vim.keymap.set("n", "<leader>pWs", function()
	telescope_builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
end)

vim.keymap.set("n", "<leader>sn", function()
	telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Oil
require("oil").setup({
	win_options = { signcolumn = "yes:2" },
	view_options = { show_hidden = true },
})
require("oil-git-status").setup({ show_ignored = false })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Oil file manager" })

-- Mini
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.jump").setup()

-- Conform (formatting)
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		graphql = { "prettierd" },
		go = { "goimports", "gofmt" },
		typescript = { "oxlint", "biome" },
		javascript = { "oxlint", "biome" },
		typescriptreact = { "oxlint", "biome" },
		javascriptreact = { "oxlint", "biome" },
	},
	format_on_save = {},
})

-- Autotag
require("nvim-ts-autotag").setup()

-- Noice
require("noice").setup({
	views = {
		cmdline_popup = {
			position = { row = 0, col = "50%" },
		},
		popupmenu = {
			position = { row = 3, col = "50%" },
		},
	},
})

-- Snacks
require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = false },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

-- LuaSnip
local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
ls.add_snippets("go", require("snippets.go"))

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	ls.jump(1)
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	ls.jump(-1)
end)

-- LazyDev
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})

-- Workspace diagnostics
require("workspace-diagnostics").setup({
	workspace_files = function()
		local gitPath = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
		if gitPath == nil or gitPath == "" then
			return {}
		end

		local all_files = vim.fn.split(vim.fn.system("git ls-files " .. gitPath), "\n")
		local ignore_dirs = { ".yarn", "node_modules", "dist", "build" }

		local function is_ignored(file)
			for _, dir in ipairs(ignore_dirs) do
				if file:match("^" .. dir .. "/") then
					return true
				end
			end
			return false
		end

		local filtered_files = {}
		for _, file in ipairs(all_files) do
			if file ~= "" and not is_ignored(file) then
				table.insert(filtered_files, file)
			end
		end
		return filtered_files
	end,
})

-- Todo comments
require("todo-comments").setup({ signs = false })

-- Gopher
require("gopher").setup({})
vim.keymap.set("n", "<leader>goat", ":GoTestAdd<cr>")
vim.keymap.set("n", "<leader>got", ":GoTestsAll<cr>")
vim.keymap.set("n", "<leader>goe", ":GoTestsExp<cr>")
vim.keymap.set("n", "<leader>goj", ":GoTagsAdd json<cr>")
