return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup {
      options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp", -- or "coc" / "ale"
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match "error" and " " or level:match "warning" and " " or ""
          return " " .. icon .. count
        end,
      },
    }
  end,
}
