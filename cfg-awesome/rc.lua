-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


mouse.coords({
  x = 683,
  y = 192,
})


local keyboardlayout = require('keyboardlayout')

network_refresh_interval = os.getenv('network_refresh_interval')

no_of_tags = 3
tag_indexes = {}
--
for i = 1, no_of_tags do
  tag_indexes[i] = tostring(i)
end
-- '--> {'1', '2', '3'}

gruvbox_fg    = os.getenv('gruvbox_fg')
gruvbox_bg    = os.getenv('gruvbox_bg')
--
gruvbox_fg_d  = os.getenv('gruvbox_fg_d')
gruvbox_bg_d  = os.getenv('gruvbox_bg_d')
--
gruvbox_gray   = os.getenv('gruvbox_gray')
gruvbox_red    = os.getenv('gruvbox_red')
gruvbox_green  = os.getenv('gruvbox_green')
gruvbox_yellow = os.getenv('gruvbox_yellow')
gruvbox_blue   = os.getenv('gruvbox_blue')
gruvbox_purple = os.getenv('gruvbox_purple')
gruvbox_aqua   = os.getenv('gruvbox_aqua')
gruvbox_orange = os.getenv('gruvbox_orange')
--
gruvbox_gray_d   = os.getenv('gruvbox_gray_d')
gruvbox_red_d    = os.getenv('gruvbox_red_d')
gruvbox_green_d  = os.getenv('gruvbox_green_d')
gruvbox_yellow_d = os.getenv('gruvbox_yellow_d')
gruvbox_blue_d   = os.getenv('gruvbox_blue_d')
gruvbox_purple_d = os.getenv('gruvbox_purple_d')
gruvbox_aqua_d   = os.getenv('gruvbox_aqua_d')
gruvbox_orange_d = os.getenv('gruvbox_orange_d')
--
gruvbox_gray_dd  = os.getenv('gruvbox_gray_dd')

widget_colors = {
  -- gruvbox_gray,
  -- gruvbox_red,
  gruvbox_green,
  gruvbox_blue,
  gruvbox_yellow,
  gruvbox_purple,
  gruvbox_aqua,
  gruvbox_orange,
}

bg = gruvbox_bg_d
fg = gruvbox_fg_d

kb_fg__awesome = gruvbox_blue

font         = 'Sans 7'
hotkeys_font = 'Sans 8'
message_font = 'Sans 8'
my_menu_font = 'Sans 8'

border_width = 0.5
border_color = gruvbox_gray_d

terminal = os.getenv('terminal')
home     = os.getenv('HOME')

hns      = home .. '/main/scripts'
hni      = home .. '/main/icons'
awe_path = home .. '/.config/awesome'

M = 'Mod4'  -- win key
S = 'Shift'
C = 'Control'
A = 'Mod1'  -- alt key

-- normal notification:
naughty.config.presets.normal['bg']               = bg
naughty.config.presets.normal['fg']               = fg
naughty.config.presets.normal['border_color']     = border_color     -- default: beautiful.notification_border_color or beautiful.border_focus or '#535d6c'
naughty.config.presets.normal['border_width']     = border_width     -- do NOT move to theme config file
naughty.config.presets.normal['font']             = message_font     -- default: beautiful.notification_font or ...
naughty.config.presets.normal['position']         = 'top_right'      -- default: top_right. Values: 'top_right', 'top_left', ...
naughty.config.presets.normal['margin']           = 10
naughty.config.presets.normal['timeout']          = 10
naughty.config.presets.normal['icon_size']        = 32               -- OR dpi(32)
-- naughty.config.presets.normal['max_height']    = 32               -- default: beautiful.notification_height or auto
-- naughty.config.presets.normal['max_width']     = 32               -- default: beautiful.notification_width or auto
-- naughty.config.presets.normal['ontop']         = true             -- default: true
-- naughty.config.presets.normal['hover_timeout'] = 0
-- naughty.config.presets.normal['screen']        = 1                -- default: 'focused'
-- naughty.config.presets.normal['text']          = 'message text'   -- default: ''
-- naughty.config.presets.normal['height']        = 60               -- default: beautiful.notification_height or auto
-- naughty.config.presets.normal['width']         = 100              -- default: beautiful.notification_width or auto
-- naughty.config.presets.normal['icon']          = '<PATH>'
-- naughty.config.presets.normal['opacity']       = 1                -- default beautiful.notification_opacity
-- naughty.config.presets.normal['run']           =                  -- Function to run on left click. The notification object will be passed to it as an argument. You need to call e.g. notification.die(naughty.notificationClosedReason.dismissedByUser) from there to dismiss the notification yourself
-- naughty.config.presets.normal['destroy']       =                  -- Function to run when notification is destroyed
-- naughty.config.presets.normal['preset']        =                  --
--
-- critical notification:
naughty.config.presets.critical['bg']           = gruvbox_red_d      -- default: '#ff0000'
naughty.config.presets.critical['border_color'] = border_color
naughty.config.presets.critical['border_width'] = border_width
naughty.config.presets.critical['margin']       = 10


-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title  = 'Startup Error',
    icon   = home .. '/main/linux/themes/alert-w.png',
    text   = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title  = 'Error',
      icon   = home .. '/main/linux/themes/alert-w.png',
      text   = tostring(err)
    })
    in_error = false
  end)
end


function run_in_shell(cmnd)
  awful.spawn.with_shell(cmnd)
end


-- https://www.reddit.com/r/awesomewm/comments/kitgn9/useless_gaps/
function resize_gap(new_gap)
  local t = awful.screen.focused().selected_tag
  t.gap = t.gap + tonumber(new_gap)
  awful.layout.arrange(awful.screen.focused())
end


function run_script(script_name, arg1, arg2)
  if arg1 == nil then
    run_in_shell(hns .. '/' .. script_name)
  elseif arg2 == nil then
    run_in_shell(hns .. '/' .. script_name .. ' ' .. arg1)
  else
    run_in_shell(hns .. '/' .. script_name .. ' ' .. arg1 .. ' ' .. arg2)
  end
end


function create_textbox(text)
  return wibox.widget {
    markup = text,
    valign = 'center',
    widget = wibox.widget.textbox,
  }
end


function create_watch(arg1, arg2, interval)
  local script_name
  local args

  if arg1 == 'network' then
    script_name = 'awesome-widgets-network.sh'
  else
    script_name = 'awesome-widgets.sh'
  end

  if arg2 == nil then
    args = arg1
  else
    args = arg1 .. ' ' .. arg2
  end

  awful.widget.watch(
    'bash -c "' .. hns .. '/' .. script_name .. ' ' .. args .. '"',
    interval
  )
end


function create_container(widg, fg_)
  -- add color
  local colored_container = wibox.container {
    widg,
    widget = wibox.container.background,
    bg     = bg,
    fg     = fg_,
    shape  = gears.shape.rounded_rect,
  }

  -- add margin
  local margined_container = wibox.container {
    colored_container,
    widget = wibox.container.margin,
    top    = 0,
    bottom = 0,
    right  = 3,
    left   = 3,
  }
  return margined_container
