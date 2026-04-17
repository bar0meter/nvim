
return {
	packs = {
		GH("olexsmir/gopher.nvim"),
		GH("diepm/vim-rest-console"),
	},
	setup = function()
		-- vim-rest-console: output body only, no headers, no status line
		vim.g.vrc_show_command = 0
		vim.g.vrc_curl_opts = { ["-s"] = "" }
		vim.g.vrc_auto_format_response_patterns = { json = "jq ." }
		vim.g.vrc_output_buffer_name = "__VRC_OUTPUT.json"

		require("gopher").setup({})
	end,
}
