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
local lain = require("lain")
require("client")

tags = {
    names  = {"CHROME", "TERM", "DB", "CODE"},
    layout = { config.layouts[1], config.layouts[1], config.layouts[1], config.layouts[1] }
}

-- tag imageboxes
chrometag = wibox.widget.imagebox(profileConfigPath.."newui/chrometag.png",true)
termtag = wibox.widget.imagebox(profileConfigPath.."newui/terminaltag.png",true)
dbtag = wibox.widget.imagebox(profileConfigPath.."newui/database.png",true)
codetag = wibox.widget.imagebox(profileConfigPath.."newui/code.png",true)

local tag_1 = {
    chrometag,
    layout = wibox.container.margin(chrometag,5,5,2,4)
}

local tag_2 = {
    termtag,
    layout = wibox.container.margin(termtag,5,3,2,4)
}

local tag_3 = {
    dbtag,
    layout = wibox.container.margin(dbtag,5,3,2,4)
}

local tag_4 = {
    codetag,
    layout = wibox.container.margin(codetag,3,2,2,4)
}

menubar.utils.terminal = config.terminal
mytextclock = wibox.widget.textclock(" %H:%M ")


-- Battery
baticon = wibox.widget.imagebox(beautiful.bat)
batbar = awful.widget.progressbar()
batbar:set_color(beautiful.fg_normal)
batbar:set_width(55)
batbar:set_ticks(true)
batbar:set_ticks_size(6)
batbar:set_background_color(beautiful.bg_normal)
batmargin = wibox.layout.margin(batbar, 7, 5, 6, 6)
batupd = lain.widget.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_perc = 100
            baticon:set_image(beautiful.ac)
        else
            bat_perc = tonumber(bat_now.perc)
            if bat_perc >= 98 then
                batbar:set_color("#8FEB8F")
            elseif bat_perc > 50 then
                batbar:set_color(beautiful.fg_normal)
                baticon:set_image(beautiful.bat)
            elseif bat_perc > 15 then
                batbar:set_color(beautiful.fg_normal)
                baticon:set_image(beautiful.bat_low)
            else
                batbar:set_color("#EB8F8F")
                baticon:set_image(beautiful.bat_no)
            end
        end
        batbar:set_value(bat_perc / 100)
    end
})
batwidget = wibox.widget.background(batmargin)
batwidget:set_bgimage(beautiful.widget_bg)

volicon = wibox.widget.imagebox(beautiful.vol)
volume = lain.widget.alsabar({
    width = 55,
    ticks = true,
    ticks_size = 6,
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(beautiful.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(beautiful.vol_low)
        else
            volicon:set_image(beautiful.vol)
        end
    end,
    colors =
    {
        background = beautiful.bg_normal,
        mute = "#EB8F8F",
        unmute = beautiful.fg_normal
    }
})
volmargin = wibox.layout.margin(volume.bar, 2, 7)
volmargin:set_top(6)
volmargin:set_bottom(6)
volumewidget = wibox.widget.background(volmargin)
volumewidget:set_bgimage(beautiful.widget_bg)

syscont = wibox.container.margin(mytextclock,10,10)
mytextclock_t = awful.tooltip({
    objects = { syscont },
    timer_function = function()
        return os.date("%b %d, %Y")
    end,
    delay_show = 1
})

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", util.wallpaper_changer)
awful.screen.connect_for_each_screen(function(s)
    local sgeo = s.geometry
    local index = s.index
    util.wallpaper_changer(s)
    tags[s] = awful.tag(tags.names, s, tags.layout)
    local taglineoffset = {
        20,
        45,
        67,
        87
    }
    local xoffset = (index-1) * sgeo.width
    s.tagline = wibox({
        border_width = 0,
        ontop = true,
        visible = true,
        type = "splash",
        x = xoffset + taglineoffset[1],
        y = 18,
        width = 22,
        height = 2,
        screen = s,
        bg = "#4082f788",
        fg = "#fefefe"
    })
    s.tagline:connect_signal("button::press", function(_,_,_,b)
        if b == 5 then awful.tag.viewidx(1)
        elseif b == 4 then awful.tag.viewidx(-1) end
    end)
    s:connect_signal("tag::history::update", function()
        local curclients = s.selected_tag:clients()
        local val = true
        for _, c in ipairs(curclients) do
            if c.fullscreen then
                val = false
                break
            end
        end
        s.tagline.visible = val
        s.tagline:emit_signal("widget::redraw_needed")
        if s.tags[1].selected then
                s.tagline.x = xoffset+taglineoffset[1]
        elseif s.tags[2].selected then
                s.tagline.x = xoffset+taglineoffset[2]
        elseif s.tags[3].selected then
                s.tagline.x = xoffset+taglineoffset[3]
        elseif s.tags[4].selected then
                s.tagline.x = xoffset+taglineoffset[4]
        end
    end)

    -- Create a tasklist widget for each screen
    local taskliststyle = { bg_focus = "#00000033", bg_normal = "#00000033", spacing = 0 }
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, keybindings.tasklist_buttons, taskliststyle)

    -- Create a wibox for each screen #31373a00
    s.wibar = awful.wibar({
        position = "top",
        screen = s,
        height = 20,
        bg = ""
    })
    -- Transparent on no maximized clients; opaque on 1 or more maximized clients
    --checkWibar(s.wibar, s)
    s:connect_signal("tag::history::update", function() util.check_wibar(s.wibar, s) end)

    -- Add widgets to the wibox
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.layoutbox(s),
            tag_1,
            tag_2,
            tag_3,
            tag_4
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            {
                wibox.widget.systray(),
                layout = wibox.layout.constraint
            },
            volicon,
            volumewidget,
            baticon,
            batwidget,
            syscont,
        },
    }
end)