local blink_copilot = {
  "fang2hou/blink-copilot",
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end,
    },
  },
  config = function()
    require("blink-copilot").setup {}
  end,
}

local github_copilot = {
  "github/copilot.vim",
}

return {
  blink_copilot,
}
