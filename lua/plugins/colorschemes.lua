-- One function per colorscheme, each owning its own tweaks.
-- Switch by changing `active` below.

local active = "zenburn"

local schemes = {}

schemes.zenburn = function()
  vim.cmd.colorscheme("zenburn")

  for _, name in ipairs({ "SignColumn", "EndOfBuffer", "LineNr" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    hl.bg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

return {
  packs = {
    GH("phha/zenburn.nvim"),
  },
  setup = function()
    schemes[active]()
  end,
}
