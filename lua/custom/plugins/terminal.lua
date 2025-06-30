local terminal = {
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
      shade_terminals = true,
      shade_factor = 1,
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

return {}
