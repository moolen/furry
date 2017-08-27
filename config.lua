local awful = require("awful")
local lain = require("lain")
local gears = require("gears")
local beautiful = require("beautiful")

local config = {
    modkey = "Mod4",
    altkey = "Mod1",
    terminal = "dbus-launch gnome-terminal",
    change_wallpaper = "feh --randomize --bg-scale "..beautiful.wallpaper_dir,
    run_menu = "dmenu_run -sb '#4082f7' -nb '#000' -l 10 -p '>' -m 0",
    revelation_charorder = "1234567890qwerasdf",
    layouts = {
        awful.layout.suit.fair,
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    }
}

return config