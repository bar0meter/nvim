return {
  packs = {
    GH("ajmwagar/vim-deus"),
    GH("EdenEast/nightfox.nvim"),
    GH("jnurmine/zenburn")
  },
  setup = function()
    vim.cmd.colorscheme("deus")
  end,
}
