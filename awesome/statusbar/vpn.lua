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

-- VPN Checker

local script_path = awful.util.getdir("config") .. "scripts/check-vpn.sh"

I.vpn = wibox.widget.textbox(
  markup(xrdb.color10, "歷 "))

W.vpn = awful.widget.watch(
    script_path,
    1,
    function(widget, stdout)
        local response_code = tonumber(stdout)
        local disconnected_code = 0

        if response_code == disconnected_code then
            widget:set_markup(
              markup.bold(
                markup(xrdb.color15, "Off ")))
            I.vpn:set_markup(markup(xrdb.color10, "轢 "))
        else
            widget:set_markup(
              markup.bold(
                markup(xrdb.color15, "On ")))
            I.vpn:set_markup(markup(xrdb.color10, "歷 "))
        end
    end
)
