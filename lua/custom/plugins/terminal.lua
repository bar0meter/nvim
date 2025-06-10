return {
  -- amongst your other plugins
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      highlights = {
        Normal = {
          guibg = "None",
        },
        FloatBorder = {
          guibg = "None",
        },
      },
      shade_terminals = false,
      float_opts = {
        border = "single", -- thin border. Use "solid" for a really minimal look (NVIM 0.9+)
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
