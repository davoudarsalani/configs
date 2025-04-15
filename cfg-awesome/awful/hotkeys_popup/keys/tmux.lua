---------------------------------------------------------------------------
--- tmux hotkeys for awful.hotkeys_widget
--
-- @author nahsi nashi@airmail.cc
-- @copyright 2017 nahsi
-- @submodule  awful.hotkeys_popup
---------------------------------------------------------------------------
-- For example: tmux.add_rules_for_terminal({ rule = { name = { 'tmux' }}})
-- will show tmux hotkeys for any window that has 'tmux' in its title. If no rules are provided then tmux hotkeys will be shown always!
-- @function add_rules_for_terminal
-- @see awful.rules.rules
-- @tparam table rule Rules to match a window containing a tmux session.

local hotkeys_popup = require('awful.hotkeys_popup.widget')
local tmux = {}

local kb_fg__fzf     = os.getenv('gruvbox_purple')
local kb_fg__sublime = os.getenv('gruvbox_orange')
local kb_fg__tmux    = os.getenv('gruvbox_aqua')
local kb_fg__vscode  = os.getenv('gruvbox_green')
local kb_fg__yazi    = os.getenv('gruvbox_yellow')

-- shares structure with create_description function is rc.lua
function create_description(kb_fg, desc)
  return '  <span color="' .. kb_fg .. '">' .. desc .. '</span>'
end

function tmux.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ['fzf']     = rule,
        ['sublime'] = rule,
        ['tmux']    = rule,
        ['vscode']  = rule,
        ['yazi']    = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local fzf_keys = {
  ['fzf'] = {
    {
      modifiers = {},
      keys = {
               ['Tab'] = create_description(kb_fg__fzf, 'select/unselect'),
             }
    },
    {
      modifiers = {'Ctrl'},
      keys = {
               a = create_description(kb_fg__fzf, 'select all'),
               j = create_description(kb_fg__fzf, 'scroll down preview'),
               k = create_description(kb_fg__fzf, 'scroll up preview'),
               s = create_description(kb_fg__fzf, 'toggle sort'),
               t = create_description(kb_fg__fzf, 'select'),
               v = create_description(kb_fg__fzf, 'paste  selected item preceded with vim'),
               w = create_description(kb_fg__fzf, 'toggle preview'),
               y = create_description(kb_fg__fzf, 'copy path to clipboard'),
             }
    },
    {
    modifiers = {'Alt'},
    keys = {
             c = create_description(kb_fg__fzf, 'cd'),
           }
    },
  },
}

