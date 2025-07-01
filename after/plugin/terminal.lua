-- Function to set ESC behavior: ESC -> stopinsert, second ESC -> close terminal
local function setup_terminal_esc_behavior(buf)
  -- Clear old mappings if any
  pcall(vim.keymap.del, "t", "<esc>", { buffer = buf })
  pcall(vim.keymap.del, "n", "<esc>", { buffer = buf })

  vim.keymap.set("t", "<esc>", function()
    vim.cmd "stopinsert"
    vim.defer_fn(function()
      vim.keymap.set("n", "<esc>", function()
        if vim.bo.filetype == "snacks_terminal" then
          local win = vim.api.nvim_get_current_win()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, false)
          end
        end
      end, { buffer = buf, nowait = true })
    end, 50)
  end, { buffer = buf, nowait = true })
end

-- Custom terminal toggle behavior that forces float mode
local function terminal_toggle(terminal_position)
  local snacks = require "snacks"
  local terminal = snacks.terminal.get(nil, {
    win = { position = terminal_position },
    create = false,
  })

  if terminal and terminal:valid() then
    if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
      -- Terminal is visible, do nothing (ESC will handle closing)
      return
    else
      -- Terminal exists but hidden, show it again
      terminal:show()
      vim.cmd.startinsert()
      setup_terminal_esc_behavior(terminal.buf)
    end
  else
    -- No valid terminal exists, create a new floating one
    terminal = snacks.terminal(nil, { win = { position = terminal_position } })
    vim.cmd.startinsert()
    setup_terminal_esc_behavior(terminal.buf)
  end
end

-- Set the toggle keymap
vim.keymap.set("n", "<leader>ft", function()
  terminal_toggle "bottom"
end, { desc = "Toggle Floating Terminal" })

-- Setup ESC behavior when a terminal opens
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].filetype == "snacks_terminal" then
      setup_terminal_esc_behavior(buf)
    end
  end,
})

-- Re-apply ESC behavior when re-entering a terminal buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].filetype == "snacks_terminal" then
      setup_terminal_esc_behavior(buf)
    end
  end,
})
