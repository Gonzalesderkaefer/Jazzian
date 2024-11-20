return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme "catppuccin"
    end
}