-- exceptionally all modifiers written in one place
local sublime_keys = {
  ['sublime'] = {
    {
      modifiers = {},
      keys = {
               ['Alt+Shift+↕']             = create_description(kb_fg__sublime, 'multiple cursors'),
               ['Ctrl+Shift+l']            = create_description(kb_fg__sublime, 'multiple cursors in selection'),
               ['Ctrl+d']                  = create_description(kb_fg__sublime, 'select similar words/selection one by one'),
               ['Alt+F3']                  = create_description(kb_fg__sublime, 'select similar words/selection at once'),
               ['Ctrl+k Ctrl+d']           = create_description(kb_fg__sublime, 'skip when selecting similar words/selection'),
               ['Ctrl+k Ctrl+b']           = create_description(kb_fg__sublime, 'toggle sidebar'),
               ['Ctrl+Shift+↕']            = create_description(kb_fg__sublime, 'move line ↕'),
               ['Ctrl+Shift+d']            = create_description(kb_fg__sublime, 'duplicate line/selection'),
               ['Ctrl+Shift+k']            = create_description(kb_fg__sublime, 'delete line'),
               ['Ctrl+Shift+j']            = create_description(kb_fg__sublime, 'join lines'),
               ['Ctrl+[/]']                = create_description(kb_fg__sublime, 'indent/unindent'),
               ['Ctrl+;']                  = create_description(kb_fg__sublime, 'find word'),
               ['Ctrl+Shift+[/]']          = create_description(kb_fg__sublime, 'fold/unfold'),
               ['Ctrl+k Ctrl+1']           = create_description(kb_fg__sublime, 'fold all'),
               ['Ctrl+k Ctrl+j']           = create_description(kb_fg__sublime, 'unfold all'),
               ['Ctrl+k Ctrl+k']           = create_description(kb_fg__sublime, 'delete to end line'),
               ['Ctrl+k Ctrl+Backspace']   = create_description(kb_fg__sublime, 'delete to beginning of line'),
               ['Ctrl+p']                  = create_description(kb_fg__sublime, 'jump to (with: @, # and :)'),
               ['Ctrl+t']                  = create_description(kb_fg__sublime, 'transpose'),
               ['Ctrl+↕']                  = create_description(kb_fg__sublime, 'move screen ↕ (in css: ↕ number)'),
               ['Alt+↕']                   = create_description(kb_fg__sublime, '(in css: ↕ number by .1)'),
               ['Ctrl+Alt+Shift+p']        = create_description(kb_fg__sublime, 'show scope for current file'),
               ['Ctrl+Shift+v']            = create_description(kb_fg__sublime, 'smart paste'),
               ['Ctrl+k Ctrl+v']           = create_description(kb_fg__sublime, 'paste from history'),
               ['Ctrl+/']                  = create_description(kb_fg__sublime, 'toggle comment'),
               ['Ctrl+Shift+/']            = create_description(kb_fg__sublime, 'toggle block comment'),
               ['Ctrl+Enter']              = create_description(kb_fg__sublime, 'insert line after'),
               ['Ctrl+Shift+Enter']        = create_description(kb_fg__sublime, 'insert line before'),
               ['Ctrl+Backspace']          = create_description(kb_fg__sublime, 'delete word backward'),
               ['Ctrl+Delete']             = create_description(kb_fg__sublime, 'delete word foreward'),
               ['Alt+.']                   = create_description(kb_fg__sublime, 'close tag'),
               ['Ctrl+Shift+a']            = create_description(kb_fg__sublime, 'select inside tag/quote'),
               ['Ctrl+Shift+m']            = create_description(kb_fg__sublime, 'select inside brackets'),
               ['Ctrl+Shift+Space']        = create_description(kb_fg__sublime, 'select current word'),
               ['Alt+Shift+w']             = create_description(kb_fg__sublime, 'wrap selection with tag'),
               ['Ctrl+l']                  = create_description(kb_fg__sublime, 'select line'),
               ['Ctrl+F3']                 = create_description(kb_fg__sublime, 'quick find current word/selection'),
               ['Alt+Shift+1/2/3/4']       = create_description(kb_fg__sublime, '1/2/3/4 columns'),
               ['Alt+Shift+g']             = create_description(kb_fg__sublime, 'grid'),
               ['Alt+Shift+8/9']           = create_description(kb_fg__sublime, '2/3 rows'),
               ['Alt+1/...']               = create_description(kb_fg__sublime, 'tab 1/...'),
               ['Ctrl+1/...']              = create_description(kb_fg__sublime, 'group 1/...'),
               ['Ctrl+k Ctrl+Shift+UP']    = create_description(kb_fg__sublime, 'new group'),
               ['Ctrl+k Ctrl+DOWN']        = create_description(kb_fg__sublime, 'close group'),
               ['Ctrl+F12']                = create_description(kb_fg__sublime, 'go to definition'),
               ['Ctrl+Shift+F12']          = create_description(kb_fg__sublime, 'go to reference'),
               ['Ctrl+g']                  = create_description(kb_fg__sublime, 'go to line'),
               ['Ctrl+.']                  = create_description(kb_fg__sublime, 'next modification'),
               ['Ctrl+,']                  = create_description(kb_fg__sublime, 'previous modification'),
               ['F2']                      = create_description(kb_fg__sublime, 'next bookmark'),
               ['Shift+F2']                = create_description(kb_fg__sublime, 'previous bookmark'),
               ['Ctrl+F2']                 = create_description(kb_fg__sublime, 'toggle bookmark'),
               ['Ctrl+Shift+F2']           = create_description(kb_fg__sublime, 'clear bookmarks'),
               ['Alt+F2']                  = create_description(kb_fg__sublime, 'select all bookmarks'),
               ['F9']                      = create_description(kb_fg__sublime, 'sort lines'),
               ['Ctrl+F9']                 = create_description(kb_fg__sublime, 'sort lines (case sensitive)'),
               ['Ctrl+m']                  = create_description(kb_fg__sublime, 'jump to matching bracket'),
               ['Ctrl+r']                  = create_description(kb_fg__sublime, 'go to symbol'),
               ['Ctrl+e']                  = create_description(kb_fg__sublime, 'copy find string from buffer'),
               ['Ctrl+Shift+p']            = create_description(kb_fg__sublime, 'command palette'),
               ['Ctrl+Alt+p']              = create_description(kb_fg__sublime, 'quick switch project'),
               ['Ctrl+Alt+Shift+c Ctrl+d'] = create_description(kb_fg__sublime, 'show diff popup'),

               -- by me

               ['Ctrl+&lt;Tab&gt;']        = create_description(kb_fg__sublime, 'next tab'),
               ['Ctrl+Shift+&lt;Tab&gt;']  = create_description(kb_fg__sublime, 'previous tab'),

               -- for ~/.config/sublime-text/Packages/User/my-module--move-cursor-to-top-or-bottom-of-screen.py
               ['Alt+UP']                  = create_description(kb_fg__sublime, 'move cursor to top of page'),
               ['Alt+DOWN']                = create_description(kb_fg__sublime, 'move cursor to bottom of page'),

               -- for SublimeGit
               ['Alt+g']                   = create_description(kb_fg__sublime, 'git status'),
             }
    },
  },
}

