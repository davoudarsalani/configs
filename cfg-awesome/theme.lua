---------------------------
-- Default awesome theme --
---------------------------

-- You can add as many variables as you wish and access them by using beautiful.variable in your rc.lua:
-- theme.bg_widget = '#cc0000'

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
-- theme.taglist_bg_focus = '#ff0000'

local theme_assets = require('beautiful.theme_assets')
local xresources   = require('beautiful.xresources')
local dpi          = xresources.apply_dpi
local gfs          = require('gears.filesystem')
local theme        = {}

theme.font = font

theme.hotkeys_modifiers_fg     = gruvbox_gray_d
theme.hotkeys_bg               = bg
theme.hotkeys_fg               = fg
theme.hotkeys_border_width     = border_width
theme.hotkeys_border_color     = border_color
theme.hotkeys_font             = hotkeys_font
theme.hotkeys_description_font = hotkeys_font
theme.hotkeys_label_bg         = fg
-- theme.hotkeys_shape
-- theme.hotkeys_label_fg
-- theme.hotkeys_group_margin

theme.bg_normal   = bg
theme.bg_focus    = bg
theme.bg_minimize = bg
theme.bg_urgent   = bg
--
theme.fg_normal   = gruvbox_gray_d
theme.fg_focus    = fg
theme.fg_minimize = gruvbox_blue
theme.fg_urgent   = gruvbox_red
--
theme.bg_systray  = bg

theme.prompt_bg = fg
theme.prompt_fg = bg

theme.border_width  = 0 -- dpi(0.1)
theme.border_normal = bg
theme.border_focus  = fg
theme.border_marked = gruvbox_red

-- local taglist_square_size   = dpi(5)
-- theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(taglist_square_size, fg)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, fg)
theme.taglist_fg_focus    = fg
theme.taglist_bg_focus    = bg
theme.taglist_fg_occupied = gruvbox_gray_d
theme.taglist_bg_occupied = bg
-- theme.taglist_fg_empty    = gruvbox_gray
-- theme.taglist_font        = font
-- theme.taglist_spacing     = 2

-- tasklist (https://awesomewm.org/apidoc/widgets/awful.widget.tasklist.html)
theme.tasklist_bg_normal   = bg
theme.tasklist_bg_focus    = bg
theme.tasklist_bg_minimize = bg
theme.tasklist_bg_urgent   = bg
--
theme.tasklist_fg_normal   = gruvbox_gray_d
theme.tasklist_fg_focus    = fg
theme.tasklist_fg_minimize = gruvbox_gray_dd
theme.tasklist_fg_urgent   = gruvbox_red
--
-- by default, the tasklist prepends some symbols in front of the client name.
-- this is used to notify that the client has some specific properties
-- that are currently enabled. this can be disabled like so:
theme.tasklist_plain_task_name = true

theme.useless_gap = dpi(1)

-- do NOT remove this line
theme.notification_bg = bg

theme.menu_submenu_icon = awe_path .. '/submenu-icons/chevron-right-1.png'
theme.menu_height       = dpi(20)
theme.menu_width        = dpi(220)
theme.menu_bg_normal    = bg
theme.menu_bg_focus     = bg
theme.menu_fg_normal    = fg
theme.menu_fg_focus     = gruvbox_blue
theme.menu_border_width = border_width
theme.menu_border_color = border_color
theme.menu_font         = my_menu_font

theme.titlebar_bg_normal = bg
theme.titlebar_bg_focus  = bg
theme.titlebar_bg_urgent = bg
--
theme.titlebar_fg_normal = gruvbox_gray_d
theme.titlebar_fg_focus  = fg
theme.titlebar_fg_urgent = gruvbox_red

-- titlebar icons 
theme.titlebar_floating_button_normal_inactive  = awe_path .. '/titlebar-zenburn/floating_normal_inactive.png'
theme.titlebar_floating_button_focus_inactive   = awe_path .. '/titlebar-zenburn/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_active    = awe_path .. '/titlebar-zenburn/floating_normal_active.png'
theme.titlebar_floating_button_focus_active     = awe_path .. '/titlebar-zenburn/floating_focus_active.png'
theme.titlebar_sticky_button_normal_inactive    = awe_path .. '/titlebar-zenburn/sticky_normal_inactive.png'
theme.titlebar_sticky_button_focus_inactive     = awe_path .. '/titlebar-zenburn/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_active      = awe_path .. '/titlebar-zenburn/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_active       = awe_path .. '/titlebar-zenburn/sticky_focus_active.png'
theme.titlebar_ontop_button_normal_inactive     = awe_path .. '/titlebar-zenburn/ontop_normal_inactive.png'
theme.titlebar_ontop_button_focus_inactive      = awe_path .. '/titlebar-zenburn/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_active       = awe_path .. '/titlebar-zenburn/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_active        = awe_path .. '/titlebar-zenburn/ontop_focus_active.png'
theme.titlebar_minimize_button_normal           = awe_path .. '/titlebar-zenburn/minimize_normal.png'
theme.titlebar_minimize_button_focus            = awe_path .. '/titlebar-zenburn/minimize_focus.png'
theme.titlebar_maximized_button_normal_inactive = awe_path .. '/titlebar-zenburn/maximized_normal_inactive.png'
theme.titlebar_maximized_button_focus_inactive  = awe_path .. '/titlebar-zenburn/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_active   = awe_path .. '/titlebar-zenburn/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_active    = awe_path .. '/titlebar-zenburn/maximized_focus_active.png'
theme.titlebar_close_button_normal              = awe_path .. '/titlebar-zenburn/close_normal.png'
theme.titlebar_close_button_focus               = awe_path .. '/titlebar-zenburn/close_focus.png'

-- layout icons
theme.layout_tile       = awe_path .. '/layouts/tile-1px-width.png'
theme.layout_tileleft   = awe_path .. '/layouts/tileleft.png'
theme.layout_tilebottom = awe_path .. '/layouts/tilebottom.png'
theme.layout_tiletop    = awe_path .. '/layouts/tiletop.png'
theme.layout_fairv      = awe_path .. '/layouts/fairv.png'
theme.layout_fairh      = awe_path .. '/layouts/fairh.png'
theme.layout_spiral     = awe_path .. '/layouts/spiral.png'
theme.layout_dwindle    = awe_path .. '/layouts/dwindle.png'
theme.layout_max        = awe_path .. '/layouts/max.png'
theme.layout_fullscreen = awe_path .. '/layouts/fullscreen.png'
theme.layout_magnifier  = awe_path .. '/layouts/magnifier.png'
theme.layout_floating   = awe_path .. '/layouts/floating.png'
theme.layout_cornernw   = awe_path .. '/layouts/cornernw.png'
theme.layout_cornerne   = awe_path .. '/layouts/cornerne.png'
theme.layout_cornersw   = awe_path .. '/layouts/cornersw.png'
theme.layout_cornerse   = awe_path .. '/layouts/cornerse.png'

-- theme.wallpaper = themes_path..'default/background.png'

-- awesome icon
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height,
    theme.bg_focus,
    theme.fg_focus
)

-- Define the icon theme for application icons.
-- If not set, then the icons from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
