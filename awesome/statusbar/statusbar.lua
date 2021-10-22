-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Wallpaper, Keys and Mouse Binding
local decoration = {
  wallpaper = require("decoration.wallpaper"),
  taglist   = require("decoration.taglist"),
}

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB = {}
wibox_package = WB -- global object name

-- statusbar widgets groupd by position
require("statusbar.widgets")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Setup Wibar
function WB.setup_boxes (s)
  -- Wallpaper - commented because wallpaper is set by pywal
  -- set_wallpaper(s)

  -- Create a promptbox for each screen
  s.promptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.layoutbox = awful.widget.layoutbox(s)

  -- Create a taglist widget
  s.taglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = WB.taglist
  }
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Populate Wibar
function WB.generate_wibox (s)
  -- Create the wibox
  s.wibox_one = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.wibox_one:setup {
    layout = wibox.layout.align.horizontal,
    WB.add_widgets_left (s),
    WB.add_widgets_middle (s),
    WB.add_widgets_right (s),
  }
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Main
function _M.init()
  WB.taglist  = decoration.taglist()
  WB.initdeco ()
    
  awful.screen.connect_for_each_screen(function(s)
    WB.setup_boxes (s)
    WB.generate_wibox (s)
  end)
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.init(...) end })
