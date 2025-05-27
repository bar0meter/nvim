local Terminal = require("toggleterm.terminal").Terminal

-- Table to store terminal instances by ID
local terminals = {}

function _G.toggle_term(id, direction)
  direction = direction or "float"

  if not terminals[id] then
    terminals[id] = Terminal:new {
      id = id,
      direction = direction,
      hidden = true,
    }
  end

  local term = terminals[id]
  term:toggle()

  -- Defer insert mode to ensure terminal buffer is focused
  if term:is_open() then
    vim.defer_fn(function()
      vim.cmd "startinsert!"
    end, 10) -- wait 10ms before entering insert mode
  end
end

-- Map <Esc> in terminal mode to toggle the terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:lua toggle_term(1)<CR>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ft", function()
  toggle_term(1, "horizontal")
end, { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "TermNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TermNormalNC", { link = "NormalNC" })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.api.nvim_win_set_option(0, "winhighlight", "")
  end,
})
