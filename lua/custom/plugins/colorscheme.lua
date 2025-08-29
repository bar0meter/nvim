local gruvbuddy = {
  "tjdevries/colorbuddy.nvim",
  config = function()
    require("colorbuddy").colorscheme "gruvbuddy"

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

local onedarkpro = {
  "olimorris/onedarkpro.nvim",
  config = function()
    require("onedarkpro").setup {
      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = false, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    }
  end,
}

local kanagawa = {
  "rebelot/kanagawa.nvim",
}

local gruvbox_material = {
  "sainnhe/gruvbox-material",
}

local nightfox = { "EdenEast/nightfox.nvim" }

local gruvbox = {
  "ellisonleao/gruvbox.nvim",
  config = function()
    require("gruvbox").setup {
      terminal_colors = false, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    }
  end,
}

local solarized = {
  "maxmx03/solarized.nvim",
}

return {
  gruvbuddy,
  gruvbox_material,
  onedarkpro,
  nightfox,
}
