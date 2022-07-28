-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local awful     = require("awful")
local watch     = require("awful.widget.watch")
local spawn     = require("awful.spawn")

-- Wibox handling library
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- Custom Local Library
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Brightness

-- Variables

local font          = beautiful.font
local timeout       = 1
local program       = 'light'
local step          = 5
local base          = 50
local current_level = 0
local old_level     = 0 -- for toggling brightness on and off

local get_brightness_cmd = 'light -G'
local set_brightness_cmd = 'light -S %d' -- <base>
local inc_brightness_cmd = 'light -A ' .. step
local dec_brightness_cmd = 'light -U ' .. step

-- Widget

W.brightness = wibox.widget({
  {
    id     = 'icon',
    font   = font,
    widget = wibox.widget.textbox
  },
  {
    id     = 'percentage',
    font   = font,
    widget = wibox.widget.textbox
  },
  layout = wibox.layout.fixed.horizontal,
  set_value = function(self, level)
    local display_level = level .. '% '

    self:get_children_by_id('percentage')[1]:set_markup(
        markup.bold(
            markup(xrdb.color7, display_level)))

    low_level = base / 2
    high_level = base * 3 / 2
    if level <= low_level then
        self:get_children_by_id('icon')[1]:set_markup(
              markup(xrdb.color2, " "))
    elseif level > low_level and level <= high_level then
        self:get_children_by_id('icon')[1]:set_markup(
              markup(xrdb.color2, " "))
    else
        self:get_children_by_id('icon')[1]:set_markup(
              markup(xrdb.color2, " "))
    end
  end
})

-- Functions

local update_widget = function(widget, stdout, _, _, _)
    local brightness_level = tonumber(string.format("%.0f", stdout))
    current_level = brightness_level
    widget:set_value(brightness_level)
end

function W.brightness:set()
    spawn.easy_async(get_brightness_cmd, function(out)
        local brightness_level = tonumber(string.format("%.0f", out))
        local value

        if brightness_level == base then
            value = 100
         else
            value = base
        end
        spawn.easy_async(string.format(set_brightness_cmd, value), function()
            update_widget(W.brightness, value .. '.00')
        end)
    end)
end

function W.brightness:toggle()
    if old_level < 0.1 then
        -- avoid toggling between '0' and 'almost 0'
        old_level = 1
    end
    if current_level < 0.1 then
        -- restore previous level
        current_level = old_level
    else
        -- save current brightness for later
        old_level = current_level
        current_level = 0
    end
    spawn.easy_async(string.format(set_brightness_cmd, current_level), function()
        update_widget(W.brightness, current_level .. '.00')
    end)
end

function W.brightness:inc()
    spawn.easy_async(inc_brightness_cmd, function()
        spawn.easy_async(get_brightness_cmd, function(out)
            update_widget(W.brightness, out)
        end)
    end)
end

function W.brightness:dec()
    spawn.easy_async(dec_brightness_cmd, function()
        spawn.easy_async(get_brightness_cmd, function(out)
            update_widget(W.brightness, out)
        end)
    end)
end

W.brightness:buttons(
    awful.util.table.join(
        awful.button({}, 1, function() W.brightness:set() end),
        awful.button({}, 3, function() W.brightness:toggle() end),
        awful.button({}, 4, function() W.brightness:inc() end),
        awful.button({}, 5, function() W.brightness:dec() end)
    )
)

watch(get_brightness_cmd, timeout, update_widget, W.brightness)