local tmux_keys = {
  ['tmux'] = {
    {
      modifiers = {'Prefix'},
      keys = {
        -- from tmux help (Prefix + ?)
        ['Space']       = create_description(kb_fg__tmux, 'Select next layout'),
        ['!']           = create_description(kb_fg__tmux, 'Break pane to a new window'),
        ['"']           = create_description(kb_fg__tmux, 'Split window vertically'),
        ['#']           = create_description(kb_fg__tmux, 'List all paste buffers'),
        ['$']           = create_description(kb_fg__tmux, 'Rename current session'),
        ['%']           = create_description(kb_fg__tmux, 'Split window horizontally'),
        ['&amp;']       = create_description(kb_fg__tmux, 'Kill current window'),
        ["'"]           = create_description(kb_fg__tmux, 'Prompt for window index to select'),
        ['(']           = create_description(kb_fg__tmux, 'Switch to previous client'),
        [')']           = create_description(kb_fg__tmux, 'Switch to next client'),
        [',']           = create_description(kb_fg__tmux, 'Rename current window'),
        ['-']           = create_description(kb_fg__tmux, 'Delete the most recent paste buffer'),
        ['.']           = create_description(kb_fg__tmux, 'Move the current window'),
        ['/']           = create_description(kb_fg__tmux, 'Describe key binding'),
        ['&lt;INT&gt;'] = create_description(kb_fg__tmux, 'Select window &lt;INT&gt;'),
        [':']           = create_description(kb_fg__tmux, 'Prompt for a command'),
        [';']           = create_description(kb_fg__tmux, 'Move to the previously active pane'),
        ['=']           = create_description(kb_fg__tmux, 'Choose a paste buffer from a list'),
        ['?']           = create_description(kb_fg__tmux, 'List key bindings'),
        ['[']           = create_description(kb_fg__tmux, 'Enter copy mode'),
        [']']           = create_description(kb_fg__tmux, 'Paste the most recent paste buffer'),
        ['{']           = create_description(kb_fg__tmux, 'Swap the active pane with the pane above'),
        ['}']           = create_description(kb_fg__tmux, 'Swap the active pane with the pane below'),
        ['~']           = create_description(kb_fg__tmux, 'Show messages'),
        ['C']           = create_description(kb_fg__tmux, 'Customize options'),
        ['D']           = create_description(kb_fg__tmux, 'Choose and detach a client from a list'),
        ['E']           = create_description(kb_fg__tmux, 'Spread panes out evenly'),
        ['L']           = create_description(kb_fg__tmux, 'Switch to the last client'),
        ['M']           = create_description(kb_fg__tmux, 'Clear the marked pane'),
        ['c']           = create_description(kb_fg__tmux, 'Create a new window'),
        ['d']           = create_description(kb_fg__tmux, 'Detach the current client'),
        ['f']           = create_description(kb_fg__tmux, 'Search for a pane'),
        ['i']           = create_description(kb_fg__tmux, 'Display window information'),
        ['l']           = create_description(kb_fg__tmux, 'Select the previously current window'),
        ['m']           = create_description(kb_fg__tmux, 'Toggle the marked pane'),
        ['n']           = create_description(kb_fg__tmux, 'Select the next window'),
        ['o']           = create_description(kb_fg__tmux, 'Select the next pane'),
        ['p']           = create_description(kb_fg__tmux, 'Select the previous window'),
        ['q']           = create_description(kb_fg__tmux, 'Display pane numbers'),
        ['r']           = create_description(kb_fg__tmux, 'Redraw the current client'),
        ['s']           = create_description(kb_fg__tmux, 'Choose a session from a list'),
        ['t']           = create_description(kb_fg__tmux, 'Show a clock'),
        ['w']           = create_description(kb_fg__tmux, 'Choose a window from a list'),
        ['x']           = create_description(kb_fg__tmux, 'Kill the active pane'),
        ['z']           = create_description(kb_fg__tmux, 'Zoom the active pane'),
        ['DC']          = create_description(kb_fg__tmux, 'Reset so the visible part of the window follows the cursor'),
        ['PPage']       = create_description(kb_fg__tmux, 'Enter copy mode and scroll up'),
        ['Up']          = create_description(kb_fg__tmux, 'Select the pane above the active pane'),
        ['Down']        = create_description(kb_fg__tmux, 'Select the pane below the active pane'),
        ['Left']        = create_description(kb_fg__tmux, 'Select the pane to the left of the active pane'),
        ['Right']       = create_description(kb_fg__tmux, 'Select the pane to the right of the active pane'),
        ['M-1']         = create_description(kb_fg__tmux, 'Set the even-horizontal layout'),
        ['M-2']         = create_description(kb_fg__tmux, 'Set the even-vertical layout'),
        ['M-3']         = create_description(kb_fg__tmux, 'Set the main-horizontal layout'),
        ['M-4']         = create_description(kb_fg__tmux, 'Set the main-vertical layout'),
        ['M-5']         = create_description(kb_fg__tmux, 'Select the tiled layout'),
        ['M-6']         = create_description(kb_fg__tmux, 'Set the main-horizontal-mirrored layout'),
        ['M-7']         = create_description(kb_fg__tmux, 'Set the main-vertical-mirrored layout'),
        ['M-n']         = create_description(kb_fg__tmux, 'Select the next window with an alert'),
        ['M-o']         = create_description(kb_fg__tmux, 'Rotate through the panes in reverse'),
        ['M-p']         = create_description(kb_fg__tmux, 'Select the previous window with an alert'),
        ['M-Up']        = create_description(kb_fg__tmux, 'Resize the pane up by 5'),
        ['M-Down']      = create_description(kb_fg__tmux, 'Resize the pane down by 5'),
        ['M-Left']      = create_description(kb_fg__tmux, 'Resize the pane left by 5'),
        ['M-Right']     = create_description(kb_fg__tmux, 'Resize the pane right by 5'),
        ['C-o']         = create_description(kb_fg__tmux, 'Rotate through the panes'),
        ['C-z']         = create_description(kb_fg__tmux, 'Suspend the current client'),
        ['C-Up']        = create_description(kb_fg__tmux, 'Resize the pane up'),
        ['C-Down']      = create_description(kb_fg__tmux, 'Resize the pane down'),
        ['C-Left']      = create_description(kb_fg__tmux, 'Resize the pane left'),
        ['C-Right']     = create_description(kb_fg__tmux, 'Resize the pane right'),
        ['S-Up']        = create_description(kb_fg__tmux, 'Move the visible part of the window up'),
        ['S-Down']      = create_description(kb_fg__tmux, 'Move the visible part of the window down'),
        ['S-Left']      = create_description(kb_fg__tmux, 'Move the visible part of the window left'),
        ['S-Right']     = create_description(kb_fg__tmux, 'Move the visible part of the window right'),

        -- be me
        ['Shift+,']                       = create_description(kb_fg__tmux, 'display window options'),
        ['Shift+.']                       = create_description(kb_fg__tmux, 'display pane options'),
        [':move-window &lt;INT&gt;']      = create_description(kb_fg__tmux, 'move window to index &lt;INT&gt;'),
        [':kill-server']                  = create_description(kb_fg__tmux, 'kill tmux'),
        [':list-sessions']                = create_description(kb_fg__tmux, 'list sessions'),
        [':new']                          = create_description(kb_fg__tmux, 'new session'),
        [':new -s &lt;NAME&gt;']          = create_description(kb_fg__tmux, 'new session with a name'),
        [':detach']                       = create_description(kb_fg__tmux, 'detach session'),
        [':kill-session']                 = create_description(kb_fg__tmux, 'kill session'),
        [':kill-session -a']              = create_description(kb_fg__tmux, 'kill other sessions'),
        [':kill-session -t &lt;NAME&gt;'] = create_description(kb_fg__tmux, 'kill session with a &lt;NAME&gt;'),
        [':new-window']                   = create_description(kb_fg__tmux, 'new window'),
        [':new-window -n &lt;NAME&gt;']   = create_description(kb_fg__tmux, 'new window with a name'),
        [':new-window -a']                = create_description(kb_fg__tmux, 'open new window here'),
        [':swap-window -t &lt;INT&gt;']   = create_description(kb_fg__tmux, 'swap current window with window &lt;INT&gt;'),
        [':swap-window -t -1']            = create_description(kb_fg__tmux, 'swap current window with previous window'),
        [':swap-window -t +1']            = create_description(kb_fg__tmux, 'swap current window with next window'),
        [':select-pane -T &lt;NAME&gt;']  = create_description(kb_fg__tmux, 'rename current pane'),
        [':swap-pane -t &lt;INT&gt;']     = create_description(kb_fg__tmux, 'swap current pane with pane &lt;INT&gt;'),
        [':swap-pane -t -1']              = create_description(kb_fg__tmux, 'swap current pane with previous pane'),
        [':swap-pane -t +1']              = create_description(kb_fg__tmux, 'swap current pane with next pane'),
      }
    }
  },
}

