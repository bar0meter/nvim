-- Auto-load all plugin specs from lua/plugins/
-- Each file should return { packs = {...}, setup = function() ... end }

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local packs = {}
local setups = {}

for _, file in ipairs(vim.fn.glob(plugin_dir .. "/*.lua", true, true)) do
	local name = vim.fn.fnamemodify(file, ":t:r")
	local ok, spec = pcall(require, "plugins." .. name)
	if ok and spec then
		if spec.packs then
			vim.list_extend(packs, spec.packs)
		end
		if spec.setup then
			table.insert(setups, spec.setup)
		end
	end
end

vim.pack.add(packs, { load = true })

for _, setup in ipairs(setups) do
	setup()
end
