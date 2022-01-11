-- variables and requires {{{
local gears          = require('gears')
local awful          = require('awful')
local wibox          = require('wibox')
local beautiful      = require('beautiful')
local naughty        = require('naughty')
local menubar        = require('menubar')
local hotkeys_popup  = require('awful.hotkeys_popup')  --.widget
local xrandr         = require('xrandr')  -- (https://awesomewm.org/recipes/xrandr/)
local keyboardlayout = require('keyboardlayout')
local modalbind      = require('modalbind')  -- (https://github.com/crater2150/awesome-modalbind)

require('awful.autofocus')
require('awful.hotkeys_popup.keys')  -- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
pcall(require, 'luarocks.loader')
-- require('global_keys')
-- require('client_keys')

modalbind.init()
-- modalbind.hide_options()  -- hides keys, just showing the name of current mode

black          = os.getenv('black')
blue           = os.getenv('blue')
grey_dark      = os.getenv('grey_dark')
red_dark       = os.getenv('red_dark')
silver         = os.getenv('silver')
bg             = black
fg_d           = blue
fg_l           = silver
awe_kb_fg      = fg_d

font           = 'play bold 9'
hotkeys_font   = 'play 10'
message_font   = 'play 10'
main_menu_font = 'play 12'
border_width   = 0.5
terminal       = os.getenv('terminal')
home           = os.getenv('HOME')
hns            = home .. '/scripts'
awe_path       = home .. '/.config/awesome'
M              = 'Mod4'
S              = 'Shift'
C              = 'Control'
A              = 'Mod1'
-- editor      = os.getenv('editor') or 'nano'
-- editor_cmd  = terminal .. ' -e ' .. editor

-- notification {{{
--> normal:
    naughty.config.presets.normal['bg']             = bg
    naughty.config.presets.normal['fg']             = fg_l
    naughty.config.presets.normal['border_color']   = fg_l             -- default: beautiful.notification_border_color or beautiful.border_focus or '#535d6c'
    naughty.config.presets.normal['border_width']   = border_width     -- do NOT move to theme config file
    naughty.config.presets.normal['margin']         = 10
    naughty.config.presets.normal['font']           = message_font     -- default: beautiful.notification_font or ...
    naughty.config.presets.normal['position']       = 'top_right'      -- default: top_right. Values: 'top_right', 'top_left', ...
    naughty.config.presets.normal['timeout']        = 10
    naughty.config.presets.normal['icon_size']      = 32  -- OR dpi(32)
 -- naughty.config.presets.normal['max_height']     = 32               -- default: beautiful.notification_height or auto
 -- naughty.config.presets.normal['max_width']      = 32               -- default: beautiful.notification_width or auto
--  naughty.config.presets.normal['ontop']          = true             -- default: true
 -- naughty.config.presets.normal['hover_timeout']  = 0
 -- naughty.config.presets.normal['screen']         = 1                -- default: 'focused'
 -- naughty.config.presets.normal['text']           = 'message text'   -- default: ''
 -- naughty.config.presets.normal['height']         = 60               -- default: beautiful.notification_height or auto
 -- naughty.config.presets.normal['width']          = 100              -- default: beautiful.notification_width or auto
 -- naughty.config.presets.normal['icon']           = '<PATH>'
 -- naughty.config.presets.normal['opacity']        = 1                -- default beautiful.notification_opacity
 -- naughty.config.presets.normal['run']            =                  -- Function to run on left click. The notification object will be passed to it as an argument. You need to call e.g. notification.die(naughty.notificationClosedReason.dismissedByUser) from there to dismiss the notification yourself
 -- naughty.config.presets.normal['destroy']        =                  -- Function to run when notification is destroyed
 -- naughty.config.presets.normal['preset']         =                  --

--> critical:
    naughty.config.presets.critical['bg']           = red_dark          -- default: '#ff0000'
    naughty.config.presets.critical['border_color'] = fg_l
    naughty.config.presets.critical['border_width'] = border_width
    naughty.config.presets.critical['margin']       = 10
-- }}}
-- }}}
-- error handling {{{
-- Check if awesome encountered an error during startup and fell back to another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title  = 'Startup Error',
                     icon   = home .. '/linux/themes/alert-w.png',
                     text   = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title  = 'Error',
                         icon   = home .. '/linux/themes/alert-w.png',
                         text   = tostring(err) })
        in_error = false
    end)
end
-- }}}
-- functions {{{
function run_in_shell(cmnd)  -- {{{
    awful.spawn.with_shell(cmnd)
end
-- }}}
function resize_gap(new_gap)  -- {{{ https://www.reddit.com/r/awesomewm/comments/kitgn9/useless_gaps/
    local t = awful.screen.focused().selected_tag
    t.gap = t.gap + tonumber(new_gap)
    awful.layout.arrange(awful.screen.focused())
end
-- }}}
function run_script(arg1, arg2, arg3)  -- {{{
    -- arg1:        script name
    -- arg2 & arg3: script args
    if     arg2 == nil then run_in_shell(hns .. '/' .. arg1)
    elseif arg3 == nil then run_in_shell(hns .. '/' .. arg1 .. ' ' .. arg2)
    else                    run_in_shell(hns .. '/' .. arg1 .. ' ' .. arg2 .. ' ' .. arg3)
    end
end
-- }}}
function create_textbox(text)  -- {{{
    new_textbox = wibox.widget { markup = text, valign = 'center', widget = wibox.widget.textbox }
    return new_textbox
end
-- }}}
function create_watch(arg1, arg2, arg3)  -- {{{
    -- ORIG (before being put in function):
    -- awful.widget.watch('bash -c ' .. hns .. '"/awesome-widgets audacious"', 10)

    if arg3 == nil then
        command = 'bash -c ' .. hns .. '"/awesome-widgets "' .. arg1
        interval = arg2
    else
        command = 'bash -c ' .. hns .. '"/awesome-widgets "' .. arg1 .. '" "' .. arg2
        interval = arg3
    end
    awful.widget.watch(command, interval)
end
-- }}}
function create_container(widg, forg)  -- {{{
    new_container = wibox.container { widg,
                                      widget = wibox.container.background,
                                      bg     = bg,
                                      fg     = forg
                                    }
    return new_container
end
-- }}}
function create_description(dscrptn, grp)  -- {{{
   new_description = {description="  <span color=\"" .. awe_kb_fg .. "\">" .. dscrptn .. "</span>", group=grp}
   return new_description
end
-- }}}
function rename_tag()  -- {{{
    awful.prompt.run { prompt       = ' Rename tag: ',
                       textbox      = awful.screen.focused().mypromptbox.widget,
                       exe_callback = function(new_name) if not new_name or #new_name == 0 then return end
                                                         local t = awful.screen.focused().selected_tag
                                                         if t then t.name = new_name end
                                      end
                     }
end
-- }}}
function create_tag()  -- {{{
    awful.prompt.run { prompt       = ' New tag: ',
                       textbox      = awful.screen.focused().mypromptbox.widget,
                       exe_callback = function(new_tag) if not new_tag or #new_tag == 0 then return end
                                                        awful.tag.add(new_tag, { screen = awful.screen.focused(),
                                                                                 layout = awful.layout.suit.floating }):view_only()
                                      end
                     }
end
-- }}}
function delete_tag()  -- {{{
    awful.prompt.run { prompt       = ' Delete tag (y/n)? ',
                       textbox      = awful.screen.focused().mypromptbox.widget,
                       exe_callback = function(delete_tag) if not delete_tag or #delete_tag == 0 or delete_tag ~= 'y' then return end
                                                           local t = awful.screen.focused().selected_tag
                                                           if not t then return end
                                                           t:delete()
                                      end
                      }
end
-- }}}
function sccc(cur_cli_class)  -- {{{ set current client class
    if     cur_cli_class == nil                           then abbr = '--'
    elseif cur_cli_class == 'firefox'                     then abbr = 'FI'
    elseif cur_cli_class == 'Tor Browser'                 then abbr = 'TO'
    elseif cur_cli_class == 'Chromium'                    then abbr = 'CH'
    elseif cur_cli_class == 'qutebrowser'                 then abbr = 'QU'
    elseif cur_cli_class == 'Gnome-terminal'              then abbr = 'TE'
    elseif cur_cli_class == 'Xfce4-terminal'              then abbr = 'TE'
    elseif cur_cli_class == 'Uget-gtk'                    then abbr = 'UG'
    elseif cur_cli_class == 'kid3'                        then abbr = 'KI'
    elseif cur_cli_class == 'kdenlive'                    then abbr = 'KD'
    elseif string.match(cur_cli_class, '^Gimp.*$')        then abbr = 'GI'
    elseif string.match(cur_cli_class, '^libreoffice.*$') then abbr = 'LI'
    elseif cur_cli_class == 'Gedit'                       then abbr = 'GE'
    elseif cur_cli_class == 'KeePass2'                    then abbr = 'KE'
    elseif cur_cli_class == 'Xreader'                     then abbr = 'XR'
    elseif cur_cli_class == 'Lxappearance'                then abbr = 'LX'
    elseif cur_cli_class == 'GParted'                     then abbr = 'GP'
    elseif cur_cli_class == 'Gnome-disks'                 then abbr = 'DI'
    elseif cur_cli_class == 'Gnome-calculator'            then abbr = 'CA'
    elseif cur_cli_class == 'GoldenDict'                  then abbr = 'GO'
    elseif cur_cli_class == 'Gpicview'                    then abbr = 'GP'
    elseif cur_cli_class == 'Audacious'                   then abbr = 'AU'
    elseif cur_cli_class == 'vlc'                         then abbr = 'VL'
    elseif string.match(cur_cli_class, '^Blueman.*$')     then abbr = 'BL'
    elseif string.match(cur_cli_class, '^Nm.*$')          then abbr = 'NE'
    elseif cur_cli_class == 'ffplay'                      then abbr = 'FF'
    else                                                       abbr = '--'
    end
    cur_cli_cls:set_markup(abbr)
end
-- }}}
-- function sccp(cc_pid)  -- {{{ set current client pid
--     if cc_pid == nil then cc_pid = '--' end
--        cur_cli_pid:set_markup(cc_pid)
-- end
-- }}}
function scsi()  -- {{{ set current screen index
    local cur_scr_index = awful.screen.focused().index
    if     cur_scr_index == 1 then cur_scr_icon = '1'  -- ＜＞➊➋
    elseif cur_scr_index == 2 then cur_scr_icon = '2'
    else                           cur_scr_icon = '3'
    end
    cur_scr_idx:set_markup(cur_scr_icon)
end
-- }}}
-- }}}
-- define theme & wallpaper {{{
beautiful.init(awe_path .. '/theme.lua')  -- original: beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
local function set_wallpaper(s) gears.wallpaper.maximized('/usr/share/wallpapers/startup_background.jpg', s, true) end

-- reset wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

mouse.coords({ x = 683, y = 190 })
-- }}}
-- layouts {{{
awful.layout.layouts = { awful.layout.suit.tile,
                         awful.layout.suit.tile.bottom,
                         awful.layout.suit.fair,
                         awful.layout.suit.max,
                         awful.layout.suit.floating,
                       }
                      -- awful.layout.suit.tile.left,
                      -- awful.layout.suit.tile.top,
                      -- awful.layout.suit.fair.horizontal,
                      -- awful.layout.suit.spiral,
                      -- awful.layout.suit.spiral.dwindle,
                      -- awful.layout.suit.max.fullscreen,
                      -- awful.layout.suit.magnifier,
                      -- awful.layout.suit.corner.nw,
                      -- awful.layout.suit.corner.ne,
                      -- awful.layout.suit.corner.sw,
                      -- awful.layout.suit.corner.se,
-- }}}
-- menu {{{
-- original menu {{{
-- myawesomemenu = {
--    { 'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--    { 'manual', terminal .. ' -e man awesome' },
--    { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
--    { 'restart', awesome.restart },
--    { 'quit', function() awesome.quit() end },
-- }

-- mymainmenu = awful.menu({ items = { { 'awesome', myawesomemenu, beautiful.awesome_icon },
--                                     { 'open terminal', terminal }
--                                   }
--                         })

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                      menu = mymainmenu })
-- }}}

app = {
        -- run_script('awesome-widgets', 'date_jdate')
        { 'audacious',            function() run_script('/awesome-app-off', 'audacious'           ) end},
        { 'blueman applet',       function() run_script('/awesome-app-off', 'blueman_applet'      ) end},
        { 'blueman manager',      function() run_script('/awesome-app-off', 'blueman_manager'     ) end},
        { 'calculator',           function() run_script('/awesome-app-off', 'calculator'          ) end},
        { 'chromium',             function() run_script('/awesome-app-off', 'chromium'            ) end},
        { 'disks',                function() run_script('/awesome-app-off', 'disks'               ) end},
        { 'firefox',              function() run_script('/awesome-app-off', 'firefox'             ) end},
        { 'gedit',                function() run_script('/awesome-app-off', 'gedit'               ) end},
        { 'gimp',                 function() run_script('/awesome-app-off', 'gimp'                ) end},
        { 'goldendict',           function() run_script('/awesome-app-off', 'goldendict'          ) end},
        { 'gparted',              function() run_script('/awesome-app-off', 'gparted'             ) end},
        { 'gpicview',             function() run_script('/awesome-app-off', 'gpicview'            ) end},
        { 'kdenlive',             function() run_script('/awesome-app-off', 'kdenlive'            ) end},
        { 'keepass',              function() run_script('/awesome-app-off', 'keepass'             ) end},
        { 'kid3',                 function() run_script('/awesome-app-off', 'kid3'                ) end},
        { 'lf',                   function() run_script('/awesome-app-off', 'lf'                  ) end},
        { 'libreoffice',          function() run_script('/awesome-app-off', 'libreoffice'         ) end},
        { 'lxappearance',         function() run_script('/awesome-app-off', 'lxappearance'        ) end},
        { 'qutebrowser',          function() run_script('/awesome-app-off', 'qutebrowser'         ) end},
        { 'ranger',               function() run_script('/awesome-app-off', 'ranger'              ) end},
        { 'simplescreenrecorder', function() run_script('/awesome-app-off', 'simplescreenrecorder') end},
        { 'terminal',             function() run_script('/awesome-app-off', 'terminal'            ) end},
        { 'terminal + tmux',      function() run_script('/awesome-app-off', 'terminal_tmux'       ) end},
        { 'terminal + torsocks',  function() run_script('/awesome-app-off', 'terminal_torsocks'   ) end},
        { 'uget',                 function() run_script('/awesome-app-off', 'uget'                ) end},
        { 'vlc',                  function() run_script('/awesome-app-off', 'vlc'                 ) end},
        { 'xreader',              function() run_script('/awesome-app-off', 'xreader'             ) end},
      }

shut = {
         { 'now',                   function() run_script('/awesome-app-off shutdown'                    ) end},
         { 'now + clear clipboard', function() run_script("/awesome-app-off 'shutdown + clear clipboard'") end}
       }

reb = {
        { 'now',                   function() run_script('/awesome-app-off reboot'                    ) end},
        { 'now + clear clipboard', function() run_script("/awesome-app-off 'reboot + clear clipboard'") end}
      }

quit_awesome = {
                 { 'now',                   function() run_script("/awesome-app-off 'quit awesome'"                  ) end},  -- function() awesome.quit() end
                 { 'now + clear clipboard', function() run_script("/awesome-app-off 'quit awesome + clear clipboard'") end}   -- function() awesome.quit() end
               }

off = {
        { 'shutdown',        shut                                                           },
        { 'reboot',          reb                                                            },
        { 'lock',            function() run_script('/awesome-app-off lock'             ) end},
        { 'screen off',      function() run_script('/awesome-app-off screen_off'       ) end},
        { 'quit awesome',    quit_awesome                                                   },
        { 'restart awesome', function() run_script("/awesome-app-off 'restart awesome'") end}  -- awesome.restart
      }

main_menu = awful.menu({
                         items = {
                                   { 'app', app },
                                   { 'off', off }
                                 }
                      })

main_menu_button = awful.widget.launcher({ image = beautiful.awesome_icon,
                                           menu  = main_menu })

-- set the terminal for applications that require it
menubar.utils.terminal = terminal
-- }}}
-- topwibox {{{
-- widgets & watches {{{
rand_wall_wch   = create_watch('rand_wall', 600)
jadi_wch        = create_watch('jadi', 600)

separator       = create_textbox(' ')
cur_scr_idx     = create_textbox('1')
cur_cli_cls     = create_textbox('')
clock           = wibox.widget.textclock('%I:%M', 30)  -- 30 is refresh interval in seconds
weather         = create_textbox('')
weather_wch     = create_watch('weather', 'update', 600)
kb_layout       = keyboardlayout()
audio           = create_textbox('')
audio_wch       = create_watch('audio', 5)
battery         = create_textbox('')
battery_wch     = create_watch('battery', 30)
memory_cpu      = create_textbox('')
memory_cpu_wch  = create_watch('memory_cpu', 'usage', 5)
harddisk        = create_textbox('')
harddisk_wch    = create_watch('harddisk', 'usage', 60)
pkg_count       = create_textbox('')
pkg_count_wch   = create_watch('pkg_count', 600)
processes       = create_textbox('')
processes_wch   = create_watch('processes', 10)
idle            = create_textbox('')
idle_wch        = create_watch('idle', 10)
reputation      = create_textbox('')
reputation_wch  = create_watch('reputation', 600)
youtube        = create_textbox('YO')
mbl_umbl        = create_textbox('')
mbl_umbl_wch    = create_watch('mbl_umbl', 10)
firewall        = create_textbox('')
bluetooth       = create_textbox('')
ymail           = create_textbox('')
ymail_wch       = create_watch('ymail', 1800)
gmail           = create_textbox('')
gmail_wch       = create_watch('gmail', 1800)
sec_rem         = create_textbox('')
sec_rem_wch     = create_watch('security_remote', 600)
webcam          = create_textbox('')
webcam_wch      = create_watch('webcam', 5)
git             = create_textbox('')
git_wch         = create_watch('git', 60)
clipboard       = create_textbox('')
clipboard_wch   = create_watch('clipboard', 5)
record          = create_textbox('RE')
keylogger       = create_textbox('')
keylogger_wch   = create_watch('klgr', 60)
established     = create_textbox('')
established_wch = create_watch('established', 10)
open_ports      = create_textbox('')
open_ports_wch  = create_watch('open_ports', 10)
tor             = create_textbox('')
network         = create_textbox('')
network_wch     = create_watch('network', 'usage', 1)

audacious       = create_textbox('')
audacious_bar   = wibox.widget { max_value        = 1,
                                 forced_width     = 60,
                                 forced_height    = 20,
                                 paddings         = 0,
                                 background_color = fg_l,
                                 color            = fg_d,
                                 shape            = gears.shape.bar,
                                 clip             = true,
                                 margins          = { top    = 0,
                                                      bottom = 0,
                                                      left   = 2,
                                                      right  = 2,
                                                    },
                                 widget           = wibox.widget.progressbar
                               }
audacious_bar_v = wibox.widget { audacious_bar,
                                 forced_height = 20,
                                 forced_width  = 3,
                                 direction     = 'east',
                                 layout        = wibox.container.rotate,
                               }
audacious_wch   = create_watch('audacious', 10)
-- }}}
-- containers {{{
cur_scr_idx_ct     = create_container(cur_scr_idx, fg_l)
cur_cli_cls_ct     = create_container(cur_cli_cls, fg_l)
clock_ct           = create_container(clock, fg_d)
weather_ct         = create_container(weather, fg_l)
kb_layout_ct       = create_container(kb_layout, fg_d)
audio_ct           = create_container(audio, fg_l)
battery_ct         = create_container(battery, fg_d)
memory_cpu_ct      = create_container(memory_cpu, fg_l)
harddisk_ct        = create_container(harddisk, fg_d)
pkg_count_ct       = create_container(pkg_count, fg_l)
processes_ct       = create_container(processes, fg_d)
idle_ct            = create_container(idle, fg_l)
reputation_ct      = create_container(reputation, fg_d)
youtube_ct         = create_container(youtube, fg_l)
mbl_umbl_ct        = create_container(mbl_umbl, fg_d)
firewall_ct        = create_container(firewall, fg_l)
bluetooth_ct       = create_container(bluetooth, fg_d)
ymail_ct           = create_container(ymail, fg_l)
gmail_ct           = create_container(gmail, fg_l)
sec_rem_ct         = create_container(sec_rem, fg_d)
webcam_ct          = create_container(webcam, fg_l)
git_ct             = create_container(git, fg_d)
clipboard_ct       = create_container(clipboard, fg_l)
record_ct          = create_container(record, fg_d)
keylogger_ct       = create_container(keylogger, fg_l)
established_ct     = create_container(established, fg_d)
open_ports_ct      = create_container(open_ports, fg_l)
tor_ct             = create_container(tor, fg_d)
network_ct         = create_container(network, fg_l)
audacious_ct       = create_container(audacious, fg_d)
audacious_bar_v_ct = create_container(audacious_bar_v, fg_d)
-- }}}
-- buttons {{{
local taglist_buttons = gears.table.join( awful.button({   }, 1, function(t) t:view_only() end),
                                       -- awful.button({ M }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
                                       -- awful.button({   }, 3, awful.tag.viewtoggle),
                                       -- awful.button({ M }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
                                          awful.button({   }, 4, function(t) awful.tag.viewprev(t.screen) end),
                                          awful.button({   }, 5, function(t) awful.tag.viewnext(t.screen) end)
                                        )

clock_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'date_jdate') end) ))

weather_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'weather', 'update'  ) end),
                                     awful.button({ }, 3, function() run_script('awesome-widgets', 'weather', 'forecast') end)
                                  ))

