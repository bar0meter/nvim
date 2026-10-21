-- One function per colorscheme, each owning its own tweaks.
-- Switch by changing `active` below.

local active = "gruvbox"

local schemes = {}

schemes.zenburn = function()
  vim.cmd.colorscheme("zenburn")

  for _, name in ipairs({ "SignColumn", "EndOfBuffer", "LineNr" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    hl.bg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end

  vim.api.nvim_set_hl(0, "StatusLine", { bg = "#3c3836", fg = "#ebdbb2" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#32302f", fg = "#928374" })
end

schemes.deus = function()
  vim.cmd.colorscheme("deus")
end

schemes.everforest = function()
  vim.o.background = "dark"
  vim.cmd.colorscheme("everforest")
end

schemes.gruvbox = function()
  vim.o.background = "dark"
  require("gruvbox").setup({ contrast = "hard" })
  vim.cmd.colorscheme("gruvbox")
end

return {
  packs = {
    GH("phha/zenburn.nvim"),
    GH("ajmwagar/vim-deus"),
    GH("sainnhe/everforest"),
    GH("ellisonleao/gruvbox.nvim"),
  },
  setup = function()
    schemes[active]()
  end,
}
