
-- Pre-compute workspace files asynchronously so LspAttach doesn't block
local _ws_files_cache = nil
local ignore_dirs = { ".yarn", "node_modules", "dist", "build" }

local function prefetch_workspace_files()
	vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }, function(r)
		if r.code ~= 0 or not r.stdout or r.stdout == "" then
			return
		end
		local root = vim.trim(r.stdout)
		vim.system({ "git", "ls-files", root }, { text = true }, function(r2)
			if r2.code ~= 0 or not r2.stdout then
				return
			end
			local files = {}
			for _, f in ipairs(vim.split(r2.stdout, "\n")) do
				if f ~= "" then
					local ignored = false
					for _, dir in ipairs(ignore_dirs) do
						if f:match("^" .. dir .. "/") then
							ignored = true
							break
						end
					end
					if not ignored then
						table.insert(files, f)
					end
				end
			end
			_ws_files_cache = files
		end)
	end)
end

return {
	packs = {
		GH("neovim/nvim-lspconfig"),
		GH("rachartier/tiny-code-action.nvim"),
		GH("folke/lazydev.nvim"),
		GH("b0o/SchemaStore.nvim"),
		GH("artemave/workspace-diagnostics.nvim"),
	},
	setup = function()
		vim.lsp.enable({
			"lua_ls",
			"gopls",
			"biome",
			"oxlint",
			"tsgo",
			"rust_analyzer",
			"yamlls",
			"jsonls",
			"bashls",
		})

		require("lazydev").setup({
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		})

		prefetch_workspace_files()

		require("workspace-diagnostics").setup({
			workspace_files = function()
				return _ws_files_cache or {}
			end,
		})
	end,
}
