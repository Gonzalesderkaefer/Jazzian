--Keybindings
vim.g.mapleader = " " --setting leader key to space
vim.cmd("nmap <leader>lc :w \\| !pdflatex %<CR>") --compile LaTeX
--vim.cmd("nmap <F5> :w \\| !pdflatex %<CR>") --compile LaTeX

