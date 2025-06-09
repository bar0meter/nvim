return {
  "folke/lsp-trouble.nvim",
  config = function()
    require("trouble").setup {
      auto_preview = false,
      auto_close = true,
      action_keys = {
        -- default binding is <esc> for this and it confuses me endlessly that I
        -- can't just escape in that window.
        cancel = {},
      },
    }
  end,
}