end


-- shares structure with create_description function is tmux.lua
function create_description(kb_fg, desc, grp)
  return {
    description='  <span color="' .. kb_fg .. '">' .. desc .. '</span>',
    group=grp
  }
end


function rename_tag()
  awful.prompt.run {
    prompt       = ' Rename tag: ',
    textbox      = awful.screen.focused().mypromptbox.widget,
    exe_callback = function(new_name)
      if not new_name or #new_name == 0 then return end
      local t = awful.screen.focused().selected_tag
      if t then t.name = new_name end
    end
  }
end


function create_tag()
  awful.prompt.run {
    prompt       = ' New tag: ',
    textbox      = awful.screen.focused().mypromptbox.widget,
    exe_callback = function(new_tag)
      if not new_tag or #new_tag == 0 then return end
      awful.tag.add(
        new_tag,
        {
          screen = awful.screen.focused(),
          layout = awful.layout.suit.floating
        }
      ):view_only()
    end
  }
end


function delete_tag()
  awful.prompt.run {
    prompt       = ' Delete tag (y/n)? ',
    textbox      = awful.screen.focused().mypromptbox.widget,
    exe_callback = function(delete_tag)
      if not delete_tag or #delete_tag == 0 or delete_tag ~= 'y' then return end
      local t = awful.screen.focused().selected_tag
      if not t then return end
      t:delete()
    end
  }
end


-- Themes define colours, icons, font and wallpapers.
beautiful.init(awe_path .. '/theme.lua')
-- ORIGINAL:
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,  -- put at the top
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.floating,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- Menu

apps_options = {
  { ' Audacious',            function() run_script('awesome-apps.sh', 'audacious'           ) end, hni .. '/ePapirus-Dark/16x16/apps/audacious.svg'},
  { ' Blueman Applet',       function() run_script('awesome-apps.sh', 'blueman_applet'      ) end, hni .. '/ePapirus-Dark/16x16/apps/preferences-system-bluetooth.svg'},
  { ' Blueman Manager',      function() run_script('awesome-apps.sh', 'blueman_manager'     ) end, hni .. '/ePapirus-Dark/16x16/apps/preferences-system-bluetooth.svg'},
  { ' Chromium',             function() run_script('awesome-apps.sh', 'chromium'            ) end, hni .. '/ePapirus-Dark/16x16/apps/chromium-browser.svg'},
  { ' DbGate',               function() run_script('awesome-apps.sh', 'dbgate'              ) end, hni .. '/ePapirus-Dark/16x16/apps/mysql-workbench.svg'},
  { ' Firefox',              function() run_script('awesome-apps.sh', 'firefox'             ) end, hni .. '/ePapirus-Dark/16x16/apps/firefox.svg'},
  { ' Gedit',                function() run_script('awesome-apps.sh', 'gedit'               ) end, hni .. '/ePapirus-Dark/16x16/apps/gedit.svg'},
  { ' GIMP',                 function() run_script('awesome-apps.sh', 'gimp'                ) end, hni .. '/ePapirus-Dark/16x16/apps/gimp.svg'},
  { ' GoldenDict',           function() run_script('awesome-apps.sh', 'goldendict'          ) end, hni .. '/ePapirus-Dark/16x16/apps/accessories-dictionary.svg'},
  { ' GParted',              function() run_script('awesome-apps.sh', 'gparted'             ) end, hni .. '/ePapirus-Dark/16x16/apps/gparted.svg'},
  { ' KeePass',              function() run_script('awesome-apps.sh', 'keepass'             ) end, hni .. '/ePapirus-Dark/16x16/apps/keepass.svg'},
  { ' LibreOffice',          function() run_script('awesome-apps.sh', 'libreoffice'         ) end, hni .. '/ePapirus-Dark/16x16/apps/libreoffice-base.svg'},
  { ' simplescreenrecorder', function() run_script('awesome-apps.sh', 'simplescreenrecorder') end, hni .. '/ePapirus-Dark/16x16/apps/simplescreenrecorder.svg'},
  { ' Sublime',              function() run_script('awesome-apps.sh', 'sublime'             ) end, hni .. '/ePapirus-Dark/16x16/apps/sublime-text.svg'},
  { ' Terminal',             function() run_script('awesome-apps.sh', 'terminal'            ) end, hni .. '/ePapirus-Dark/16x16/apps/utilities-terminal.svg'},
  { ' Terminal + Tmux',      function() run_script('awesome-apps.sh', 'terminal_tmux'       ) end, hni .. '/ePapirus-Dark/16x16/apps/utilities-terminal.svg'},
  { ' Terminal + Torsocks',  function() run_script('awesome-apps.sh', 'terminal_torsocks'   ) end, hni .. '/ePapirus-Dark/16x16/apps/utilities-terminal.svg'},
  { ' Thunar',               function() run_script('awesome-apps.sh', 'thunar'              ) end, hni .. '/ePapirus-Dark/16x16/apps/thunar.svg'},
  { ' uGet',                 function() run_script('awesome-apps.sh', 'uget'                ) end, hni .. '/ePapirus-Dark/16x16/apps/uget.svg'},
  { ' Visual Studio Code',   function() run_script('awesome-apps.sh', 'visual-studio-code'  ) end, hni .. '/ePapirus-Dark/16x16/apps/visual-studio-code.svg'},
  { ' vlc',                  function() run_script('awesome-apps.sh', 'vlc'                 ) end, hni .. '/ePapirus-Dark/16x16/apps/vlc.svg'},
  { ' xreader',              function() run_script('awesome-apps.sh', 'xreader'             ) end, hni .. '/ePapirus-Dark/16x16/apps/document-viewer.svg'},
}

power_options = {
  { ' Shutdown',                       function() run_script('awesome-power.sh', 'shutdown'                        ) end, hni .. '/ePapirus-Dark/16x16/actions/action-unavailable.svg'},
  { ' Shutdown + Clear Clipboard',     function() run_script('awesome-power.sh', '"shutdown + clear clipboard"'    ) end, hni .. '/ePapirus-Dark/16x16/actions/action-unavailable.svg'},
  { ' Reboot',                         function() run_script('awesome-power.sh', 'reboot'                          ) end, hni .. '/ePapirus-Dark/16x16/actions/view-refresh.svg'},
  { ' Reboot + Clear Clipboard',       function() run_script('awesome-power.sh', '"reboot + clear clipboard"'      ) end, hni .. '/ePapirus-Dark/16x16/actions/view-refresh.svg'},
  { ' Lock',                           function() run_script('awesome-power.sh', 'lock'                            ) end, hni .. '/ePapirus-Dark/16x16/actions/database-lock.svg'},
  { ' Screen Off',                     function() run_script('awesome-power.sh', '"screen off"'                    ) end, hni .. '/ePapirus-Dark/16x16/actions/contrast.svg'},
  { ' Quit Awesome',                   function() run_script('awesome-power.sh', '"quit awesome"'                  ) end, hni .. '/ePapirus-Dark/16x16/actions/action-unavailable.svg'},
  { ' Quit Awesome + Clear Clipboard', function() run_script('awesome-power.sh', '"quit awesome + clear clipboard"') end, hni .. '/ePapirus-Dark/16x16/actions/action-unavailable.svg'},
  { ' Restart Awesome',                function() run_script('awesome-power.sh', '"restart awesome"'               ) end, hni .. '/ePapirus-Dark/16x16/actions/view-refresh.svg'},
}

