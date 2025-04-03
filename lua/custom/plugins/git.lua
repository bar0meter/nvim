return {
  "rbong/vim-flog",
  lazy = false,
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = {
    "tpope/vim-fugitive",
    "sindrets/diffview.nvim",
    "f-person/git-blame.nvim",
  },
}