-- exceptionally all modifiers written in one place
local vscode_keys = {
  ['vscode'] = {
    {
      modifiers = {},
      keys = {
        ['Ctrl+K Ctrl+S']          = create_description(kb_fg__vscode, 'keyboard shortcut'),
        ['Ctrl+Shift+G']           = create_description(kb_fg__vscode, 'source control'),
        ['Ctrl+B']                 = create_description(kb_fg__vscode, 'toggle sidebar'),
        ['Ctrl+J']                 = create_description(kb_fg__vscode, 'toggle panel'),
        ['Ctrl+,']                 = create_description(kb_fg__vscode, 'settings'),
        ['Ctrl+K Z']               = create_description(kb_fg__vscode, 'zen mode'),
        ['Ctrl+Shift+M']           = create_description(kb_fg__vscode, 'errors and warnings'),
        ['Alt+Shift+F3']           = create_description(kb_fg__vscode, 'previous change'),
        ['Alt+F3']                 = create_description(kb_fg__vscode, 'next change'),
        ['Shift+F8']               = create_description(kb_fg__vscode, 'previous error'),
        ['F8']                     = create_description(kb_fg__vscode, 'next error'),
        ['Ctrl+P']                 = create_description(kb_fg__vscode, 'quick open (press right arrow to open multiple files)'),
        ['Ctrl+R']                 = create_description(kb_fg__vscode, 'open a recent file'),
        ['Ctrl+\\']                = create_description(kb_fg__vscode, 'side by side editing'),
        ['Alt+Shift+Up/Down']      = create_description(kb_fg__vscode, 'add cursor above/below'),
        ['Alt+Shift+drag mouse']   = create_description(kb_fg__vscode, 'column (box) selection'),
        ['Alt+mouse scroll']       = create_description(kb_fg__vscode, 'fast scroll'),
        ['Ctrl+Up/Down']           = create_description(kb_fg__vscode, 'up/down one line without moving cursor'),
        ['Alt+Page Up/Down']       = create_description(kb_fg__vscode, 'up/down one page without moving cursor'),
        ['Ctrl+Alt+Shift+Up/Down'] = create_description(kb_fg__vscode, 'duplicate line up/down'),
        ['Ctrl+Shift+K']           = create_description(kb_fg__vscode, 'delete line'),
        ['Alt+Shift+I']            = create_description(kb_fg__vscode, 'insert cursor at end of each line selected'),
        ['Ctrl+Shift+\\']          = create_description(kb_fg__vscode, 'jump to matching bracket'),
        ['Alt+Up/Down']            = create_description(kb_fg__vscode, 'move line up/down'),
        ['Ctrl+Shift+O']           = create_description(kb_fg__vscode, 'go to symbol in file'),
        ['Ctrl+T']                 = create_description(kb_fg__vscode, 'go to symbol in workspace'),
        ['Ctrl+G']                 = create_description(kb_fg__vscode, 'go to line'),
        ['Ctrl+Shift+[/]']         = create_description(kb_fg__vscode, 'fold/unfold'),
        ['Ctrl+K Ctrl+L']          = create_description(kb_fg__vscode, 'fold/unfold'),
        ['Ctrl+K Ctrl+0']          = create_description(kb_fg__vscode, 'fold all regions in the editor'),
        ['Ctrl+K Ctrl+J']          = create_description(kb_fg__vscode, 'unfold all regions in the editor'),
        ['Ctrl+L']                 = create_description(kb_fg__vscode, 'select line'),
        ['Ctrl+K V']               = create_description(kb_fg__vscode, 'open markdown preview (side by side)'),
        ['Ctrl+Shift+V']           = create_description(kb_fg__vscode, 'open markdown preview (in new tab)'),
        ['Ctrl+F2']                = create_description(kb_fg__vscode, 'select all occurrences of current word'),
        ['Ctrl+Shift+L']           = create_description(kb_fg__vscode, 'select all occurrences of current selection'),
        ['Ctrl+K %']               = create_description(kb_fg__vscode, '(by me) two columns'),
        ['Ctrl+K "']               = create_description(kb_fg__vscode, '(by me) two rows'),
        ['Ctrl+D']                 = create_description(kb_fg__vscode, 'select next occurrence of the selection'),
        ['Ctrl+.']                 = create_description(kb_fg__vscode, 'quick fix'),

        -- peek/go definition/implementations/references
        ['Ctrl+Shift+F10']         = create_description(kb_fg__vscode, 'peek definition'),
        ['Ctrl+Shift+F12']         = create_description(kb_fg__vscode, 'peek implementations'),
        ['F12']                    = create_description(kb_fg__vscode, 'go to definition'),
        ['Shift+F12']              = create_description(kb_fg__vscode, 'go to references'),
        ['Ctrl+F12']               = create_description(kb_fg__vscode, 'go to implementations'),
        ['Alt+Shift+F12']          = create_description(kb_fg__vscode, 'view all references'),
      }
    },
    -- {
    --   modifiers = {'Alt'},
    --   keys = {
    --            ['m'] = create_description(kb_fg__vscode, '...'),
    --          }
    -- },
  },
}

