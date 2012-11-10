----------------------------------
--  Halfwit - awesome wm theme  --
--                              --
--  why did I name it this?     --
--  idunno                      --
----------------------------------

theme = {}

-- Set this to your wallpaper
theme.wallpaper_cmd = { "feh --bg-fill /home/r/media/wallpapers/dark-floral-pattern.png" }

theme.wploc = "/home/r/media/wallpapers/"

theme.wallpapers = { "dark-floral-pattern.png",
                     "abstract-fractal-gears.jpg", 
                     "doublesexy.jpg",
                     "natural1.jpeg",
                     "natural4.jpeg",
                     "poni2.png",
                     "sexy3.jpg",
                     "sexy5.jpg",
                     "fractal2.png"
}

theme.font          = "curemod 12"

theme.wibox_height = "15"
theme.wibox_bg_image = "/home/r/.config/awesome/themes/halfwit/wibox_bg.png"

theme.fg_normal     = "#a2a2a2"
theme.fg_focus      = "#4268f4"
theme.fg_urgent     = "#f62020"
theme.fg_minimize   = "#ffffff"

theme.bg_normal     = "#161616"
theme.bg_focus      = "#00000035"
theme.bg_urgent     = "#00000000"
theme.bg_minimize   = "#91919112"

theme.bg_urgent     = "#2b2b2b55"

theme.tasklist_bg_normal     = "#161616"
theme.tasklist_bg_focus      = "#050505"
theme.tasklist_bg_urgent     = "#ff0000"
theme.tasklist_bg_minimize   = "#00000000"

theme.tasklist_fg_normal     = theme.fg_normal
theme.tasklist_fg_focus      = "#73afb4"
theme.tasklist_fg_urgent     = theme.fg_urgent
theme.tasklist_fg_minimize   = "#555555"

theme.taglist_fg_focus = "#aab6f6"

theme.border_width  = "1"
theme.border_focus = "#404040"
theme.border_normal = "#0e0e0e"
theme.border_marked = ""


theme.taglist_squares_sel = ""
theme.taglist_squares_unsel = ""

theme.taglist_bg_focus = "#030303"
--theme.taglist_bg_focus = "#00000095"

theme.tasklist_floating_icon = ""

theme.menu_bg_focus = "#191919"

theme.menu_border_width = "1"
theme.menu_border_color = "#080808"
theme.menu_height = "17"
theme.menu_width  = "100"

--theme.awesome_icon = ""
theme.awesome_icon = "/home/r/.config/awesome/themes/halfwit/icon_dull_15x.jpg"
theme.menu_submenu_icon = ""

theme.taglist_icon_1 = "/home/r/.config/awesome/themes/halfwit/icons/tags/1.png"
theme.taglist_icon_2 = "/home/r/.config/awesome/themes/halfwit/icons/tags/2.png"
theme.taglist_icon_3 = "/home/r/.config/awesome/themes/halfwit/icons/tags/3.png"
theme.taglist_icon_4 = "/home/r/.config/awesome/themes/halfwit/icons/tags/4.png"
theme.taglist_icon_5 = "/home/r/.config/awesome/themes/halfwit/icons/tags/5.png"
theme.taglist_icon_6 = "/home/r/.config/awesome/themes/halfwit/icons/tags/6.png"
theme.taglist_icon_7 = "/home/r/.config/awesome/themes/halfwit/icons/tags/7.png"
theme.taglist_icon_8 = "/home/r/.config/awesome/themes/halfwit/icons/tags/8.png"

-- Widget icons
theme.widget_seperator = "/home/r/.config/awesome/themes/halfwit/icons/seperator.png"
theme.widget_arrow_seperator = "/home/r/.config/awesome/themes/halfwit/icons/arrow_sep.png"
theme.widget_battery = "/home/r/.config/awesome/themes/halfwit/icons/battery.png"
theme.widget_battery_unplugged = "/home/r/.config/awesome/themes/halfwit/icons/battery_unplugged.png"
theme.widget_memory = "/home/r/.config/awesome/themes/halfwit/icons/memory.png"
theme.widget_cpu = "/home/r/.config/awesome/themes/halfwit/icons/cpu.png"
theme.widget_thermal = "/home/r/.config/awesome/themes/halfwit/icons/thermal.png"
theme.widget_net_down = "/home/r/.config/awesome/themes/halfwit/icons/net_down.png"
theme.widget_net_up = "/home/r/.config/awesome/themes/halfwit/icons/net_up.png"
theme.widget_volume = "/home/r/.config/awesome/themes/halfwit/icons/volume.png"
theme.widget_music = "/home/r/.config/awesome/themes/halfwit/icons/music.png"

-- These don't matter but awesome gets upset if they're not specified
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"


-- I'm not going to share these icons because they depend on wibox size, but they are generated using 
-- http://ni.fr.eu.org/blog/awesome_icons/ , with 
-- mkicons --size 16x16 --fg trans --bg '#a2a2a2' --margin-top 2 --margin-right 2 --margin-left 2 --margin-bottom 2 --too-small 3

-- Just to confirm, if you want this to look good, you need to generate icons yourself, if not, just replace these lines with the stuff from the default theme, if you don't do either it'll give errors or something

theme.layout_fairh = "/home/r/.config/awesome/themes/halfwit/layouts/fairh.png"
theme.layout_fairv = "/home/r/.config/awesome/themes/halfwit/layouts/fairv.png"
theme.layout_floating = "/home/r/.config/awesome/themes/halfwit/layouts/floating.png"
theme.layout_magnifier = "/home/r/.config/awesome/themes/halfwit/layouts/magnifier.png"
theme.layout_max = "/home/r/.config/awesome/themes/halfwit/layouts/max.png"
theme.layout_fullscreen = "/home/r/.config/awesome/themes/halfwit/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/r/.config/awesome/themes/halfwit/layouts/tilebottom.png"
theme.layout_tileleft = "/home/r/.config/awesome/themes/halfwit/layouts/tileleft.png"
theme.layout_tile = "/home/r/.config/awesome/themes/halfwit/layouts/tile.png"
theme.layout_tiletop = "/home/r/.config/awesome/themes/halfwit/layouts/tiletop.png"
theme.layout_spiral = "/home/r/.config/awesome/themes/halfwit/layouts/spiral.png"
theme.layout_dwindle = "/home/r/.config/awesome/themes/halfwit/layouts/dwindle.png"

return theme
