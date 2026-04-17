
local function update_highlight(name, opts)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if not ok then
		return
	end
	vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", hl, opts))
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

return {
	packs = {
		GH("folke/noice.nvim"),
		GH("MunifTanjim/nui.nvim"),
		GH("rcarriga/nvim-notify"),
		GH("folke/snacks.nvim"),
		GH("nvim-tree/nvim-web-devicons"),
		GH("akinsho/bufferline.nvim"),
		GH("lewis6991/gitsigns.nvim"),
	},
	setup = function()
		require("nvim-web-devicons").setup({ default = true })

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

		require("noice").setup({
			views = {
				cmdline_popup = {
					position = { row = 0, col = "50%" },
				},
				popupmenu = {
					position = { row = 3, col = "50%" },
				},
			},
			routes = {
				-- let snacks.picker handle vim.ui.select
				{ filter = { event = "select" }, opts = { skip = true } },
			},
		})

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
	end,
}
