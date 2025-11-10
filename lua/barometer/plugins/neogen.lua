return {
  "danymat/neogen",
  cmd = "Neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = {
    {
      "<leader>dg",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
  config = function()
    require("neogen").setup {
      enabled = true,
      languages = {
        lua = { template = { annotation_convention = "ldoc" } },
        python = { template = { annotation_convention = "reST" } },
        javascript = { template = { annotation_convention = "jsdoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
      },
    }
  end,
}
