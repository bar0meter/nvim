local devicons = { "nvim-tree/nvim-web-devicons" }

local nonicons = {
  "ya2s/nvim-nonicons",
  config = function()
    require("nvim-nonicons").setup()
  end,
}

return {
  -- devicons,
  -- nonicons,
}
