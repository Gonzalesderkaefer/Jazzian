return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set(
                'n',
                '<leader>ga',
                ":Git add %<CR>", { desc = "Stage this file" }
            )

            vim.keymap.set(
                'n',
                '<leader>gc',
                ":Git commit <CR>", { desc = "Stage this file" }
            )

            vim.keymap.set(
                'n',
                '<leader>gp',
                ":Git push ", { desc = "Stage this file" }
            )
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
}
