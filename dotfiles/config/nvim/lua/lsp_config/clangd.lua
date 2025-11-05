vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = {'c'},
  callback = function(ev)
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd' },
      -- capabilities = require("blink.cmp").get_lsp_capabilities(),

      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`ev.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(ev.buf, {
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac', -- AutoTools
          '.git',
      }),
    })
  end,
})
