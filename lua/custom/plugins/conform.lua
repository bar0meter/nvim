return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>fr",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    require("conform").setup {
      notify_on_error = false,
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sql_formatter" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
