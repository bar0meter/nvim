return {
  "mhinz/vim-startify",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "pwntester/octo.nvim",
    "tyru/open-browser.vim",
  },
  config = function()
    vim.cmd [[
    let g:startify_commands = [
      \ {'f': [' Find Files', ':Telescope find_files']},
      \ {'b': ['󰌨 Buffers', ':Telescope buffers']},
      \ {'p': ['󰈞 Pattern', ':Telescope live_grep']},
      \ {'pr': [' PR List', ':Octo pr list']},
      \ {'?': ['󰋖 Cheat Sheet', ':OpenBrowser https://vim.rtorr.com']},
      \ ]

    let g:startify_session_number = 5
    let g:startify_session_sort = 1
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_session_delete_buffers = 0
    let g:startify_change_to_vcs_root = 1

   ]]
  end,
}
