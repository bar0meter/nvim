return {
  packs = {
    GH("ajmwagar/vim-deus"),
    GH("EdenEast/nightfox.nvim"),
    GH("rebelot/kanagawa.nvim"),
    GH("mofiqul/vscode.nvim"),
    GH("ellisonleao/gruvbox.nvim"),
    GH("sainnhe/gruvbox-material"),
    GH("neanias/everforest-nvim"),
    GH("sainnhe/sonokai"),
    GH("sainnhe/edge"),
    GH("folke/tokyonight.nvim")
  },
  setup = function()
    require("gruvbox").setup({
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "",  -- can be "hard", "soft" or empty string
    })

    vim.g.gruvbox_material_disable_italic_comment = true

    vim.cmd.colorscheme("deus")
  end,
}
