-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

local _M = {}

require("statusbar.widgets")

local W = clone_widget_set     -- object name
local I = clone_icon_set       -- object name

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Prompt

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Floating windows
    -- Resize
    awful.key({ modkey, "Control" }, "Down",
              function () awful.client.moveresize( 0, 0, 0, -20) end,
              {description = "decrease size vertically", group = "floating window"}),
    awful.key({ modkey, "Control" }, "Up",
              function () awful.client.moveresize( 0, 0, 0,  20) end,
              {description = "increase size vertically", group = "floating window"}),
    awful.key({ modkey, "Control" }, "Left",
              function () awful.client.moveresize( 0, 0, -20, 0) end,
              {description = "decrease size horizontally", group = "floating window"}),
    awful.key({ modkey, "Control" }, "Right",
              function () awful.client.moveresize( 0, 0,  20, 0) end,
              {description = "increase size horizontally", group = "floating window"}),

    -- Move
    awful.key({ modkey, "Shift"   }, "Down",
              function () awful.client.moveresize(  0,  20,   0,   0) end,
              {description = "move down", group = "floating window"}),
    awful.key({ modkey, "Shift"   }, "Up",
              function () awful.client.moveresize(  0, -20,   0,   0) end,
              {description = "move up", group = "floating window"}),
    awful.key({ modkey, "Shift"   }, "Left",
              function () awful.client.moveresize(-20,   0,   0,   0) end,
              {description = "move left", group = "floating window"}),
    awful.key({ modkey, "Shift"   }, "Right",
              function () awful.client.moveresize( 20,   0,   0,   0) end,
              {description = "move right", group = "floating window"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Media control keys
    awful.key({}, "XF86AudioRaiseVolume",
              function ()
                awful.spawn.with_shell("amixer -q set Master 5%+")
              end,
              {description = "volume up", group = "media"}),
    awful.key({}, "XF86AudioLowerVolume",
              function ()
                awful.spawn.with_shell("amixer -q set Master 5%-")
              end,
              {description = "volume down", group = "media"}),
    awful.key({}, "XF86AudioMute",
              function ()
                awful.spawn.with_shell("amixer -q set Master toggle")
              end,
              {description = "volume mute", group = "media"}),
    awful.key({}, "XF86AudioPlay",
              function ()
                awful.spawn.with_shell("playerctl play-pause")
              end,
              {description = "play/pause media", group = "media"}),
    awful.key({}, "XF86AudioNext",
              function ()
                awful.spawn.with_shell("playerctl next")
              end,
              {description = "play next", group = "media"}),
    awful.key({}, "XF86AudioPrev",
              function ()
                awful.spawn.with_shell("playerctl previous")
              end,
              {description = "play previous", group = "media"}),
    -- Screen
    awful.key({}, "XF86MonBrightnessUp",
              function () W.brightness:inc() end,
              {description = "increase brightness", group = "screen"}),
    awful.key({}, "XF86MonBrightnessDown",
              function () W.brightness:dec() end,
              {description = "decrease brightness", group = "screen"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Application launcher
    awful.key({ modkey }, "r", function() awful.spawn.with_shell("sh ${HOME}/.config/awesome/scripts/dmenu.sh") end,
              {description = "show dmenu", group = "launcher"}),
    awful.key({ modkey }, "space", function() awful.spawn.with_shell("rofi -show drun") end,
              {description = "run rofi in drun mode", group = "launcher"}),
    awful.key({ modkey, 'Shift' }, "space", function() awful.spawn.with_shell("rofi -show run") end,
              {description = "run rofi in run mode", group = "launcher"}),
    awful.key({ modkey }, "=", function() awful.spawn.with_shell("rofi -show calc") end,
              {description = "run rofi in calculator mode", group = "launcher"}),
    awful.key({ modkey }, "w", function() awful.spawn.with_shell("rofi -show window") end,
              {description = "run rofi in window mode", group = "launcher"}),
    -- Firefox
    awful.key({ modkey }, "b", function () awful.spawn.with_shell("firefox") end,
              {description = "opens Firefox", group = "launcher"}),
    -- Flameshot
    awful.key({}, "Print", function () awful.spawn.with_shell("flameshot gui") end,
              {description = "opens Flameshot (screeshot tool)", group = "launcher"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Other
    awful.key({ modkey }, "BackSpace",
              function ()
                  I.systray.visible = not I.systray.visible
              end,
              {description = "toggle systray", group = "other"})
  )

  return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
