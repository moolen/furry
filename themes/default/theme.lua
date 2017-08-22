---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
profileConfigPath = gfs.get_configuration_dir()

theme.font          = "Ubuntu Mono 10"

theme.bg_normal     = "#31373a"
theme.window_bg_normal = "#3d4346"
theme.window_bg_focus = "#31373a"
theme.bg_focus      = "#4082f7"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#44444422"
theme.bg_systray    = "#232729"

theme.fg_normal     = "#aaaaaa"
theme.window_fg_normal = "#aaa"
theme.fg_focus      = "#ffffff"
theme.window_fg_focus = "#aaa"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = 5
theme.border_width  = 0
theme.border_normal = "#8d8d8d"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Tasklist stuffs
theme.tasklist_plain_task_name = true
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true

-- Hotkeys dialog
theme.hotkeys_bg = "#31373a"
theme.hotkeys_fg = "#aaa"
theme.hotkeys_border_width = 1
theme.hotkeys_border_color = "#aaaaaa44"
theme.hotkeys_modifiers_fg = "#777"
theme.hotkeys_label_bg = "#000"
theme.hotkeys_label_fg = "#fff"
theme.hotkeys_font = "Roboto 9"
theme.hotkeys_description_font = "Roboto 9"

-- Prompt dialog
theme.prompt_fg = "#aaa"
theme.prompt_bg = "#000"


theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.titlebar_close_button_normal = profileConfigPath.."themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_normal_hover = profileConfigPath.."themes/default/titlebar/close_normal_hover.png"
theme.titlebar_close_button_normal_press = profileConfigPath.."themes/default/titlebar/close_normal_press.png"
theme.titlebar_close_button_focus  = profileConfigPath.."themes/default/titlebar/close_focus.png"
theme.titlebar_close_button_focus_hover = profileConfigPath.."themes/default/titlebar/close_focus_hover.png"
theme.titlebar_close_button_focus_press = profileConfigPath.."themes/default/titlebar/close_focus_press.png"

theme.titlebar_minimize_button_normal = profileConfigPath.."themes/default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_normal_hover = profileConfigPath.."themes/default/titlebar/minimize_normal_hover.png"
theme.titlebar_minimize_button_normal_press = profileConfigPath.."themes/default/titlebar/minimize_normal_press.png"
theme.titlebar_minimize_button_focus  = profileConfigPath.."themes/default/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_focus_hover = profileConfigPath.."themes/default/titlebar/minimize_focus_hover.png"
theme.titlebar_minimize_button_focus_press = profileConfigPath.."themes/default/titlebar/minimize_focus_press.png"

theme.titlebar_maximized_button_normal_inactive = profileConfigPath.."themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_normal_inactive_hover = profileConfigPath.."themes/default/titlebar/maximized_normal_inactive_hover.png"
theme.titlebar_maximized_button_normal_inactive_press = profileConfigPath.."themes/default/titlebar/maximized_normal_inactive_press.png"
theme.titlebar_maximized_button_focus_inactive  = profileConfigPath.."themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_focus_inactive_hover = profileConfigPath.."themes/default/titlebar/maximized_focus_inactive_hover.png"
theme.titlebar_maximized_button_focus_inactive_press = profileConfigPath.."themes/default/titlebar/maximized_focus_inactive_press.png"

theme.titlebar_maximized_button_normal_active = profileConfigPath.."themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_normal_active_hover = profileConfigPath.."themes/default/titlebar/maximized_normal_active_hover.png"
theme.titlebar_maximized_button_normal_active_press = profileConfigPath.."themes/default/titlebar/maximized_normal_active_press.png"
theme.titlebar_maximized_button_focus_active  = profileConfigPath.."themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_focus_active_hover = profileConfigPath.."themes/default/titlebar/maximized_focus_active_hover.png"
theme.titlebar_maximized_button_focus_active_press = profileConfigPath.."themes/default/titlebar/maximized_focus_active_press.png"

theme.wallpaper = themes_path.."default/background.png"

theme.vol = profileConfigPath .. "themes/default/icons/vol.png"
theme.vol_low  = profileConfigPath .. "themes/default/icons/vol_low.png"
theme.vol_no = profileConfigPath .. "themes/default/icons/vol_no.png"
theme.vol_mute = profileConfigPath .. "themes/default/icons/vol_mute.png"

theme.bat                                       = profileConfigPath .. "themes/default/icons/bat.png"
theme.bat_low                                   = profileConfigPath .. "themes/default/icons/bat_low.png"
theme.bat_no                                    = profileConfigPath .. "themes/default/icons/bat_no.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
theme.layout_termfair    = themes_path .. "termfair.png"
theme.layout_centerfair  = themes_path .. "centerfair.png"  -- termfair.center
theme.layout_cascade     = themes_path .. "cascade.png"
theme.layout_cascadetile = themes_path .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork  = themes_path .. "centerwork.png"
theme.layout_centerhwork = themes_path .. "centerworkh.png" -- centerwork.horizontal


theme.awesome_icon = profileConfigPath.."newui/applauncher.png"

theme.icon_theme = "breeze"

return theme
