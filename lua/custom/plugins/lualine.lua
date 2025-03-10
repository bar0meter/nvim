return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require "lualine"
    local lazy_status = require "lazy.status"
    local function maximize_status()
      return vim.t.maximized and "Maximized   " or ""
    end
    local function split(str, delimiter)
      local result = {}
      for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
      end
      return result
    end

    lualine.setup {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dapui_stacks",
          "dap-repl",
          "Avante",
          "AvanteInput",
        },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_y = {},
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
    }
  end,
}
