
-- Include general settings
require("mycfg.remap")
require("mycfg.settings")
require("mycfg.lazy")

-- function to check if file exists
local file_exists = function (name)
    local f = io.open(name,"r")
    return f ~= nil and io.close(f)
end

-- include user-specific settings
if file_exists(os.getenv("HOME") .. "/.config/nvim/lua/mycfg/devicespecific.lua") then
    require("mycfg.devicespecific")
end

