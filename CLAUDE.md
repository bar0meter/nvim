# Neovim Configuration Guide

## Commands
- Format buffer: `<leader>fr`
- LSP commands:
  - Go to definition: `gd`
  - Find references: `gr`
  - Rename symbol: `<leader>rn`
  - Code action: `<leader>ca`
  - Hover documentation: `K`

## Code Style Guidelines
- Indentation: 2 spaces (defined in stylua.toml)
- Formatters:
  - Lua: stylua
  - Python: black
  - JavaScript/TypeScript: prettier
  - SQL: sql_formatter
- Format on save enabled with 500ms timeout
- Only ERROR level diagnostics shown by default
- Semantic highlighting disabled by default

## Conventions
- Plugin configurations in lua/custom/plugins/
- Modules organized with require("module_name")
- Keybindings follow <leader> pattern for custom actions
- Plugin management via lazy.nvim
- LSP configurations defined per language server