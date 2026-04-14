-- Neovim 0.12+ built-in package management (vim.pack)

local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	-- Colorschemes
	gh("ellisonleao/gruvbox.nvim"),
	gh("folke/tokyonight.nvim"),
	gh("sainnhe/everforest"),
	gh("Mofiqul/dracula.nvim"),

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
	{ src = gh("Saghen/blink.cmp"), version = vim.version.range("1") },
	gh("Bekaboo/dropbar.nvim"),

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
	gh("akinsho/bufferline.nvim"),
	gh("lewis6991/gitsigns.nvim"),

	-- Language specific
	gh("olexsmir/gopher.nvim"),
	gh("diepm/vim-rest-console"),

	-- Misc
	gh("folke/todo-comments.nvim"),
}, { load = true })

------------------------------------------------------
-- Plugin configuration
------------------------------------------------------

-- vim-rest-console: output body only, no headers, no status line
vim.g.vrc_show_command = 0
vim.g.vrc_curl_opts = { ["-s"] = "" }
vim.g.vrc_auto_format_response_patterns = { json = "jq ." }
vim.g.vrc_output_buffer_name = "__VRC_OUTPUT.json"

-- Gruvbox (active colorscheme)
require("dracula").setup({
	show_end_of_buffer = false,
	transparent_bg = false,
	italic_comment = false,
})
vim.cmd.colorscheme("dracula")

local function set_hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

local function color(group, attr, fallback)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok and hl and hl[attr] then
		return hl[attr]
	end
	if fallback then
		return color(fallback[1], fallback[2], fallback[3])
	end
end

local function apply_ui_highlights()
	local normal_bg = color("Normal", "bg")
	local normal_fg = color("Normal", "fg")
	local comment_fg = color("Comment", "fg", { "Normal", "fg" })
	local float_bg = color("NormalFloat", "bg", { "Pmenu", "bg", { "Normal", "bg" } })
	local border_fg = color("FloatBorder", "fg", { "WinSeparator", "fg", { "Comment", "fg" } })
	local selected_bg = color("CursorLine", "bg", { "Visual", "bg", { "PmenuSel", "bg", { "StatusLine", "bg" } } })
	local selected_fg = color("PmenuSel", "fg", { "Normal", "bg", { "Normal", "fg" } })
	local alt_bg = color("StatusLine", "bg", { "TabLine", "bg", { "Normal", "bg" } })
	local visual_bg = color("Visual", "bg", { "CursorLine", "bg", { "StatusLine", "bg" } })
	local warn_fg = color("DiagnosticWarn", "fg", { "WarningMsg", "fg", { "Normal", "fg" } })
	local error_fg = color("DiagnosticError", "fg", { "ErrorMsg", "fg", { "Normal", "fg" } })
	local hint_fg = color("DiagnosticHint", "fg", { "Directory", "fg", { "Normal", "fg" } })
	local info_fg = color("DiagnosticInfo", "fg", { "Special", "fg", { "Normal", "fg" } })
	local accent_fg = color("Keyword", "fg", { "Statement", "fg", { "Special", "fg" } })
	local function_fg = color("Function", "fg", { "Identifier", "fg", { "Normal", "fg" } })
	local type_fg = color("Type", "fg", { "Constant", "fg", { "Normal", "fg" } })

	set_hl("Comment", { fg = comment_fg, bg = normal_bg, italic = false })
	set_hl("Pmenu", { fg = normal_fg, bg = float_bg })
	set_hl("PmenuSel", { fg = selected_fg, bg = selected_bg, bold = true })
	set_hl("PmenuSbar", { bg = alt_bg })
	set_hl("PmenuThumb", { bg = comment_fg })
	set_hl("BlinkCmpMenu", { fg = normal_fg, bg = float_bg })
	set_hl("BlinkCmpMenuBorder", { fg = border_fg, bg = float_bg })
	set_hl("BlinkCmpMenuSelection", { fg = selected_fg, bg = selected_bg, bold = true })
	set_hl("BlinkCmpDoc", { fg = normal_fg, bg = float_bg })
	set_hl("BlinkCmpDocBorder", { fg = border_fg, bg = float_bg })
	set_hl("BlinkCmpSignatureHelp", { fg = normal_fg, bg = float_bg })
	set_hl("BlinkCmpSignatureHelpBorder", { fg = border_fg, bg = float_bg })
	set_hl("BlinkCmpLabel", { fg = normal_fg, bg = float_bg })
	set_hl("BlinkCmpLabelMatch", { fg = accent_fg, bg = float_bg, bold = true })
	set_hl("BlinkCmpLabelDeprecated", { fg = comment_fg, bg = float_bg, strikethrough = true })
	set_hl("BlinkCmpKind", { fg = info_fg, bg = float_bg })
	for _, name in ipairs({ "File", "Reference", "Event", "Unit" }) do
		set_hl("BlinkCmpKind" .. name, { fg = info_fg, bg = float_bg })
	end
	for _, name in ipairs({ "Folder", "Module", "Enum", "EnumMember", "Snippet", "Class", "Struct", "Interface", "Constant", "Value", "TypeParameter" }) do
		set_hl("BlinkCmpKind" .. name, { fg = type_fg, bg = float_bg })
	end
	for _, name in ipairs({ "Function", "Method", "Constructor" }) do
		set_hl("BlinkCmpKind" .. name, { fg = function_fg, bg = float_bg })
	end
	for _, name in ipairs({ "Variable", "Property", "Field" }) do
		set_hl("BlinkCmpKind" .. name, { fg = normal_fg, bg = float_bg })
	end
	for _, name in ipairs({ "Keyword", "Operator", "Color" }) do
		set_hl("BlinkCmpKind" .. name, { fg = accent_fg, bg = float_bg })
	end
	set_hl("BlinkCmpScrollBarGutter", { bg = alt_bg })
	set_hl("BlinkCmpScrollBarThumb", { bg = comment_fg })
	set_hl("TelescopeNormal", { fg = normal_fg, bg = float_bg })
	set_hl("TelescopeBorder", { fg = border_fg, bg = float_bg })
	set_hl("TelescopePromptBorder", { fg = border_fg, bg = float_bg })
	set_hl("TelescopePromptTitle", { link = "PmenuSel" })
	set_hl("TelescopeResultsTitle", { link = "PmenuSel" })
	set_hl("TelescopePreviewTitle", { link = "PmenuSel" })
	set_hl("WinBar", { fg = normal_fg, bg = normal_bg })
	set_hl("WinBarNC", { fg = comment_fg, bg = normal_bg })
	set_hl("DropBarIconUISeparator", { fg = comment_fg, bg = normal_bg })
	set_hl("DropBarCurrentContext", { link = "PmenuSel" })
	set_hl("DropBarMenuCurrentContext", { link = "PmenuSel" })
	set_hl("DropBarMenuFloatBorder", { fg = border_fg, bg = float_bg })
	set_hl("DropBarMenuNormalFloat", { fg = normal_fg, bg = float_bg })
	set_hl("DropBarMenuHoverEntry", { fg = normal_fg, bg = visual_bg })
	set_hl("DropBarMenuHoverSymbol", { fg = accent_fg, bg = visual_bg, bold = true })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("custom_ui_highlights", { clear = true }),
	callback = function()
		vim.schedule(apply_ui_highlights)
	end,
})