mymainmenu = awful.menu({
  items = {
    { ' Apps',  apps_options,  hni .. '/ePapirus-Dark/16x16/actions/view-grid.svg'     },
    { ' Power', power_options, hni .. '/ePapirus-Dark/16x16/actions/code-function.svg' },
    { ' Hot Keys',
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
        hni .. '/ePapirus-Dark/16x16/actions/configure-shortcuts.svg'
    },
  },
})


-- mylauncher = awful.widget.launcher({
--   image = beautiful.awesome_icon,
--   menu  = mymainmenu,
-- })


-- Menubar configuration
menubar.utils.terminal = terminal  -- Set the terminal for applications that require it


-- Wibar

-- textboxes and watches
clock           = create_textbox('00:00')
clock_wc        = create_watch('clock', nil, 50)
kb_layout       = keyboardlayout()
audio           = create_textbox('')
audio_wch       = create_watch('audio', nil, 5)
memory_cpu      = create_textbox('')
memory_cpu_wch  = create_watch('memory_cpu', 'usage', 5)
harddisk        = create_textbox('')
harddisk_wch    = create_watch('harddisk', 'usage', 60)
processes       = create_textbox('')
processes_wch   = create_watch('processes', nil, 60)
status          = create_textbox('')
status_wch      = create_watch('status', nil, 3600)
mbl_umbl        = create_textbox('')
mbl_umbl_wch    = create_watch('mbl_umbl', nil, 60)
firewall        = create_textbox('')
firewall_wch    = create_watch('firewall', nil, 60)
bluetooth       = create_textbox('')
bluetooth_wch   = create_watch('bluetooth', nil, 60)
ymail           = create_textbox('')
ymail_wch       = create_watch('ymail', nil, 3600)
gmail           = create_textbox('')
gmail_wch       = create_watch('gmail', nil, 3600)
clipboard       = create_textbox('')
clipboard_wch   = create_watch('clipboard', nil, 10)
established     = create_textbox('')
established_wch = create_watch('established', nil, 10)
open_ports      = create_textbox('')
open_ports_wch  = create_watch('open_ports', nil, 10)
tor             = create_textbox('')
tor_wch         = create_watch('tor', nil, 10)
git             = create_textbox('')
git_wch         = create_watch('git', nil, 60)

network_wch     = create_watch('network', nil, network_refresh_interval)
--
nw_connection   = create_textbox('')
nw_down_up      = create_textbox('')
nw_total        = create_textbox('')

ping            = create_textbox('')
ping_wch        = create_watch('ping', nil, 30)

audacious       = create_textbox('')
audacious_wch   = create_watch('audacious', nil, 10)
audacious_bar   = wibox.widget {
  widget           = wibox.widget.progressbar,
  max_value        = 1,
  forced_width     = 60,
  forced_height    = 20,
  paddings         = 0,
  background_color = fg,
  color            = gruvbox_blue_d,
  shape            = gears.shape.bar,
  clip             = true,
  margins          = {
    top    = 0,
    bottom = 0,
    left   = 2,
    right  = 2,
  },
}
audacious_bar_v = wibox.widget {
  audacious_bar,
  forced_height = 20,
  forced_width  = 3,
  direction     = 'east',
  layout        = wibox.container.rotate,
}


-- containers
clock_ct           = create_container(clock,           widget_colors[1])
kb_layout_ct       = create_container(kb_layout,       widget_colors[2])
audio_ct           = create_container(audio,           widget_colors[3])
memory_cpu_ct      = create_container(memory_cpu,      widget_colors[4])
harddisk_ct        = create_container(harddisk,        widget_colors[5])
processes_ct       = create_container(processes,       widget_colors[6])
status_ct          = create_container(status,          widget_colors[1])
mbl_umbl_ct        = create_container(mbl_umbl,        widget_colors[2])
firewall_ct        = create_container(firewall,        widget_colors[3])
bluetooth_ct       = create_container(bluetooth,       widget_colors[4])
ymail_ct           = create_container(ymail,           widget_colors[5])
gmail_ct           = create_container(gmail,           widget_colors[5])
clipboard_ct       = create_container(clipboard,       widget_colors[6])
established_ct     = create_container(established,     widget_colors[1])
open_ports_ct      = create_container(open_ports,      widget_colors[2])
tor_ct             = create_container(tor,             widget_colors[3])
git_ct             = create_container(git,             widget_colors[4])
nw_connection_ct   = create_container(nw_connection,   widget_colors[5])
nw_down_up_ct      = create_container(nw_down_up,      fg)
nw_total_ct        = create_container(nw_total,        gruvbox_gray)
ping_ct            = create_container(ping,            gruvbox_red)
--
audacious_ct       = create_container(audacious,       fg)
audacious_bar_v_ct = create_container(audacious_bar_v, fg)


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  -- ...,
  awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
)


local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function (c)
    if c == client.focus then
      c.minimized = true
      awful.client.focus.byidx(1)
    else
      c:emit_signal(
        'request::activate',
        'tasklist',
        {raise = true}
      )
      client.focus = c
      c:raise()
      c.minimized = false
    end
  end),
  -- ...,
  awful.button({}, 4, function ()
    awful.client.focus.byidx(-1)
  end),
  awful.button({}, 5, function ()
    awful.client.focus.byidx(1)
  end)
)


audio_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'audio', 'toggle_vol') end),
  awful.button({ }, 4, function() run_script('awesome-widgets.sh', 'audio', 'vol_up'    ) end),
  awful.button({ }, 5, function() run_script('awesome-widgets.sh', 'audio', 'vol_down'  ) end)
))

memory_cpu_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'memory_cpu', 'intensives') end)
))

status_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'status') end)
))

mbl_umbl_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'mbl_umbl') end)
))

firewall_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'firewall', 'turn_on' ) end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'firewall', 'turn_off') end)
))

bluetooth_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'bluetooth', 'turn_on' ) end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'bluetooth', 'turn_off') end)
))

ymail_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'ymail') end)
))

gmail_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'gmail') end)
))

clipboard_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'clipboard', 'start') end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'clipboard', 'stop' ) end)
))

established_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'established', 'message') end)
))

open_ports_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'open_ports', 'message') end)
))

tor_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'tor', 'start') end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'tor', 'stop' ) end)
))

git_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'git') end)
))

ping_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'ping') end)
))

audacious_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'audacious', 'play_pause') end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'audacious', 'next'      ) end),
  awful.button({ }, 4, function() run_script('awesome-widgets.sh', 'audacious', '+60'       ) end),
  awful.button({ }, 5, function() run_script('awesome-widgets.sh', 'audacious', '-60'       ) end)
))

