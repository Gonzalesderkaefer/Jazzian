return {
    {
        'navarasu/onedark.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.hi 'Comment gui=none'
            vim.cmd.colorscheme 'sorbet'
        end,
    },
}
