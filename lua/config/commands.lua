-- :LspList — show LSP clients attached to current buffer in one line
vim.api.nvim_create_user_command("LspList", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		vim.notify("No LSP clients attached", vim.log.levels.WARN)
		return
	end
	local names = vim.tbl_map(function(c)
		return c.name
	end, clients)
	vim.notify("LSP: " .. table.concat(names, ", "))
end, { desc = "List LSP clients attached to current buffer" })

-- update all vim.pack packages
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all packages" })

local function get_inactive_pack_names()
	return vim.iter(vim.pack.get())
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackClean", function()
	local names = get_inactive_pack_names()
	if vim.tbl_isempty(names) then
		vim.notify("No removed packages to clean")
		return
	end

	vim.pack.del(names)
	vim.notify("Removed packages: " .. table.concat(names, ", "))
end, { desc = "Delete removed packages" })

vim.api.nvim_create_user_command("PackSync", function()
	local names = get_inactive_pack_names()
	if not vim.tbl_isempty(names) then
		vim.pack.del(names)
		vim.notify("Removed packages: " .. table.concat(names, ", "))
	end

	vim.pack.update()
end, { desc = "Clean removed packages and update the rest" })
