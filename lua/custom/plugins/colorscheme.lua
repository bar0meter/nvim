local gruvbox_material = {
  "sainnhe/gruvbox-material",
}

local tokyonight = {
  "folke/tokyonight.nvim",
}

local catppuccin = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

local rosepine = {
  "rose-pine/neovim",
  config = function()
    require("rose-pine").setup {
      disable_background = true,
      styles = {
        italic = false,
      },
    }
  end,
}

local nightfox = {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    }
  end,
}

local gruvbox = {
  "ellisonleao/gruvbox.nvim",
  config = function()
    -- Default options:
    require("gruvbox").setup {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = false,
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

return {
  gruvbox_material,
  tokyonight,
  rosepine,
  catppuccin,
  nightfox,
  gruvbox,
}
