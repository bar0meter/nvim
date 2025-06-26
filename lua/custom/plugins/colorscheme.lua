local gruvbuddy = {
  "tjdevries/colorbuddy.nvim",
  config = function()
    require("colorbuddy").colorscheme "gruvbuddy"

    vim.cmd [[
      colorscheme gruvbuddy
    ]]
    local colorbuddy = require "colorbuddy"
    local c = colorbuddy.colors
    local s = colorbuddy.styles
    local Color = colorbuddy.Color
    local Group = colorbuddy.Group
    Color.new("background", "#282c34")
    Color.new("line_fg", "#565c64") -- Subtle line numbers

    -- Set background via Normal group
    Group.new("Normal", c.superwhite, c.background)

    -- Update LineNr to use the same background
    Group.new("LineNr", c.line_fg, c.background)
    Group.new("CursorLineNr", c.yellow, nil, s.bold)
    Group.new("CursorLine", nil, c.background:light(0.1))
  end,
}

return {
  gruvbuddy,
}
