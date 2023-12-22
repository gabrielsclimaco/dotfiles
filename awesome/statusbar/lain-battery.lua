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

-- Battery

I.bat = wibox.widget.textbox(
  markup(xrdb.color10, " "))

W.bat = lain.widget.bat({
    settings = function()
        local perc_color = xrdb.color15
        local icon_color = xrdb.color10

        if bat_now.perc == "N/A" then
            perc = "AC "
            icon = " "
        elseif bat_now.perc <= 10 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 20 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 30 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 40 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 50 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 60 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 70 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 80 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        elseif bat_now.perc <= 90 then
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        else
            if bat_now.ac_status == 1 then
                perc = bat_now.perc .. "% "
                icon = " "
            else
                perc = bat_now.perc .. "% "
                icon = " "
            end
        end

        widget:set_markup(
          markup.bold(
            markup(perc_color, perc)))
        I.bat:set_markup(
            markup(icon_color, icon))
    end
})
