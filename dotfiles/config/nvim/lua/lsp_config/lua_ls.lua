-- This config is taken from 'nvim-lspconfig'
local lua_lsp = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc",
    ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }
}





vim.api.nvim_create_autocmd('FileType', {
    -- This handler will fire when the buffer's 'filetype' is "python"
    pattern = "lua",
    callback = function(ev)
        vim.lsp.start({
            name = 'lua_ls',
            cmd = { 'lua-language-server' },

            -- Set the "root directory" to the parent directory of the file in the
            -- current buffer (`ev.buf`) that contains either a "setup.py" or a
            -- "pyproject.toml" file. Files that share a root directory will reuse
            -- the connection to the same LSP server.
            root_dir = vim.fs.root(ev.buf, {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git"
            }),



            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths
                                -- here.
                                -- '${3rd}/luv/library'
                                -- '${3rd}/busted/library'
                            }
                            -- Or pull in all of 'runtimepath'.
                            -- NOTE: this is a lot slower and will cause issues when working on
                            -- your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            -- library = {
                                --     vim.api.nvim_get_runtime_file('', true),
                                -- }
                            }
                        })
                    end,
                    settings = {
                        Lua = {}
                    }
                })
            end,
        })