audio_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'audio', 'toggle_vol') end),
                                   awful.button({ }, 4, function() run_script('awesome-widgets', 'audio', 'vol_up'    ) end),
                                   awful.button({ }, 5, function() run_script('awesome-widgets', 'audio', 'vol_down'  ) end)
                                ))

memory_cpu_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'memory_cpu', 'intensives') end) ))

harddisk_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'harddisk', 'partitions') end) ))

reputation_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'reputation') end) ))

youtube_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'youtube') end) ))

firewall_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'firewall', 'turn_on' ) end),
                                      awful.button({ }, 3, function() run_script('awesome-widgets', 'firewall', 'turn_off') end)
                                   ))

bluetooth_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'bluetooth', 'turn_on' ) end),
                                       awful.button({ }, 3, function() run_script('awesome-widgets', 'bluetooth', 'turn_off') end)
                                    ))

ymail_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'ymail') end) ))

gmail_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'gmail') end) ))

sec_rem_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'security_remote') end) ))

git_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'git') end) ))

clipboard_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'clipboard', 'start') end),
                                       awful.button({ }, 3, function() run_script('awesome-widgets', 'clipboard', 'stop' ) end)
                                    ))

established_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'established', 'message') end) ))

open_ports_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'open_ports', 'message') end) ))

