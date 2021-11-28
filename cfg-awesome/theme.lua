---------------------------
-- Default awesome theme --
---------------------------

-- You can add as many variables as you wish and access them by using beautiful.variable in your rc.lua:
-- theme.bg_widget = "#cc0000"

-- There are other variable sets overriding the default one when defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi
local gfs          = require("gears.filesystem")
local theme        = {}

theme.font = font

theme.hotkeys_modifiers_fg     = grey
theme.hotkeys_bg               = bg
theme.hotkeys_fg               = fg_l
theme.hotkeys_border_width     = border_width
theme.hotkeys_border_color     = fg_l
theme.hotkeys_font             = hotkeys_font
theme.hotkeys_description_font = hotkeys_font
theme.hotkeys_label_bg         = fg_d

theme.bg_normal   = bg
theme.bg_focus    = "#535d6c"
theme.bg_urgent   = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray  = bg
theme.fg_normal   = fg_l
theme.fg_focus    = "#ffffff"
theme.fg_urgent   = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.prompt_bg = fg_d
theme.prompt_fg = bg

theme.titlebar_bg_focus  = bg
theme.titlebar_fg_focus  = fg_l
theme.titlebar_bg_normal = grey -- "#4a4a4a"
theme.titlebar_fg_normal = fg_l

theme.border_width  = 0 -- dpi(0.1)
theme.border_normal = bg
theme.border_focus  = fg_d
theme.border_marked = red

-- local taglist_square_size   = dpi(5)
-- theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(taglist_square_size, fg_l)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, fg_l)
theme.taglist_fg_focus    = fg_d
theme.taglist_bg_focus    = bg
-- theme.taglist_fg_occupied = grey
-- theme.taglist_fg_empty    = grey_dark
-- theme.taglist_font        = font
-- theme.taglist_spacing     = 2




theme.useless_gap = dpi(1)

theme.notification_bg = bg --- do NOT remove this line

theme.menu_submenu_icon = awe_path .. "/submenu.png"
theme.menu_height       = dpi(20)
theme.menu_width        = dpi(220)
theme.menu_bg_normal    = bg
theme.menu_bg_focus     = bg
theme.menu_fg_normal    = fg_l
theme.menu_fg_focus     = fg_d
theme.menu_border_width = border_width
theme.menu_border_color = fg_l
theme.menu_font         = main_menu_font

-- {{{ titlebar icons 
theme.titlebar_close_button_normal              = awe_path .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = awe_path .. "/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = awe_path .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = awe_path .. "/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = awe_path .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = awe_path .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = awe_path .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = awe_path .. "/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = awe_path .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = awe_path .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = awe_path .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = awe_path .. "/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = awe_path .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = awe_path .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = awe_path .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = awe_path .. "/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = awe_path .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = awe_path .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = awe_path .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = awe_path .. "/titlebar/maximized_focus_active.png"
-- }}}
-- {{{ layout icons 
theme.layout_tile          = awe_path .. "/layouts/tile-dc.png"
theme.layout_tilebottom    = awe_path .. "/layouts/tilebottom-dc.png"
theme.layout_fairv         = awe_path .. "/layouts/fairv-dc.png"
theme.layout_max           = awe_path .. "/layouts/max-dc.png"
theme.layout_floating      = awe_path .. "/layouts/floating-dc.png"
-- theme.layout_fairh      = awe_path .. "/layouts/fairh-dc.png"
-- theme.layout_magnifier  = awe_path .. "/layouts/magnifier-dc.png"
-- theme.layout_fullscreen = awe_path .. "/layouts/fullscreen-dc.png"
-- theme.layout_tileleft   = awe_path .. "/layouts/tileleft-dc.png"
-- theme.layout_tiletop    = awe_path .. "/layouts/tiletop-dc.png"
-- theme.layout_spiral     = awe_path .. "/layouts/spiral-dc.png"
-- theme.layout_dwindle    = awe_path .. "/layouts/dwindle-dc.png"
-- theme.layout_cornernw   = awe_path .. "/layouts/cornernw-dc.png"
-- theme.layout_cornerne   = awe_path .. "/layouts/cornerne-dc.png"
-- theme.layout_cornersw   = awe_path .. "/layouts/cornersw-dc.png"
-- theme.layout_cornerse   = awe_path .. "/layouts/cornerse-dc.png"
--}}}

-- theme.wallpaper = themes_path.."default/background.png"

-- awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set, then the icons from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
