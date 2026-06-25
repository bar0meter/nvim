-- Telescope extension wrapper for fuzzymenu.
-- Registers fuzzymenu as a first-class Telescope extension so it can be used as:
--   require("telescope").load_extension("fuzzymenu")
--   :Telescope fuzzymenu
--   :Telescope fuzzymenu menu
--   require("telescope").extensions.fuzzymenu.menu()

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("fuzzymenu requires telescope.nvim")
end

local fuzzymenu = require("fuzzymenu")

return telescope.register_extension({
    -- setup runs once when the extension is loaded; merge user opts into defaults.
    setup = function(ext_config)
        fuzzymenu.setup(ext_config)
    end,
    exports = {
        -- `:Telescope fuzzymenu` defaults to this (key matching the extension name).
        fuzzymenu = function(opts)
            fuzzymenu.open(opts)
        end,
        -- `:Telescope fuzzymenu menu`
        menu = function(opts)
            fuzzymenu.open(opts)
        end,
    },
})
