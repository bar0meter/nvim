return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>fr",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    local setup = function()
      -- Autoformatting Setup
      local conform = require "conform"
      conform.setup {
        formatters = {
          ["ml-format"] = {
            command = "./_build/_private/default/.dev-tool/ocamlformat/ocamlformat/target/bin/ocamlformat",
            args = {
              "--enable-outside-detected-project",
              "--name",
              "$FILENAME",
              "-",
            },
          },
          prettier = {
            command = "prettier",
            args = { "--stdin-filepath", "$FILENAME", "--loglevel", "debug" },
            cwd = require("conform.util").root_file { ".prettierrc", ".prettierrc.yaml", "package.json", ".git" },
            condition = function(ctx)
              -- vim.notify("[Conform] Running prettier on " .. vim.inspect(ctx))
              return true
            end,
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          blade = { "blade-formatter" },
          ocaml = { "ml-format" },
          ocaml_mlx = { "ocamlformat_mlx" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          html = { "prettier" },
        },
      }

      conform.formatters.injected = {
        options = {
          ignore_errors = false,
          lang_to_formatters = {
            sql = { "sleek" },
          },
        },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
        callback = function(args)
          local ft = vim.bo.filetype
          if ft == "blade" then
            require("conform").format {
              bufnr = args.buf,
              lsp_fallback = false,
              quiet = true,
              async = true,
            }

            return
          end

          if ft == "ocaml.mlx" then
            -- Hmmm... this is a little weird,
            -- it seems like it should be automatic, but that's OK
            require("conform").format {
              bufnr = args.buf,
              formatters = { "ocamlformat_mlx" },
              lsp_fallback = false,
            }

            return
          end

          require("conform").format {
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          }
        end,
      })
    end

    setup()

    return { setup = setup }
  end,
}
