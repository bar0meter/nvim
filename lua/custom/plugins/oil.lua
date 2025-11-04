return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>ee",
        function()
          local oil = require "oil"
          local bufnr = vim.api.nvim_get_current_buf()
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          -- Check if the current buffer is an oil buffer
          if bufname:match "^oil://" then
            -- If it's open, close it
            oil.close()
          else
            -- If it's not open, open it as a floating window
            oil.open_float()
          end
        end,
        desc = "Toggle Oil floating file explorer",
      },
    },
    config = function()
      require("oil").setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirms_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == ".DS_Store" or name == ".git"
          end,
        },
        win_options = {
          wrap = true,
        },
        -- Floating window options
        float = {
          padding = 2,
          max_width = 40,
          max_height = 15,
          border = "double", -- Options: "none", "single", "double", "rounded", etc.
          win_options = {
            winblend = 0, -- Transparency
          },
        },
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
      }

      vim.keymap.set("n", "-", function()
        require("oil").open(vim.fn.expand "%:p:h")
      end, { desc = "Open Oil in current file's directory" })
    end,
  },
}
