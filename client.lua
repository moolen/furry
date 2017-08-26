-- Standard awesome library
local gears = require("gears")
local timer = require("gears.timer")
local awful = require("awful")
              require("awful.autofocus")
local keybindings = require("keybindings")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local common = require("awful.widget.common")
local dpi = require("beautiful").xresources.apply_dpi
local config = require("config")
local util = require("util")


-- }}}
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- autofocus on mouse enter
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    util.check_wibar(c.screen.wibar, c.screen)
end)

client.connect_signal("unmanage", function (c)
    local s = c.screen
    local curclients = s.selected_tag:clients()
    local val = true
    for _, cl in ipairs(curclients) do
        if cl.fullscreen then
            val = false
            break
        end
    end
    s.tagline.visible = val
    util.check_wibar(s.wibar, s)
end)

client.connect_signal("property::fullscreen", function(c)
    local s = c.screen
    if c.fullscreen then
        s.tagline.visible = false
    else
        local curclients = s.selected_tag:clients()
        local val = true
        for _, cl in ipairs(curclients) do
            if cl.fullscreen then
                val = false
                break
            end
        end
        s.tagline.visible = val
    end
end)

client.connect_signal("property::maximized", function(c) util.check_wibar(c.screen.wibar, c.screen) end)
client.connect_signal("property::minimized", function(c) util.check_wibar(c.screen.wibar, c.screen) end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    if not awful.rules.match(c, {class = "Chrauncher"}) then
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1, function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
            end)
        )
        titlebaricon = awful.titlebar.widget.iconwidget(c)
        titlebaricon.forced_height = 32
        titlebaricon.forced_width = 32

        local maximized = wibox.widget.imagebox(profileConfigPath.."themes/default/titlebar/maximized_focus_active3.png",false)
        c:connect_signal("focus",function()
            maximized.image = "themes/default/titlebar/maximized_focus_active3.png"
        end)
        c:connect_signal("unfocus",function()
            maximized.image = "themes/default/titlebar/normal.png"
        end)
        c:connect_signal("mouse::enter",function()
            maximized.image = "themes/default/titlebar/maximized_focus_active2.png"
        end)
        c:connect_signal("mouse::leave",function()
            maximized.image = "themes/default/titlebar/maximized_focus_active3.png"
        end)

        titlebartext = wibox.container.margin(awful.titlebar.widget.titlewidget(c),5)
        titlebartext.align = "left"
        awful.titlebar(c, { size = 28, bg_focus = beautiful.window_bg_focus, bg_normal = beautiful.window_bg_normal, fg_focus = beautiful.window_fg_focus, fg_normal = beautiful.window_fg_normal }) : setup {
            { -- Left
                {
                    titlebaricon,
                    layout = wibox.container.margin(titlebaricon,3,0,3)
                },
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    titlebartext,
                    layout = wibox.container.margin(titlebartext,-1)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
end)
