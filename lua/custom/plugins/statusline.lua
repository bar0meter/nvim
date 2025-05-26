local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- options: 0 = just filename, 1 = relative path, 2 = absolute path, 3 = short path
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
      },
    }
  end,
}

return {
  lualine,
}
