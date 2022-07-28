-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Wibox handling library
local wibox = require("wibox")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- Custom Local Library
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Power menu

-- Variables

local rows = { layout = wibox.layout.fixed.vertical }
local font = beautiful.font

local onlogout = function () awesome.quit() end
local onlock =function() awful.spawn.with_shell("betterlockscreen --lock blur --blur 1") end
local onreboot = function() awful.spawn.with_shell("reboot") end
local onsuspend = function() awful.spawn.with_shell("systemctl suspend") end
local onpoweroff = function() awful.spawn.with_shell("shutdown now") end

-- Status bar widget

W.power_menu = wibox.widget {
    {
        {
            text = '⏼ ',
            font = font,
            widget = wibox.widget.textbox
        },
        margins = 4,
        layout = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    widget = wibox.container.background,
}

-- Popup

local menu_popup = awful.popup {
    ontop = true,
    visible = false, -- invisible when created
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5, x = -10},
    widget = {}
}

local menu_items = {
    { name = 'Bloquear', icon = ' ', command = onlock },
    { name = 'Sair', icon = ' ', command = onlogout },
    { name = 'Reiniciar', icon = '累 ', command = onreboot },
    { name = 'Suspender', icon = '鈴 ', command = onsuspend },
    { name = 'Desligar', icon = ' ﳧ', command = onpoweroff },
}

for _, item in ipairs(menu_items) do

    local row = wibox.widget {
        {
            {
                {
                    text = item.icon,
                    font = font,
                    widget = wibox.widget.textbox
                },
                {
                    text = item.name,
                    font = font,
                    widget = wibox.widget.textbox
                },
                spacing = 12,
                layout = wibox.layout.fixed.horizontal
            },
            margins = 8,
            layout = wibox.container.margin
        },
        bg = xrdb.background,
        widget = wibox.container.background
    }

    row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
    row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

    local old_cursor, old_wibox
    row:connect_signal("mouse::enter", function()
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.bg = xrdb.color2
    end)
    row:connect_signal("mouse::leave", function()
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    row:buttons(awful.util.table.join(awful.button({}, 1, function()
        menu_popup.visible = not menu_popup.visible
        item.command()
    end)))

    table.insert(rows, row)
end

menu_popup:setup(rows)

W.power_menu:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            if menu_popup.visible then
                menu_popup.visible = not menu_popup.visible
                W.power_menu:set_bg(xrdb.background)
            else
                menu_popup:move_next_to(mouse.current_widget_geometry)
                W.power_menu:set_bg(xrdb.color2)
            end
        end)
    )
)
