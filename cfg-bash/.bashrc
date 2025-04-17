#
# if ! [[ "$(ps -p $(ps -p $(echo $$) -o ppid=) -o comm=)" =~ 'bicon'* ]] ; then bicon.bin ; fi # To launch bicon if not launched (https://unix.stackexchange.com/questions/123756/how-to-make-arabic-appear-properly-in-linux-terminal):




## inspired by: https://starship.rs/presets/gruvbox-rainbow

prompt_logo_arch="󰣇"
prompt_logo_linux="󰌽"
prompt_tip=""

PS1='$(
xt_stts="$?"

[ "$VIRTUAL_ENV"    ] && VIRT=" ${VIRTUAL_ENV##*/} "
[ "$SSH_CONNECTION" ] && SSH=" SSH "
[ "$xt_stts" -gt 0  ] && EXIT=" $xt_stts"

reset="\[\e[0m\]"

fg="\[\e[38;5;230m\]"

bg_gray_d="\[\e[48;5;239m\]"
bg_red_d="\[\e[48;5;88m\]"
bg_green_d="\[\e[48;5;30m\]"
bg_yellow_d="\[\e[48;5;136m\]"
bg_blue_d="\[\e[48;5;24m\]"
bg_purple_d="\[\e[48;5;131m\]"
bg_aqua_d="\[\e[48;5;71m\]"
bg_orange_d="\[\e[48;5;166m\]"

fg_gray_d="\[\e[38;5;239m\]"
fg_red_d="\[\e[38;5;88m\]"
fg_green_d="\[\e[38;5;30m\]"
fg_yellow_d="\[\e[38;5;136m\]"
fg_blue_d="\[\e[38;5;24m\]"
fg_purple_d="\[\e[38;5;131m\]"
fg_aqua_d="\[\e[38;5;71m\]"
fg_orange_d="\[\e[38;5;166m\]"

echo "\
${bg_gray_d} ${prompt_logo_linux} ${reset}\
${fg_gray_d}${bg_orange_d}${prompt_tip}${reset}\
${bg_orange_d} \u@\h ${reset}\
${fg_orange_d}${bg_yellow_d}${prompt_tip}${reset}\
${bg_yellow_d} \! ${reset}\
${fg_yellow_d}${bg_blue_d}${prompt_tip}${reset}\
${bg_blue_d} \w ${reset}\
${fg_blue_d}${bg_green_d}${prompt_tip}${reset}\
${bg_green_d}${VIRT}${reset}\
${fg_green_d}${bg_gray_d}${prompt_tip}${reset}\
${bg_gray_d}${SSH}${reset}\
${fg_gray_d}${prompt_tip}${reset}\
${fg_red_d}${EXIT}${reset}\
 ")'

[ -f "$HOME"/.fzf/shell/completion.bash   ] && source ~/.fzf/shell/completion.bash
[ -f "$HOME"/.fzf/shell/key-bindings.bash ] && source ~/.fzf/shell/key-bindings.bash

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

[ $UID -ne 0 ] && [ -d ~/main/downloads ] && cd ~/main/downloads

HISTSIZE=  HISTFILESIZE=  ## infinite history
export HISTIGNORE='a:b:c:d:e:j:k:n:p:r:s:t:v:w:y:ya:yb:yc:yd:ye:yh:yk:yn:yp:yr:ys:yt:yv:yw'
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTTIMEFORMAT='%Y%m%d%H%M%S '
export PATH="${PATH}:${HOME}/main/scripts"
export LS_FLAGS='-A --color=always --group-directories-first'
export LC_ALL='en_US.UTF-8'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONPATH="$HOME"/main/scripts
export PYTHONDONTWRITEBYTECODE=1
_common_rg_flags='--smart-case --color=always'
export RG_MATCH_FLAGS="$_common_rg_flags --colors 'match:bg:0' --colors 'match:fg:2' --colors 'match:style:underline'"
export RG="\rg \
           $_common_rg_flags \
           --sort path --hidden --files-with-matches \
           --no-messages --glob '!{.git,.cache,.venv*,kaddy,trash}/*'"
           ## keep ignored paths synced with JUMP_1
           ## --files-with-matches prints the paths with at least one match and suppress match contents
           ## --multiline prints the total number of matches instead of the total number of lines

