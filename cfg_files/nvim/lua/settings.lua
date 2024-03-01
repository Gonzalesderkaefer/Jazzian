--Settings

--Editor
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
vim.cmd("set number")
vim.cmd("set cursorline")
vim.cmd("hi CursorLine term=bold cterm=bold ctermbg=236")
vim.cmd("hi CursorLineNr term=bold cterm=bold ctermbg=236")
vim.cmd("hi StatusLine ctermbg=blue ctermfg=black")

-- Autocmds --
--
--
-- Compile LaTeX after writing
vim.cmd("autocmd BufWritePost *.tex !pdflatex %")
-- Compile Java after writing
vim.cmd("autocmd BufWritePost *.java !javac %")
-- Compile cpp after saving
vim.cmd(" autocmd BufWritePost *.cpp !make \"$(echo \"%\" | sed -e 's/.cpp//')\" ")
-- Compile c after saving
vim.cmd(" autocmd BufWritePost *.c !make \"$(echo \"%\" | sed -e 's/.c//')\" ")


--Open .tex file in Zathura upon opening
vim.cmd(" autocmd BufReadPost *.tex !zathura \"$(echo \"%\" | sed -e 's/.tex/.pdf/')\" & ")

