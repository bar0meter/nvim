return {
    packs = {
        GH("nvim-treesitter/nvim-treesitter"),
    },
    setup = function()
        -- main branch API: install parsers, then start highlighting per-filetype.
        local langs = {
            "lua",
            "vim",
            "vimdoc",
            "go",
            "gomod",
            "bash",
            "json",
            "yaml",
            "toml",
            "markdown",
            "markdown_inline",
        }
        require("nvim-treesitter").install(langs)

        -- Start highlighting + treesitter indent for any buffer with a parser.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                if pcall(vim.treesitter.start, ev.buf) then
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
