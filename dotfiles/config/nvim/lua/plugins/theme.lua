return {
    {
        'navarasu/onedark.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.colorscheme 'kanagawa'
            vim.cmd(":highlight StatusLine guibg=NONE")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000
    },
}
