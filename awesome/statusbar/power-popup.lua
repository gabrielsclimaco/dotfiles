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
local bg_color = args.bg_color or beautiful.bg_normal
local accent_color = args.accent_color or beautiful.bg_focus
local text_color = args.text_color or beautiful.fg_normal
local label_color = args.label_color or beautiful.fg_focus
local phrases = args.phrases or {'Goodbye!'}
local icon_size = args.icon_size or 40
local icon_margin = args.icon_margin or 16

local onlogout   = function() awesome.quit() end
local onlock     = function() awful.spawn.with_shell("betterlockscreen --lock blur --blur 1") end
local onreboot   = function() awful.spawn.with_shell("reboot") end
local onsuspend  = function() awful.spawn.with_shell("systemctl suspend") end
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
                menu_popup.visible = false
                phrase_widget:set_text('')
                capi.keygrabber.stop()
                W.power_menu:set_bg(xrdb.background)
            else
                launch(args)
                W.power_menu:set_bg(xrdb.color2)
            end
        end)
    )
)

local menu_popup = wibox {
    bg = xrdb.background,
    max_widget_size = 500,
    ontop = true,
    height = 200,
    width = 400,
    shape = function(cr, width, height)
        gears.shape.rounded_rece(cr, width, height, 8)
    end
}

local action = wibox.widget {
    text = '',
    widget = wibox.widget.textbox
}

local phrase_widget = wibox.widget{
    text   = 'Vai pa onde?',
    align  = 'center',
    widget = wibox.widget.textbox
}

local function create_button(icon_name, action_name, accent_color, label_color, onclick, icon_size, icon_margin)

    local button = awesomebuttons.with_icon {
        type = 'basic',
        icon = icon_name,
        color = accent_color,
        icon_size = icon_size,
        icon_margin = icon_margin,
        onclick = function()
            onclick()
            w.visible = false
            capi.keygrabber.stop()
        end
    }
    button:connect_signal("mouse::enter", function()
            action:set_markup('<span color="' .. label_color .. '">' .. action_name .. '</span>')
        end)

    button:connect_signal("mouse::leave", function() action:set_markup('<span> </span>') end)

    return button
end

local function launch(args)
    args = args or {}

    w:set_bg(bg_color)
    if #phrases > 0 then
        phrase_widget:set_markup(
            '<span color="'.. text_color .. '" size="20000">' .. phrases[ math.random( #phrases ) ] .. '</span>')
    end

    w:setup {
        {
            phrase_widget,
            {
                {
                    create_button('log-out', 'Log Out (l)',
                        accent_color, label_color, onlogout, icon_size, icon_margin),
                    create_button('lock', 'Lock (k)',
                        accent_color, label_color, onlock, icon_size, icon_margin),
                    create_button('refresh-cw', 'Reboot (r)',
                        accent_color, label_color, onreboot, icon_size, icon_margin),
                    create_button('moon', 'Suspend (u)',
                        accent_color, label_color, onsuspend, icon_size, icon_margin),
                    create_button('power', 'Power Off (s)',
                        accent_color, label_color, onpoweroff, icon_size, icon_margin),
                    id = 'buttons',
                    spacing = 8,
                    layout = wibox.layout.fixed.horizontal
                },
                valign = 'center',
                layout = wibox.container.place
            },
            {
                action,
                haligh = 'center',
                layout = wibox.container.place
            },
            spacing = 32,
            layout = wibox.layout.fixed.vertical
        },
        id = 'a',
        shape_border_width = 1,
        valign = 'center',
        layout = wibox.container.place
    }

    w.screen = mouse.screen
    w.visible = true

    awful.placement.centered(w)
    capi.keygrabber.run(function(_, key, event)
        if event == "release" then return end
        if key then
            if key == 'Escape' then
                phrase_widget:set_text('')
                capi.keygrabber.stop()
                w.visible = false
            elseif key == 's' then onpoweroff()
            elseif key == 'r' then onreboot()
            elseif key == 'u' then onsuspend()
            elseif key == 'k' then onlock()
            elseif key == 'l' then onlogout()
            end

            if key == 'Escape' or string.match("srukl", key) then
                phrase_widget:set_text('')
                capi.keygrabber.stop()
                w.visible = false
            end
        end
    end)
end

local function widget(args)
    local icon = args.icon or WIDGET_DIR .. '/power.svg'

    local res = wibox.widget {
        {
            {
                image = icon,
                widget = wibox.widget.imagebox
            },
            margins = 4,
            layout = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
    }

    res:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if w.visible then
                    phrase_widget:set_text('')
                    capi.keygrabber.stop()
                    w.visible = false
                else
                    launch(args)
                end
            end)
        ))

    return res

end
