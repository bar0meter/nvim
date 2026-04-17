
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
	end,
}
