local deus = {
  "theniceboy/nvim-deus",
}

local vscode_modern = {
  "gmr458/vscode_modern_theme.nvim",
}

local vscode = {
  "Mofiqul/vscode.nvim",
}

local gruvbuddy = {
  "tjdevries/colorbuddy.nvim",
}

local kanagawa = {
  "rebelot/kanagawa.nvim",
  opts = {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = {
        wave = {},
        lotus = {},
        dragon = {},
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors) -- add/modify highlights
      local theme = colors.theme
      return {
        LineNr = { fg = colors.palette.dragonGray2 },
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        -- Damn Kanagawa doesn't auto-set StatusLine transparency even if transparent=true
        StatusLine = { bg = "none" },
        StatusLineNC = { bg = "none" },

        BufferTabpageFill = { bg = "none" },
        BufferOffset = { bg = "none" },
        BufferTabpages = { bg = "none" },

        -- Save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        WinSeparator = { fg = theme.ui.fg_dim, bg = "none" },
        NeoTreeWinSeparator = { fg = theme.ui.fg_dim, bg = "none" },
      }
    end,
    theme = "wave", -- Load "wave" theme when 'background' option is not set
    background = { -- map the value of 'background' option to a theme
      dark = "wave", -- try "dragon" !
      light = "lotus",
    },
  },
}

local gruvbox_material = {
  "sainnhe/gruvbox-material",
}

local nightfox = { "EdenEast/nightfox.nvim" }

local gruvbox = {
  "ellisonleao/gruvbox.nvim",
}

local tokyonight = {
  "folke/tokyonight.nvim",
}

local catppuccin = {
  "catppuccin/nvim",
}

local sitrunna = {
  "eemed/sitruuna.vim",
}

local monokai_pro = {
  "gthelding/monokai-pro.nvim",
  config = function()
    require("monokai-pro").setup {
      filter = "ristretto",
      override = function()
        return {
          NonText = { fg = "#948a8b" },
          MiniIconsGrey = { fg = "#948a8b" },
          MiniIconsRed = { fg = "#fd6883" },
          MiniIconsBlue = { fg = "#85dacc" },
          MiniIconsGreen = { fg = "#adda78" },
          MiniIconsYellow = { fg = "#f9cc6c" },
          MiniIconsOrange = { fg = "#f38d70" },
          MiniIconsPurple = { fg = "#a8a9eb" },
          MiniIconsAzure = { fg = "#a8a9eb" },
          MiniIconsCyan = { fg = "#85dacc" }, -- same value as MiniIconsBlue for consistency
        }
      end,
    }
  end,
}

local rose_pine = {
  "rose-pine/neovim",
  name = "rose-pine",
}

local bamboo = {
  "ribru17/bamboo.nvim",
}

local everforest = {
  "neanias/everforest-nvim",
}

local matteblack = {
  "tahayvr/matteblack.nvim",
}

return {
  gruvbox_material,
  nightfox,
  kanagawa,
  tokyonight,
  catppuccin,
  gruvbox,
  monokai_pro,
  rose_pine,
  bamboo,
  everforest,
  matteblack,
  sitrunna,
  gruvbuddy,
  vscode_modern,
  vscode,
}
