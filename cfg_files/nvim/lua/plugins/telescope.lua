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


        -- NOTE: Keybindings
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')




        vim.keymap.set('n', '<leader>fh', function() builtin.help_tags(themes.get_ivy()) end, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>fk', function() builtin.keymaps(themes.get_ivy()) end, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>ff', function() builtin.find_files(themes.get_ivy()) end, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fs', function() builtin.builtin(themes.get_ivy()) end, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>fw', function() builtin.grep_string(themes.get_ivy()) end, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>fg', function() builtin.live_grep(themes.get_ivy()) end, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics(themes.get_ivy()) end, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', function() builtin.resume(themes.get_ivy()) end, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>f.', function() builtin.oldfiles(themes.get_ivy()) end, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', function() builtin.buffers(themes.get_ivy()) end, { desc = '[ ] Find existing buffers' })






    end
}
