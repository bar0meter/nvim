local kanagawa = {
  "rebelot/kanagawa.nvim",
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
}
