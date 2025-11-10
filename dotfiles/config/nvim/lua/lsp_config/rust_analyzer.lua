vim.api.nvim_create_autocmd('FileType', {
    -- This handler will fire when the buffer's 'filetype' is "python"
    pattern = {'rust'},
    callback = function(ev)
        vim.lsp.start({
            cmd = { 'rust-analyzer' },
            filetypes = { 'rust' },
              root_dir = vim.fs.root(ev.buf, {
                  'Cargo.toml',
                  'Cargo.lock',
                  '.git',
              }),

            capabilities = {
                experimental = {
                    serverStatusNotification = true,
                    commands = {
                        commands = {
                            'rust-analyzer.showReferences',
                            'rust-analyzer.runSingle',
                            'rust-analyzer.debugSingle',
                        },
                    },
                },
            },

            before_init = function(init_params, config)
                -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
                if config.settings and config.settings['rust-analyzer'] then
                    init_params.initializationOptions = config.settings['rust-analyzer']
                end
                ---@param command table{ title: string, command: string, arguments: any[] }
                vim.lsp.commands['rust-analyzer.runSingle'] = function(command)
                    local r = command.arguments[1]
                    local cmd = { 'cargo', unpack(r.args.cargoArgs) }
                    if r.args.executableArgs and #r.args.executableArgs > 0 then
                        vim.list_extend(cmd, { '--', unpack(r.args.executableArgs) })
                    end

                    local proc = vim.system(cmd, { cwd = r.args.cwd })

                    local result = proc:wait()

                    if result.code == 0 then
                        vim.notify(result.stdout, vim.log.levels.INFO)
                    else
                        vim.notify(result.stderr, vim.log.levels.ERROR)
                    end
                end
            end,
            on_attach = function(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoReload', function()
                    reload_workspace(bufnr)
                end, { desc = 'Reload current cargo workspace' })
            end,
        })
    end,
})
