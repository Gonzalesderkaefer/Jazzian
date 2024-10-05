-- Installing lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath) 

local opts = {} 

-- include settings
require("nvim-settings")

-- function to check if file exists
local file_exists = function (name)
    local f = io.open(name,"r")
    return f ~= nil and io.close(f)
end

-- include user-specific settings
if file_exists(os.getenv("HOME") .. "/.config/nvim/lua/devicespecific.lua") then
    require("devicespecific")
end

-- make lazy install stuff
require("lazy").setup("plugins")

