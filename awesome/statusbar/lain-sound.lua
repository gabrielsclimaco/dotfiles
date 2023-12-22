--[[
     Original Source Modified From: github.com/copycat-killer
     https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.copland
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local beautiful = require("beautiful")
local bfont = beautiful.font
local gears = require("gears")
local awful = require("awful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Wibox handling library
local wibox = require("wibox")
local lain = require("lain")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- Custom Local Library
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- ALSA volume bar

-- global terminal is required in alsabar, unfortunately
terminal = RC.vars.terminal

-- ALSA volume bar from copycat-copland


I.volume_dynamic = wibox.widget.textbox(
  markup(xrdb.color10, "墳 "))

local volume_wibox_settings = function()
    if volume_now.status == "off" then
        I.volume_dynamic:set_markup_silently(
          markup(xrdb.color10, "婢 "))
    elseif volume_now.level == 0 then
        I.volume_dynamic:set_markup_silently(
          markup(xrdb.color10, "奄 "))
    elseif volume_now.level <= 50 then
        I.volume_dynamic:set_markup_silently(
          markup(xrdb.color10, "奔 "))
    else
        I.volume_dynamic:set_markup_silently(
          markup(xrdb.color10, "墳 "))
    end
end

local volume_wibox_colors = {
    background = xrdb.background,
    mute = xrdb.color1,
    unmute = xrdb.color10
}

W.volume_wibox = lain.widget.alsabar({
  width = 55,
  step = "2%",
  timeout = 1,
  settings = volume_wibox_settings,
  colors = volume_wibox_colors,
  notification_preset = { font = "Hack Nerd Font Mono 14" }
})

W.volume_wibox_buttons = my_table.join (
  awful.button({}, 1, function()
    awful.spawn(string.format("%s -e alsamixer", terminal))
  end),
  awful.button({}, 2, function()
    os.execute(string.format("%s set %s 100%%", W.volume_wibox.cmd, W.volume_wibox.channel))
    W.volume_wibox.update()
  end),
  awful.button({}, 3, function()
    os.execute(string.format("%s set %s toggle", W.volume_wibox.cmd, W.volume_wibox.togglechannel or W.volume_wibox.channel))
    W.volume_wibox.update()
    end),
  awful.button({}, 4, function()
    os.execute(string.format("%s set %s 5%%+", W.volume_wibox.cmd, W.volume_wibox.channel))
    W.volume_wibox.update()
  end),
  awful.button({}, 5, function()
    os.execute(string.format("%s set %s 5%%-", W.volume_wibox.cmd, W.volume_wibox.channel))
    W.volume_wibox.update()
  end)
)

W.volume_wibox.tooltip.wibox.fg = xrdb.background

W.volume_wibox.bar:buttons(W.volume_wibox_buttons)

W.volumebg = wibox.container.background(
  W.volume_wibox.bar, xrdb.color15, gears.shape.rectangle)
W.volumewidget = wibox.container.margin(
  W.volumebg, dpi(2), dpi(7), dpi(9), dpi(9))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MPD from copycat-multicolor

-- I.mpd = wibox.widget.imagebox(beautiful.widget_note)
-- W.mpd = lain.widget.mpd({
--     settings = function()
--         mpd_notification_preset = {
--             text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
--                    mpd_now.album, mpd_now.date, mpd_now.title)
--         }

--         if mpd_now.state == "play" then
--             artist = mpd_now.artist .. " > "
--             title  = mpd_now.title .. " "
--             I.mpd:set_image(beautiful.widget_note_on)
--         elseif mpd_now.state == "pause" then
--             artist = "mpd "
--             title  = "paused "
--         else
--             artist = ""
--             title  = ""
--             I.mpd:set_image(nil)
--         end
--         widget:set_markup(markup(xrdb.color10, artist)
--             .. markup(xrdb.color6, title))
--     end
-- })