apply_ui_highlights()

require("nvim-web-devicons").setup({ default = true })

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

-- Blink completion
require("blink.cmp").setup({
	keymap = {
		["<CR>"] = { "accept", "fallback" },
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

-- Dropbar
require("dropbar").setup({
	bar = {
		hover = true,
	},
})

-- Oil
require("oil").setup({
	win_options = { signcolumn = "yes:2" },
	view_options = { show_hidden = true },
})
require("oil-git-status").setup({ show_ignored = false })

-- Bufferline
local function update_highlight(name, opts)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if not ok then
		return
	end

	vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", hl, opts))
end

local function hl_color(group, attr, fallback)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok and hl and hl[attr] then
		return hl[attr]
	end
	if fallback then
		return hl_color(fallback[1], fallback[2], fallback[3])
	end
end

local function style_bufferline_filenames()
	for _, name in ipairs({ "BufferLineBuffer", "BufferLineBufferVisible", "BufferLineBufferSelected" }) do
		update_highlight(name, { italic = false, bold = false })
	end

	for _, name in ipairs({
		"BufferLineWarning",
		"BufferLineWarningVisible",
		"BufferLineWarningSelected",
		"BufferLineError",
		"BufferLineErrorVisible",
		"BufferLineErrorSelected",
	}) do
		update_highlight(name, { italic = true, bold = true })
	end
end

require("bufferline").setup({
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
		truncate_names = false,
		indicator = { style = "none" },
		close_command = function(bufnr)
			vim.api.nvim_buf_delete(bufnr, { force = false })
		end,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diag)
			local icons = require("icons").diagnostics
			local indicator = (diag.error and icons.ERROR .. " " or "") .. (diag.warning and icons.WARN or "")
			return vim.trim(indicator)
		end,
	},
})
style_bufferline_filenames()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("bufferline_filename_style", { clear = true }),
	callback = function()
		vim.schedule(style_bufferline_filenames)
	end,
})

-- Gitsigns
local solid_bar = require("icons").misc.vertical_bar
local dashed_bar = require("icons").misc.dashed_bar
require("gitsigns").setup({
	signs = {
		add = { text = solid_bar },
		change = { text = solid_bar },
		delete = { text = solid_bar },
		topdelete = { text = solid_bar },
		changedelete = { text = solid_bar },
		untracked = { text = solid_bar },
	},
	signs_staged = {
		add = { text = dashed_bar },
		change = { text = dashed_bar },
		delete = { text = dashed_bar },
		topdelete = { text = dashed_bar },
		changedelete = { text = dashed_bar },
		untracked = { text = dashed_bar },
	},
	preview_config = { border = "rounded" },
	current_line_blame = true,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function nmap(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
		end

		nmap("[g", gs.prev_hunk, "Previous hunk")
		nmap("]g", gs.next_hunk, "Next hunk")
		nmap("<leader>gR", gs.reset_buffer, "Reset buffer")
		nmap("<leader>gb", gs.blame_line, "Blame line")
		nmap("<leader>gp", gs.preview_hunk, "Preview hunk")
		nmap("<leader>gr", gs.reset_hunk, "Reset hunk")
		nmap("<leader>gs", gs.stage_hunk, "Stage hunk")
	end,
})

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
