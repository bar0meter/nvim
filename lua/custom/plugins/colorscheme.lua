local gruvbox_material = {
  "sainnhe/gruvbox-material",
}

local tokyonight = {
  "folke/tokyonight.nvim",
}

local gruvbuddy = {
  "tjdevries/colorbuddy.nvim",
}

local gruvbox = {
  "ellisonleao/gruvbox.nvim",
  config = function()
    -- Default options:
    require("gruvbox").setup {
      terminal_colors = false, -- add neovim terminal colors
      undercurl = true,
      underline = false,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
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

return {
  gruvbox_material,
  gruvbox,
  gruvbuddy,
  tokyonight,
}
