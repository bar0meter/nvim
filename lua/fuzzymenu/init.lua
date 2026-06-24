-- fuzzymenu: a fuzzymenu.vim-style action menu, powered by Telescope.
--
-- Register actions from anywhere:
--   require("fuzzymenu").add({
--     { category = "Git", name = "Status", run = function() vim.cmd("Git") end },
--   })
-- then open the menu with require("fuzzymenu").open() (or :Fzm).

local M = {}

-- Registry of menu items. Each item: { category = string, name = string, run = fn }
M.items = {}

-- Default picker opts, overridable via the Telescope extension's setup().
M.config = {}

--- Merge extension config (called by the Telescope extension on load_extension).
--- @param config table|nil
function M.setup(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

--- Register one or more menu items.
--- @param items table A single item or a list of items.
function M.add(items)
  -- Allow passing a single item table.
  if items.run then
    items = { items }
  end
  for _, item in ipairs(items) do
    assert(item.name, "fuzzymenu item requires a `name`")
    assert(type(item.run) == "function", "fuzzymenu item `run` must be a function")
    item.category = item.category or "General"
    table.insert(M.items, item)
  end
end

--- Open the menu in a Telescope picker.
--- @param opts table|nil Telescope picker opts.
function M.open(opts)
  opts = vim.tbl_deep_extend("force", M.config, opts or {})

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  -- Width of the widest category, for column alignment.
  local cat_width = 0
  for _, item in ipairs(M.items) do
    cat_width = math.max(cat_width, vim.fn.strdisplaywidth(item.category))
  end

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = cat_width },
      { remaining = true },
    },
  })

  pickers
    .new(opts, {
      prompt_title = "Fuzzymenu",
      finder = finders.new_table({
        results = M.items,
        entry_maker = function(item)
          return {
            value = item,
            ordinal = item.category .. " " .. item.name,
            display = function(_)
              return displayer({
                { item.category, "TelescopeResultsIdentifier" },
                item.name,
              })
            end,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            selection.value.run()
          end
        end)
        return true
      end,
    })
    :find()
end

return M
