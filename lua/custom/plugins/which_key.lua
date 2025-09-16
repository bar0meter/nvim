return {
  "folke/which-key.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "folke/todo-comments.nvim" },
  config = function()
    require("which-key").setup {}
  end,
}
