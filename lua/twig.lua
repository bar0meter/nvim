-- Twig worktree integration: telescope picker to switch/create/remove worktrees.
-- <CR> cd to worktree, <C-x> remove worktree, <C-n> create from prompt input.

local M = {}

local function parse_ls()
    local out = vim.fn.systemlist({ "twig", "ls" })
    if vim.v.shell_error ~= 0 then
        vim.notify("twig ls failed:\n" .. table.concat(out, "\n"), vim.log.levels.ERROR)
        return {}
    end
    local entries = {}
    for i, line in ipairs(out) do
        if i > 1 then -- skip header
            local id, repo, branch, dirty, ahead, behind, path =
                line:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
            if id then
                table.insert(entries, {
                    id = id,
                    repo = repo,
                    branch = branch,
                    dirty = dirty ~= "-" and dirty or nil,
                    ahead = ahead,
                    behind = behind,
                    path = path,
                })
            end
        end
    end
    return entries
end

local function switch_to(path)
    vim.cmd.cd(vim.fn.fnameescape(path))
    vim.notify("cwd: " .. path)
end

-- Create worktree for target (branch, pr:123, ...), then cd into it. Async: hook may be slow.
function M.checkout(target)
    if not target or target == "" then
        return
    end
    vim.notify("twig checkout " .. target .. " ...")
    vim.system({ "twig", "checkout", target }, { text = true }, function(res)
        vim.schedule(function()
            if res.code ~= 0 then
                vim.notify("twig checkout failed:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
                return
            end
            local path = vim.trim(vim.fn.system({ "twig", "path", target }))
            if vim.v.shell_error == 0 and path ~= "" then
                switch_to(path)
            end
        end)
    end)
end

function M.checkout_prompt()
    vim.ui.input({ prompt = "twig checkout (branch/pr:N/origin/x): " }, M.checkout)
end

function M.pick(opts)
    opts = opts or {}
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local entries = parse_ls()
    if #entries == 0 then
        return
    end

    pickers
        .new(opts, {
            prompt_title = "Twig worktrees",
            finder = finders.new_table({
                results = entries,
                entry_maker = function(e)
                    local status = e.dirty and (" ✗" .. e.dirty) or ""
                    if e.ahead ~= "0" or e.behind ~= "0" then
                        status = status .. " ↑" .. e.ahead .. "↓" .. e.behind
                    end
                    local display = string.format("%-6s %-40s%s", e.repo, e.branch, status)
                    return {
                        value = e,
                        display = display,
                        ordinal = e.repo .. " " .. e.branch .. " " .. e.path,
                        path = e.path,
                    }
                end,
            }),
            sorter = conf.generic_sorter(opts),
            previewer = false,
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local entry = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if entry then
                        switch_to(entry.value.path)
                    end
                end)
                map({ "i", "n" }, "<C-x>", function()
                    local entry = action_state.get_selected_entry()
                    if not entry then
                        return
                    end
                    local e = entry.value
                    if e.dirty then
                        vim.notify("worktree dirty (" .. e.dirty .. " files), not removing: " .. e.branch,
                            vim.log.levels.WARN)
                        return
                    end
                    actions.close(prompt_bufnr)
                    local out = vim.fn.system({ "twig", "rm", "id:" .. e.id })
                    if vim.v.shell_error ~= 0 then
                        vim.notify("twig rm failed:\n" .. out, vim.log.levels.ERROR)
                    else
                        vim.notify("removed worktree " .. e.branch .. " (branch kept)")
                    end
                end)
                map({ "i", "n" }, "<C-n>", function()
                    actions.close(prompt_bufnr)
                    M.checkout_prompt()
                end)
                return true
            end,
        })
        :find()
end

return M
