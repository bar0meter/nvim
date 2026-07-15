return {
    packs = {
        GH("ajmwagar/vim-deus"),
        GH("EdenEast/nightfox.nvim"),
        GH("rebelot/kanagawa.nvim"),
        GH("mofiqul/vscode.nvim"),
        GH("ellisonleao/gruvbox.nvim"),
        GH("sainnhe/gruvbox-material"),
        GH("neanias/everforest-nvim"),
        GH("sainnhe/sonokai"),
        GH("sainnhe/edge"),
        GH("folke/tokyonight.nvim"),
    },
    setup = function()
        vim.cmd.colorscheme("duskfox")
    end,
}