## fzf
export FZF_DEFAULT_COMMAND='find "$HOME" -type f ! -path "*.git/*" ! -path "*.cache/*" ! -path "*.venv*/*" ! -path "*kaddy/*" ! -path "*trash/*" 2>/dev/null'
## ^--,-- # ' | sed 's#$HOME#~#''  ## keep ignored paths synced with JUMP_1
##    |-- ! -path flags also used in git option in ~/main/scripts/awesome-widgets.sh
##    '-- 2>/dev/null to ignore the error:
##        find: '/home/nnnn/kaddy/lost+found': Permission denied.
##        FIXME although ! -path "*kaddy/*" is added, find keeps looking inside kaddy

export FZF_DEFAULT_OPTS='--header "C-j/k:preview down/up|C-w:toggle preview|C-s:toggle sort|C-y:copy to clipboard" --no-bold --sort --cycle --border horizontal --no-multi --reverse --inline-info --ansi --pointer ">" --prompt ": " --marker "+" --height 70% --preview-window noborder:right:80%:wrap --bind "ctrl-s:toggle-sort,ctrl-y:execute-silent(echo "{-1}" | xclip -selection clipboard)+abort,backward-eof:abort,ctrl-k:preview-up,ctrl-j:preview-down,ctrl-w:toggle-preview" --color 'fg:${silver},fg+:${silver},hl+:2:underline,hl:2:underline,bg:${black},bg+:${gray_dark},preview-bg:${black},border:${gray_dark},gutter:${black},header:${blue}''
## conditional preview: --preview "[[ -d {} ]] && tree -C {} | head -200"  ## https://github.com/Bhupesh-V/til/blob/master/Shell/fzf-tips-tricks.md

## gruvbox theme: --color 'fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f,info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'eval cat {-1}' --header 'select'"

export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND/ -type f / -type d }"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview '$HOME/main/scripts/fzf-dir-preview.sh {-1}' --header 'cd' --color 'fg:${blue},fg+:${blue}' --preview-window noborder:right:65%:wrap"  # --preview-window 'hidden'

export FZF_CTRL_R_OPTS="--header='history'"

# export FZF_COMPLETION_TRIGGER='~~' ## use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_OPTS="$FZF_DEFAULT_OPTS"

# export FZF_TMUX_OPTS=''

## ! -path flags also used in git option in ~/main/scripts/awesome-widgets.sh
export FZF_ALT_C_COMMAND_GIT="$FZF_ALT_C_COMMAND ! -path '*.config/*' ! -path '*.vim/*' ! -path '*go/*' ! -path '*trash/*' -iname '.git' | sed 's#/\.git##' | sort"

