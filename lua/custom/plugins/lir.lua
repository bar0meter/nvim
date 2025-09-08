return {
  "tamago324/lir.nvim",
  config = function()
    local loaded, lir = pcall(require, "lir")
    if not loaded then
      return
    end

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local actions = require "lir.actions"
    lir.setup {
      show_hidden_files = true,
      mappings = {
        ["<CR>"] = actions.edit,
        ["-"] = actions.up,
        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["Y"] = actions.yank_path,
        ["D"] = actions.delete,
        ["."] = actions.toggle_show_hidden,
      },
    }

    vim.api.nvim_create_user_command("Lir", function()
      local directory = vim.fn.expand "%:p:h"
      vim.cmd.edit {
        args = { directory },
      }
    end, {})

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" and vim.bo.buftype == "" then
          vim.schedule(function()
            vim.cmd "Lir" -- open lir in the current directory
          end)
        end
      end,
    })

    vim.keymap.set("n", "-", ":edit %:h<CR>", { noremap = true })
  end,
}
