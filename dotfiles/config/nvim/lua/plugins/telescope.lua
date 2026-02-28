return
{
    'nvim-telescope/telescope.nvim',
    dependencies =
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },

    config = function()
        defaults =
        {
            previewer = true,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        }
        require("telescope").setup
        {
            extensions =
            {
                fzf = {}
            },
        }
        -- Use native fzf
        require("telescope").load_extension("fzf")


        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')

        vim.keymap.set('n', '<leader>ff', function() builtin.find_files(themes.get_ivy()) end, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fd', function() vim.cmd(":w") builtin.diagnostics(themes.get_ivy()) end, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr',function() builtin.lsp_references(themes.get_ivy()) end, {desc = '[G]oto [R]eferences'})
        vim.keymap.set('n', '<leader><leader>', function() builtin.buffers(themes.get_ivy()) end, { desc = '[ ] Find existing buffers' })
        --vim.keymap.set('n', '<leader>fr', function() builtin.resume(themes.get_ivy()) end, { desc = '[R]esume' })
    end
}
