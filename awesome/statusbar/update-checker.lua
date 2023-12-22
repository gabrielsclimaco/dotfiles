-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local xresources = require("beautiful.xresources")
-- local dpi = xresources.apply_dpi

-- Wibox handling library
local wibox = require("wibox")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- Custom Local Library
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Update checker

local script_path = awful.util.getdir("config") .. "scripts/check-updates.sh"

I.update_checker = wibox.widget.textbox(
  markup(xrdb.color10, " "))

W.update_checker = awful.widget.watch(
    script_path,
    300,
    function(widget, stdout)
        local response_code = tonumber(stdout)
        local updates_code = 100

        if response_code == updates_code then
            widget:set_markup(markup(xrdb.color15, " "))
            I.update_checker:set_markup(markup(xrdb.color10, " "))
        else
            widget:set_markup(markup(xrdb.color15, " "))
            I.update_checker:set_markup(markup(xrdb.color10, " "))
        end
    end
)
