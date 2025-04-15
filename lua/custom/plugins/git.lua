return {
  "rbong/vim-flog",
  lazy = false,
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "sindrets/diffview.nvim",
    "f-person/git-blame.nvim",
    "pwntester/octo.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("gitblame").setup {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <author> • <<sha>> • <date>", -- template for the blame message, check the Message template section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      message_when_not_committed = "",
      delay = 0,
      date_format = "%r",
    }
    require("octo").setup {}
  end,
}
