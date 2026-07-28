return {
  packs = {
    GH("tjdevries/colorbuddy.nvim")
  },
  setup = function()
    local colorbuddy = require("colorbuddy")
    local Color = colorbuddy.Color
    local Group = colorbuddy.Group
    local c = colorbuddy.colors
    local g = colorbuddy.groups
    local s = colorbuddy.styles

    vim.cmd.colorscheme("gruvbuddy")

    local background_string = "#282c34"
    Color.new("background", background_string)
    Color.new("gray0", background_string)

    -- Re-apply all groups so the new gray0 propagates to NormalFloat, PMenuSbar, etc.
    for _, grp in pairs(require("colorbuddy.group").groups) do
      grp:apply()
    end

    Group.new("StatusLine", c.gray5, c.gray2)
    Group.new("StatusLineNC", c.gray3, c.gray1)

    Group.new("LineNr", c.gray0:light():light():light(), c.gray0)
    Group.new("CursorLineNr", c.yellow, c.gray0)

    Group.new("@constant", c.orange, nil, s.none)
    Group.new("@function", c.yellow, nil, s.none)
    Group.new("@function.bracket", g.Normal, g.Normal)
    Group.new("@keyword", c.violet, nil, s.none)
    Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
    Group.new("@property", c.blue)
    Group.new("@variable", c.superwhite, nil)
    Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

    -- I've always liked lua function calls to be blue. I don't know why.
    Group.new("@function.call.lua", c.blue:dark(), nil, nil)
  end,
}
