--[[
     Original Source Modified From: github.com/copycat-killer
     https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.copland
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Wibox handling library
local wibox = require("wibox")
local lain = require("lain")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- Custom Local Library
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- / fs

I.fs = wibox.widget.textbox(
  markup(xrdb.color2, " "))

--
-- Can't create more than one fs widget
W.fs = lain.widget.fs({
  threshold = 80, -- Percentage threshold at which the notification is triggered
  settings  = function()
    widget:set_markup(
      markup.bold(
        markup(xrdb.color7, fs_now["/"].percentage .. "% ")))
  end,
  notification_preset = {
    fg = xrdb.foreground,
    bg = xrdb.background,
    font = "Hack Nerd Font Mono 16"
  },
})
