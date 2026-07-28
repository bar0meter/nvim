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

    local background_string = "#2f323b"
    Color.new("background", background_string)
    Color.new("gray0", background_string)

    -- Re-apply all groups so the new gray0 propagates to NormalFloat, PMenuSbar, etc.
    for _, grp in pairs(require("colorbuddy.group").groups) do
      grp:apply()
    end

    Color.new("statusline", "#90a9c3")
    Group.new("StatusLine", c.gray0, c.statusline)
    Group.new("StatusLineNC", c.gray0, c.statusline:dark())

    -- express_line mode badge: bold accent text on the editor background
    Group.new("ElNormal", c.blue, c.gray0, s.bold)
    Group.new("ElInsert", c.green, c.gray0, s.bold)
    Group.new("ElVisual", c.orange, c.gray0, s.bold)
    Group.new("ElVisualLine", g.ElVisual, g.ElVisual, s.bold)
    Group.new("ElVisualBlock", g.ElVisual, g.ElVisual, s.bold)
    Group.new("ElSelect", g.ElVisual, g.ElVisual, s.bold)
    Group.new("ElCommand", c.yellow, c.gray0, s.bold)
    Group.new("ElReplace", c.red, c.gray0, s.bold)
    Group.new("ElVirtualReplace", g.ElReplace, g.ElReplace, s.bold)
    Group.new("ElTerm", c.purple, c.gray0, s.bold)

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

    -- disable italics across the colorscheme (colorbuddy sets them under `cterm`)
    for name, def in pairs(vim.api.nvim_get_hl(0, {})) do
      if def.italic or (def.cterm and def.cterm.italic) then
        def.italic = nil
        if def.cterm then
          def.cterm.italic = nil
        end
        vim.api.nvim_set_hl(0, name, def)
      end
    end
  end,
}
