return {
  -- amongst your other plugins
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      float_opts = {
        border = "none", -- removes the border
      },
    }
  end,
}