audacious_bar_v_ct:buttons(gears.table.join(
  awful.button({ }, 1, function() run_script('awesome-widgets.sh', 'audacious', 'play_pause') end),
  awful.button({ }, 3, function() run_script('awesome-widgets.sh', 'audacious', 'next'      ) end),
  awful.button({ }, 4, function() run_script('awesome-widgets.sh', 'audacious', '+60'       ) end),
  awful.button({ }, 5, function() run_script('awesome-widgets.sh', 'audacious', '-60'       ) end)
))


local function set_wallpaper(s)
  gears.wallpaper.maximized(
    awe_path .. '/wallpaper.png',
    s,
    true
  )
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


awful.screen.connect_for_each_screen( function(s)
  wibox.widget.systray().visible = false

  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(tag_indexes, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.noempty,  -- noempty/selected/all
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    style   = {
      shape = gears.shape.rounded_rect,
    },

    layout = {
      spacing = 10,
      spacing_widget = {
          {
              forced_width = 4,
              shape        = gears.shape.circle,
              widget       = wibox.widget.separator,
          },
          valign = "center",
          halign = "center",
          widget = wibox.container.place,
      },
      layout = wibox.layout.flex.horizontal,
    },

    -- https://awesomewm.org/doc/api/classes/awful.widget.tasklist.html
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
          {
              {
                  {
                      id     = 'icon_role',
                      widget = wibox.widget.imagebox,
                  },
                  margins = 5,
                  widget  = wibox.container.margin,
              },
              {
                  id     = 'text_role',
                  widget = wibox.widget.textbox,
              },
              layout = wibox.layout.fixed.horizontal,
          },
          left  = 5,
          right = 5,
          widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }

  -- Create the wibox
  s.topwibox = awful.wibar({
    position = 'top',
    ontop    = true,
    screen   = s,
    bg       = bg,
    fg       = fg,
  })

  -- Add widgets to the wibox
  s.topwibox:setup {
    layout = wibox.layout.align.horizontal,

    -- Left widgets
    {
      layout = wibox.layout.fixed.horizontal,
      s.mypromptbox,
      wibox.widget.systray(),
      s.mylayoutbox,
      s.mytaglist,

      clock_ct,
      kb_layout_ct,
      audio_ct,
      memory_cpu_ct,
      harddisk_ct,
      processes_ct,
      status_ct,
      mbl_umbl_ct,
      firewall_ct,
      bluetooth_ct,
      ymail_ct,
      gmail_ct,
      clipboard_ct,
      established_ct,
      open_ports_ct,
      tor_ct,
      git_ct,
      nw_connection_ct,
      nw_down_up_ct,
      nw_total_ct,
      ping_ct,
    },

    -- Middle widget
    s.mytasklist,

    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      audacious_ct,
      audacious_bar_v_ct,
    },
  }
end)


-- Mouse bindings
root.buttons(gears.table.join(
  awful.button({ }, 1, function() mymainmenu:hide() end),
  awful.button({ }, 3, function() mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewprev),
  awful.button({ }, 5, awful.tag.viewnext)
))


