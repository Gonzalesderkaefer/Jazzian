
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")



local devicespecific = {
    awful.spawn.with_shell("xinput set-prop 'Logitech G203 LIGHTSYNC Gaming Mouse' 'libinput Accel Profile Enabled' 0 1 0"),
    awful.spawn.with_shell("xinput set-prop 'Logitech G203 LIGHTSYNC Gaming Mouse' 'libinput Accel Speed' -0.4"),
    awful.spawn.with_shell("Monitor_setup"),
    awful.spawn.with_shell("x11startup")
}

return devicespecific
