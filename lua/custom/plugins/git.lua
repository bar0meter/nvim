return {
  "rbong/vim-flog",
  lazy = false,
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "sindrets/diffview.nvim",
    "pwntester/octo.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("octo").setup {}
  end,
}
