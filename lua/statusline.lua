local icons = require("icons")

local M = {}

vim.g.qf_disable_statusline = 1
vim.o.showmode = false

local statusline_hls = {}

local function hex(color)
	if not color then
		return nil
	end

	return string.format("#%06x", color)
end

local function create_hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
	statusline_hls[name] = true
end

local function ensure_mode_highlights()
	local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })
	local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
	local bg = hex(statusline.bg) or hex(normal.bg) or "#000000"

	local groups = {
		Normal = "Function",
		Pending = "WarningMsg",
		Visual = "String",
		Insert = "Keyword",
		Command = "Title",
		Other = "Comment",
	}

	for suffix, base_name in pairs(groups) do
		local base = vim.api.nvim_get_hl(0, { name = base_name })
		local fg = hex(base.fg) or hex(normal.fg) or "#ffffff"
		create_hl("StatuslineModeSeparator" .. suffix, { fg = fg, bg = bg })
		create_hl("StatuslineMode" .. suffix, { fg = bg, bg = fg, bold = true })
	end

	create_hl("StatuslineTitle", { fg = hex(normal.fg) or "#ffffff", bg = bg, bold = true })
	create_hl("StatuslineItalic", { fg = hex(normal.fg) or "#ffffff", bg = bg, italic = true })
	create_hl("StatuslineSpinner", { fg = hex(vim.api.nvim_get_hl(0, { name = "Special" }).fg) or "#ffffff", bg = bg })
	statusline_hls = {}
	statusline_hls.initialized = true
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("custom_statusline_highlights", { clear = true }),
	callback = ensure_mode_highlights,
})

---@param hl string
---@return string
function M.get_or_create_hl(hl)
	local hl_name = "Statusline" .. hl

	if not statusline_hls[hl_name] then
		local bg_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		local fg_hl = vim.api.nvim_get_hl(0, { name = hl })
		create_hl(hl_name, {
			bg = hex(bg_hl.bg) or hex(normal.bg) or "#000000",
			fg = hex(fg_hl.fg) or hex(normal.fg) or "#ffffff",
		})
	end

	return hl_name
end

function M.mode_component()
	local mode_to_str = {
		n = "NORMAL",
		no = "OP-PENDING",
		nov = "OP-PENDING",
		noV = "OP-PENDING",
		["no\22"] = "OP-PENDING",
		niI = "NORMAL",
		niR = "NORMAL",
		niV = "NORMAL",
		nt = "NORMAL",
		ntT = "NORMAL",
		v = "VISUAL",
		vs = "VISUAL",
		V = "VISUAL",
		Vs = "VISUAL",
		["\22"] = "VISUAL",
		["\22s"] = "VISUAL",
		s = "SELECT",
		S = "SELECT",
		["\19"] = "SELECT",
		i = "INSERT",
		ic = "INSERT",
		ix = "INSERT",
		R = "REPLACE",
		Rc = "REPLACE",
		Rx = "REPLACE",
		Rv = "VIRT REPLACE",
		Rvc = "VIRT REPLACE",
		Rvx = "VIRT REPLACE",
		c = "COMMAND",
		cv = "VIM EX",
		ce = "EX",
		r = "PROMPT",
		rm = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		t = "TERMINAL",
	}

	local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"
	local hl = "Other"

	if mode:find("NORMAL", 1, true) then
		hl = "Normal"
	elseif mode:find("PENDING", 1, true) then
		hl = "Pending"
	elseif mode:find("VISUAL", 1, true) then
		hl = "Visual"
	elseif mode:find("INSERT", 1, true) or mode:find("SELECT", 1, true) then
		hl = "Insert"
	elseif mode:find("COMMAND", 1, true) or mode:find("TERMINAL", 1, true) or mode:find("EX", 1, true) then
		hl = "Command"
	end

	return table.concat({
		string.format("%%#StatuslineModeSeparator%s#", hl),
		string.format("%%#StatuslineMode%s#%s", hl, mode),
		string.format("%%#StatuslineModeSeparator%s#", hl),
	})
end

