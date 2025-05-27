return {
  -- amongst your other plugins
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      highlights = {
        Normal = {
          guibg = "#282828",
        },
      },
      shade_terminals = false,
      float_opts = {
        border = "none", -- thin border. Use "solid" for a really minimal look (NVIM 0.9+)
        winblend = 5,
        highlights = {
          border = "FloatBorder",
          background = "NormalFloat",
        },
        title_pos = "center",
      },
    }
  end,
}
