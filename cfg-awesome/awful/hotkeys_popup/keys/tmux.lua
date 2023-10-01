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
local tmux          = {}
local mode_fg       = os.getenv('blue')
local plugin_fg     = os.getenv('grey')
local tmux_kb_fg    = os.getenv('olive')
local vim_kb_fg     = os.getenv('orange')
local lf_kb_fg      = os.getenv('yellow')
local fzf_kb_fg     = os.getenv('cyan')
local sublime_kb_fg = os.getenv('brown')
local simplescreenrecorder_kb_fg = os.getenv('purple')
local qutebrowser_kb_fg = os.getenv('pink')

function create_description(frgrnd, dscrptn)
    return "   <span color='" .. frgrnd .. "'>" .. dscrptn .. "</span>"
end

function tmux.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ['tmux']                                          = rule,
        ['tmux: prev/next pane/window, resize pane, etc'] = rule,
        ['tmux: copy']                                    = rule,
        ['vim']                                           = rule,
        ['lf']                                            = rule,
        ['fzf']                                           = rule,
        ['simplescreenrecorder']                          = rule,
        ['qutebrowser']                                   = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local tmux_keys = {  -- {{{
-- tmux {{{
  ['tmux'] = {
    {
      modifiers = {'Prefix'},
      keys = {
               s                         = create_description(tmux_kb_fg, "display sessions tree"),
               w                         = create_description(tmux_kb_fg, "display windows, sessions and panes tree"),
               p                         = create_description(tmux_kb_fg, "display panes numbers"),
               q                         = create_description(tmux_kb_fg, "display panes numbers"),
               r                         = create_description(tmux_kb_fg, "source config and reload"),
               m                         = create_description(tmux_kb_fg, "toggle mouse"),
               [',']                     = create_description(tmux_kb_fg, "rename window"),
               c                         = create_description(tmux_kb_fg, "new window"),
               f                         = create_description(tmux_kb_fg, "find window"),
               i                         = create_description(tmux_kb_fg, "display window information"),
               k                         = create_description(tmux_kb_fg, "kill server"),
               l                         = create_description(tmux_kb_fg, "go to last window"),
               ['&amp;']                 = create_description(tmux_kb_fg, "kill window"),
               ['$']                     = create_description(tmux_kb_fg, "rename session"),
               ['!']                     = create_description(tmux_kb_fg, "turn pane into window"),
               n                         = create_description(tmux_kb_fg, "new session"),
               o                         = create_description(tmux_kb_fg, "kill other sessions"),
               ['Right']                 = create_description(tmux_kb_fg, "new pane right"),
               ['Down']                  = create_description(tmux_kb_fg, "new pane down"),
               x                         = create_description(tmux_kb_fg, "kill pane"),
               [':']                     = create_description(tmux_kb_fg, "enter command mode"),
               t                         = create_description(tmux_kb_fg, "display clock"),
               ['(']                     = create_description(tmux_kb_fg, "previous session"),
               [')']                     = create_description(tmux_kb_fg, "next session"),
               d                         = create_description(tmux_kb_fg, "detach session"),
               l                         = create_description(tmux_kb_fg, "go to last previously-used window"),
               z                         = create_description(tmux_kb_fg, "zoom/unzoom pane"),
               ['~']                     = create_description(tmux_kb_fg, "display messages"),
               ['Shift+,']               = create_description(tmux_kb_fg, "display window options"),
               ['Shift+.']               = create_description(tmux_kb_fg, "display pane options"),
               ['Ctrl+x']                = create_description(tmux_kb_fg, "toggle synchronized panes"),
               ['Space']                 = create_description(tmux_kb_fg, "change layout"),
               ['Ctrl+s']                = create_description(tmux_kb_fg, "<span color='" .. plugin_fg .. "'>[resurrect]</span> save environment"),
               ['Ctrl+r']                = create_description(tmux_kb_fg, "<span color='" .. plugin_fg .. "'>[resurrect]</span> restore environment"),
               [':move-window NUM']      = create_description(tmux_kb_fg, "move window to index NUM"),
               [':kill-server']          = create_description(tmux_kb_fg, "kill tmux"),
               [':list-sessions']        = create_description(tmux_kb_fg, "list sessions"),
               [':new']                  = create_description(tmux_kb_fg, "new session"),
               [':new -s NAME']          = create_description(tmux_kb_fg, "new session with a name"),
               [':detach']               = create_description(tmux_kb_fg, "detach session"),
               [':kill-session']         = create_description(tmux_kb_fg, "kill session"),
               [':kill-session -a']      = create_description(tmux_kb_fg, "kill other sessions"),
               [':kill-session -t NAME'] = create_description(tmux_kb_fg, "kill NAME session"),
               [':new-window']           = create_description(tmux_kb_fg, "new window"),
               [':new-window -n NAME']   = create_description(tmux_kb_fg, "new window"),
               [':new-window -a']        = create_description(tmux_kb_fg, "open new window here"),
               [':swap-window -t NUM']   = create_description(tmux_kb_fg, "swap current window with window NUM"),
               [':swap-window -t -1']    = create_description(tmux_kb_fg, "swap current window with prev window"),
               [':swap-window -t +1']    = create_description(tmux_kb_fg, "swap current window with next window"),
               [':select-pane -T NAME']  = create_description(tmux_kb_fg, "rename current pane"),
               [':swap-pane -t NUM']     = create_description(tmux_kb_fg, "swap current pane with pane NUM"),
               [':swap-pane -t -1']      = create_description(tmux_kb_fg, "swap current pane with prev pane"),
               [':swap-pane -t +1']      = create_description(tmux_kb_fg, "swap current pane with next pane"),
             }
    }
  },
-- }}}
-- tmux: prev/next pane/window, resize pane, etc {{{
  ['tmux: prev/next pane/window, resize pane, etc'] = {
    {
      modifiers = {'Ctrl'},
      keys = {
               d               = create_description(tmux_kb_fg, "kill window"),
               ['Left']        = create_description(tmux_kb_fg, "previous window"),
               ['Right']       = create_description(tmux_kb_fg, "next window"),
               ['Shift+Left']  = create_description(tmux_kb_fg, "pane left"),
               ['Shift+Right'] = create_description(tmux_kb_fg, "pane right"),
               ['Shift+Up']    = create_description(tmux_kb_fg, "pane up"),
               ['Shift+Down']  = create_description(tmux_kb_fg, "pane down"),
               ['Alt+Left']    = create_description(tmux_kb_fg, "resize pane to left"),
               ['Alt+Right']   = create_description(tmux_kb_fg, "resize pane to right"),
               ['Alt+Up']      = create_description(tmux_kb_fg, "resize pane to up"),
               ['Alt+Down']    = create_description(tmux_kb_fg, "resizepane to down"),
             }
    }
  },
-- }}}
-- tmux: copy {{{
  ['tmux: copy'] = {
    {
      modifiers = {},
      keys = {
               ['1  Prefix+[']                = create_description(tmux_kb_fg, "enter copy mode"),
               ['2  arrowkeys']               = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>C</span> navigate to the position"),
               ['3a  v+arrowkeys']            = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>C</span> start selecting text"),
               ['3b  Ctrl+v+space+arrowkeys'] = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>C</span> start selecting block"),
               ['4  Ctrl+y']                  = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>C</span> copy selected text to clipboard"),
               ['5  Prefix+]']                = create_description(tmux_kb_fg, "paste")
             }
    }
  },
-- }}}
}
-- }}}

