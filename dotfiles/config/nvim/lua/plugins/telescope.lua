return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {   -- This 
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        }
    },

    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {}
            },
        }
        -- Use native fzf
        require("telescope").load_extension("fzf")


        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')

        vim.keymap.set('n', '<leader>ff', function() builtin.find_files(themes.get_ivy()) end, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics(themes.get_ivy()) end, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', function() builtin.resume(themes.get_ivy()) end, { desc = '[R]esume' })
        vim.keymap.set('n', '<leader>gr',function() builtin.lsp_references(themes.get_ivy()) end, {desc = '[G]oto [R]eferences'})
        vim.keymap.set('n', '<leader><leader>', function() builtin.buffers(themes.get_ivy()) end, { desc = '[ ] Find existing buffers' })
    end
}
