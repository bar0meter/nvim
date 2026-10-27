-- Adapted from LazyVim's lua/lazyvim/plugins/{ui,util}.lua for vim.pack.
return {
  packs = {
    GH("folke/snacks.nvim"),
    GH("nvim-lualine/lualine.nvim"),
  },
  setup = function()
    require("snacks").setup({
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    })
    vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
    vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
    vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
    vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
        },
        lualine_x = {
          Snacks.profiler.status(),
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = { function() return " " .. os.date("%R") end },
      },
      extensions = { "oil", "quickfix" },
    })
  end,
}
