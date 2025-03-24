local wilder = {
  "gelguy/wilder.nvim",
  config = function()
    require("wilder").setup { modes = { ":", "/", "?" } }
  end,
}

return {
  wilder,
}
