local awful = require("awful")
local lain = require("lain")
local gears = require("gears")
local beautiful = require("beautiful")

local config = {
    modkey = "Mod4",
    altkey = "Mod1",
    terminal = "dbus-launch gnome-terminal",
    --change_wallpaper = "feh --randomize --bg-scale "..beautiful.wallpaper_dir,
    change_wallpaper = "feh --bg-scale /home/moritz/.wallpaper/space.png",
    --run_menu = "dmenu_run -sb '#4082f7' -nb '#000' -l 10 -p '>' -m 0",
    run_menu = "rofi -show run",
    revelation_charorder = "1234567890qwerasdf",
    layouts = {
        awful.layout.suit.fair,
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    }
}

return config
