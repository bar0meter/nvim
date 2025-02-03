local gruvbox = {
  "gruvbox-community/gruvbox",
  config = function() end,
}

local solarized = {
  "altercation/vim-colors-solarized",
}

local onedark = {
  "olimorris/onedarkpro.nvim",
}

local nord = {
  "gbprod/nord.nvim",
}

local colorbuddy = {
  "tjdevries/colorbuddy.nvim",
  config = function()
    local colorbuddy = require "colorbuddy"
    local Color = colorbuddy.Color
    local Group = colorbuddy.Group
    local c = colorbuddy.colors

    vim.cmd.colorscheme "gruvbuddy"
    Color.new("background", "#282c34")
    Color.new("gray0", "#282c34")

    Group.new("Normal", c.superwhite, c.gray0)

    vim.cmd [[
      hi LineNr guifg=#f8fe7a
      hi LineNrAbove guifg=#b0b1b0
      hi LineNrBelow guifg=#b0b1b0
    ]]
  end,
}

return {
  gruvbox,
  solarized,
  onedark,
  nord,
  -- colorbuddy,
}
