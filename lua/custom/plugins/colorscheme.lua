local gruvbox = {
  "gruvbox-community/gruvbox",
  config = function() end,
}

local nord = {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
        borders = true, -- Enable the border between verticaly split windows visible
        errors = { mode = "bg" }, -- Display mode for errors and diagnostics
        -- values : [bg|fg|none]
        search = { theme = "vim" }, -- theme for highlighting search results
        -- values : [vim|vscode]
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},

          -- To customize lualine/bufferline
          bufferline = {
            current = {},
            modified = { italic = true },
          },
        },

        -- colorblind mode
        -- see https://github.com/EdenEast/nightfox.nvim#colorblind
        -- simulation mode has not been implemented yet.
        colorblind = {
          enable = false,
          preserve_background = false,
          severity = {
            protan = 0.0,
            deutan = 0.0,
            tritan = 0.0,
          },
        },

        -- Override the default colors
        ---@param colors Nord.Palette
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with all highlights and the colorScheme table
        ---@param colors Nord.Palette
        on_highlights = function(highlights, colors) end,
      }
    end,
  },
}

local lackluster = {
  "slugbyte/lackluster.nvim",
  config = function()
    local lackluster = require "lackluster"

    local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9

    -- !must called setup() before setting the colorscheme!
    lackluster.setup {
      -- You can overwrite the following syntax colors by setting them to one of...
      --   1) a hexcode like "#a1b2c3" for a custom color.
      --   2) "default" or nil will just use whatever lackluster's default is.
      tweak_syntax = {
        string = "default",
        -- string = "#a1b2c3", -- custom hexcode
        -- string = color.green, -- lackluster color
        string_escape = "default",
        comment = "default",
        builtin = "default", -- builtin modules and functions
        type = "default",
        keyword = "default",
        keyword_return = "default",
        keyword_exception = "default",
      },
      -- You can overwrite the following background colors by setting them to one of...
      --   1) a hexcode like "#a1b2c3" for a custom color
      --   2) "none" for transparency
      --   3) "default" or nil will just use whatever lackluster's default is.
      tweak_background = {
        normal = "default", -- main background
        -- normal = 'none',    -- transparent
        -- normal = '#a1b2c3',    -- hexcode
        -- normal = color.green,    -- lackluster color
        telescope = "default", -- telescope
        menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
        popup = "default", -- lazy, mason, whichkey ... (bad idea to transparent)
      },
    }
  end,
}

local rosepine = {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup {
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    }
  end,
}

return {
  gruvbox,
  rosepine,
  lackluster,
  nord,
}
