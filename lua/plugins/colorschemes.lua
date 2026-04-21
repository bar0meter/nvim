
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
	set_hl("BlinkCmpMenuSelection", { bg = selected_bg, bold = true })
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
	for _, name in ipairs({
		"Folder",
		"Module",
		"Enum",
		"EnumMember",
		"Snippet",
		"Class",
		"Struct",
		"Interface",
		"Constant",
		"Value",
		"TypeParameter",
	}) do
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

	-- silence unused variable warnings
	local _ = warn_fg or error_fg or hint_fg

	-- deus is a pre-treesitter theme; re-link structural @-groups to Normal
	-- so they use deus's warm yellowish fg instead of terminal white
	if vim.g.colors_name == "deus" then
		for _, group in ipairs({
			"@variable",
			"@variable.member",
			"@variable.parameter",
			"@operator",
			"@punctuation.bracket",
			"@punctuation.delimiter",
			"@punctuation.special",
		}) do
			set_hl(group, { link = "Normal" })
		end
	end
end

return {
	packs = {
		GH("ellisonleao/gruvbox.nvim"),
		GH("folke/tokyonight.nvim"),
		GH("sainnhe/everforest"),
		GH("ajmwagar/vim-deus"),
	},
	setup = function()
		vim.cmd.colorscheme("deus")

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("custom_ui_highlights", { clear = true }),
			callback = function()
				vim.schedule(apply_ui_highlights)
			end,
		})

		apply_ui_highlights()
	end,
}
