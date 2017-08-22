local awful = require("awful")
local lain = require("lain")

local config = {
    modkey = "Mod4",
    altkey = "Mod1",
    terminal = "dbus-launch gnome-terminal",
    change_wallpaper = "feh --randomize --bg-scale /home/moritz/.wallpaper/*",
    run_menu = "dmenu_run -sb '#4082f7' -nb '#000' -l 10 -p '>' -m 0",
    layouts = {
        awful.layout.suit.fair,
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    }
}

return config