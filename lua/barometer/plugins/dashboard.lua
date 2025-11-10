local function dashboard_setup()
  local M = {}
  local ok, lazy = pcall(require, "lazy")

  -- Define configs for alpha.lua's dahsboard theme
  M.alpha_dashboard = require "alpha.themes.dashboard"

  -- Set header --
  M.alpha_dashboard.section.header.val = {

    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠶⠶⣄⡀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⣀⡀⠘⠻⣄⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢣⣄⠘⢳⡄⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠾⢛⠛⣛⡟⠀⣿⠀⠀⠀",
    "⠀⠀⠀⢀⡠⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠞⢀⡦⠟⠛⠛⠛⢦⡃⢸⡇⠀⠀",
    "⠀⠀⠀⣾⠓⠸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠋⠀⠀⠀⠀⠀⢸⡇⢸⡇⠀⠀",
    "⠀⠀⠀⣿⢧⡄⠙⠛⢦⡀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡼⢻⡄⠀⠸⣁⠹⡀⠀",
    "⠀⠀⠀⠛⣿⣿⠤⠜⠛⠛⠒⢢⣤⠤⠖⠚⠛⠀⣉⣈⣀⡼⠂⠀⠀⢫⡄⢳⡄",
    "⠀⠀⠀⠀⢹⡏⣜⣢⠀⠀⠀⠈⠉⢀⣤⣴⣶⣾⣿⣿⠟⠁⠀⠀⠀⢸⣇⢸⡇",
    "⠀⢀⣀⡾⣯⡅⠙⠋⢁⡠⣤⡤⠐⢺⣿⣿⣿⠯⠟⠁⠀⠀⠀⠀⣸⠯⡙⡾⠃",
    "⢠⢟⣩⡕⣏⣡⠄⠀⠾⣧⠿⠃⠀⠈⠉⠛⢯⡀⣀⡠⠤⢤⡤⣒⣏⣼⠝⠁⠀",
    "⠀⠈⠉⠙⠚⠑⢤⣄⣀⣀⠀⢀⣶⡀⣤⡀⠀⢹⣉⠁⠀⠀⠀⠉⠙⡇⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠉⢹⡯⣐⠪⢩⡕⠛⠑⠒⣤⣿⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢀⣼⢱⠒⠋⠉⠀⠀⠀⠀⠀⣄⣤⣤⣄⠀⠀⠀⢸⣇⠀⠀",
    "⠀⠀⠀⠀⢀⣴⠒⠚⣅⣚⣿⣶⣠⠀⠀⠀⣶⡿⠿⣿⣿⣿⣷⣤⡄⠀⠘⣧⠀",
    "⠀⠀⠀⠠⡼⢳⣰⡾⠞⠋⠀⠈⣿⠀⢀⡴⠋⠀⠀⢸⣿⣿⠋⠀⢸⠁⠀⣿⠀",
    "⠀⠀⠀⠈⢻⣦⠏⠀⠀⠀⠀⢰⠉⠀⣶⠁⠀⠀⣠⣾⣿⡟⠁⢠⡟⠁⢰⠋⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡆⢰⠋⠀⠀⠀⠉⠉⠉⠀⠀⠈⠑⢳⠋⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⡤⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  }
  M.alpha_dashboard.section.buttons.val = {
    M.alpha_dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    M.alpha_dashboard.button("f", "󰈞  Find Files", ":Telescope find_files<CR>"),
    M.alpha_dashboard.button("g", "󰊄  Grep Files", ":Telescope live_grep<CR>"),
    M.alpha_dashboard.button("d", "󰈬  Browse Docs", ":Telescope help_tags<CR>"),
    M.alpha_dashboard.button("l", "󰒲  Open Lazy", ":Lazy<CR>"),
    M.alpha_dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
  }

  return M
end

return {
  "goolord/alpha-nvim",
  config = function()
    local ds = dashboard_setup()
    require("alpha").setup(ds.alpha_dashboard.opts)
  end,
}
