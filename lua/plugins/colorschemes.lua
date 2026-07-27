return {
  packs = {
    GH("ajmwagar/vim-deus"),
    GH("EdenEast/nightfox.nvim"),
    GH("jnurmine/zenburn"),
    GH("morhetz/gruvbox"),
    GH("navarasu/onedark.nvim"),
    GH("kepano/flexoki-neovim"),
    GH("rose-pine/neovim"),
    GH("folke/tokyonight.nvim")
  },
  setup = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}
