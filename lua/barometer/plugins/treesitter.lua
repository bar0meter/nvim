local treesitter = { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      disable = {},
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
    local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

    require("nvim-treesitter").setup {
      ensure_install = {
        "core",
        "stable",
        -- Elixir langs
        "elixir",
        "heex",
      },
    }

    local syntax_on = {
      elixir = true,
      php = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
          return
        end
        pcall(vim.treesitter.start)

        local ft = vim.bo[bufnr].filetype
        if syntax_on[ft] then
          vim.bo[bufnr].syntax = "on"
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "TSUpdate",
      callback = function()
        local parsers = require "nvim-treesitter.parsers"

        parsers.lua = {
          tier = 0,

          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            path = "~/plugins/tree-sitter-lua",
            files = { "src/parser.c", "src/scanner.c" },
          },
        }

        parsers.cram = {
          tier = 0,

          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            path = "~/git/tree-sitter-cram",
            files = { "src/parser.c" },
          },
        }

        parsers.reason = {
          tier = 0,

          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            url = "https://github.com/reasonml-editor/tree-sitter-reason",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "master",
          },
        }

        parsers.blade = {
          tier = 0,

          ---@diagnostic disable-next-line: missing-fields
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade",
        }
      end,
    })

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}

return {
  treesitter,
}