local vim_keys = {  -- {{{
  ['vim'] = {
    {
      modifiers = {},
      keys = {
               F1                       = create_description(vim_kb_fg, "quit"),
               F2                       = create_description(vim_kb_fg, "save"),
               F3                       = create_description(vim_kb_fg, "save and quit"),
               F4                       = create_description(vim_kb_fg, "run"),
               F5                       = create_description(vim_kb_fg, "watch"),
               F6                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> <span color='" .. plugin_fg .. "'>[ultisnips]</span> snippets"),
               F7                       = create_description(vim_kb_fg, "replace"),
               F8                       = create_description(vim_kb_fg, "toggle cursorcolumn"),
               F9                       = create_description(vim_kb_fg, "pymodelint (in python)"),
               K                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> show help/doc on current word in preview window"),
               TT                       = create_description(vim_kb_fg, "move current line to top screen"),
               MM                       = create_description(vim_kb_fg, "move current line to middle of screen"),
               BB                       = create_description(vim_kb_fg, "move current line to bottom of screen"),
               f                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[easymotion]</span>"),
               o                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>V</span> move to other end of selection"),
               F                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[easymotion (2 chars)]</span>"),
               gcc                      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> comment/uncomment"),
               gT                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> prev tab"),
               gt                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> next tab"),
               gd                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> go to definition(i.e. first occurrence) of the current word"),
               gv                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> go to the previously selected text"),
               J                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N/V</span> join lines putting one space between them"),
               gJ                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N/V</span> join lines putting no space between them"),
               u                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> undo"),
               U                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> redo"),
               zR                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> open all folds"),
               zM                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> close all folds"),
               zf                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> fold selection"),
               ['Return']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle seach highlighting"),
               ['g&amp;']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> apply last substitute on all lines"),
               ['&amp;']                = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> repeat last substitute on all current line"),
               ['"+LETTER+p']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> paste register LETTER"),
               ['@+LETTER+p']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> paste register LETTER"),
               ['m+LETTER']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> create/delete LETTER mark"),
               ['`+LETTER']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump to LETTER mark position"),
               ["'+LETTER"]             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump to LETTER mark line"),
               ['m+leader']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> delete all marks"),
               ['`+`']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump between last two used lines"),
               ['`+.']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump to last modified position"),
               ["'+."]                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump to last modified line"),
               ['{/}']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> jump to prev/next bash/python function"),
               ['~']                    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> invert case of current character"),
               ['q+/']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> display prev searches (navigate then Ctrl+c to paste in search bar)"),
               [':g/STRING/d']          = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> delete lines containing STRING"),
               [':g!/STRING/d']         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> delete lines not containing STRING"),
               [':r!COMMAND']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> print command output into buffer"),
               [':r FILEPATH']          = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> import a file's content"),
               [':%s/STRING/SUB/gc']    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> interactive substitution (y:yes, n:no, a:all, q:quit)"),
               [':+(C-d)']              = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> displays a list of commands"),
               [':11,25s/STRING/SUB/g'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> replace only on lines 11 to 25"),
               [':.,25s/STRING/SUB/g']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> replace only on current line to 25"),
               [':.,.+5s/STRING/SUB/g'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> replace only on current line to 5 lines after that"),
               [':.,$s/STRING/SUB/g']   = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> replace only on current line to end of document"),
               [':reg']                 = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> show registers"),
               ['!sort']                = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>V</span> sort selected lines"),
               [':read ! COAMMAND']     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> insert output of bash command in next line"),
               [':retab']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> turn tabs into spaces"),
               [':Filter STRING']       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>C</span> display lines containing STRING in a split"),
               ['STRING+&lt;Tab&gt;']   = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> <span color='" .. plugin_fg .. "'>[ultisnips]</span> expand snippet"),  -- NOTE do NOT use < and > instead of &lt; and &gt;
               ['STRING+&lt;S-Tab&gt;'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> sparkup expand snippet"),
             }
    },
    {
      modifiers = {'Ctrl'},
      keys = {
               d         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> unindent"),
               h         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[signify]</span> hunk diff"),
               j         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> <span color='" .. plugin_fg .. "'>[ultisnips]</span> jump forward  <span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[signify]</span> next hunk"),
               k         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> <span color='" .. plugin_fg .. "'>[ultisnips]</span> jump backward  <span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[signify]</span> prev hunk"),
               n         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N/V</span> <span color='" .. plugin_fg .. "'>[multicursor]</span> select current word/selection, <span color='" .. mode_fg .. "'>I</span> mucomplete"),
               o         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> insert new line without leaving normal mode"),
               p         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[multicursor]</span> go to previous match"),
               t         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> indent"),
               u         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[signify]</span> undo hunk"),
               y         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> copy yanked text to clipboard"),
               ['Space'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>I</span> jedi omnicomplition"),
             }
    },
    {
      modifiers = {'Leader'},
      keys = {
               ['0'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> turn jedi off"),
               ['1'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle line number"),
               ['2'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle signify"),
               ['3'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle undotree"),
               ['4'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle better whitespace"),
               ['5'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle mucomplete"),
               ['6'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle syntactic"),
               ['7'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle illuminate"),
               ['8'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle tagbar"),
               ['9'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle colorizer"),
               a     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> ascending numbers"),
               b     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> black (in python)"),
               bd    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> black diff (in python)"),
               d     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[jedi]</span> jump to current word's def/class"),
               k     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[jedi]</span> show docstring of function/class"),
               q     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> toggle quickfix"),
               u     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>N</span> <span color='" .. plugin_fg .. "'>[jedi]</span> usages of current word"),
             }
    }
  },
}
-- }}}

local lf_keys = {  -- {{{
  ['lf'] = {
    {
      modifiers = {'Ctrl'},
      keys = {
               c = create_description(lf_kb_fg, "commands"),
               p = create_description(lf_kb_fg, "prev command"),
               n = create_description(lf_kb_fg, "next command"),
               t = create_description(lf_kb_fg, "fzf select"),
             }
    },
    {
      modifiers = {'Alt'},
      keys = {
               c = create_description(lf_kb_fg, "fzf cd"),
               r = create_description(lf_kb_fg, "fzf recent directories"),
             }
    },
    {
      modifiers = {'r'},
      keys = {
               ['Right'] = create_description(lf_kb_fg, "replicate horizontally"),
               ['Down']  = create_description(lf_kb_fg, "replicate vertically"),
             }
    },
    {
      modifiers = {},
      keys = {
               ["'"]    = create_description(lf_kb_fg, "marks"),
               ['o']    = create_description(lf_kb_fg, "open"),
               ['w/W']  = create_description(lf_kb_fg, "toggle preview"),
             }
    },
  },
}
-- }}}

local fzf_keys = {  -- {{{
  ['fzf'] = {
    {
      modifiers = {},
      keys = {
               ['Tab'] = create_description(fzf_kb_fg, "select/unselect"),
             }
    },
    {
      modifiers = {'Ctrl'},
      keys = {
               a = create_description(fzf_kb_fg, "select all"),
               j = create_description(fzf_kb_fg, "scroll down preview"),
               k = create_description(fzf_kb_fg, "scroll up preview"),
               s = create_description(fzf_kb_fg, "toggle sort"),
               t = create_description(fzf_kb_fg, "select"),
               v = create_description(fzf_kb_fg, "paste  selected item preceded with vim"),
               w = create_description(fzf_kb_fg, "toggle preview"),
               y = create_description(fzf_kb_fg, "copy path to clipboard"),
             }
    },
    {
    modifiers = {'Alt'},
    keys = {
             c = create_description(fzf_kb_fg, "cd"),
           }
    },
  },
}
-- }}}

local simplescreenrecorder_keys = {  -- {{{
  ['simplescreenrecorder'] = {
    {
      modifiers = {'Ctrl', 'Shift', 'Super'},
      keys = {
               ['s'] = create_description(simplescreenrecorder_kb_fg, "start/stop recording"),
             }
    },
  },
}
-- }}}

local qutebrowser_keys = {  -- {{{
  ['qutebrowser'] = {
    {
      modifiers = {},
      keys = {
               ['b'] =  create_description(qutebrowser_kb_fg, "quickmarks"),
               ['xd'] = create_description(qutebrowser_kb_fg, "download hint url"),
               ['xp'] = create_description(qutebrowser_kb_fg, "play hint url"),
               ['xs'] = create_description(qutebrowser_kb_fg, "toggle status bar and tabs"),
             }
    },
    {
      modifiers = {'Alt'},
      keys = {
               ['m'] = create_description(qutebrowser_kb_fg, "mute/unmute"),
             }
    },
  },
}
-- }}}

local sublime_keys = {  -- {{{
  ['sublime'] = {
    {
      modifiers = {},
      keys = {
               ['Alt+Shift+↕']             = create_description(sublime_kb_fg, "multiple cursors"),
               ['Ctrl+Shift+l']            = create_description(sublime_kb_fg, "multiple cursors in selection"),
               ['Ctrl+d']                  = create_description(sublime_kb_fg, "select similar words/selection one by one"),
               ['Alt+F3']                  = create_description(sublime_kb_fg, "select similar words/selection at once"),
               ['Ctrl+k Ctrl+d']           = create_description(sublime_kb_fg, "skip when selecting similar words/selection"),
               ['Ctrl+k Ctrl+b']           = create_description(sublime_kb_fg, "toggle sidebar"),
               ['Ctrl+Shift+↕']            = create_description(sublime_kb_fg, "move line ↕"),
               ['Ctrl+Shift+d']            = create_description(sublime_kb_fg, "duplicate line/selection"),
               ['Ctrl+Shift+k']            = create_description(sublime_kb_fg, "delete line"),
               ['Ctrl+Shift+j']            = create_description(sublime_kb_fg, "join lines"),
               ['Ctrl+[/]']                = create_description(sublime_kb_fg, "indent/unindent"),
               ['Ctrl+Shift+[/]']          = create_description(sublime_kb_fg, "fold/unfold"),
               ['Ctrl+k Ctrl+1']           = create_description(sublime_kb_fg, "fold all"),
               ['Ctrl+k Ctrl+j']           = create_description(sublime_kb_fg, "unfold all"),
               ['Ctrl+k Ctrl+k']           = create_description(sublime_kb_fg, "delete to end line"),
               ['Ctrl+k Ctrl+Backspace']   = create_description(sublime_kb_fg, "delete to beginning of line"),
               ['Ctrl+p']                  = create_description(sublime_kb_fg, "jump to (with: @, # and :)"),
               ['Ctrl+t']                  = create_description(sublime_kb_fg, "transpose"),
               ['Ctrl+↕']                  = create_description(sublime_kb_fg, "move screen ↕ (in css: ↕ number)"),
               ['Alt+↕']                   = create_description(sublime_kb_fg, "(in css: ↕ number by .1)"),
               ['Ctrl+Alt+Shift+p']        = create_description(sublime_kb_fg, "show scope for current file"),
               ['Ctrl+Shift+v']            = create_description(sublime_kb_fg, "smart paste"),
               ['Ctrl+Alt+d']              = create_description(sublime_kb_fg, "<span color='" .. plugin_fg .. "'>[anaconda]</span> get documentation"),
               ['Ctrl+k Ctrl+v']           = create_description(sublime_kb_fg, "paste from history"),
               ['Ctrl+/']                  = create_description(sublime_kb_fg, "toggle comment"),
               ['Ctrl+Shift+/']            = create_description(sublime_kb_fg, "toggle block comment"),
               ['Ctrl+Enter']              = create_description(sublime_kb_fg, "insert line after"),
               ['Ctrl+Shift+Enter']        = create_description(sublime_kb_fg, "insert line before"),
               ['Ctrl+Backspace']          = create_description(sublime_kb_fg, "delete word backward"),
               ['Ctrl+Delete']             = create_description(sublime_kb_fg, "delete word foreward"),
               ['Alt+.']                   = create_description(sublime_kb_fg, "close tag"),
               ['Ctrl+Shift+a']            = create_description(sublime_kb_fg, "select inside tag/quote"),
               ['Ctrl+Shift+m']            = create_description(sublime_kb_fg, "select inside brackets"),
               ['Ctrl+Shift+Space']        = create_description(sublime_kb_fg, "select current word"),
               ['Alt+Shift+w']             = create_description(sublime_kb_fg, "wrap selection with tag"),
               ['Ctrl+l']                  = create_description(sublime_kb_fg, "select line"),
               ['Ctrl+F3']                 = create_description(sublime_kb_fg, "quick find current word/selection"),
               ['Alt+Shift+1/2/3/4']       = create_description(sublime_kb_fg, "1/2/3/4 columns"),
               ['Alt+Shift+g']             = create_description(sublime_kb_fg, "grid"),
               ['Alt+Shift+8/9']           = create_description(sublime_kb_fg, "2/3 rows"),
               ['Alt+1/...']               = create_description(sublime_kb_fg, "tab 1/..."),
               ['Ctrl+1/...']              = create_description(sublime_kb_fg, "group 1/..."),
               ['Ctrl+k Ctrl+Shift+UP']    = create_description(sublime_kb_fg, "new group"),
               ['Ctrl+k Ctrl+DOWN']        = create_description(sublime_kb_fg, "close group"),
               ['Ctrl+F12']                = create_description(sublime_kb_fg, "go to definition"),
               ['Ctrl+Shift+F12']          = create_description(sublime_kb_fg, "go to reference"),
               ['Ctrl+g']                  = create_description(sublime_kb_fg, "go to line"),
               ['Ctrl+.']                  = create_description(sublime_kb_fg, "next modification"),
               ['Ctrl+,']                  = create_description(sublime_kb_fg, "previous modification"),
               ['Ctrl+F2']                 = create_description(sublime_kb_fg, "toggle bookmark"),
               ['F2']                      = create_description(sublime_kb_fg, "next bookmark"),
               ['Shift+F2']                = create_description(sublime_kb_fg, "previous bookmark"),
               ['Ctrl+Shift+F2']           = create_description(sublime_kb_fg, "clear bookmarks"),
               ['Alt+F2']                  = create_description(sublime_kb_fg, "select all bookmarks"),
               ['Ctrl+m']                  = create_description(sublime_kb_fg, "jump to matching bracket"),
               ['Ctrl+r']                  = create_description(sublime_kb_fg, "go to symbol"),
               ['Ctrl+Shift+p']            = create_description(sublime_kb_fg, "command palette"),
               ['Ctrl+Alt+p']              = create_description(sublime_kb_fg, "quick switch project"),
               ['Ctrl+Alt+Shift+c Ctrl+d'] = create_description(sublime_kb_fg, "show diff popup"),
             }
    },
  },
}
-- }}}

hotkeys_popup.add_hotkeys(tmux_keys)
hotkeys_popup.add_hotkeys(vim_keys)
hotkeys_popup.add_hotkeys(lf_keys)
hotkeys_popup.add_hotkeys(fzf_keys)
hotkeys_popup.add_hotkeys(simplescreenrecorder_keys)
hotkeys_popup.add_hotkeys(qutebrowser_keys)
hotkeys_popup.add_hotkeys(sublime_keys)

return tmux

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
