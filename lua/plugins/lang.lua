return {
    packs = {
        GH("olexsmir/gopher.nvim"),
        GH("diepm/vim-rest-console"),
    },
    setup = function()
        -- vim-rest-console: output body only, no headers, no status line
        vim.g.vrc_show_command = 0
        vim.g.vrc_curl_opts = { ["-s"] = "" }
        vim.g.vrc_auto_format_response_patterns = { json = "jq ." }
        vim.g.vrc_output_buffer_name = "__VRC_OUTPUT.json"

        require("gopher").setup({})

        -- Surface Go (gopher.nvim) actions in the fuzzymenu.
        local ok, fzm = pcall(require, "fuzzymenu")
        if ok then
            fzm.add({
                {
                    category = "Go",
                    name = "Add test for function",
                    run = function()
                        vim.cmd("GoTestAdd")
                    end,
                },
                {
                    category = "Go",
                    name = "Add tests for all functions",
                    run = function()
                        vim.cmd("GoTestsAll")
                    end,
                },
                {
                    category = "Go",
                    name = "Add tests for exported",
                    run = function()
                        vim.cmd("GoTestsExp")
                    end,
                },
                {
                    category = "Go",
                    name = "Tidy modules",
                    run = function()
                        vim.cmd("GoMod tidy")
                    end,
                },
                {
                    category = "Go",
                    name = "Add json struct tags",
                    run = function()
                        vim.cmd("GoTagsAdd json")
                    end,
                },
                {
                    category = "Go",
                    name = "Generate if-err block",
                    run = function()
                        vim.cmd("GoIfErr")
                    end,
                },
            })
        end
    end,
}
