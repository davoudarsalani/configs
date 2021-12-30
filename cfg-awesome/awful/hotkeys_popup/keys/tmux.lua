---------------------------------------------------------------------------
--- tmux hotkeys for awful.hotkeys_widget
--
-- @author nahsi nashi@airmail.cc
-- @copyright 2017 nahsi
-- @submodule  awful.hotkeys_popup
---------------------------------------------------------------------------
-- For example: tmux.add_rules_for_terminal({ rule = { name = { "tmux" }}})
-- will show tmux hotkeys for any window that has 'tmux' in its title. If no rules are provided then tmux hotkeys will be shown always!
-- @function add_rules_for_terminal
-- @see awful.rules.rules
-- @tparam table rule Rules to match a window containing a tmux session.

local hotkeys_popup = require("awful.hotkeys_popup.widget")
local tmux          = {}
local mode_fg       = os.getenv("purple")
local tmux_kb_fg    = os.getenv("olive")
local vim_kb_fg     = os.getenv("orange")
local lf_kb_fg      = os.getenv("yellow")
local fzf_kb_fg     = os.getenv("cyan")
local simplescreenrecorder_kb_fg = os.getenv("brown")
local qutebrowser_kb_fg = os.getenv("pink")

function create_description(frgrnd, dscrptn)
    new_description = "   <span color='" .. frgrnd .. "'>" .. dscrptn .. "</span>"
    return new_description
end