function M.git_component()
	local head = vim.b.gitsigns_head
	if not head or head == "" then
		return ""
	end

	local component = string.format("%s %s", icons.misc.git, head)
	local ok, hunks = pcall(function()
		return require("gitsigns").get_hunks() or {}
	end)
	if ok and #hunks > 0 then
		component = component .. string.format(" (#Hunks: %d)", #hunks)
	end

	return component
end

function M.dap_component()
	if not package.loaded.dap then
		return nil
	end

	local status = require("dap").status()
	if status == "" then
		return nil
	end

	return string.format("%%#%s#%s  %s", M.get_or_create_hl("Special"), icons.misc.bug, status)
end

local progress_status = {
	client = nil,
	title = nil,
}

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("custom_statusline_progress", { clear = true }),
	desc = "Update LSP progress in statusline",
	pattern = { "begin", "end" },
	callback = function(args)
		if not args.data then
			return
		end

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		progress_status.client = client and client.name or nil
		progress_status.title = args.data.params.value.kind == "end" and nil or args.data.params.value.title

		if progress_status.title == nil then
			vim.defer_fn(vim.cmd.redrawstatus, 3000)
		else
			vim.cmd.redrawstatus()
		end
	end,
})

function M.lsp_progress_component()
	if not progress_status.client or not progress_status.title then
		return ""
	end

	if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
		return ""
	end

	return table.concat({
		"%#StatuslineSpinner#󱥸 ",
		string.format("%%#StatuslineTitle#%s  ", progress_status.client),
		string.format("%%#StatuslineItalic#%s%s", progress_status.title, icons.misc.ellipsis),
	})
end

function M.filetype_component()
	local devicons = require("nvim-web-devicons")
	local special_icons = {
		["ccc-ui"] = { icons.misc.palette, "Comment" },
		["dap-view"] = { icons.misc.bug, "Special" },
		fzf = { icons.misc.terminal, "Special" },
		gitcommit = { icons.misc.git, "Number" },
		gitrebase = { icons.misc.git, "Number" },
		lazy = { icons.symbol_kinds.Method, "Special" },
		minifiles = { icons.symbol_kinds.Folder, "Directory" },
		qf = { icons.misc.search, "Conditional" },
	}

	local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "[No Name]"
	local icon, icon_hl

	if special_icons[filetype] then
		icon, icon_hl = unpack(special_icons[filetype])
	else
		local buf_name = vim.api.nvim_buf_get_name(0)
		local name = vim.fn.fnamemodify(buf_name, ":t")
		local ext = vim.fn.fnamemodify(buf_name, ":e")
		icon, icon_hl = devicons.get_icon(name, ext)
		if not icon then
			icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
		end
	end

	return string.format("%%#%s#%s %%#StatuslineTitle#%s", M.get_or_create_hl(icon_hl), icon, filetype)
end

function M.encoding_component()
	local encoding = vim.opt.fileencoding:get()
	return encoding ~= "" and string.format("%%#StatuslineItalic#%s %s", "", encoding) or ""
end

function M.position_component()
	local line = vim.fn.line(".")
	local line_count = vim.api.nvim_buf_line_count(0)
	local col = vim.fn.virtcol(".")

	return table.concat({
		"%#StatuslineItalic#l: ",
		string.format("%%#StatuslineTitle#%d", line),
		string.format("%%#StatuslineItalic#/%d c: %d", line_count, col),
	})
end

function M.render()
	local function concat_components(components)
		local result = ""
		for _, component in ipairs(components) do
			if component ~= nil and component ~= "" then
				result = result == "" and component or string.format("%s    %s", result, component)
			end
		end
		return result
	end

	return table.concat({
		concat_components({
			M.mode_component(),
			M.git_component(),
			M.dap_component() or M.lsp_progress_component(),
		}),
		"%#StatusLine#%=",
		concat_components({
			vim.diagnostic.status(),
			M.filetype_component(),
			M.encoding_component(),
			M.position_component(),
		}),
		" ",
	})
end

ensure_mode_highlights()
vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M
