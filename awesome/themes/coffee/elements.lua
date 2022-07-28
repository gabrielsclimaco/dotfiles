local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local naughty = require("naughty")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Fonts
theme.font = "Hack Nerd Font 14"
theme.taglist_font = "Hack Nerd Font Mono 18"

-- Taglist
-- theme.bg_normal     = xrdb.background .. "ee" -- "ee" for transparency
theme.bg_normal     = xrdb.background
-- theme.bg_focus      = xrdb.color12
-- theme.bg_urgent     = xrdb.color9
-- theme.bg_minimize   = xrdb.color8
-- theme.bg_systray    = xrdb.background

-- theme.fg_normal     = xrdb.foreground
-- theme.fg_focus      = xrdb.background
-- theme.fg_urgent     = xrdb.background
-- theme.fg_minimize   = xrdb.background

theme.taglist_bg_focus = xrdb.color2
theme.taglist_fg_focus = xrdb.color0

-- Generate taglist squares:
local taglist_square_size = dpi(12)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, xrdb.color1
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, xrdb.color1
)

-- Gaps
theme.useless_gap = 8

-- Borders
theme.border_width  = 1

theme.border_normal = xrdb.color0
theme.border_focus  = xrdb.color4
theme.border_marked = xrdb.color1

-- Menu
-- theme.menu_submenu_icon  = theme_path .. "misc/default/submenu.png"

theme.menu_height = 20      -- dpi(15)
theme.menu_width  = 180     -- dpi(100)
--theme.menu_context_height = 20

theme.menu_bg_normal = xrdb.background
theme.menu_bg_focus  = xrdb.color2
theme.menu_fg_focus  = xrdb.background

theme.menu_border_color = xrdb.color4
theme.menu_border_width = 1

-- Notifications
local rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

theme.notification_icon_size    = 100
theme.notification_border_width = 0
theme.notification_border_color = xrdb.background
-- theme.notification_shape        = rrect(10)