tor_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'tor', 'start') end),
                                 awful.button({ }, 3, function() run_script('awesome-widgets', 'tor', 'stop' ) end)
                              ))

audacious_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'audacious', 'play_pause') end),
                                       awful.button({ }, 3, function() run_script('awesome-widgets', 'audacious', 'next'      ) end),
                                       awful.button({ }, 4, function() run_script('awesome-widgets', 'audacious', '+60'       ) end),
                                       awful.button({ }, 5, function() run_script('awesome-widgets', 'audacious', '-60'       ) end)
                                    ))

audacious_bar_v_ct:buttons(gears.table.join( awful.button({ }, 1, function() run_script('awesome-widgets', 'audacious', 'play_pause') end),
                                             awful.button({ }, 3, function() run_script('awesome-widgets', 'audacious', 'next'      ) end),
                                             awful.button({ }, 4, function() run_script('awesome-widgets', 'audacious', '+60'       ) end),
                                             awful.button({ }, 5, function() run_script('awesome-widgets', 'audacious', '-60'       ) end)
                                          ))
-- }}}

awful.screen.connect_for_each_screen( function(s)

    wibox.widget.systray().visible = false

    set_wallpaper(s)

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox_mrgn = wibox.container.margin(s.mylayoutbox, 0, 0, 5, 5)
    s.mylayoutbox_mrgn:buttons(gears.table.join( awful.button({ }, 1, function() awful.layout.inc( 1) end),
                                                 awful.button({ }, 3, function() awful.layout.inc(-1) end),
                                                 awful.button({ }, 4, function() awful.layout.inc( 1) end),
                                                 awful.button({ }, 5, function() awful.layout.inc(-1) end)
                                              ))

    awful.tag({'1', '2', '3', '4', '5'}, s, awful.layout.layouts[1])  -- ➀➁➂➃➄➅➆➇➈➉ ➊➋➌➍➎➏➐➑➒➓ ⓵⓶⓷⓸⓹⓺⓻⓼⓽⓾ ⓿❶❷❸❹❺❻❼❽❾❿ ⓪①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳ ０１２３４５６７８９ Ⅰ Ⅱ Ⅲ ⅰ ⅱ ⅲ
    s.mytaglist = awful.widget.taglist { screen = s, filter = awful.widget.taglist.filter.noempty, buttons = taglist_buttons }  -- noempty/selected/all

    s.topwibox = awful.wibar({ position = 'top', screen = s, bg = bg, fg = grey_dark })
    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        { layout = wibox.layout.fixed.horizontal,
                     s.mypromptbox,
                     wibox.widget.systray(),
                     s.mylayoutbox_mrgn,
          separator, cur_scr_idx_ct,
          separator, s.mytaglist,
          separator, cur_cli_cls_ct,
          separator, clock_ct,
          separator, weather_ct,
          separator, kb_layout_ct,
          separator, audio_ct,
          separator, battery_ct,
          separator, memory_cpu_ct,
          separator, harddisk_ct,
          separator, pkg_count_ct,
          separator, processes_ct,
          separator, idle_ct,
          separator, reputation_ct,
          separator, youtube_ct,
          separator, mbl_umbl_ct,
          separator, firewall_ct,
          separator, bluetooth_ct,
          separator, ymail_ct,
          separator, gmail_ct,
          separator, sec_rem_ct,
          separator, webcam_ct,
          separator, git_ct,
          separator, clipboard_ct,
          separator, record_ct,
          separator, keylogger_ct,
          separator, established_ct,
          separator, open_ports_ct,
          separator, tor_ct,
          separator, network_ct,
        },
          separator,
        { layout = wibox.layout.fixed.horizontal,
                     audacious_ct,
          separator, audacious_bar_v_ct,
          separator
        },
    }
