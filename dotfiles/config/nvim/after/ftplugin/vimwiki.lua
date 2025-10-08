-- This function checks if a file exists
-- @param name File name to check
function file_exsits(name)
    local file = io.open(name,"r")
    return file ~= nil and io.close(file)
end

--print(file_exsits(vim.fn.expand('%:p:h') .. "/Makefile"))


vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = {"*"},
    callback = function()
        local parent_dir = vim.fn.expand('%:p:h')
        if file_exsits(parent_dir .. "/Makefile") and vim.fn.getcwd() == parent_dir then
            vim.cmd("!make")
        end
    end,


})
