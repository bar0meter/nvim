local airline = {
  "vim-airline/vim-airline",
  dependencies = { "vim-airline/vim-airline-themes" },
  config = function()
    vim.g.airline_powerline_fonts = 1
    vim.cmd [[
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#whitespace#enabled = 0
      let g:airline#extensions#hunks#enabled = 1
      let g:airline#extensions#hunks#non_zero_only = 1
    ]]
    vim.cmd [[
      AirlineTheme gruvbox-material
    ]]
  end,
}

return {
  airline,
}