-- Key bindings
globalkeys = gears.table.join(
  awful.key({ M    }, 'F1',  function() run_script('speech.sh', 'play') end, create_description(kb_fg__awesome, 'play', 'speech')),
  awful.key({ M, S }, 'F1',  function() run_script('speech.sh', 'move') end, create_description(kb_fg__awesome, 'move', 'speech')),
  awful.key({ M, C }, 'F1',  function() run_script('speech.sh', 'add_4') end, create_description(kb_fg__awesome, 'add 4', 'speech')),
  awful.key({ M    }, 'F2',  function() run_script('music.sh') end, create_description(kb_fg__awesome, 'play' , 'music')),
  awful.key({ M    }, 'F3',  function() run_script('movie.sh', 'select') end, create_description(kb_fg__awesome, 'select', 'movie')),
  awful.key({ M, S }, 'F3',  function() run_script('movie.sh', 'random') end, create_description(kb_fg__awesome, 'random', 'movie')),
  awful.key({ M    }, 'F4',  function() awful.layout.set(awful.layout.suit.tile) end, create_description(kb_fg__awesome, 'tile', 'layout')),
  awful.key({ M, S }, 'F4',  function() awful.layout.set(awful.layout.suit.floating) end, create_description(kb_fg__awesome, 'floating', 'layout')),
  awful.key({ M    }, 'F5',  rename_tag, create_description(kb_fg__awesome, 'rename tag', 'screen/tag')),
  awful.key({ M    }, 'F6',  delete_tag, create_description(kb_fg__awesome, 'delete tag', 'screen/tag')),
  awful.key({ M    }, 'F7',  create_tag, create_description(kb_fg__awesome, 'new tag', 'screen/tag')),
  awful.key({ M    }, 'F8',  function() mouse.screen.topwibox.ontop   = not mouse.screen.topwibox.ontop   end, create_description(kb_fg__awesome, 'toggle ontop',      'topwibox')),
  awful.key({ M    }, 'F9',  function() mouse.screen.topwibox.visible = not mouse.screen.topwibox.visible end, create_description(kb_fg__awesome, 'toggle visibility', 'topwibox')),
                             -- OR: function() awful.screen.focused().topwibox.visible = not awful.screen.focused().topwibox.visible end
                             --     (https://wiki.archlinux.org/index.php/awesome)
  --
  awful.key({ M    }, 'F10', function() wibox.widget.systray().visible = not wibox.widget.systray().visible end, create_description(kb_fg__awesome, '', 'systray')),
  -- '--> https://pavelmakhov.com/2018/01/hide-systray-in-awesome/
  --
  awful.key({ M    }, 'F11', function() end, create_description(kb_fg__awesome, '', '--')),
  awful.key({ M    }, 'F12', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, create_description(kb_fg__awesome, '', 'keybindings')),

  -- go to previous/next screen
  awful.key({ M       }, 'Left',        function() awful.screen.focus_relative(-1) end, create_description(kb_fg__awesome, 'previous screen', 'screen/tag')),  -- OR function() awful.screen.focus_bydirection('left') end)
  awful.key({ M       }, 'Right',       function() awful.screen.focus_relative(1) end, create_description(kb_fg__awesome, 'next screen', 'screen/tag')),  -- OR function() awful.screen.focus_bydirection('right') end)

  -- go to screen 1/2
  awful.key({ M       }, '1',           function() awful.screen.focus(1) end, create_description(kb_fg__awesome, 'screen 1', 'screen/tag')),
  awful.key({ M       }, '2',           function() awful.screen.focus(2) end, create_description(kb_fg__awesome, 'screen 2', 'screen/tag')),

  -- go to previous/next tag
  awful.key({ M, S    }, 'Left',        awful.tag.viewprev, create_description(kb_fg__awesome, 'previous tag', 'screen/tag')),
  awful.key({ M, S    }, 'Right',       awful.tag.viewnext, create_description(kb_fg__awesome, 'next tag', 'screen/tag')),

  -- go to tag 1/2/3
  -- JUMP_2

  -- audio
  awful.key({         }, 'KP_Insert',   function() run_script('awesome-widgets.sh', 'audio', 'vol_30')     end, create_description(kb_fg__awesome, 'volume 30',       'audio')),
  awful.key({         }, 'KP_Down',     function() run_script('awesome-widgets.sh', 'audio', 'vol_up')     end, create_description(kb_fg__awesome, 'increase volume', 'audio')),
  awful.key({         }, 'KP_End',      function() run_script('awesome-widgets.sh', 'audio', 'vol_down')   end, create_description(kb_fg__awesome, 'decrease volume', 'audio')),
  awful.key({ S       }, 'KP_Down',     function() run_script('awesome-widgets.sh', 'audio', 'vol_100')    end, create_description(kb_fg__awesome, 'volume 100',      'audio')),
  awful.key({ S       }, 'KP_End',      function() run_script('awesome-widgets.sh', 'audio', 'vol_0')      end, create_description(kb_fg__awesome, 'volume 0',        'audio')),
  awful.key({         }, 'KP_Next',     function() run_script('awesome-widgets.sh', 'audio', 'toggle_vol') end, create_description(kb_fg__awesome, 'toggle vol',      'audio')),
  awful.key({         }, 'KP_Begin',    function() run_script('awesome-widgets.sh', 'audio', 'mic_up')     end, create_description(kb_fg__awesome, 'increase mic',    'audio')),
  awful.key({         }, 'KP_Left',     function() run_script('awesome-widgets.sh', 'audio', 'mic_down')   end, create_description(kb_fg__awesome, 'decrease mic',    'audio')),
  awful.key({ S       }, 'KP_Begin',    function() run_script('awesome-widgets.sh', 'audio', 'mic_100')    end, create_description(kb_fg__awesome, 'mic 100',         'audio')),
  awful.key({ S       }, 'KP_Left',     function() run_script('awesome-widgets.sh', 'audio', 'mic_0')      end, create_description(kb_fg__awesome, 'mic 0',           'audio')),
  awful.key({         }, 'KP_Right',    function() run_script('awesome-widgets.sh', 'audio', 'toggle_mic') end, create_description(kb_fg__awesome, 'toggle mic',      'audio')),
  awful.key({         }, 'KP_Up',       function() run_script('awesome-widgets.sh', 'audio', 'mon_up')     end, create_description(kb_fg__awesome, 'increase mon',    'audio')),
  awful.key({         }, 'KP_Home',     function() run_script('awesome-widgets.sh', 'audio', 'mon_down')   end, create_description(kb_fg__awesome, 'decrease mon',    'audio')),
  awful.key({ S       }, 'KP_Up',       function() run_script('awesome-widgets.sh', 'audio', 'mon_100')    end, create_description(kb_fg__awesome, 'mon 100',         'audio')),
  awful.key({ S       }, 'KP_Home',     function() run_script('awesome-widgets.sh', 'audio', 'mon_0')      end, create_description(kb_fg__awesome, 'mon 0',           'audio')),
  awful.key({         }, 'KP_Prior',    function() run_script('awesome-widgets.sh', 'audio', 'toggle_mon') end, create_description(kb_fg__awesome, 'toggle mon',      'audio')),
  awful.key({         }, 'KP_Delete',   function() run_script('awesome-widgets.sh', 'audio', 'full_info')  end, create_description(kb_fg__awesome, 'full info',       'audio')),
  -- awful.key({      }, 'KP_Add',      function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({      }, 'KP_Subtract', function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({      }, 'KP_Enter',    function() end, create_description(kb_fg__awesome, '', '--')),

  -- audacious
  awful.key({         }, '0x1008ff14',  function() run_script('awesome-widgets.sh', 'audacious', 'play_pause') end, create_description(kb_fg__awesome, 'play/pause',     'audacious')),
  awful.key({ M       }, '0x1008ff14',  function() run_script('awesome-widgets.sh', 'audacious', 'songs')      end, create_description(kb_fg__awesome, 'songs',          'audacious')),
  awful.key({         }, '0x1008ff16',  function() run_script('awesome-widgets.sh', 'audacious', 'previous')   end, create_description(kb_fg__awesome, 'previous',           'audacious')),
  awful.key({         }, '0x1008ff17',  function() run_script('awesome-widgets.sh', 'audacious', 'next')       end, create_description(kb_fg__awesome, 'next',           'audacious')),
  awful.key({ S       }, '0x1008ff16',  function() run_script('awesome-widgets.sh', 'audacious', '-60')        end, create_description(kb_fg__awesome, '-60',            'audacious')),
  awful.key({ S       }, '0x1008ff17',  function() run_script('awesome-widgets.sh', 'audacious', '+60')        end, create_description(kb_fg__awesome, '+60',            'audacious')),
  awful.key({         }, '0x1008ff15',  function() run_script('awesome-widgets.sh', 'audacious', 'tog_shuff')  end, create_description(kb_fg__awesome, 'toggle shuffle', 'audacious')),
  
  -- awful.key({ M    }, 'Print',       function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Scroll_Lock', function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Pause',       function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Prior',       function() end, create_description(kb_fg__awesome, '', '--')),  -- (Page Up key)
  -- awful.key({ M    }, 'Next',        function() end, create_description(kb_fg__awesome, '', '--')),  -- (Page Down key)
  -- awful.key({ M    }, 'Home',        function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'End',         function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Insert',      function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Delete',      function() end, create_description(kb_fg__awesome, '', '--')),
  
  -- awful.key({ M    }, 'BackSpace',   function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, '-',           function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, '=',           function() end, create_description(kb_fg__awesome, '', '--')),

  -- exceptionally using awesome-apps.sh script
  -- instead of using run_in_shell function only for consistency
  awful.key({ M,      }, 'Return',      function() run_script('awesome-apps.sh', 'terminal'         ) end, create_description(kb_fg__awesome, '',           'terminal')),
  awful.key({ M, C    }, 'Return',      function() run_script('awesome-apps.sh', 'terminal_tmux'    ) end, create_description(kb_fg__awesome, '+ tmux',     'terminal')),
  awful.key({ M, S    }, 'Return',      function() run_script('awesome-apps.sh', 'terminal_torsocks') end, create_description(kb_fg__awesome, '+ torsocks', 'terminal')),
   
  -- awful.key({      }, 'Caps_Lock',   -- set for keyboardlayout
  -- awful.key({ M    }, 'Tab',         function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, '/',           function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, '\\',          function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, '[',           function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, ']',           function() end, create_description(kb_fg__awesome, '', '--')),
  -- awful.key({ M    }, 'Menu',        function() end, create_description(kb_fg__awesome, '', '--')),
  awful.key({ M       }, 'space',       function() awful.layout.inc( 1) end, create_description(kb_fg__awesome, 'next', 'layout')),
  awful.key({ M, S    }, 'space',       function() awful.layout.inc(-1) end, create_description(kb_fg__awesome, 'previous', 'layout')),
  awful.key({ M       }, 'period',      function() resize_gap(1)  end, create_description(kb_fg__awesome, 'decrease', 'gap')),
  awful.key({ M       }, 'comma',       function() resize_gap(-1) end, create_description(kb_fg__awesome, 'increase', 'gap')),
  awful.key({ M       }, 'semicolon',   function() awful.tag.incnmaster(-1, nil, true) end, create_description(kb_fg__awesome, 'decrease no. of masters', 'client')),
  awful.key({ M       }, 'apostrophe',  function() awful.tag.incnmaster( 1, nil, true) end, create_description(kb_fg__awesome, 'increase no. of masters', 'client')),
  awful.key({ M, S    }, 'semicolon',   function() awful.tag.incncol(-1, nil, true) end, create_description(kb_fg__awesome, 'decrease no. of columns', 'client')),
  awful.key({ M, S    }, 'apostrophe',  function() awful.tag.incncol(1, nil, true) end, create_description(kb_fg__awesome, 'increase no. of columns', 'client')),

  awful.key({ M       }, 'q',           function() run_script('awesome-widgets.sh', 'clipboard', 'start') end, create_description(kb_fg__awesome, 'start', 'clipboard')),
  awful.key({ M, S    }, 'q',           function() run_script('awesome-widgets.sh', 'clipboard', 'stop') end, create_description(kb_fg__awesome, 'stop', 'clipboard')),
  awful.key({ M       }, 'w',           function() run_script('screenshot.py') end, create_description(kb_fg__awesome, '', 'screenshot')),
  awful.key({ M       }, 'e',           function() run_script('awesome-apps.sh', 'dbgate') end, create_description(kb_fg__awesome, '', 'dbgate')),
  awful.key({ M       }, 'r',           function() run_script('awesome-apps.sh', 'visual-studio-code') end, create_description(kb_fg__awesome, '', 'visual-studio-code')),
  awful.key({ M       }, 't',           function() run_script('awesome-widgets.sh', 'memory_cpu', 'intensives') end, create_description(kb_fg__awesome, '', 'memory/cpu intensives')),
  awful.key({ M       }, 'y',           function() run_script('browser.sh', 'firefox') end, create_description(kb_fg__awesome, 'firefox', 'browser')),
  awful.key({ M, S    }, 'y',           function() run_script('browser.sh', 'chromium') end, create_description(kb_fg__awesome, 'chromium', 'browser')),
  awful.key({ M       }, 'u',           function() run_script('awesome-widgets.sh', 'established', 'message') end, create_description(kb_fg__awesome, '', 'established')),
  awful.key({ M       }, 'i',           function() run_script('awesome-widgets.sh', 'ymail') end, create_description(kb_fg__awesome, 'ymail', 'e-mail')),
  awful.key({ M, S    }, 'i',           function() run_script('awesome-widgets.sh', 'gmail') end, create_description(kb_fg__awesome, 'gmail', 'e-mail')),
  awful.key({ M       }, 'o',           function() run_script('awesome-apps.sh', 'thunar') end, create_description(kb_fg__awesome, 'thunar', 'file manager')),
  awful.key({ M       }, 'p',           function() run_script('launcher.sh', 'rofi') end, create_description(kb_fg__awesome, 'rofi', 'launcher')),
  awful.key({ M, S    }, 'p',           function() run_script('launcher.sh', 'dmenu') end, create_description(kb_fg__awesome, 'dmenu', 'launcher')),
  awful.key({ M, C    }, 'p',           function() mymainmenu:toggle({coords = {x = 20, y = 26}}) end, create_description(kb_fg__awesome, 'main menu', 'launcher')),
  awful.key({ M, A    }, 'p',           function() awful.screen.focused().mypromptbox:run() end, create_description(kb_fg__awesome, 'prompt box', 'launcher')),
  awful.key({ M       }, 'a',           function() run_script('awesome-apps.sh', 'goldendict') end, create_description(kb_fg__awesome, '', 'goldendict')),
  awful.key({ M       }, 's',           function() run_script('awesome-widgets.sh', 'firewall', 'turn_on') end, create_description(kb_fg__awesome, 'turn on', 'firewall')),
  awful.key({ M, S    }, 's',           function() run_script('awesome-widgets.sh', 'firewall', 'turn_off') end, create_description(kb_fg__awesome, 'turn off', 'firewall')),
  awful.key({ M       }, 'd',           function() run_script('openvpn.sh') end, create_description(kb_fg__awesome, '', 'openvpn')),
  awful.key({ M       }, 'f',           function() run_script('awesome-widgets.sh', 'bluetooth', 'turn_on') end, create_description(kb_fg__awesome, 'turn on', 'bluetooth')),
  awful.key({ M, S    }, 'f',           function() run_script('awesome-widgets.sh', 'bluetooth', 'turn_off') end, create_description(kb_fg__awesome, 'turn off', 'bluetooth')),
  awful.key({ M       }, 'g',           function() run_script('awesome-widgets.sh', 'wifi', 'turn_on') end, create_description(kb_fg__awesome, 'turn on', 'wifi')),
  awful.key({ M, S    }, 'g',           function() run_script('awesome-widgets.sh', 'wifi', 'turn_off') end, create_description(kb_fg__awesome, 'turn off', 'wifi')),
  awful.key({ M       }, 'h',           function() awful.tag.incmwfact(-0.01) end, create_description(kb_fg__awesome, 'decrease master width', 'client')),
  awful.key({ M       }, 'l',           function() awful.tag.incmwfact(0.01) end, create_description(kb_fg__awesome, 'increase master width', 'client')),
  awful.key({ M, S    }, 'h',           function() awful.client.incwfact(-0.01) end, create_description(kb_fg__awesome, 'decrease non-master width', 'client')),  -- (https://stackoverflow.com/questions/17705888/resizing-window-vertically)
  awful.key({ M, S    }, 'l',           function() awful.client.incwfact(0.01) end, create_description(kb_fg__awesome, 'increase non-master width', 'client')),  -- (https://stackoverflow.com/questions/17705888/resizing-window-vertically)
  awful.key({ M       }, 'k',           function() awful.client.focus.byidx(1) end, create_description(kb_fg__awesome, 'next', 'client')),
  awful.key({ M       }, 'j',           function() awful.client.focus.byidx(-1) end, create_description(kb_fg__awesome, 'previous', 'client')),
  awful.key({ M, S    }, 'k',           function() awful.client.swap.byidx(1) end, create_description(kb_fg__awesome, 'swap with next', 'client')),
  awful.key({ M, S    }, 'j',           function() awful.client.swap.byidx(-1) end, create_description(kb_fg__awesome, 'swap with previous', 'client')),
  awful.key({ M       }, 'z',           function() run_script('mount-umount.sh', 'mount') end, create_description(kb_fg__awesome, 'mount', 'mount/umount')),
  awful.key({ M, S    }, 'z',           function() run_script('mount-umount.sh', 'umount') end, create_description(kb_fg__awesome, 'umount', 'mount/umount')),
  awful.key({ M       }, 'x',           function() run_script('power.sh') end, create_description(kb_fg__awesome, '', 'power')),
  -- awful.key({ M    }, 'c',           set in clientkeys
  awful.key({ M       }, 'v',           function() run_script('awesome-widgets.sh', 'tor', 'start') end, create_description(kb_fg__awesome, 'start', 'tor')),
  awful.key({ M, S    }, 'v',           function() run_script('awesome-widgets.sh', 'tor', 'stop') end, create_description(kb_fg__awesome, 'stop', 'tor')),
  awful.key({ M, C    }, 'v',           function() run_script('awesome-widgets.sh', 'tor', 'restart') end, create_description(kb_fg__awesome, 'restart', 'tor')),
  awful.key({ M, A    }, 'v',           function() run_script('awesome-widgets.sh', 'tor', 'is-tor') end, create_description(kb_fg__awesome, 'is-tor', 'tor')),
  awful.key({ M       }, 'b',           function() run_script('awesome-widgets.sh', 'open_ports', 'message') end, create_description(kb_fg__awesome, '', 'open ports')),

  -- together with JUMP_3
  awful.key({ M, S    }, 'n',           function() local c = awful.client.restore() if c then client.focus = c c:raise() end end, create_description(kb_fg__awesome, 'unminimize', 'client'))

  -- awful.key({ M    }, 'm',           set in clientkeys

  -------------------------------
  -- NOTE JUMP_4
  -- no comma after last element
  -------------------------------
)


clientkeys = gears.table.join(
  awful.key({ M    }, 'Escape', function(c) c:lower() end, create_description(kb_fg__awesome, 'lower', 'client')),
  awful.key({ M, S }, 'Escape', function(c) c:raise() end, create_description(kb_fg__awesome, 'raise', 'client')),
  awful.key({ M    }, 'Up',     function(c) c.maximized = not c.maximized c:raise() end, create_description(kb_fg__awesome, 'maximize/unmaximize', 'client')),

  -- move client to screen 1/2
  awful.key({ M, C }, '1',      function(c) c:move_to_screen(1) end, create_description(kb_fg__awesome, 'move to screen 1', 'client')),
  awful.key({ M, C }, '2',      function(c) c:move_to_screen(-1) end, create_description(kb_fg__awesome, 'move to screen 2', 'client')),
  
  -- move client to previous/next screen
  awful.key({ M, C }, 'Left',   function(c) c:move_to_screen(1) end, create_description(kb_fg__awesome, 'move to previous screen', 'client')),
  awful.key({ M, C }, 'Right',  function(c) c:move_to_screen(-1) end, create_description(kb_fg__awesome, 'move to next screen', 'client')),

  awful.key({ M    }, 'c',      function(c) c:kill() end, create_description(kb_fg__awesome, 'close', 'client')),
  awful.key({ M    }, 'm',      function(c) c:swap(awful.client.getmaster()) end, create_description(kb_fg__awesome, 'make master', 'client')),
  
  -- together with JUMP_3
  awful.key({ M    }, 'n',      function(c) c.minimized = true end, create_description(kb_fg__awesome, 'minimize', 'client'))
  
  -------------------------------
  -- NOTE JUMP_4
  -- no comma after last element
  -------------------------------
)

-- tag keybindings
-------------- BY ME vv --------------
globalkeys = gears.table.join( globalkeys,
  -- move client to previous tag
  awful.key(
    { M, C, S },
    'Left',
    function()
      local prev_tag_index
      local current_tag_index
      local tag
      local screen

      if client.focus then
        current_tag_index = awful.screen.focused().selected_tag.index

        if current_tag_index == 1 then
          prev_tag_index = no_of_tags
        else
          prev_tag_index = current_tag_index - 1
        end

        tag = client.focus.screen.tags[prev_tag_index]
        if tag then client.focus:move_to_tag(tag) end

        -- and also go to the tag
        screen = awful.screen.focused()    --,
        tag = screen.tags[prev_tag_index]  --|--> OR awful.tag.viewprev,
        if tag then tag:view_only() end    --'
      end
    end,
    create_description(kb_fg__awesome, 'move to previous tag', 'client')
  ),

  -- move client to next tag
  awful.key(
    { M, C, S },
    'Right',
    function()
      local next_tag_index
      local current_tag_index
      local tag
      local screen

      if client.focus then
        current_tag_index = awful.screen.focused().selected_tag.index

        if current_tag_index == no_of_tags then
          next_tag_index = 1
        else
          next_tag_index = current_tag_index + 1
        end

        tag = client.focus.screen.tags[next_tag_index]
        if tag then client.focus:move_to_tag(tag) end

        -- and also go to the tag
        screen = awful.screen.focused()    --,
        tag = screen.tags[next_tag_index]  --|--> OR awful.tag.viewnext,
        if tag then tag:view_only() end    --'
      end
    end,
    create_description(kb_fg__awesome, 'move to next tag', 'client')
  )
)
-------------- BY ME ^^ --------------


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, no_of_tags do  -- ORIGINAL: for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,

  -- JUMP_1 go to tag i
    awful.key(
      { M, S },
      i,
      function()
        -- JUMP_2
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then tag:view_only() end
      end,
      create_description(kb_fg__awesome, 'tag ' .. i, 'screen/tag')
    ),

    -- move client to tag i
    awful.key(
      { M, C, S },
      i,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then client.focus:move_to_tag(tag) end

          -- and also go to tag i
          -- JUMP_2
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then tag:view_only() end
        end
      end,
      create_description(kb_fg__awesome, 'move to tag ' .. i, 'client')
    )

    -- ...,
  )
end


clientbuttons = gears.table.join(
  awful.button({   }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', {raise = true})
  end),
  awful.button({ M }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ M }, 3, function(c)
    c:emit_signal('request::activate', 'mouse_click', {raise = true})
    awful.mouse.client.resize(c)
  end)
)


-- Set keys
root.keys(globalkeys)

-- Rules
-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = 0,
      border_color = border_color,
      focus        = awful.client.focus.filter,
      raise        = true,
      keys         = clientkeys,
      buttons      = clientbuttons,
      screen       = awful.screen.preferred,
      placement    = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered,
      -- ORIGINAL:
      -- placement = awful.placement.no_overlap+awful.placement.no_offscreen

      -- make terminal fill screen properly
      -- (https://stackoverflow.com/questions/28369999/awesome-wm-terminal-window-doesnt-take-full-space)
      size_hints_honor = false,
    },

    -- start clients as slave rather than master
    -- (https://awesomewm.org/apidoc/documentation/90-FAQ.md.html)
    callback = awful.client.setslave
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"},

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },


  -- vvv my rules ------------------

  {
    rule = { class = 'vlc' },
    properties = {
      callback = function(c)
        -- pause audacious when vlc opens
        run_script('awesome-widgets.sh', 'audacious', 'pause')
      end,

      -- open vlc on screen 2
      -- NOTE setting the value to 2 throws error
      --      when second monitor is not available.
      --      so we can do this:
      --      (https://stackoverflow.com/questions/61427799/i-would-like-to-open-one-program-on-the-second-screen-in-awesomewm-but-only-if)
      screen = function() return screen.count() end,
    },
  },

  { 
    rule = { class = 'Xfce4-terminal' },
    properties = {
      -- open maximized
      maximized = true,
    },
  },

  -- ^^^ my rules ------------------
}


-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    -- left click
    awful.button(
      {},
      1,
      function()
        c:emit_signal(
          'request::activate',
          'titlebar',
          {raise = true}
        )
        awful.mouse.client.move(c)
      end
    ),

    -- right click
    awful.button(
      {},
      3,
      function()
        c:emit_signal(
          'request::activate',
          'titlebar',
          {raise = true}
        )
        awful.mouse.client.resize(c)
      end
    )
  )

  awful.titlebar(c):setup {
    -- Left
    {
      -- modified to add margins to the icon
      wibox.container.place(
        wibox.container.margin(
          awful.titlebar.widget.iconwidget(c),
          5, 5, 5, 5
        ),
        'center'
      ),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },

    -- Middle
    {
      {  -- Title
        align  = 'center',
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    -- Right
    {
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.minimizebutton (c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal,
    spacing = 10
  }

  -- initially hides the titlebars
  -- (https://wiki.archlinux.org/index.php/awesome)
  -- awful.titlebar.hide(c)

  -- hides tooltips from titlebar
  -- (https://www.reddit.com/r/awesomewm/comments/88x9po/how_to_hide_awfultitlebarwidgetclosebutton_tooltip/)
  awful.titlebar.enable_tooltip = true
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


client.connect_signal(
  "focus",
  function(c)
    c.opacity = 1
  end
)
client.connect_signal(
  "unfocus",
  function(c)
    if c.class == 'vlc' then return end
    c.opacity = 0.85
  end
)


-- by me
-- prevent new clients from being urgent by default
-- (https://github.com/awesomeWM/awesome/blob/master/docs/90-FAQ.md):
-- client.disconnect_signal('request::activate', awful.ewmh.activate)
--   function awful.ewmh.activate(c)
--     if c:isvisible() then
--       client.focus = c
--       c:raise()
--     end
--   end
-- client.connect_signal('request::activate', awful.ewmh.activate)


-- run startup script
run_script('awesome-startup.sh')

-- ---------------------------------------------
-- notes
-- cur_scr_index="$(awesome-client 'local awful = require("awful") ; return awful.screen.focused().index' | awk '{print $NF}')"
-- tag:    awful.tag.selected()                      0x55ab4c31eac8  <--,
--         awful.tag.selected().name                 ➊               <--|-- depracated
--         awful.tag.selected().index                1               <--'
--         awful.screen.focused().selected_tag       0x55ab4c31eac8
--         awful.screen.focused().selected_tag.name  ➊
--         awful.screen.focused().selected_tag.index 1
--         awful.screen.focused().selected_tags   0x563293355490
--         awful.screen.focused().tags            0x55ab4d776d30
--         root.tags()                            0x563293fe8ee0
-- screen: awful.screen.focused()                 0x55ab4be775c8
--         awful.screen.focused().index           1
-- (OR mouse.screen instead of awful.screen.focused())

-- send message in bash:
-- message(){ echo -e "local naughty = require('naughty')
--                     naughty.notify({ preset   = naughty.config.presets.normal,
--                                      bg       = '$blue',
--                                      fg       = '$cyan',
--                                      title    = os.date('%A - %Y - %m ( %B ) - %d'),
--                                      text     = string.format('<b><i>%s</i></b>: %s, %d ', 100, 200, 300),
--                                      timeout  = 10,
--                                      position = 'top_right',
--                                   })" | awesome-client ;}
-- message

-- go to screen 2
-- echo -e 'local awful = require("awful"); awful.screen.focus(2)' | awesome-client

-- go to tag 3
-- echo -e 'local awful = require("awful"); awful.screen.focused().tags[3]:view_only()' | awesome-client

-- awesome-client '<widget>.markup = <text>'
-- awesome-client 'awesome.restart()'
-- echo -e "<widget>.markup = '<text>'" | awesome-client
-- echo "<widget>:set_markup('<text>')" | awesome-client
-- echo -e 'awesome.quit()' | awesome-client
-- echo -e 'weather.show(5)' | awesome-client

-- os.date('%A - %Y - %m - %d')
-- string.format('<b><i>%s</i></b>: %s, %d ', bat_level, ac_dc, bat_rem)
-- os.setlocale(os.getenv('LANG'))
-- os.getenv('HOME')
-- screen.count()
-- awesome.version

-- conditions in topwibox setup (https://github.com/lgaggini/awesome-archKiss/blob/master/rc.lua):
-- s.index == 2 and s.mylayoutbox,
-- screen:count() == 2 and s.index == 1 and s.mylayoutbox,

-- get a script output (https://www.reddit.com/r/awesomewm/comments/abssz2/having_trouble_configuring_rclua/):
-- awful.key({ M    }, '=', function() awful.spawn.easy_async_with_shell(hns .. '/awesome-widgets battery',
--                                     function(stdout, stderr, exitreason, exitcode)
--                                         naughty.notify({ title = 'Battery Info', text = stdout })
--                                     end)
--                          end, create_description(kb_fg__awesome, 'do this', 'group name')),

--  ╭─► time_wch = awful.widget.watch( { awful.util.shell, '-c', .. hns .. '/awesome-widgets time' }, 10, function(widget, stdout) widget:set_markup(stdout) end)
-- ─┤
--  ╰─► time_wch = awful.widget.watch('bash -c "' .. hns .. '/awesome-widgets time"', 10, function(widget, stdout) widget:set_markup(stdout) end)

-- function(widget, stdout, stderr, exitreason, exitcode)
-- function(stdout, _, _, _)

-- Trigger timer in bash:
-- echo -e '<timer>:emit_signal("timeout")' | awesome-client && exit

-- set a custom colour for a category in awful.hotkeys_popup (https://stackoverflow.com/questions/68396503/how-do-i-set-a-custom-colour-for-a-category-in-awful-hotkeys-popup/68396654#68396654)
-- hotkeys_popup.add_group_rules('awesome', { color = '#fF0000' })

-- aud_grid
-- aud_grid = wibox.layout { forced_num_rows = 1,
--                           homogeneous     = false,
--                           layout          = wibox.layout.grid
--                         }

-- aud_grid:add_widget_at(aud_shuffle, 1, 1,  1, 1)
-- aud_grid:add_widget_at(aud_count,   1, 2,  1, 1)
-- aud_grid:add_widget_at(aud_time,    1, 3,  1, 1)
-- aud_grid:add_widget_at(aud_sep,     1, 4,  1, 1)
-- aud_grid:add_widget_at(aud_title,   1, 5,  1, 1)
-- aud_grid:add_widget_at(aud_sep,     1, 6,  1, 1)
-- aud_grid:add_widget_at(aud_album,   1, 7,  1, 1)
-- aud_grid:add_widget_at(aud_sep,     1, 8,  1, 1)
-- aud_grid:add_widget_at(aud_artist,  1, 9,  1, 1)
-- aud_grid:add_widget_at(aud_symbol,  1, 10, 1, 1)
