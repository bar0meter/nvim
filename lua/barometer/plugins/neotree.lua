return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = true, -- Load only when called explicitly
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
    filesystem = {
      hijack_netrw_behavior = "disabled",
      follow_current_file = {
        enabled = true, -- <- auto-focus the file in tree
      },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Save current window
        local current_win = vim.api.nvim_get_current_win()

        -- Open Neo-tree and reveal current file
        -- require("neo-tree.command").execute({
        -- 	action = "show",
        -- 	source = "filesystem",
        -- 	reveal = true,
        -- })
        --
        -- -- Restore focus back to original window
        -- vim.defer_fn(function()
        -- 	vim.api.nvim_set_current_win(current_win)
        -- end, 50)
      end,
    })
  end,
}
