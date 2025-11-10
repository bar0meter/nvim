return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_diagnostic_signs = true,
    fold_open = "",
    fold_closed = "",
    indent_lines = true,
    signs = {
      error = "",
      warning = "",
      hint = "",
      information = "",
    },
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "│  ",
      },
    },
    position = "bottom",
    height = 10,
    width = 50,
    mode = "diagnostics_buffer",
    modes = {
      -- v3-style minimal look
      diagnostics = {
        groups = {
          { "filename", format = "{file_icon} {basename:Title} {count}" },
        },
      },

      -- Inline split preview on the right
      test = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },

      -- Diagnostics only for current buffer
      diagnostics_buffer = {
        mode = "diagnostics",
        filter = { buf = 0 },
      },

      -- Errors from current buffer and project-wide errors
      mydiags = {
        mode = "diagnostics",
        filter = {
          any = {
            buf = 0, -- current buffer
            {
              severity = vim.diagnostic.severity.ERROR,
              function(item)
                return item.filename:find((vim.uv or vim.loop).cwd(), 1, true)
              end,
            },
          },
        },
      },
    },
  }, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