function tmux.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["tmux"]                                          = rule,
        ["tmux: prev/next pane/window, resize pane, etc"] = rule,
        ["tmux: copy"]                                    = rule,
        ["vim"]                                           = rule,
        ["lf"]                                            = rule,
        ["fzf"]                                           = rule,
        ["simplescreenrecorder"]                          = rule,
        ["qutebrowser"]                                   = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local tmux_keys = { -- {{{
-- tmux {{{
  ["tmux"] = {
    {
      modifiers = {"Prefix"},
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
               ['Ctrl+s']                = create_description(tmux_kb_fg, "[resurrect] save environment"),
               ['Ctrl+r']                = create_description(tmux_kb_fg, "[resurrect] restore environment"),
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
  ["tmux: prev/next pane/window, resize pane, etc"] = {
    {
      modifiers = {"Ctrl"},
      keys = {
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
               d               = create_description(tmux_kb_fg, "kill window")
             }
    }
  },
-- }}}
-- tmux: copy {{{
  ["tmux: copy"] = {
    {
      modifiers = {},
      keys = {
               ['1  Prefix+[']                = create_description(tmux_kb_fg, "enter copy mode"),
               ['2  arrowkeys']               = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> navigate to the position"),
               ['3a  v+arrowkeys']            = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> start selecting text"),
               ['3b  Ctrl+v+space+arrowkeys'] = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> start selecting block"),
               ['4  Ctrl+y']                  = create_description(tmux_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> copy selected text to clipboard"),
               ['5  Prefix+]']                = create_description(tmux_kb_fg, "paste")
             }
    }
  },
-- }}}
}
-- }}}
local vim_keys = { -- {{{
  ["vim"] = {
    {
      modifiers = {},
      keys = {
               F1                       = create_description(vim_kb_fg, "quit"),
               F2                       = create_description(vim_kb_fg, "save"),
               F3                       = create_description(vim_kb_fg, "save and quit"),
               F4                       = create_description(vim_kb_fg, "run"),
               F5                       = create_description(vim_kb_fg, "SurroundWord"),
               F6                       = create_description(vim_kb_fg, "SurroundSelection"),
               F7                       = create_description(vim_kb_fg, "replace"),
               F8                       = create_description(vim_kb_fg, "toggle cursorcolumn"),
               F9                       = create_description(vim_kb_fg, "pymodelint (in python)"),
               F10                      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[I]</span> ultisnips"),
               F12                      = create_description(vim_kb_fg, "watch"),
               K                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> show help/doc on current word in preview window"),
               TT                       = create_description(vim_kb_fg, "move current line to top screen"),
               MM                       = create_description(vim_kb_fg, "move current line to middle of screen"),
               BB                       = create_description(vim_kb_fg, "move current line to bottom of screen"),
               f                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [easymotion]"),
               o                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[V]</span> move to other end of selection"),
               F                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [easymotion (2 chars)]"),
               ["g+Ctrl+g"]             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> info on current cursor position"),
               gc                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> comment/uncomment"),
               gT                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> prev tab"),
               gt                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> next tab"),
               gd                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> go to definition(i.e. first occurrence) of the current word"),
               gv                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> go to the previously selected text"),
               J                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N][V]</span> join lines putting one space between them"),
               gJ                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N][V]</span> join lines putting no space between them"),
               u                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> undo"),
               U                        = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> redo"),
               zR                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> open all folds"),
               zM                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> close all folds"),
               zf                       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> fold selection"),
               ['Return']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle seach highlighting"),
               ['g&amp;']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> apply last substitute on all lines"),
               ['&amp;']                = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> repeat last substitute on all current line"),
               ['"+LETTER+p']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> paste register LETTER"),
               ['@+LETTER+p']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> paste register LETTER"),
               ['`']                    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> show marks"),
               ['m+LETTER']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> create/delete LETTER mark"),
               ['`+LETTER']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump to LETTER mark position"),
               ["'+LETTER"]             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump to LETTER mark line"),
               ['m+leader']             = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> delete all marks"),
               ['`+`']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump between last two used lines"),
               ['`+.']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump to last modified position"),
               ["'+."]                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump to last modified line"),
               ['{/}']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> jump to prev/next bash/python function"),
               ['~']                    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> invert case of current character"),
               ['q+/']                  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> display prev searches (navigate then Ctrl+c to paste in search bar)"),
               [':g/STRING/d']          = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> delete lines containing STRING"),
               [':g!/STRING/d']         = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> delete lines not containing STRING"),
               [':r!COMMAND']           = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> print command output into buffer"),
               [':r FILEPATH']          = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> import a file's content"),
               [':%s/STRING/SUB/gc']    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> interactive substitution (y:yes, n:no, a:all, q:quit)"),
               [':+(C-d)']              = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> displays a list of commands"),
               [':11,25s/STRING/SUB/g'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> replace only on lines 11 to 25"),
               [':.,25s/STRING/SUB/g']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> replace only on current line to 25"),
               [':.,.+5s/STRING/SUB/g'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> replace only on current line to 5 lines after that"),
               [':.,$s/STRING/SUB/g']   = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> replace only on current line to end of document"),
               [':TailStart/TailStop']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> Tail start/stop"),
               [':reg']                 = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> show registers"),
               ['!sort']                = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[V]</span> sort selected lines"),
               [':read ! COAMMAND']     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> insert output of bash command in next line"),
               [':retab']               = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> turn tabs into spaces"),
               [':Filter STRING']       = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[C]</span> display lines containing STRING in a split"),
             }
    },
    {
      modifiers = {"Ctrl"},
      keys = {
               n            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N][V]</span> [multicursor] select current word/selection, <span color='" .. mode_fg .. "'>[I]</span> mucomplete"),
               x            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [multicursor] skip match, <span color='" .. mode_fg .. "'>[N]</span> [CtrlXA] cycle through lists of keywords"),
               p            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [multicursor] go to previous match"),
               y            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> copy yanked text to clipboard"),
               o            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> insert new line without leaving normal mode"),
               t            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[I]</span> indent"),
               d            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[I]</span> unindent"),
               ['i+LETTER'] = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> insert single character without leaving normal mode"),
               ['Space']    = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[I]</span> jedi omnicomplition"),
             }
    },
    {
      modifiers = {"Alt"},
      keys = {
               d            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] diff"),
               f            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] fold unchanged lines"),
               h            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] hunk diff"),
               k            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] prev hunk"),
               j            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] next hunk"),
               r            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] refresh"),
               t            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] toggle"),
               u            = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [signify] undo hunk"),
             }
    },
    {
      modifiers = {"Leader"},
      keys = {
               ['0']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> turn jedi off"),
               ['1']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle line number"),
               ['2']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle tagbar"),
               ['3']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle better whitespace"),
               ['4']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle undotree"),
               ['5']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle mucomplete"),
               ['6']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle syntactic"),
               ['7']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle signature"),
               ['8']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle illuminate"),
               ['9']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle diminactive"),
               ['.']  = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> run current line"),
               a      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> ascending numbers"),
               b      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> black (in python)"),
               bd     = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> black diff (in python)"),
               c      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> count current word"),
               d      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [jedi] jump to current word's def/class"),
               e      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle encode"),
               f      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> fzf"),
               h      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [HighlightLines] toggle highlight current line"),
               i      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> indent level"),
               k      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [jedi] show docstring of function/class"),
               q      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> toggle quickfix"),
               r      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> rename tmux window to current file name"),
               s      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [SyntaxAttr] show syntax attr of current word"),
               t      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> typer start"),
               u      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> [jedi] usages of current word"),
               v      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[V]</span> run selection"),
               w      = create_description(vim_kb_fg, "<span color='" .. mode_fg .. "'>[N]</span> words frequency"),
             }
    }
  },
}
-- }}}
local lf_keys = { -- {{{
  ["lf"] = {
    {
      modifiers = {"Ctrl"},
      keys = {
               c = create_description(lf_kb_fg, "commands"),
               p = create_description(lf_kb_fg, "prev command"),
               n = create_description(lf_kb_fg, "next command"),
               o = create_description(lf_kb_fg, "open"),
               t = create_description(lf_kb_fg, "fzf select"),
             }
    },
    {
      modifiers = {"Alt"},
      keys = {
               c = create_description(lf_kb_fg, "fzf cd"),
             }
    },
    {
      modifiers = {},
      keys = {
               ['w/W']  = create_description(lf_kb_fg, "toggle preview"),
             }
    },
  },
}
-- }}}
local fzf_keys = { -- {{{
  ["fzf"] = {
    {
      modifiers = {},
      keys = {
               ['Tab'] = create_description(fzf_kb_fg, "select/unselect"),
             }
    },
    {
      modifiers = {"Ctrl"},
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
    modifiers = {"Alt"},
    keys = {
             c = create_description(fzf_kb_fg, "cd"),
           }
    },
  },
}
-- }}}
local simplescreenrecorder_keys = { -- {{{
  ["simplescreenrecorder"] = {
    {
      modifiers = {'Ctrl+Shift+Super'},
      keys = {
               ['s'] = create_description(simplescreenrecorder_kb_fg, "start/stop recording"),
             }
    },
  },
}
-- }}}
local qutebrowser_keys = { -- {{{
  ["qutebrowser"] = {
    {
      modifiers = {},
      keys = {
               ['b'] = create_description(qutebrowser_kb_fg, "quickmarks"),
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

hotkeys_popup.add_hotkeys(tmux_keys)
hotkeys_popup.add_hotkeys(vim_keys)
hotkeys_popup.add_hotkeys(lf_keys)
hotkeys_popup.add_hotkeys(fzf_keys)
hotkeys_popup.add_hotkeys(simplescreenrecorder_keys)
hotkeys_popup.add_hotkeys(qutebrowser_keys)

return tmux

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
