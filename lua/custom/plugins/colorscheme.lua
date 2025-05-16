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
    require("rose-pine").setup {}
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

return {
  gruvbox_material,
  tokyonight,
  rosepine,
  catppuccin,
  nightfox,
}
