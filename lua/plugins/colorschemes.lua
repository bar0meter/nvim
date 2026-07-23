return {
  packs = {
    GH("ajmwagar/vim-deus"),
    GH("EdenEast/nightfox.nvim"),
    GH("jnurmine/zenburn"),
    GH("morhetz/gruvbox"),
    GH("navarasu/onedark.nvim")
  },
  setup = function()
    vim.cmd.colorscheme("onedark")
  end,
}