## ls colors
## (https://linuxhint.com/ls_colors_bash/)
## Command to get extensions: dircolors --print-database
export LS_COLORS="no=2;37:di=0;34:fi=0;37:ex=0;32:ln=0;36:\
*.tar=0;31:*.tgz=0;31:*.arc=0;31:*.arj=0;31:*.taz=0;31:\
*.lha=0;31:*.lz4=0;31:*.lzh=0;31:*.lzma=0;31:*.tlz=0;31:\
*.txz=0;31:*.tzo=0;31:*.t7z=0;31:*.zip=0;31:*.z=0;31:*.dz=0;31:\
*.gz=0;31:*.lrz=0;31:*.lz=0;31:*.lzo=0;31:*.xz=0;31:*.zst=0;31:\
*.tzst=0;31:*.bz2=0;31:*.bz=0;31:*.tbz=0;31:*.tbz2=0;31:*.tz=0;31:\
*.deb=0;31:*.rpm=0;31:*.jar=0;31:*.war=0;31:*.ear=0;31:*.sar=0;31:\
*.rar=0;31:*.alz=0;31:*.ace=0;31:*.zoo=0;31:*.cpio=0;31:*.7z=0;31:\
*.rz=0;31:*.cab=0;31:*.wim=0;31:*.swm=0;31:*.dwm=0;31:*.esd=0;31:\
*.jpg=0;33:*.jpeg=0;33:*.mjpg=0;33:*.mjpeg=0;33:*.gif=0;33:*.webp=0;33:\
*.bmp=0;33:*.pbm=0;33:*.pgm=0;33:*.ppm=0;33:*.tga=0;33:*.xbm=0;33:\
*.xpm=0;33:*.tif=0;33:*.tiff=0;33:*.png=0;33:*.svg=0;33:*.svgz=0;33:\
*.mng=0;33:*.pcx=0;33:*.qt=0;33:*.nuv=0;33:*.gl=0;33:*.dl=0;33:\
*.xcf=0;33:*.xwd=0;33:*.yuv=0;33:*.cgm=0;33:*.emf=0;33:\
*.mov=0;35:*.mpg=0;35:*.mpeg=0;35:*.m2v=0;35:*.mkv=0;35:\
*.webm=0;35:*.ogm=0;35:*.mp4=0;35:*.m4v=0;35:*.mp4v=0;35:\
*.vob=0;35:*.wmv=0;35:*.asf=0;35:*.rm=0;35:*.rmvb=0;35:*.flc=0;35:\
*.avi=0;35:*.fli=0;35:*.flv=0;35:*.aac=0;35:*.au=0;35:*.flac=0;35:\
*.m4a=0;35:*.mid=0;35:*.midi=0;35:*.mka=0;35:*.mp3=0;35:*.wma=0;35:\
*.mpc=0;35:*.ogg=0;35:*.oga=0;35:*.ra=0;35:*.wav=0;35:*.opus=0;35"

## bd = (BLOCK, BLK)   Block device (buffered) special file
## cd = (CHAR, CHR)    Character device (unbuffered) special file
## di = (DIR)  Directory
## do = (DOOR) [Door][1]
## ex = (EXEC) Executable file (ie. has 'x' set in permissions)
## fi = (FILE) Normal file
## ln = (SYMLINK, LINK, LNK)   Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
## mi = (MISSING)  Non-existent file pointed to by a symbolic link (visible when you type ls -l)
## no = (NORMAL, NORM) Normal (non-filename) text. Global default, although everything should be something
## or = (ORPHAN)   Symbolic link pointing to an orphaned non-existent file
## ow = (OTHER_WRITABLE)   Directory that is other-writable (o+w) and not sticky
## pi = (FIFO, PIPE)   Named pipe (fifo file)
## sg = (SETGID)   File that is setgid (g+s)
## so = (SOCK) Socket file
## st = (STICKY)   Directory with the sticky bit set (+t) and not other-writable
## su = (SETUID)   File that is setuid (u+s)
## tw = (STICKY_OTHER_WRITABLE)    Directory that is sticky and other-writable (+t,o+w)
## *.extension =   Every file using this extension e.g. *.rpm = files with the ending .rpm

## set, shopt and bind
shopt -s globstar
# shopt -s autocd # autocd
# shopt -s dirspell # correct minor spelling errors when tab-completing names
# shopt -s cdspell # Corrects minor spelling errors when cd-ing
# shopt -s histappend # append to the history file, don't overwrite it
# shopt -s extglob # extended globbing capabilities
# shopt -s cmdhist # preserve new lines in history

set -o pipefail  ## prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline (http://redsymbol.net/articles/unofficial-bash-strict-mode/)
# set -e  ## immediately exit if any command has a non-zero exit status
# set -u  ## exit in case of unbound variable
# set -o notify  ## report status of terminated background jobs immediately
# set -x  ## verbose mode
# complete -d cd  ## tab completion only for directories when using cd-ing
# stty -ixon  ## disable ctrl-s and ctrl-q

