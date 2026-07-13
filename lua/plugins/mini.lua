return {
    packs = {
        GH("nvim-mini/mini.nvim"),
    },
    setup = function()
        require("mini.ai").setup()
        require("mini.pairs").setup()
        require("mini.surround").setup()
        require("mini.jump").setup()
        require("mini.icons").setup()
        require("mini.tabline").setup()
        require("mini.completion").setup()
        require("mini.comment").setup()
        -- vim-airline "dark" theme reimplemented on mini.statusline
        -- (airline layout + palette + powerline arrows). Needs a nerd/powerline font.
        local ministatusline = require("mini.statusline")
        local RIGHT, LEFT = "", "" -- powerline separators U+E0B0 / U+E0B2

        ministatusline.setup({
            content = {
                active = function()
                    local mode, mode_hl = ministatusline.section_mode({ trunc_width = 120 })
                    local branch = vim.b.airline_branch or ""
                    local git = branch ~= "" and (" " .. branch) or "" -- nerd-font branch glyph
                    local diff = ministatusline.section_diff({ trunc_width = 75 })
                    local diagnostics = ministatusline.section_diagnostics({ trunc_width = 75 })
                    local lsp = ministatusline.section_lsp({ trunc_width = 75, icon = "LSP" })
                    local filename = ministatusline.section_filename({ trunc_width = 140 })
                    local fileinfo = ministatusline.section_fileinfo({ trunc_width = 120 })
                    local location = ministatusline.section_location({ trunc_width = 75 })
                    local search = ministatusline.section_searchcount({ trunc_width = 75 })

                    local nonempty = function(parts)
                        return table.concat(
                            vim.tbl_filter(function(s)
                                return s ~= nil and s ~= ""
                            end, parts),
                            " "
                        )
                    end
                    local devinfo = nonempty({ git, diff, diagnostics, lsp })
                    local right = nonempty({ search, location })
                    local sep_mode = mode_hl:gsub("Mode", "Sep") -- e.g. MiniStatuslineSepNormal

                    -- section b (devinfo) collapses when empty: mode arrows straight into filename
                    local left
                    if devinfo ~= "" then
                        left = {
                            "%#",
                            sep_mode,
                            "#",
                            RIGHT,
                            "%#MiniStatuslineDevinfo# ",
                            devinfo,
                            " ",
                            "%#MiniStatuslineSepBC#",
                            RIGHT,
                        }
                    else
                        left = { "%#", mode_hl:gsub("Mode", "SepC"), "#", RIGHT }
                    end

                    return table.concat({
                        "%#",
                        mode_hl,
                        "# ",
                        mode,
                        " ",
                        table.concat(left),
                        "%#MiniStatuslineFilename# %<",
                        filename,
                        " ",
                        "%#MiniStatuslineFilename#%=",
                        "%#MiniStatuslineSepBC#",
                        LEFT,
                        "%#MiniStatuslineFileinfo# ",
                        fileinfo,
                        " ",
                        "%#",
                        sep_mode,
                        "#",
                        LEFT,
                        "%#",
                        mode_hl,
                        "# ",
                        right,
                        " ",
                    })
                end,
            },
        })

        -- airline "dark" palette (guifg, guibg, ctermfg, ctermbg)
        local p = {
            ModeNormal = { fg = "#00005f", bg = "#dfff00", ctermfg = 17, ctermbg = 190 },
            ModeInsert = { fg = "#00005f", bg = "#00dfff", ctermfg = 17, ctermbg = 45 },
            ModeVisual = { fg = "#000000", bg = "#ffaf00", ctermfg = 232, ctermbg = 214 },
            ModeReplace = { fg = "#ffffff", bg = "#af0000", ctermfg = 255, ctermbg = 124 },
            ModeCommand = { fg = "#00005f", bg = "#afd700", ctermfg = 17, ctermbg = 148 },
            ModeOther = { fg = "#000000", bg = "#ffaf00", ctermfg = 232, ctermbg = 214 },
            Devinfo = { fg = "#ffffff", bg = "#444444", ctermfg = 255, ctermbg = 238 },
            Fileinfo = { fg = "#ffffff", bg = "#444444", ctermfg = 255, ctermbg = 238 },
            Filename = { fg = "#9cffd3", bg = "#202020", ctermfg = 85, ctermbg = 234 },
            Inactive = { fg = "#4e4e4e", bg = "#1c1c1c", ctermfg = 239, ctermbg = 234 },
        }
        local function set_airline_hl()
            local set = vim.api.nvim_set_hl
            for name, c in pairs(p) do
                set(0, "MiniStatusline" .. name, c)
            end
            -- fixed B→C (and fill→Y) separator: fg = section-b bg, bg = section-c bg
            set(0, "MiniStatuslineSepBC", {
                fg = p.Devinfo.bg,
                bg = p.Filename.bg,
                ctermfg = p.Devinfo.ctermbg,
                ctermbg = p.Filename.ctermbg,
            })
            for _, m in ipairs({ "Normal", "Insert", "Visual", "Replace", "Command", "Other" }) do
                local mode = p["Mode" .. m]
                -- A→B / Y→Z separator: fg = mode bg, bg = section-b bg
                set(0, "MiniStatuslineSep" .. m, {
                    fg = mode.bg,
                    bg = p.Devinfo.bg,
                    ctermfg = mode.ctermbg,
                    ctermbg = p.Devinfo.ctermbg,
                })
                -- A→C separator (when section b collapses): fg = mode bg, bg = section-c bg
                set(0, "MiniStatuslineSepC" .. m, {
                    fg = mode.bg,
                    bg = p.Filename.bg,
                    ctermfg = mode.ctermbg,
                    ctermbg = p.Filename.ctermbg,
                })
            end
        end
        set_airline_hl()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_airline_hl })

        -- git branch for the statusline, cached per buffer (mini.git/gitsigns not set up).
        -- Works for oil buffers too by resolving the "oil://" path. ponytail: shells out
        -- only on these events, not on every redraw, and async so a slow git/disk never
        -- blocks BufEnter/FocusGained (was a synchronous systemlist -> startup/UI stalls).
        vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "FocusGained", "BufWritePost" }, {
            callback = function(ev)
                local name = vim.api.nvim_buf_get_name(ev.buf)
                local dir = name:match("^oil://(.*)")
                    or (name ~= "" and vim.fn.fnamemodify(name, ":h"))
                    or vim.fn.getcwd()
                if vim.fn.isdirectory(dir) == 0 then
                    dir = vim.fn.getcwd()
                end
                vim.system({ "git", "-C", dir, "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }, function(r)
                    vim.schedule(function()
                        if not vim.api.nvim_buf_is_valid(ev.buf) then
                            return
                        end
                        vim.b[ev.buf].airline_branch = (r.code == 0 and vim.trim(r.stdout or "")) or ""
                        vim.cmd("redrawstatus")
                    end)
                end)
            end,
        })

        require("mini.files").setup({
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 30,
            },
            options = {
                use_as_default_explorer = true,
            },
        })

        vim.api.nvim_create_user_command("Files", function()
            local mini = require("mini.files")
            mini.open(vim.api.nvim_buf_get_name(0), true)
            mini.reveal_cwd()
        end, { desc = "Open mini.files" })

        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- `[` and `]` keys
                { mode = "n", keys = "[" },
                { mode = "n", keys = "]" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "x", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            window = {
                delay = 250,
            },

            clues = {
                miniclue.gen_clues.square_brackets(),
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
        })

        local function pum_accept(fallback)
            return function()
                if vim.fn.pumvisible() == 0 then
                    return fallback
                end
                if vim.fn.complete_info({ "selected" }).selected == -1 then
                    return "<C-n><C-y>"
                end
                return "<C-y>"
            end
        end

        local opts = { expr = true, replace_keycodes = true }
        vim.keymap.set("i", "<CR>", pum_accept("<CR>"), opts)
        vim.keymap.set("i", "<Tab>", pum_accept("<Tab>"), opts)
        vim.keymap.set("i", "<C-y>", pum_accept("<C-y>"), opts)
    end,
}
