local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/coffee/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables

theme = {}

dofile(theme_path .. "elements.lua")
dofile(theme_path .. "layouts.lua")

-- Wallpaper is set by pywal
-- theme.wallpaper          = theme_path .. "background.png"
theme.awesome_icon       = theme_path .. "launcher/archlinux_logo.png"
theme.awesome_subicon    = theme_path .. "launcher/archlinux_logo.png"

return theme
