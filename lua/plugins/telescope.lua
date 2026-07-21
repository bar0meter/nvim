return {
    packs = {
        GH("nvim-lua/plenary.nvim"),
        GH("nvim-telescope/telescope.nvim"),
        GH("nvim-telescope/telescope-fzf-native.nvim"),
        GH("nvim-telescope/telescope-ui-select.nvim"),
    },
    setup = function()
        require("telescope").setup({
            defaults = {},
            extensions = {
                fzf = {},
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            pickers = {
                live_grep = {
                    file_ignore_patterns = { "node_modules", ".git" },
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                },
                find_files = {
                    file_ignore_patterns = { "node_modules", ".git" },
                    hidden = true,
                },
            },
        })

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
    end,
}