## ignore upper and lowercase when TAB completion
# bind 'set completion-ignore-case on'

set -o vi  ## turn on vi mode
## turning on vi mode wil stop Ctrl+l from functioning, so these lines will come to the rescue:
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

## alt+d
bind '"\ed":"django.sh"'

## alt+f
bind '"\ef":"find . -mindepth 1 -not -path \"./venv/*\" -type f -iname \"*.json\""'

## alt+g
bind '"\eg":"git.sh --directory ."'

## alt+k
bind '"\ek":"kaddyify.sh --sync --directory ."'

## alt+m
bind '"\em":"~/main/project2/venv/bin/python ~/main/project2/manage.py "'

## alt+r
bind '"\er":"rg.sh --case-sensitive --directory ."'


alias a='cd    ~/main/project0/'
alias b='cd    ~/main/project1/'
alias c='cd    ~/main/configs/'
alias d='cd    ~/main/downloads/'
alias e='cd    ~/main/project2/'
alias k='cd    ~/kaddy/'
alias n='cd    ~/main/project3/'
alias p='cd    ~/main/pypi/'
alias r='cd    ~/main/project4/'
alias s='cd    ~/main/scripts/'
alias t='cd    ~/main/trash/'
alias v='cd    ~/main/venvs/'
alias w='cd    ~/main/project5/'
alias y='yazi  ~/main/downloads/'
alias ya='yazi ~/main/project0/'
alias yb='yazi ~/main/project1/'
alias yc='yazi ~/main/configs/'
alias yd='yazi ~/main/downloads/'
alias ye='yazi ~/main/project2/'
alias yh='yazi ~/'
alias yk='yazi ~/kaddy/'
alias yn='yazi ~/main/project3/'
alias yp='yazi ~/main/pypi/'
alias yr='yazi ~/main/project4/'
alias ys='yazi ~/main/scripts/'
alias yt='yazi ~/main/trash/'
alias yv='yazi ~/main/venvs/'
alias yw='yazi ~/main/project5/'
##
alias ls="\ls $LS_FLAGS"
alias cp='cp -v'
alias rm='rm -v --preserve-root'
alias mv='mv -v'
alias mkdir='mkdir -v'
alias ln='ln -v'
alias chown='chown -v --preserve-root'
alias chmod='chmod -v --preserve-root'
alias diff='\diff --color=always -y --suppress-common-lines'  ## -y prints in columns; --suppress-common-lines removes common lines
alias grep='grep --color=always -n'
alias lsblk_full='lsblk -o NAME,LABEL,SIZE,UUID,FSTYPE,TYPE,MOUNTPOINT,OWNER,GROUP,MODE,MAJ:MIN,RM,RO'


function command_not_found_handle {
    source ~/main/scripts/gb-color.sh

    red "not found: $1"
    return 127
}


function reset_bash_history {
    \cp -v ~/main/configs/cfg-bash/.bash_history ~/.bash_history
}


function lsl {
    source ~/main/scripts/gb.sh
    source ~/main/scripts/gb-color.sh

    shopt -s expand_aliases
    local first_line ls_command ls_output

    first_line='PERMISSIONS LINKS OWNER GROUP SIZE YYYY-MM-DD HH:MM:SS NAME'
    alias ls_command='\ls $LS_FLAGS -lbh --time-style=+"%Y-%m-%d %H:%M:%S"'

    if [ ! "$1" ] || [ -d "$1" ]; then
        ls_output="$(ls_command "${@}" | sed 1d)"
    else
        ls_output="$(ls_command "${@}")"
    fi

    printf '%s\n\n%s\n' "$(gray "$first_line")" "$ls_output" | column -t
    unalias ls_command
}


## needed by yazi.
## put at the end of file
eval "$(zoxide init bash)"