end)
-- }}}
-- root mouse bindings {{{
root.buttons(gears.table.join( awful.button({ }, 1, function() main_menu:hide() end),
                               awful.button({ }, 3, function() main_menu:toggle() end),
                               awful.button({ }, 4, awful.tag.viewprev),
                               awful.button({ }, 5, awful.tag.viewnext)
                            ))
-- }}}
-- modal keybindings {{{
local safe_mode_keybindings = { }

local audio_mode_keybindings = {
                                 { 'separator', 'volume' },
                                 { 'z', function() run_script('awesome-widgets', 'audio', 'vol_down') end, 'down' },
                                 { 'x', function() run_script('awesome-widgets', 'audio', 'vol_up')   end, 'up' },

                                 { 'separator', 'mic' },
                                 { 'v', function() run_script('awesome-widgets', 'audio', 'turn_up_mic') end, 'up mic' },
                                 { 's', function() run_script('awesome-widgets', 'audio', 'toggle_mic')  end, 'toggle mic' },
                               }
-- }}}
-- global keybindings {{{
globalkeys = gears.table.join(
   awful.key({ M       }, 'F1',          function() run_script('music') end, create_description('play' , 'music')),
   awful.key({ M       }, 'F2',          function() run_script('speech', 'play') end, create_description('play', 'speech')),
   awful.key({ M, S    }, 'F2',          function() run_script('speech', 'move') end, create_description('move', 'speech')),
   awful.key({ M, C    }, 'F2',          function() run_script('speech', 'add_4') end, create_description('add 4', 'speech')),
   awful.key({ M       }, 'F3',          function() run_script('movie', 'select') end, create_description('select', 'movie')),
   awful.key({ M, S    }, 'F3',          function() run_script('movie', 'random') end, create_description('random', 'movie')),
   awful.key({ M       }, 'F4',          function() run_script('awesome-widgets', 'restart_picom') end, create_description('', 'restart picom')),
   awful.key({ M       }, 'F5',          function() modalbind.grab{keymap=safe_mode_keybindings, name='Safe Mode (exit: KP_Subtract)', stay_in_mode=true} end, create_description('safe', 'modes')),  -- 0xff14
   awful.key({ M, S    }, 'F5',          function() modalbind.grab{keymap=audio_mode_keybindings, name='Audio Mode (exit: KP_Subtract)', stay_in_mode=true} end, create_description('audio', 'modes')),  -- 0xff14
   awful.key({ M       }, 'F6',          function() run_script('mount-umount', 'mount') end, create_description('mount', 'mount/umount')),
   awful.key({ M, S    }, 'F6',          function() run_script('mount-umount', 'umount') end, create_description('umount', 'mount/umount')),
   awful.key({ M       }, 'F7',          rename_tag, create_description('rename tag', 'screen/tag')),
   awful.key({ M, S    }, 'F7',          delete_tag, create_description('delete tag', 'screen/tag')),
   awful.key({ M, C    }, 'F7',          create_tag, create_description('new tag', 'screen/tag')),
   awful.key({ M       }, 'F8',          function() xrandr.xrandr() end, create_description('', 'xrandr')),
   awful.key({ M       }, 'F9',          function() awful.layout.set(awful.layout.suit.tile) end, create_description('tile', 'layout')),
   awful.key({ M       }, 'F10',         function() awful.layout.set(awful.layout.suit.floating) end, create_description('floating', 'layout')),
   --                     'F11' & 'F12' in client keybindings

   -- go to prev/next screen
   awful.key({ M       }, 'Left',        function() awful.screen.focus_relative(-1) end, create_description('prev screen', 'screen/tag')),  -- OR function() awful.screen.focus_bydirection('left') end)
   awful.key({ M       }, 'Right',       function() awful.screen.focus_relative(1) end, create_description('next screen', 'screen/tag')),  -- OR function() awful.screen.focus_bydirection('right') end)

   -- go to screen 1/2/3
   awful.key({ M       }, '1',           function() awful.screen.focus(1) end, create_description('screen 1', 'screen/tag')),
   awful.key({ M       }, '2',           function() awful.screen.focus(2) end, create_description('screen 2', 'screen/tag')),
   awful.key({ M       }, '3',           function() awful.screen.focus(3) end, create_description('screen 3', 'screen/tag')),

   -- go to prev/next tag
   awful.key({ M, S    }, 'Left',        awful.tag.viewprev, create_description('prev tag', 'screen/tag')),
   awful.key({ M, S    }, 'Right',       awful.tag.viewnext, create_description('next tag', 'screen/tag')),

   awful.key({ M       }, 'Return',      function() run_script('/awesome-app-off', 'terminal_tmux'    ) end, create_description('+ tmux', 'terminal')),      -- <--,
   awful.key({ M, S    }, 'Return',      function() run_script('/awesome-app-off', 'terminal_torsocks') end, create_description('+ torsocks', 'terminal')),  -- <--|-- exceptionally using awesome-app-off script instead of using run_in_shell function only for the sake of synchronisation
   awful.key({ M, C    }, 'Return',      function() run_script('/awesome-app-off', 'terminal'         ) end, create_description('', 'terminal')),            -- <--'

   awful.key({ M       }, 'space',       function() awful.layout.inc( 1) end, create_description('next', 'layout')),
   awful.key({ M, S    }, 'space',       function() awful.layout.inc(-1) end, create_description('prev', 'layout')),
   awful.key({ M       }, 'Tab',         function() awful.menu.menu_keys.down = { 'Down', 'Tab' } awful.menu.clients({ keygrabber = true, coords = { x = 4, y = 24 }}) end, create_description('cycle through', 'client')),
   awful.key({ M       }, 'Caps_Lock',   function() end, create_description('', '--')),  -- 0xffe5
   awful.key({ M       }, 'period',      function() resize_gap(1) end, create_description('decrease', 'gap')),  -- 0x2e
   awful.key({ M       }, 'comma',       function() resize_gap(-1) end, create_description('increase', 'gap')),  -- 0x2c
   awful.key({         }, 'KP_Insert',   function() run_script('awesome-widgets', 'audio', 'vol_30') end, create_description('volume 30', 'audio')),  -- 0xff9e
   awful.key({         }, 'KP_Down',     function() run_script('awesome-widgets', 'audio', 'vol_up') end, create_description('increase volume', 'audio')),  -- 0xff99
   awful.key({         }, 'KP_End',      function() run_script('awesome-widgets', 'audio', 'vol_down') end, create_description('decrease volume', 'audio')),  -- 0xff9c
   awful.key({ S       }, 'KP_Down',     function() run_script('awesome-widgets', 'audio', 'vol_100') end, create_description('volume 100', 'audio')),  -- 0xff99
   awful.key({ S       }, 'KP_End',      function() run_script('awesome-widgets', 'audio', 'vol_0') end, create_description('volume 0', 'audio')),  -- 0xff9c
   awful.key({         }, 'KP_Next',     function() run_script('awesome-widgets', 'audio', 'toggle_vol') end, create_description('toggle vol', 'audio')),  -- 0xff9b
   awful.key({         }, 'KP_Begin',    function() run_script('awesome-widgets', 'audio', 'mic_up') end, create_description('increase mic', 'audio')),  -- 0xff9d
   awful.key({         }, 'KP_Left',     function() run_script('awesome-widgets', 'audio', 'mic_down') end, create_description('decrease mic', 'audio')),  -- 0xff96
   awful.key({ S       }, 'KP_Begin',    function() run_script('awesome-widgets', 'audio', 'mic_100') end, create_description('mic 100', 'audio')),  -- 0xff9d
   awful.key({ S       }, 'KP_Left',     function() run_script('awesome-widgets', 'audio', 'mic_0') end, create_description('mic 0', 'audio')),  -- 0xff96
   awful.key({         }, 'KP_Right',    function() run_script('awesome-widgets', 'audio', 'toggle_mic') end, create_description('toggle mic', 'audio')),  -- 0xff98
   awful.key({         }, 'KP_Up',       function() run_script('awesome-widgets', 'audio', 'mon_up') end, create_description('increase mon', 'audio')),  -- 0xff97
   awful.key({         }, 'KP_Home',     function() run_script('awesome-widgets', 'audio', 'mon_down') end, create_description('decrease mon', 'audio')),  -- 0xff95
   awful.key({ S       }, 'KP_Up',       function() run_script('awesome-widgets', 'audio', 'mon_100') end, create_description('mon 100', 'audio')),  -- 0xff97
   awful.key({ S       }, 'KP_Home',     function() run_script('awesome-widgets', 'audio', 'mon_0') end, create_description('mon 0', 'audio')),  -- 0xff95
   awful.key({         }, 'KP_Prior',    function() run_script('awesome-widgets', 'audio', 'toggle_mon') end, create_description('toggle mon', 'audio')),  -- 0xff9a
   awful.key({         }, 'KP_Delete',   function() run_script('awesome-widgets', 'audio', 'full_info') end, create_description('full info', 'audio')),  -- 0xff90
   awful.key({         }, 'KP_Add',      function() run_script('awesome-widgets', 'audio', 'connect_to_headset') end, create_description('connect to headset', 'audio')),  -- 0xffab
   awful.key({         }, '0x1008ff8e',  function() run_script('awesome-widgets', 'audacious', 'play_pause') end, create_description('play/pause', 'audacious')),
   awful.key({ M       }, '0x1008ff8e',  function() run_script('awesome-widgets', 'audacious', 'songs') end, create_description('songs', 'audacious')),
   awful.key({         }, '0x1008ff2e',  function() run_script('awesome-widgets', 'audacious', 'prev') end, create_description('prev', 'audacious')),
   awful.key({         }, '0x1008ff4a',  function() run_script('awesome-widgets', 'audacious', 'next') end, create_description('next', 'audacious')),
   awful.key({         }, '0x1008ff41',  function() run_script('awesome-widgets', 'audacious', '+60') end, create_description('+60', 'audacious')),
   awful.key({         }, '0x1008ff19',  function() run_script('awesome-widgets', 'audacious', '-60') end, create_description('-60', 'audacious')),
   awful.key({         }, '0x1008ff2d',  function() run_script('awesome-widgets', 'audacious', 'tog_shuff') end, create_description('toggle shuffle', 'audacious')),
   awful.key({         }, 'Print',       function() run_script('awesome-widgets', 'audacious', 'forward') end, create_description('forward', 'audacious')),  -- 0xff61
   awful.key({         }, 'Scroll_Lock', function() run_script('awesome-widgets', 'audacious', 'resume') end, create_description('resume', 'audacious')),  -- 0xff14
   awful.key({         }, 'Pause',       function() end, create_description('', '--')),  -- 0xff13
   awful.key({         }, 'KP_Enter',    function() run_script('awesome-widgets', 'audacious', 'main_window') end, create_description('main window', 'audacious')),  -- 0xff8d
-- awful.key({ M       }, 'Print',       function() local cur_scr_index = awful.screen.focused().index if cur_scr_index == 1 then run_script('awesome-widgets', 'youtube', 'screen_1') else run_script('awesome-widgets', 'youtube', 'screen_2') end end, create_description('', 'youtube')),  -- 0xff61
   awful.key({ M       }, 'Print',       function() run_script('awesome-widgets', 'youtube') end, create_description('', 'youtube')),  -- 0xff61
   awful.key({ M       }, 'Scroll_Lock', function() mouse.screen.topwibox.ontop = not mouse.screen.topwibox.ontop end, create_description('toggle ontop', 'topwibox')),  -- 0xff14
   awful.key({ M       }, 'Pause',       function() mouse.screen.topwibox.visible = not mouse.screen.topwibox.visible end, create_description('toggle visibility', 'topwibox')),  -- OR: awful.key({ M }, '=', function() awful.screen.focused().topwibox.visible = not awful.screen.focused().topwibox.visible end) (https://wiki.archlinux.org/index.php/awesome) :-- 0xff13
   awful.key({ M       }, '-',           function() end, create_description('', '--')),
   awful.key({ M       }, '=',           function() end, create_description('', '--')),
   awful.key({ M       }, 'BackSpace',   function() wibox.widget.systray().visible = not wibox.widget.systray().visible end, create_description('', 'systray')),  -- (https://pavelmakhov.com/2018/01/hide-systray-in-awesome/):
   awful.key({ M       }, 'Insert',      function() run_in_shell('touch /tmp/security-remote-proof') end, create_description('touch proof', 'security remote')),  -- 0xff63
   awful.key({ M       }, 'Delete',      function() run_script('awesome-widgets', 'turn_off_scr_3') end, create_description('turn off screen 3', 'screen/tag')),  -- 0xffff
   awful.key({ M       }, 'Home',        function() run_script('awesome-widgets', 'memory_cpu', 'intensives') end, create_description('', 'memory/cpu intensives')),
   awful.key({ M       }, 'End',         function() run_script('off') end, create_description('', 'off')),  -- 0xff57
   awful.key({ M       }, 'Prior',       function() end, create_description('', '--')),  -- 0xff55 (page up key)
   awful.key({ M       }, 'Next',        function() end, create_description('', '--')),  -- 0xff56 (page down key)
   awful.key({ M       }, 'Menu',        hotkeys_popup.show_help, create_description('', 'keybindings')),  -- 0xff67
   awful.key({ M       }, '\\',          function() run_script('awesome-widgets', 'harddisk', 'partitions') end, create_description('', 'partitions')),
   awful.key({ M       }, '/',           function() run_script('reminder.py') end, create_description('', 'reminder')),
   awful.key({ M       }, 'q',           function() run_script('awesome-widgets', 'clipboard', 'start') end, create_description('start', 'clipboard')),
   awful.key({ M, S    }, 'q',           function() run_script('awesome-widgets', 'clipboard', 'stop') end, create_description('stop', 'clipboard')),
   awful.key({ M       }, 'w',           function() run_script('screenshot.py') end, create_description('', 'screenshot')),
   awful.key({ M       }, 'e',           function() run_script('todo') end, create_description('', 'todo')),
   awful.key({ M       }, 'r',           function() run_script('fingil') end, create_description('', 'fingil')),
   awful.key({ M       }, 't',           function() run_script('0-test') end, create_description('0-test', '0-test{,.py}')),
   awful.key({ M, S    }, 't',           function() run_script('0-test.py') end, create_description('0-test.py', '0-test{,.py}')),
   awful.key({ M       }, 'y',           function() end, create_description('', '--')),
   awful.key({ M       }, 'u',           function() run_script('awesome-widgets', 'established', 'message') end, create_description('', 'established')),
   awful.key({ M       }, 'i',           function() run_script('awesome-widgets', 'ymail') end, create_description('ymail', 'e-mail')),
   awful.key({ M, S    }, 'i',           function() run_script('awesome-widgets', 'gmail') end, create_description('gmail', 'e-mail')),
   awful.key({ M       }, 'o',           function() run_script('record-audio.py') end, create_description('audio', 'record')),
   awful.key({ M, S    }, 'o',           function() run_script('record-video.py') end, create_description('video', 'record')),
   awful.key({ M, C    }, 'o',           function() run_script('record-screen.py') end, create_description('screen', 'record')),
   awful.key({ M       }, 'p',           function() run_script('launcher', 'rofi') end, create_description('rofi', 'launcher')),
   awful.key({ M, S    }, 'p',           function() run_script('launcher', 'dmenu') end, create_description('dmenu', 'launcher')),
   awful.key({ M, C    }, 'p',           function() main_menu:toggle({coords = {x = 20, y = 26}}) end, create_description('main menu', 'launcher')),
   awful.key({ M, A    }, 'p',           function() awful.screen.focused().mypromptbox:run() end, create_description('prompt box', 'launcher')),
   awful.key({ M       }, '[',           function() run_script('browser', 'firefox') end, create_description('firefox', 'browser')),
   awful.key({ M, S    }, '[',           function() run_script('browser', 'chromium') end, create_description('chromium', 'browser')),
   awful.key({ M, C    }, '[',           function() run_script('browser', 'qb') end, create_description('qutebrowser', 'browser')),
   awful.key({ M       }, ']',           function() run_script('dictionary', 'goldendict') end, create_description('goldendict', 'dictionary')),
   awful.key({ M, S    }, ']',           function() run_script('dictionary', 'goldendict words') end, create_description('goldendict + words', 'dictionary')),
   awful.key({ M       }, 'a',           function() run_script('awesome-widgets', 'weather', 'update') end, create_description('update', 'weather')),
   awful.key({ M, S    }, 'a',           function() run_script('awesome-widgets', 'weather', 'forecast') end, create_description('forecast', 'weather')),
   awful.key({ M       }, 's',           function() run_script('awesome-widgets', 'firewall', 'turn_on') end, create_description('turn on', 'firewall')),
   awful.key({ M, S    }, 's',           function() run_script('awesome-widgets', 'firewall', 'turn_off') end, create_description('turn off', 'firewall')),
   awful.key({ M       }, 'd',           function() local tags = awful.screen.focused().tags for i = 1, 2 do tags[i].selected = false end end, create_description('show', 'desktop')),  --  <--,-- (https://stackoverflow.com/questions/47578473/how-to-hide-all-clients-in-all-tags-in-awesomewm)
   awful.key({ M, S    }, 'd',           function() local tags = awful.screen.focused().tags for i = 1, 2 do tags[i].selected = true end end, create_description('unshow', 'desktop')),  -- <--'
   awful.key({ M       }, 'f',           function() run_script('awesome-widgets', 'bluetooth', 'turn_on') end, create_description('turn on', 'bluetooth')),
   awful.key({ M, S    }, 'f',           function() run_script('awesome-widgets', 'bluetooth', 'turn_off') end, create_description('turn off', 'bluetooth')),
   awful.key({ M       }, 'g',           function() run_script('awesome-widgets', 'network', 'turn_on_wifi') end, create_description('turn on wifi', 'network')),
   awful.key({ M, S    }, 'g',           function() run_script('awesome-widgets', 'network', 'turn_off_wifi') end, create_description('turn off wifi', 'network')),
   awful.key({ M       }, 'h',           function() awful.tag.incmwfact(-0.01) end, create_description('decrease master width', 'client')),
   awful.key({ M       }, 'l',           function() awful.tag.incmwfact(0.01) end, create_description('increase master width', 'client')),
   awful.key({ M, S    }, 'h',           function() awful.client.incwfact(-0.01) end, create_description('decrease non-master width', 'client')),  -- (https://stackoverflow.com/questions/17705888/resizing-window-vertically)
   awful.key({ M, S    }, 'l',           function() awful.client.incwfact(0.01) end, create_description('increase non-master width', 'client')),  -- (https://stackoverflow.com/questions/17705888/resizing-window-vertically)
   awful.key({ M       }, 'k',           function() awful.client.focus.byidx(1) end, create_description('next', 'client')),
   awful.key({ M       }, 'j',           function() awful.client.focus.byidx(-1) end, create_description('prev', 'client')),
   awful.key({ M, S    }, 'k',           function() awful.client.swap.byidx(1) end, create_description('swap with next', 'client')),
   awful.key({ M, S    }, 'j',           function() awful.client.swap.byidx(-1) end, create_description('swap with prev', 'client')),
   awful.key({ M       }, 'semicolon',   function() awful.tag.incnmaster(-1, nil, true) end, create_description('decrease no. of masters', 'client')),  -- 0x3b
   awful.key({ M       }, 'apostrophe',  function() awful.tag.incnmaster( 1, nil, true) end, create_description('increase no. of masters', 'client')),  -- 0x27
   awful.key({ M, S    }, 'semicolon',   function() awful.tag.incncol(-1, nil, true) end, create_description('decrease no. of columns', 'client')),  -- 0x3b
   awful.key({ M, S    }, 'apostrophe',  function() awful.tag.incncol(1, nil, true) end, create_description('increase no. of columns', 'client')),  -- 0x27
   awful.key({ M       }, 'z',           function() run_script('wallpaper', 'select') end, create_description('select', 'wallpaper')),
   awful.key({ M, S    }, 'z',           function() run_script('wallpaper', 'random') end, create_description('random', 'wallpaper')),
   awful.key({ M, C    }, 'z',           function() run_script('wallpaper', 'current') end, create_description('current', 'wallpaper')),
   awful.key({ M       }, 'x',           function() run_script('awesome-widgets', 'date_jdate') end, create_description('', 'date/jdate')),
   awful.key({ M       }, 'v',           function() run_script('awesome-widgets', 'tor', 'start') end, create_description('start', 'tor')),
   awful.key({ M, S    }, 'v',           function() run_script('awesome-widgets', 'tor', 'stop') end, create_description('stop', 'tor')),
   awful.key({ M, C    }, 'v',           function() run_script('awesome-widgets', 'tor', 'restart') end, create_description('restart', 'tor')),
   awful.key({ M       }, 'b',           function() run_script('awesome-widgets', 'open_ports', 'message') end, create_description('', 'open ports')),
   awful.key({ M, S    }, 'n',           function() local c = awful.client.restore() if c then client.focus = c c:raise() end end, create_description('unminimize', 'client'))  -- do NOT put comma at th end
)
-- }}}
-- client keybindings {{{
clientkeys = gears.table.join(
   awful.key({ M       }, 'F11',         awful.titlebar.toggle, create_description('toggle titlebar', 'client')),
   awful.key({ M       }, 'F12',         awful.client.floating.toggle, create_description('toggle floating', 'client')),
   awful.key({ M, S    }, 'F12',         function(c) if c.floating == false then awful.client.floating.toggle(c) c:geometry({ width = 700 , height = 500 }) awful.placement.centered(c) else awful.client.floating.toggle(c) end end, create_description('centralize/uncentralize', 'client')),
   awful.key({ M       }, 'KP_End',      function(c) c:relative_move(-20,   0,   0,   0) end, create_description('move left', 'floating client move/resize')),  -- 0xff9c
   awful.key({ M       }, 'KP_Next',     function(c) c:relative_move( 20,   0,   0,   0) end, create_description('move right', 'floating client move/resize')),  -- 0xff9b
   awful.key({ M       }, 'KP_Begin',    function(c) c:relative_move(  0, -20,   0,   0) end, create_description('move up', 'floating client move/resize')),  -- 0xff9d
   awful.key({ M       }, 'KP_Down',     function(c) c:relative_move(  0,  20,   0,   0) end, create_description('move down', 'floating client move/resize')),  -- 0xff99
   awful.key({ M, S    }, 'KP_Next',     function(c) c:relative_move(  0,   0,  20,   0) end, create_description('increase width', 'floating client move/resize')),  -- 0xff9b
   awful.key({ M, S    }, 'KP_End',      function(c) c:relative_move(  0,   0, -20,   0) end, create_description('decrease width', 'floating client move/resize')),  -- 0xff9c
   awful.key({ M, S    }, 'KP_Down',     function(c) c:relative_move(  0,   0,   0,  20) end, create_description('increase height', 'floating client move/resize')),  -- 0xff99
   awful.key({ M, S    }, 'KP_Begin',    function(c) c:relative_move(  0,   0,   0, -20) end, create_description('decrease height', 'floating client move/resize')),  -- 0xff9d
   awful.key({ M       }, 'Escape',      function(c) c:lower() end, create_description('lower', 'client')),
   awful.key({ M, S    }, 'Escape',      function(c) c:raise() end, create_description('raise', 'client')),
   awful.key({ M       }, 'c',           function(c) c:kill() end, create_description('close', 'client')),
   awful.key({ M       }, 'm',           function(c) c:swap(awful.client.getmaster()) end, create_description('move to master', 'client')),
   awful.key({ M       }, 'n',           function(c) c.minimized = true end, create_description('minimize', 'client')),
   awful.key({ M       }, 'Up',          function(c) c.maximized = not c.maximized c:raise() end, create_description('maximize/unmaximize', 'client')),
   awful.key({ M, S    }, 'Up',          function(c) c.maximized_vertical = not c.maximized_vertical c:raise() end, create_description('maximize/unmaximize vertically', 'client')),
   awful.key({ M, A    }, 'Up',          function(c) c.maximized_horizontal = not c.maximized_horizontal c:raise() end, create_description('maximize/unmaximize horizontally', 'client')),
   awful.key({ M, C    }, '1',           function(c) c:move_to_screen(1) end, create_description('move to screen 1', 'client')),
   awful.key({ M, C    }, '2',           function(c) c:move_to_screen(-1) end, create_description('move to screen 2', 'client')),
   awful.key({ M, C    }, 'Left',        function(c) c:move_to_screen(1) end, create_description('move to prev screen', 'client')),
   awful.key({ M, C    }, 'Right',       function(c) c:move_to_screen(-1) end, create_description('move to next screen', 'client'))
)

-- }}}
-- tag keybindings {{{
-------------- BY ME vv --------------
globalkeys = gears.table.join( globalkeys,
    -- move client to prev tag
    awful.key({ M, C, S }, 'Left',
                function() if client.focus then
                             current_tag_index = awful.screen.focused().selected_tag.index
                             if     current_tag_index == 1 then prev_tag_index = 5
                             elseif current_tag_index == 2 then prev_tag_index = 1
                             elseif current_tag_index == 3 then prev_tag_index = 2
                             elseif current_tag_index == 4 then prev_tag_index = 3
                             elseif current_tag_index == 5 then prev_tag_index = 4
                             end

                             local tag = client.focus.screen.tags[prev_tag_index]
                             if tag then client.focus:move_to_tag(tag) end

                             -- and also go to the tag
                             local screen = awful.screen.focused()    --,
                             local tag = screen.tags[prev_tag_index]  --|--> OR awful.tag.viewprev,
                             if tag then tag:view_only() end          --'
                           end
                end,
                create_description('move to prev tag', 'client')),

    -- move client to next tag
    awful.key({ M, C, S }, 'Right',
                function() if client.focus then
                             current_tag_index = awful.screen.focused().selected_tag.index
                             if     current_tag_index == 1 then next_tag_index = 2
                             elseif current_tag_index == 2 then next_tag_index = 3
                             elseif current_tag_index == 3 then next_tag_index = 4
                             elseif current_tag_index == 4 then next_tag_index = 5
                             elseif current_tag_index == 5 then next_tag_index = 1
                             end

                             local tag = client.focus.screen.tags[next_tag_index]
                             if tag then client.focus:move_to_tag(tag) end

                             -- and also go to the tag
                             local screen = awful.screen.focused()    --,
                             local tag = screen.tags[next_tag_index]  --|--> OR awful.tag.viewnext,
                             if tag then tag:view_only() end          --'
                           end
                end,
                create_description('move to next tag', 'client'))
)
-------------- BY ME ^^ --------------

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do  -- original: for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- go to tag 1/5
        awful.key({ M, S }, i,  -- original: '#' .. i + 9,
                  function() local screen = awful.screen.focused()
                             local tag = screen.tags[i]
                             if tag then tag:view_only() end
                  end,
                  create_description('tag ' .. i, 'screen/tag')),

        -- move client to tag 1/5
        awful.key({ M, C, S }, i,  -- original: awful.key({ M, S }, '#' .. i + 9,
                  function() if client.focus then
                               local tag = client.focus.screen.tags[i]
                               if tag then client.focus:move_to_tag(tag) end

                               -- and also go to tag i
                               local screen = awful.screen.focused()
                               local tag = screen.tags[i]
                               if tag then tag:view_only() end
                             end
                  end,
                  create_description('move to tag ' .. i, 'client'))

        -- Toggle tag display
        -- awful.key({ M, C }, '#' .. i + 9,
        --           function()
        --               local screen = awful.screen.focused()
        --               local tag = screen.tags[i]
        --               if tag then
        --                  awful.tag.viewtoggle(tag)
        --               end
        --           end,
        --           create_description('toggle tag #' .. i, 'tag')),

        -- Toggle tag on focused client
        -- awful.key({ M, C, S }, '#' .. i + 9,
        --           function()
        --               if client.focus then
        --                   local tag = client.focus.screen.tags[i]
        --                   if tag then
        --                       client.focus:toggle_tag(tag)
        --                   end
        --               end
        --           end,
        --           create_description('toggle focused client on tag #' .. i, 'tag'))
    )
end
-- }}}
-- client mouse bindings {{{
clientbuttons = gears.table.join( awful.button({   }, 1, function(c) c:emit_signal('request::activate', 'mouse_click', {raise = true}) end),
                                  awful.button({ M }, 1, function(c) c:emit_signal('request::activate', 'mouse_click', {raise = true})
                                                                     awful.mouse.client.move(c)
                                                         end),
                                  awful.button({ M }, 3, function(c) c:emit_signal('request::activate', 'mouse_click', {raise = true})
                                                                     awful.mouse.client.resize(c)
                                                         end)
                                )
-- }}}
-- set root keys {{{
root.keys(globalkeys)
-- }}}
-- rules {{{
-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
      rule = { },
      properties = {
                     border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered,  -- ORIG: placement = awful.placement.no_overlap+awful.placement.no_offscreen
                     size_hints_honor = false  -- to make terminal fill screen properly (https://stackoverflow.com/questions/28369999/awesome-wm-terminal-window-doesnt-take-full-space)
                   },
      callback = awful.client.setslave  -- start clients as slave instead of master (https://awesomewm.org/apidoc/documentation/90-FAQ.md.html)
    },

    -- Floating clients.
    {
      rule_any = {
                   instance = {
                                'DTA',  -- Firefox addon DownThemAll.
                                'copyq',  -- Includes session name in class.
                                'pinentry',
                              },
                   class = {
                             'Arandr',
                             -- 'Blueman-manager',
                             'Gpick',
                             'Kruler',
                             'MessageWin',  -- kalarm.
                             'Sxiv',
                             -- 'Tor Browser',  -- Needs a fixed window size to avoid fingerprinting by screen size.
                             'Wpa_gui',
                             'veromix',
                             'xtightvncviewer'
                           },

                   -- Note that the name property shown in xprop might be set slightly after creation of the client
                   -- and the name shown there might not match defined rules here.
                   name = { 'Event Tester' },  -- xev.
                   role = {
                            'AlarmWindow',  -- Thunderbird's calendar.
                            'ConfigManager',  -- Thunderbird's about:config.
                            'pop-up',       -- e.g. Google Chrome's (detached) Developer Tools.
                          }
                 },
      properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
      rule_any   = { type = { 'normal', 'dialog' }},  -- to get more types: https://awesomewm.org/doc/api/classes/client.html
      properties = { titlebars_enabled = true }  -- JUMP_1 does this work?
    },

    -- Pause audacious when vlc opens:
    {
      rule       = { class = 'vlc' },
      properties = { callback = function(c) run_script('awesome-widgets', 'audacious', 'pause') end,
                     screen = 2,
                     -- this throws error when second monitor is not available.
                     -- so we can do this:
                     -- screen = function() return screen.count() end,  -- https://stackoverflow.com/questions/61427799/i-would-like-to-open-one-program-on-the-second-screen-in-awesomewm-but-only-if
                   },
    },

    -- Pause audacious when mpv opens (only works when opening a video):
    {
      rule       = { class = 'mpv' },
      properties = { callback = function(c) run_script('awesome-widgets', 'audacious', 'pause') end, },
    },

    -- Open gpicview maximized with titlebar:
    {
      rule       = { class = 'Gpicview' },
      properties = { callback = function(c) awful.titlebar.show(c) end,
                     -- maximized = true,
                   },
    },

    -- Open audacious in floating and centered:
    -- {
    --   rule       = { class = 'Audacious' },
    --   properties = { floating = true,
    --                  callback = function(c) awful.placement.under_mouse(c)  end,
    --                  callback = function(c) awful.placement.no_offscreen(c) end,
    --                  callback = function(c) awful.placement.centered(c)     end,
    --                },
    -- },

    -- Add titlebars to specific clients:
    -- {
    --   rule_any   = { class = { 'vlc', 'Gpicview', 'Gimp' }},
    --   properties = { titlebars_enabled = true },  -- JUMP_1 does this work?
    -- },

    -- Set xfce4-terminal to always map on a specific tag on a specific screen:
    -- {
    --   rule       = { class = 'Xfce4-terminal' },
    --   properties = { screen = 1, tag = '2' },
    -- },

    -- Set Firefox to always map on the tag named '2' on screen 1.
    -- {
    --   rule = { class = 'Firefox' },
    --   properties = { screen = 1, tag = '2' }
    -- },
}
-- }}}
-- signals {{{

  -- display message when client appears (https://superuser.com/questions/585058/how-to-move-just-opened-new-window-of-an-already-started-client-to-a-tag-automat)
  -- client.connect_signal('manage', function(c, startup)
  --     naughty.notify({ preset  = naughty.config.presets.normal,
  --                      text    = c.name,
  --                      timeout = 1
  --                    })
  -- end)

  -- Signal when layout changes (https://stackoverflow.com/questions/28261378/how-to-get-a-signal-when-layout-has-changed-in-awesome-wm):
  --  tag.connect_signal('property::layout', function(t) naughty.notify({ preset = naughty.config.presets.normal,
  --                                                                      text   = awful.layout.getname(),
  --                                                                   })
  --                                         end)

  -- prevent firefox from stealing focus (https://awesomewm.org/doc/api/libraries/awful.ewmh.html):
  awful.ewmh.add_activate_filter( function(c) if c.class == 'firefox' then return false end end, 'ewmh' )

  -- prevent new clients from being urgent by default (https://github.com/awesomeWM/awesome/blob/master/docs/90-FAQ.md):
  client.disconnect_signal('request::activate', awful.ewmh.activate)
  function awful.ewmh.activate(c)
      if c:isvisible() then
          client.focus = c
          c:raise()
      end
  end
  client.connect_signal('request::activate', awful.ewmh.activate)

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
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
    local buttons = gears.table.join( awful.button({ }, 1, function() c:emit_signal('request::activate', 'titlebar', {raise = true})
                                                                      awful.mouse.client.move(c)
                                                           end),
                                      awful.button({ }, 3, function() c:emit_signal('request::activate', 'titlebar', {raise = true})
                                                                      awful.mouse.client.resize(c)
                                                           end)
                                    )

    awful.titlebar(c):setup { {  -- Left
                                awful.titlebar.widget.iconwidget(c),
                                buttons = buttons,
                                layout  = wibox.layout.fixed.horizontal
                              },
                              {  -- Middle
                                {  -- Title
                                  align  = 'center',
                                  widget = awful.titlebar.widget.titlewidget(c)
                                },
                                buttons = buttons,
                                layout  = wibox.layout.flex.horizontal
                              },
                              {  -- Right
                                awful.titlebar.widget.floatingbutton (c),
                                awful.titlebar.widget.maximizedbutton(c),
                                awful.titlebar.widget.stickybutton   (c),
                                awful.titlebar.widget.ontopbutton    (c),
                                awful.titlebar.widget.closebutton    (c),
                                layout = wibox.layout.fixed.horizontal()
                              },
                              layout = wibox.layout.align.horizontal
                            }
                            awful.titlebar.hide(c)  -- initially hides the titlebars (https://wiki.archlinux.org/index.php/awesome)
                            awful.titlebar.enable_tooltip = false  -- hides tooltips from titlebar (https://www.reddit.com/r/awesomewm/comments/88x9po/how_to_hide_awfultitlebarwidgetclosebutton_tooltip/)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c) c:emit_signal('request::activate', 'mouse_enter', {raise = false}) end)

client.connect_signal('focus',   function(c) sccc(client.focus.class)
                                          -- sccp(client.focus.pid)
                                             scsi()
                                             c.opacity = 1
                                 end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal
                                             if c.class ~= 'vlc' then c.opacity = 0.88 end
                                 end)
-- }}}
-- autorun {{{
run_script('awesome-autorun')
-- }}}
-- notes {{{
-- cur_scr_index="$(awesome-client 'local awful = require("awful") ; return awful.screen.focused().index' | awk '{print $NF}')"
-- tag:    awful.tag.selected()                      0x55ab4c31eac8 <--,
--         awful.tag.selected().name                 ➊              <--|-- depracated
--         awful.tag.selected().index                1              <--'
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
-- separator, s.index == 1 and youtube1_ct, s.index == 2 and youtube2_ct,
-- s.index == 2 and s.mylayoutbox,
-- screen:count() == 2 and s.index == 1 and s.mylayoutbox,

-- get a script output (https://www.reddit.com/r/awesomewm/comments/abssz2/having_trouble_configuring_rclua/):
-- awful.key({ M    }, '=', function() awful.spawn.easy_async_with_shell(hns .. '/awesome-widgets battery',
--                                     function(stdout, stderr, exitreason, exitcode)
--                                         naughty.notify({ title = 'Battery Info', text = stdout })
--                                     end)
--                          end, create_description('do this', 'group name')),

--  ╭─► time_wch = awful.widget.watch( { awful.util.shell, '-c', .. hns .. '/awesome-widgets time' }, 10, function(widget, stdout) widget:set_markup(stdout) end)
-- ─┤
--  ╰─► time_wch = awful.widget.watch('bash -c ' .. hns .. '"/awesome-widgets time"', 10, function(widget, stdout) widget:set_markup(stdout) end)

-- function(widget, stdout, stderr, exitreason, exitcode)
-- function(stdout, _, _, _)

-- Trigger timer in bash:
-- echo -e '<timer>:emit_signal("timeout")' | awesome-client && exit

-- set a custom colour for a category in awful.hotkeys_popup (https://stackoverflow.com/questions/68396503/how-do-i-set-a-custom-colour-for-a-category-in-awful-hotkeys-popup/68396654#68396654)
-- hotkeys_popup.add_group_rules('awesome', { color = '#fF0000' })

-- aud_grid {{{
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
-- }}}
-- }}}
