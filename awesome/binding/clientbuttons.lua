-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
    end),
    -- awful.button({}, 6, function(c)
    --   c:emit_signal("request::activate", "mouse_click", { raise = true })
    --   awful.tag.viewprev()
    --   Wait(0.3)
    -- end),
    -- awful.button({}, 7, function(c)
    --   c:emit_signal("request::activate", "mouse_click", { raise = true })
    --   awful.tag.viewnext()
    --   Wait(0.3)
    -- end),
    awful.button({ modkey }, 3, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  return clientbuttons
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function Wait(seconds)
  local time = os.clock()
  while os.clock() - time <= seconds do
    -- nothing
  end
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
