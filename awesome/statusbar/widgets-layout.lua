-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")
local lain  = require("lain")

-- Custom Local Library
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("statusbar.widgets")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Variables

local WB = wibox_package

local cws = clone_widget_set
local cis = clone_icon_set

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Create spacer
function WB.initdeco ()
    WB.spacer = wibox.widget.textbox(" ")
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Left widgets
function WB.add_widgets_left (s)
  return { 
    layout = wibox.layout.fixed.horizontal,
    RC.launcher,
    WB.spacer,
    s.taglist,
  }
end

-- Middle widgets
function WB.add_widgets_middle (s)
  return {
    layout = wibox.layout.fixed.horizontal,
    --  Datetime
    cws.clockwidget,
  } 
end

-- Right widgets
function WB.add_widgets_right (s)
  return {
    layout = wibox.layout.fixed.horizontal,

    --  network traffic
    cis.netdown, cws.netdowninfo,
    cis.netup,   cws.netupinfo,

    WB.spacer,

    -- memory
    cis.mem, cws.mem,

    WB.spacer,

    -- cpu
    cis.cpu, cws.cpu,

    WB.spacer,

    -- disk usage
    cis.fs, cws.fs,

    WB.spacer,

    -- vpn
    cis.vpn, cws.vpn,

    WB.spacer,

    -- check for updates
    cis.update_checker, cws.update_checker,

    WB.spacer,

    cws.brightness,

    WB.spacer,

    --  battery
    cis.bat,     cws.bat,

    WB.spacer,

    --  volume
    cis.volume_dynamic,  cws.volumewidget,
    
    -- notification systray
    cws.systray,

    -- keyboard layout
    cws.keyboardlayout,

    -- layout indicator
    s.layoutbox,

    cws.power_menu,
  }
end
