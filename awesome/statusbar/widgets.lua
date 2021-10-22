-- {{{ Required libraries
-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")
local lain  = require("lain")

-- Custom Local Library
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
-- local xrdb = xresources.get_current_theme()
require("statusbar.lain")
-- }}}

local WB = wibox_package

local cws = clone_widget_set
local cis = clone_icon_set

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.initdeco ()
    -- Spacer
    WB.spacer = wibox.widget.textbox(" ")

    -- Separators lain
    -- local separators  = lain.util.separators
    -- local arrow_color = gmc.color['red300']
    -- WB.arrow_dl = separators.arrow_left("alpha", arrow_color)
    -- WB.arrow_ld = separators.arrow_left(arrow_color, "alpha")
    -- WB.arrow_dr = separators.arrow_right("alpha", arrow_color)
    -- WB.arrow_rd = separators.arrow_right(arrow_color, "alpha")
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Keyboard map indicator and switcher
mysystray = wibox.container.margin(
  wibox.widget.systray(),
  dpi(4),
  dpi(4),
  dpi(4),
  dpi(4)
)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.add_widgets_left (s)
  return { -- Left widgets
    layout = wibox.layout.fixed.horizontal,
    RC.launcher,
    WB.spacer,
    s.taglist,
    s.promptbox,
  }
end

function WB.add_widgets_middle (s)
  return {
    layout = wibox.layout.fixed.horizontal,
    --  Datetime
    cws.clockwidget,
  } 
end

function WB.add_widgets_right (s)
  return { -- Right widgets
    layout = wibox.layout.fixed.horizontal,

    --  network traffic
    cis.netdown, cws.netdowninfo,
    cis.netup,   cws.netupinfo,

    WB.spacer,

    -- memory
    cis.mem,     cws.mem,

    WB.spacer,

    -- cpu
    cis.cpu,     cws.cpu,

    WB.spacer,

    -- disk usage
    cis.fs,      cws.fs,

    WB.spacer,

    --  mpd
    -- cis.mpd,     cws.mpd,

    --  volume
    cis.volume_dynamic,  cws.volumewidget,
    
    -- notification systray
    mysystray,

    -- keyboard layout
    mykeyboardlayout,

    -- layout indicator
    s.layoutbox,
  }
end
