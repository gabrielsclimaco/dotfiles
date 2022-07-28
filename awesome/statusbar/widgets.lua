-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- split module, to make each file shorter,
-- all must have same package name

local W = {}
clone_widget_set = W           -- object name

local I = {}
clone_icon_set = I             -- object name

-- progress bar related widgets -- after global markup
local config_path = awful.util.getdir("config") .. "statusbar/"
-- Lain
dofile(config_path .. "lain.lua")
dofile(config_path .. "lain-battery.lua")
dofile(config_path .. "lain-diskfree.lua")
dofile(config_path .. "lain-sound.lua")
-- Custom
dofile(config_path .. "brightness.lua")
dofile(config_path .. "power-menu.lua")
dofile(config_path .. "update-checker.lua")
  dofile(config_path .. "vpn.lua")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Keyboard layout indicator
W.keyboardlayout = awful.widget.keyboardlayout()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Keyboard layout indicator
I.systray = wibox.widget.systray()

W.systray = wibox.container.margin(
  I.systray,
  dpi(4),
  dpi(4),
  dpi(4),
  dpi(4)
)
