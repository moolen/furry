-- Standard awesome library
local beautiful = require("beautiful")
local revelation = require("revelation")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

beautiful.init(gears.filesystem.get_configuration_dir().."themes/default/theme.lua")
revelation.init()

local config  = require("config")
local keybindings = require("keybindings")
require("client")
require("screen")
local util = require("util")

revelation.charorder = config.revelation_charorder
terminal = config.terminal
root.keys(keybindings.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keybindings.clientkeys,
            buttons = keybindings.clientbuttons,
        }
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = {
            titlebars_enabled = true
        }
    },
    {
        rule = { class = "Gnome-terminal" },
        properties = { opacity = 0.92 },
    },
}
