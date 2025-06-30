-------------------------------------------------------------------------------
-- Semantic Highlighting
-------------------------------------------------------------------------------
local links = {
  ["@lsp.type.namespace"] = "@namespace",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.struct"] = "@structure",
  ["@lsp.type.parameter"] = "Normal",
  ["@lsp.type.variable"] = "@variable",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.method"] = "@method",
  ["@lsp.type.macro"] = "@macro",
  ["@lsp.type.decorator"] = "@function",
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

local schemastore = {
  "b0o/schemastore.nvim",
  config = function()
    require("lspconfig").jsonls.setup {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    require("lspconfig").yamlls.setup {
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    }
  end,
}
local scala_metals = {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}

local jdtls = {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  opts = {
    root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  },
  config = function(_, opts)
    local resolve_opts = function()
      local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      if vim.loop.fs_stat(workspace_dir) == nil then
        os.execute("mkdir " .. workspace_dir)
      end
      local nvim_root = vim.fn.expand "$HOME/.config/nvim"
      local install_path = nvim_root .. "/resources/jdtls"
      local os
      if vim.fn.has "macunix" then
        os = "mac_arm"
      else
        os = "linux"
      end

      return {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. install_path .. "/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          install_path .. "/config_" .. os,
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
      }
    end
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "java", -- autocmd to start jdtls
      callback = function()
        local start_opts = resolve_opts()
        require("jdtls").start_or_attach(start_opts)
      end,
    })
  end,
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "")

        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
      return
    end

    lspconfig.gleam.setup {
      cmd = { "gleam", "lsp" },
      filetypes = { "gleam" },
      root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
    }

    local servers =
      {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT", -- Neovim uses LuaJIT
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },

        gopls = {
          settings = {
            gopls = {
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
            },
          },
        },

        jinja_lsp = {},

        pyright = {},

        terraformls = {},

        eslint = {},

        bashls = {},
      },
      --  You can press `g?` for help in this menu.
      require("mason").setup {}

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.handlers = {
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              if result.diagnostics == nil then
                return
              end

              -- Filter out non-error diagnostics (show only errors)
              local filtered_diagnostics = {}
              for i, diagnostic in ipairs(result.diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  table.insert(filtered_diagnostics, diagnostic)
                end
              end

              result.diagnostics = filtered_diagnostics
              result.virtual_text = false

              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end,
          }
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }

    -- Disable semantic highlighting for all LSPs
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })

    vim.diagnostic.config {
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      signs = true,
      underline = true,
      virtual_text = false,
    }

    local function define_sign(name, icon)
      vim.fn.sign_define(name, {
        text = icon,
        texthl = name,
        numhl = "",
      })
    end

    define_sign("DiagnosticSignError", "")
    define_sign("DiagnosticSignWarn", "")
    define_sign("DiagnosticSignHint", "")
    define_sign("DiagnosticSignInfo", "")
  end,
}

return {
  jdtls,
  lspconfig,
  scala_metals,
  schemastore,
}
