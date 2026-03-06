local function enable_transparency()
	local groups = {
		"Normal",
		"NormalFloat",
		"FloatBorder",
		"Pmenu",
		"Terminal",
		"EndOfBuffer",
		"FoldColumn",
		"Folded",
		"SignColumn",
		"NormalNC",
		"WhichKeyFloat",
		"StatusLine",
		"TelescopeBorder",
		"TelescopeNormal",
		"TelescopePromptBorder",
		"TelescopePromptTitle",
		"NvimTreeNormal",
		"NvimTreeVertSplit",
		"NvimTreeEndOfBuffer",
		"NotifyINFOBody",
		"NotifyERRORBody",
		"NotifyWARNBody",
		"NotifyTRACEBody",
		"NotifyDEBUGBody",
		"NotifyINFOTitle",
		"NotifyERRORTitle",
		"NotifyWARNTitle",
		"NotifyTRACETitle",
		"NotifyDEBUGTitle",
		"NotifyINFOBorder",
		"NotifyERRORBorder",
		"NotifyWARNBorder",
		"NotifyTRACEBorder",
		"NotifyDEBUGBorder",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#5c6370" })
	vim.api.nvim_set_hl(0, "MiniTablineCurrent", { bold = true, bg = "none" })
	vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { bold = true, bg = "none" })
end

vim.cmd.colorscheme("tokyonight")

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = enable_transparency,
})

enable_transparency()
