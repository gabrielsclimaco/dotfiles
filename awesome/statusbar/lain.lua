-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")
local lain = require("lain")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- global for all splited
markup = lain.util.markup

-- Custom Local Library
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MEM
I.mem = wibox.widget.textbox(
  markup(xrdb.color2, " "))

W.mem = lain.widget.mem({
  settings = function()
    widget:set_markup(
      markup.bold(
        markup(xrdb.color7, mem_now.perc .. "% ")))
  end
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- CPU
I.cpu = wibox.widget.textbox(
  markup(xrdb.color2, " "))

W.cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(
      markup.bold(
        markup(xrdb.color7, cpu_now.usage .. "% ")))
  end
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Textclock

I.iconclock = wibox.widget.textbox(markup(xrdb.color2, " "))

W.textclock = wibox.widget.textclock(
  markup.bold("%A %d %B " .. "-" .. " %H:%M "))

W.clock_container = wibox.widget ({
  layout = wibox.layout.fixed.horizontal,
  I.iconclock,
  W.textclock,
})

W.clockwidget = wibox.container.margin(
  W.clock_container,
  dpi(200), -- left
  dpi(0),   -- right
  dpi(0),   -- top
  dpi(0)    -- bottom
)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Calendar

W.calendar = lain.widget.cal({
  attach_to = { W.clockwidget },
  week_start = 1, -- Start on Sunday
  three = true, -- Display three months spanning the date
  notification_preset = {
    fg = xrdb.foreground,
    bg = xrdb.background,
    font = "Hack Nerd Font Mono 18"
  },
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Net
I.netdown = wibox.widget.textbox(
  markup(xrdb.color2, " ﲐ"))

W.netdowninfo = wibox.widget.textbox()

I.netup = wibox.widget.textbox(
  markup(xrdb.color2, " ﲓ"))

W.netupinfo = lain.widget.net({
    settings = function()
        local fg_color_up   = xrdb.color7
        local fg_color_down = xrdb.color7

        widget:set_markup(
          markup.bold(
            markup(fg_color_up, net_now.sent .. " ")))
        W.netdowninfo:set_markup(
          markup.bold(
            markup(fg_color_down, net_now.received .. " ")))
    end
})
