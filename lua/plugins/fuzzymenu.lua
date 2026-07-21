-- fuzzymenu: a fuzzymenu.vim-style action menu as a Telescope extension.
-- Engine lives in lua/fuzzymenu/, the extension in lua/telescope/_extensions/fuzzymenu.lua.

return {
    -- No `packs`: this is a local plugin. It depends on telescope, which is
    -- declared in plugins/telescope.lua and loaded before setups run.
    setup = function()
        local fzm = require("fuzzymenu")

        -- Register starter menu items. Add more from anywhere with fzm.add({...}).
        fzm.add({
            {
                category = "Files",
                name = "Find files",
                run = function()
                    require("telescope.builtin").find_files()
                end,
            },
            {
                category = "Files",
                name = "Recent files",
                run = function()
                    require("telescope.builtin").oldfiles()
                end,
            },
            {
                category = "Search",
                name = "Live grep",
                run = function()
                    require("telescope.builtin").live_grep()
                end,
            },
            {
                category = "Search",
                name = "Diagnostics",
                run = function()
                    require("telescope.builtin").diagnostics()
                end,
            },
            {
                category = "Buffers",
                name = "List buffers",
                run = function()
                    require("telescope.builtin").buffers()
                end,
            },
            {
                category = "Git",
                name = "Git files",
                run = function()
                    require("telescope.builtin").git_files()
                end,
            },
            {
                category = "LSP",
                name = "Toggle inlay hints",
                run = function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end,
            },
            {
                category = "Search",
                name = "Help tags",
                run = function()
                    require("telescope.builtin").help_tags()
                end,
            },
            {
                category = "Search",
                name = "Commands",
                run = function()
                    require("telescope.builtin").commands()
                end,
            },
            {
                category = "Search",
                name = "Keymaps",
                run = function()
                    require("telescope.builtin").keymaps()
                end,
            },
            {
                category = "Search",
                name = "Command history",
                run = function()
                    require("telescope.builtin").command_history()
                end,
            },
            {
                category = "UI",
                name = "Toggle folding",
                run = function()
                    vim.wo.foldenable = not vim.wo.foldenable
                end,
            },
            {
                category = "UI",
                name = "Colorscheme",
                run = function()
                    require("telescope.builtin").colorscheme({ enable_preview = true })
                end,
            },
            {
                category = "Config",
                name = "Edit Neovim config",
                run = function()
                    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
                end,
            },
            {
                category = "Config",
                name = "Reload config",
                run = function()
                    vim.cmd("update")
                    vim.cmd("source $MYVIMRC")
                end,
            },
            {
                category = "Config",
                name = "Update plugins",
                run = function()
                    vim.cmd("PackUpdate")
                end,
            },
            {
                category = "Config",
                name = "Clean plugins (remove unused)",
                run = function()
                    vim.cmd("PackClean")
                end,
            },
            {
                category = "Config",
                name = "Sync plugins (clean + update)",
                run = function()
                    vim.cmd("PackSync")
                end,
            },
        })

        -- Register as a Telescope extension.
        pcall(require("telescope").load_extension, "fuzzymenu")

        -- :Fzm command and keymap.
        vim.api.nvim_create_user_command("Fzm", function()
            fzm.open()
        end, { desc = "Open fuzzymenu" })

        vim.keymap.set("n", "<leader>fm", fzm.open, { desc = "Fuzzymenu" })
    end,
}
