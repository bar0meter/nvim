return {
  packs = {
    GH("ajmwagar/vim-deus"),
    GH("EdenEast/nightfox.nvim"),
    GH("jnurmine/zenburn"),
    GH("morhetz/gruvbox")
  },
  setup = function()
    vim.cmd.colorscheme("duskfox")
  end,
}
