-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            -- defer centering slightly so it's applied after render
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- enforce a uniform indent width (built-in ftplugins set 4 for python,
-- markdown, rust, ... — re-assert 2 after they run). expandtab is left to the
-- global option / ftplugin so tab-required filetypes (go, make) keep real tabs.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("indent_width", { clear = true }),
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- show cursorline only in active window enable
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--  	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
--  	callback = function()
--  		vim.opt_local.cursorline = true
--  	end,
-- })

-- show cursorline only in active window disable
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
-- 	group = "active_cursorline",
-- 	callback = function()
-- 		vim.opt_local.cursorline = false
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

-- welcome screen when nvim opens with no arguments
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() ~= 0 then
            return
        end

        vim.cmd("enew")
        local lines = {
            "Welcome back, commander.",
        }
        local width = vim.api.nvim_win_get_width(0)
        local height = vim.api.nvim_win_get_height(0)
        local centered = {}

        for _, line in ipairs(lines) do
            local padding = math.floor((width - vim.api.nvim_strwidth(line)) / 2)
            if line == "" or padding <= 0 then
                table.insert(centered, line)
            else
                table.insert(centered, string.rep(" ", padding) .. line)
            end
        end

        local top_padding = math.floor((height - #centered * 2) / 2)
        for _ = 1, top_padding do
            table.insert(centered, 1, "")
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, centered)
        local buf = vim.api.nvim_get_current_buf()
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "hide"
        vim.bo[buf].swapfile = false
        vim.bo[buf].modifiable = false
        vim.bo[buf].readonly = true
        vim.bo[buf].filetype = "dashboard"
        vim.bo[buf].buflisted = false
    end,
})
