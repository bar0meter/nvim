local typescript_tools = {
  "pmizio/typescript-tools.nvim",
  opts = {
    expose_as_code_action = "all",
    complete_function_calls = true,
    include_completions_with_insert_text = true,
  },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
}

return {}
