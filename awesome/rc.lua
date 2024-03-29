-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

-- Enable autofocus
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Global namespace, on top before require any modules
RC = {}
RC.vars = require("main.user-variables")
-- }}}

-- {{{ Error handling
require("main.error-handling")
-- }}}

-- {{{ Theme
require("main.theme")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- }}}

-- {{{ Variable definitions
modkey = RC.vars.modkey

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys"),
}
-- }}}

-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
RC.layouts = main.layouts()
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}

-- {{{ Statusbar: Wibar
local statusbar = require("statusbar.statusbar")
statusbar()
-- }}}

-- {{{ Startup apps and scripts
awful.spawn.with_shell("picom --experimental-backends")
awful.spawn.with_shell("wal -R")
awful.spawn.with_shell("feh --bg-fill ~/Imagens/Wallpapers/current/wallpaper.jpg")
awful.spawn.with_shell("pkill flameshot && flameshot &")
awful.spawn.with_shell("copyq &")
awful.spawn.with_shell("xinput set-prop \"ELAN0B00:00 04F3:3192 Touchpad\" \"libinput Tapping Enabled\" 1")
awful.spawn.with_shell("setxkbmap -model abnt2 -layout br -variant abnt2 -option caps:ctrl_modifier shift:both_capslock_cancel")
-- awful.spawn.with_shell("setxkbmap -model abnt2 -layout us -variant intl -option caps:ctrl_modifier shift:both_capslock_cancel")
-- awful.spawn.with_shell("~/.config/scripts/arandr.sh")
-- }}}