local yazi_keys = {
  ['yazi'] = {
    {
      modifiers = {'Ctrl'},
      keys = {
               a = create_description(kb_fg__yazi, 'select all'),
               r = create_description(kb_fg__yazi, 'Inverse selection of all'),
               s = create_description(kb_fg__yazi, 'Cancel the ongoing search'),
               c = create_description(kb_fg__yazi, 'close current tab'),
             }
    },
    {
      modifiers = {},
      keys = {
              o =               create_description(kb_fg__yazi, 'open'),
              O =               create_description(kb_fg__yazi, 'open interactively'),
              y =               create_description(kb_fg__yazi, 'copy'),
              x =               create_description(kb_fg__yazi, 'cut'),
              p =               create_description(kb_fg__yazi, 'paste'),
              P =               create_description(kb_fg__yazi, 'paste and override'),
              ['Y/X'] =         create_description(kb_fg__yazi, 'cancel copy/cut'),
              d =               create_description(kb_fg__yazi, 'trash'),
              D =               create_description(kb_fg__yazi, 'delete permanently'),
              a =               create_description(kb_fg__yazi, 'Create a file (ends with / for directories)'),
              r =               create_description(kb_fg__yazi, 'rename'),
              f =               create_description(kb_fg__yazi, 'filter'),
              s =               create_description(kb_fg__yazi, 'search (using fd)'),
              S =               create_description(kb_fg__yazi, 'search (using ripgrep)'),
              w =               create_description(kb_fg__yazi, 'show/close task manager'),
              z =               create_description(kb_fg__yazi, 'Jump to a file/directory via fzf'),
              Z =               create_description(kb_fg__yazi, 'Jump to a directory via zoxide'),
              T =               create_description(kb_fg__yazi, 'toggle pane'),
              ['g+c'] =         create_description(kb_fg__yazi, 'Goto ~/.config'),
              ['~/F1'] =        create_description(kb_fg__yazi, 'help'),
              ['g+Space'] =     create_description(kb_fg__yazi, 'Jump interactively'),
              ['m+...'] =       create_description(kb_fg__yazi, 'Linemode: ...'),
              ['c+...'] =       create_description(kb_fg__yazi, 'Copy ...'),
              [',+...'] =       create_description(kb_fg__yazi, 'Sort by ...'),
              [';'] =           create_description(kb_fg__yazi, 'Run a shell command'),
              [':'] =           create_description(kb_fg__yazi, 'Run a shell command (block until finishes)'),
              t =               create_description(kb_fg__yazi, 'new tab'),
              ['&lt;int&gt;'] = create_description(kb_fg__yazi, 'switch to nth tab'),
              ['[/]'] =         create_description(kb_fg__yazi, 'switch to previous/next tab'),
              ['{/}'] =         create_description(kb_fg__yazi, 'Swap current tab with previous/next tab'),
              ['Tab'] =         create_description(kb_fg__yazi, 'Show the file information'),
            }
    },
  },
}


hotkeys_popup.add_hotkeys(fzf_keys)
hotkeys_popup.add_hotkeys(sublime_keys)
hotkeys_popup.add_hotkeys(tmux_keys)
hotkeys_popup.add_hotkeys(vscode_keys)
hotkeys_popup.add_hotkeys(yazi_keys)

return tmux
