-- Statusline: a faithful port of LazyVim's lualine to this vim.pack setup.
-- Source: LazyVim lua/lazyvim/plugins/ui.lua + util/lualine.lua + util/root.lua.
--
-- Everything that differs from upstream does so only because the plugin/util it
-- relied on isn't present here:
--   * Snacks.util.color(group)  -> fg(group), via lualine highlight extraction
--   * LazyVim.root.* / .norm    -> inlined get_root()
--   * Snacks.profiler.status()  -> omitted (no snacks.nvim)
--   * lazy.status updates       -> omitted (this config uses vim.pack, not lazy.nvim)
--   * trouble symbols           -> omitted (no trouble.nvim)
-- The noice and dap segments are copied verbatim and stay dormant until those
-- plugins are installed (guarded via package.loaded), exactly like upstream.

-- Nerd Font glyph + trailing space. Codepoints are kept explicit so the glyphs
-- survive editing; these are LazyVim's exact icons.
local function nf(cp)
  return vim.fn.nr2char(cp) .. " "
end

local icons = {
  diagnostics = {
    Error = nf(0xF057),
    Warn = nf(0xF071),
    Hint = nf(0xF0EB),
    Info = nf(0xF05A),
  },
  git = {
    added = nf(0xF0FE),
    modified = nf(0xF14B),
    removed = nf(0xF146),
  },
}

-- { fg = <fg of hl group> } color callback, replacing Snacks.util.color.
local function fg(name)
  return function()
    return { fg = require("lualine.utils.utils").extract_highlight_colors(name, "fg") }
  end
end

-- Verbatim port of LazyVim.lualine.format: caches a lualine highlight group
-- derived from an existing hl group so dir/filename can be styled.
local function format(component, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then
    return text
  end
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    local gui = vim.tbl_filter(function(x)
      return x
    end, {
      utils.extract_highlight_colors(hl_group, "bold") and "bold",
      utils.extract_highlight_colors(hl_group, "italic") and "italic",
    })
    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

-- LazyVim's root detection, condensed to its default spec { "lsp", { ".git",
-- "lua" }, "cwd" }: longest LSP root containing the buffer, else nearest marker
-- ancestor, else cwd.
local function get_root()
  local buf = vim.api.nvim_get_current_buf()
  local bufpath = vim.api.nvim_buf_get_name(buf)
  bufpath = bufpath ~= "" and vim.fs.normalize(bufpath) or nil

  local best
  if bufpath then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
      local dirs = {}
      for _, ws in ipairs(client.config.workspace_folders or {}) do
        dirs[#dirs + 1] = vim.uri_to_fname(ws.uri)
      end
      if client.config.root_dir then
        dirs[#dirs + 1] = client.config.root_dir
      end
      for _, d in ipairs(dirs) do
        d = vim.fs.normalize(d)
        if bufpath:find(d, 1, true) == 1 and (not best or #d > #best) then
          best = d
        end
      end
    end
  end

  if not best then
    local start = bufpath and vim.fs.dirname(bufpath) or vim.uv.cwd()
    best = vim.fs.root(start, { ".git", "lua" })
  end

  return vim.fs.normalize(best or vim.uv.cwd() or vim.fn.getcwd())
end

-- Verbatim port of LazyVim.lualine.root_dir.
local function root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = nf(0xF126D),
    color = fg("Special"),
  }, opts or {})

  local function get()
    local cwd = vim.fs.normalize(vim.uv.cwd() or vim.fn.getcwd())
    local root = get_root()
    local name = vim.fs.basename(root)

    if root == cwd then
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      return opts.parent and name
    else
      return opts.other and name
    end
  end

  return {
    function()
      return opts.icon .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    color = opts.color,
  }
end

-- Verbatim port of LazyVim.lualine.pretty_path, with LazyVim's root resolver
-- swapped for a plain cwd-relative path.
local function pretty_path(opts)
  opts = vim.tbl_extend("force", {
    modified_hl = "MatchParen",
    directory_hl = "",
    filename_hl = "Bold",
    modified_sign = "",
    readonly_icon = " " .. vim.fn.nr2char(0xF033E) .. " ",
    length = 3,
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p")
    if path == "" then
      return ""
    end

    path = vim.fs.normalize(path)
    local cwd = vim.fs.normalize(vim.uv.cwd() or vim.fn.getcwd())
    if path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    if opts.length ~= 0 and #parts > opts.length then
      parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. opts.modified_sign
      parts[#parts] = format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = format(self, parts[#parts], opts.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dir = format(self, dir .. sep, opts.directory_hl)
    end

    local readonly = ""
    if vim.bo.readonly then
      readonly = format(self, opts.readonly_icon, opts.modified_hl)
    end
    return dir .. parts[#parts] .. readonly
  end
end

return {
  packs = {
    GH("nvim-lualine/lualine.nvim"),
  },
  setup = function()
    -- Let lualine pick up mini.icons for filetype icons (e.g. the zig glyph).
    pcall(function()
      require("mini.icons").mock_nvim_web_devicons()
    end)

    vim.o.laststatus = 3

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { pretty_path() },
        },
        lualine_x = {
          -- noice command + mode (dormant unless noice.nvim is loaded)
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = fg("Statement"),
          },
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = fg("Constant"),
          },
          -- dap status (dormant unless nvim-dap is loaded)
          {
            function()
              return nf(0xF46F) .. " " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = fg("Debug"),
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return nf(0xF43A) .. os.date("%R")
          end,
        },
      },
      extensions = { "fzf" },
    })
  end,
}
