local function toggle_snacks_explorer()
  local pickers = Snacks.picker.get { source = "explorer" } or {}
  -- if one is focused, close it
  for _, p in ipairs(pickers) do
    if p:is_focused() then
      p:close()
      return
    end
  end
  -- if one exists but isn't focused, focus it
  if #pickers > 0 then
    pickers[1]:focus()
    return
  end
  -- otherwise open a new one
  Snacks.explorer()
end

vim.keymap.set("n", "<leader>fr", toggle_snacks_explorer, { desc = "Toggle Snacks Explorer" })
