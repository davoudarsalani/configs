## If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

[ -f "$HOME"/.fzf/shell/completion.bash   ] && source "$HOME"/.fzf/shell/completion.bash
[ -f "$HOME"/.fzf/shell/key-bindings.bash ] && source "$HOME"/.fzf/shell/key-bindings.bash

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome* ) PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\/home/nnnn}"' ;;
  screen*                               ) PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\/home/nnnn}"' ;;
esac

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# [ $UID -ne 0 ] && cd "$HOME"/main/downloads/
# tmux &>/dev/null

## PS1 {{{
# PS1='[\u@\h \W]\$ '
## [CHECKING_HOST]
PS1='$(
xt_stts="$?"
reset="\[\e[0m\]"

[ "$EUID" -eq 0         ] && ROOT="ROOT "
[ "$LF_LEVEL"           ] && LF="LF "
[ "$RANGER_LEVEL"       ] && RANG="RANGER "
[ "$HOSTNAME" == "acer" ] || HOST="${HOSTNAME^^} "
[ "$SSH_CONNECTION"     ] && SSH="SSH "
[ "$xt_stts" -gt 0      ] && EXIT="$xt_stts "
[ \j -gt 0              ] && JOBS="BG=\j "
HIST="\! "
[ "$TMUX"               ] && HERE="" || HERE="\w "
[ "$VIRTUAL_ENV"        ] && VIRT="${VIRTUAL_ENV##*/} "

echo "\
\[\e[05;49;031m\]${ROOT}${reset}\
\[\e[38;05;202m\]${LF}${reset}\
\[\e[38;05;202m\]${RANG}${reset}\
\[\e[38;05;011m\]${HOST}${reset}\
\[\e[38;05;013m\]${SSH}${reset}\
\[\e[38;05;001m\]${EXIT}${reset}\
\[\e[38;05;002m\]${JOBS}${reset}\
\[\e[38;05;008m\]${HIST}${reset}\
\[\e[38;05;004m\]${HERE}${reset}\
\[\e[38;05;005m\]${VIRT}${reset}"
)'
## }}}
## export {{{
HISTSIZE=  HISTFILESIZE=  ## infinite history
export HISTIGNORE='a:c:d:e:j:k:n:p:r:s:t:v:w:lf:lfa:lfc:lfd:lfe:lfj:lfk:lfn:lfp:lfr:lfs:lft:lfv:lfw:q'
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTTIMEFORMAT='%Y%m%d%H%M%S '
export PATH="${PATH}:${HOME}/main/scripts"
export LS_FLAGS='-A --color=always --group-directories-first'
export LC_ALL='en_US.UTF-8'
export GREP_COLORS='4;49;32'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONPATH="$HOME"/main/scripts
export PYTHONDONTWRITEBYTECODE=1
export RANGER_LOAD_DEFAULT_RC='FALSE'  ## to avoid loading rc.conf twice
export HIGHLIGHT='highlight --config-file=$HOME/.config/highlight/anotherdark.theme -O xterm256 --line-numbers --line-range=1-50 --force'  ## NOTE do NOT replace $HOME with ~
[ "$(command -v apt)" ] && export HIGHLIGHT="${HIGHLIGHT/--line-range=* }"  ## NOTE [CHECKING_HOST] there is no such option as --line-range on mint
export BLACK='$HOME/main/scripts/.venv/bin/black --line-length 170 --skip-string-normalization'
export BLACKDIFF='$HOME/main/scripts/.venv/bin/black --line-length 170 --skip-string-normalization --diff --color'
common_rg_flags='--smart-case --color=always'
export RG_MATCH_FLAGS="$common_rg_flags --colors 'match:bg:0' --colors 'match:fg:2' --colors 'match:style:underline'"
export RG="\rg $common_rg_flags --sort path --hidden --files-with-matches \
           --no-messages --glob '!{.git,.cache,.venv*,kaddy,trash}/*'"
           ## keep ignored paths synced with JUMP_1
           ## --files-with-matches prints the paths with at least one match and suppress match contents
           ## --multiline prints the total number of matches instead of the total number of lines

## fzf {{{
export FZF_DEFAULT_COMMAND='find "$HOME" -type f ! -path "*.git/*" ! -path "*.cache/*" ! -path "*.venv*/*" ! -path "*kaddy/*" ! -path "*trash/*" 2>/dev/null'  ##  <--,-- # ' | sed 's#$HOME#~#''  ## keep ignored paths synced with JUMP_1
                                                                                                                                                               ##     |-- ! -path flags also used in git option in ~/main/scripts/awesome-widgets
                                                                                                                                                               ##     '-- 2>/dev/null to ignore the error:
                                                                                                                                                               ##         find: '/home/nnnn/kaddy/lost+found': Permission denied.
                                                                                                                                                               ##         FIXME although ! -path "*kaddy/*" is added, find keeps looking inside kaddy
export FZF_DEFAULT_OPTS='--header "C-j/k:preview down/up|C-w:toggle preview|C-s:toggle sort|C-y:copy to clipboard" --no-bold --sort --cycle --border horizontal --no-multi --reverse --inline-info --ansi --pointer ">" --prompt ": " --marker "+" --height 70% --preview-window noborder:right:80%:wrap --bind "ctrl-s:toggle-sort,ctrl-y:execute-silent(echo "{-1}" | xclip -selection clipboard)+abort,backward-eof:abort,ctrl-k:preview-up,ctrl-j:preview-down,ctrl-w:toggle-preview" --color 'fg:${silver},fg+:${silver},hl+:2:underline,hl:2:underline,bg:${black},bg+:${grey_dark},preview-bg:${black},border:${grey_dark},gutter:${black},header:${blue}''
## conditional preview: --preview "[[ -d {} ]] && tree -C {} | head -200"  ## https://github.com/Bhupesh-V/til/blob/master/Shell/fzf-tips-tricks.md

## gruvbox theme: --color 'fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f,info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'eval "$HIGHLIGHT" {-1} 2>/dev/null' --header 'select'"

export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND/ -type f / -type d }"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview '$HOME/main/scripts/fzf-dir-preview {-1}' --header 'cd' --color 'fg:${blue},fg+:${blue}' --preview-window noborder:right:65%:wrap"  # --preview-window 'hidden'

export FZF_CTRL_R_OPTS="--header='history'"

# export FZF_COMPLETION_TRIGGER='~~' ## use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_OPTS="$FZF_DEFAULT_OPTS"

# export FZF_TMUX_OPTS=''

## ! -path flags also used in git option in ~/main/scripts/awesome-widgets
export FZF_ALT_C_COMMAND_GIT="$FZF_ALT_C_COMMAND ! -path '*.config/*' ! -path '*.vim/*' ! -path '*go/*' ! -path '*trash/*' -iname '.git' | sed 's#/\.git##' | sort"
## }}}
## }}}
## ls colors {{{
## (https://linuxhint.com/ls_colors_bash/)
## Command to get extensions: dircolors --print-database
export LS_COLORS="no=2;37:di=0;34:fi=0;37:ex=0;32:ln=0;36:\
*.tar=0;31:*.tgz=0;31:*.arc=0;31:*.arj=0;31:*.taz=0;31:*.lha=0;31:*.lz4=0;31:*.lzh=0;31:*.lzma=0;31:*.tlz=0;31:*.txz=0;31:*.tzo=0;31:*.t7z=0;31:*.zip=0;31:*.z=0;31:*.dz=0;31:*.gz=0;31:*.lrz=0;31:*.lz=0;31:*.lzo=0;31:*.xz=0;31:*.zst=0;31:*.tzst=0;31:*.bz2=0;31:*.bz=0;31:*.tbz=0;31:*.tbz2=0;31:*.tz=0;31:*.deb=0;31:*.rpm=0;31:*.jar=0;31:*.war=0;31:*.ear=0;31:*.sar=0;31:*.rar=0;31:*.alz=0;31:*.ace=0;31:*.zoo=0;31:*.cpio=0;31:*.7z=0;31:*.rz=0;31:*.cab=0;31:*.wim=0;31:*.swm=0;31:*.dwm=0;31:*.esd=0;31:\
*.jpg=0;33:*.jpeg=0;33:*.mjpg=0;33:*.mjpeg=0;33:*.gif=0;33:*.webp=0;33:*.bmp=0;33:*.pbm=0;33:*.pgm=0;33:*.ppm=0;33:*.tga=0;33:*.xbm=0;33:*.xpm=0;33:*.tif=0;33:*.tiff=0;33:*.png=0;33:*.svg=0;33:*.svgz=0;33:*.mng=0;33:*.pcx=0;33:*.qt=0;33:*.nuv=0;33:*.gl=0;33:*.dl=0;33:*.xcf=0;33:*.xwd=0;33:*.yuv=0;33:*.cgm=0;33:*.emf=0;33:\
*.mov=0;35:*.mpg=0;35:*.mpeg=0;35:*.m2v=0;35:*.mkv=0;35:*.webm=0;35:*.ogm=0;35:*.mp4=0;35:*.m4v=0;35:*.mp4v=0;35:*.vob=0;35:*.wmv=0;35:*.asf=0;35:*.rm=0;35:*.rmvb=0;35:*.flc=0;35:*.avi=0;35:*.fli=0;35:*.flv=0;35:\
*.aac=0;35:*.au=0;35:*.flac=0;35:*.m4a=0;35:*.mid=0;35:*.midi=0;35:*.mka=0;35:*.mp3=0;35:*.wma=0;35:*.mpc=0;35:*.ogg=0;35:*.oga=0;35:*.ra=0;35:*.wav=0;35:*.opus=0;35"
## }}}
## lf icons {{{
## https://github.com/gokcehan/lf/wiki/Icons
export LF_ICONS="\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.7z=:\
*.a=:\
*.ai=:\
*.accdb=:\
*.apk=:\
*.asm=:\
*.asp=:\
*.aup=:\
*.avi=:\
*.bat=:\
*.bgl=:\
*.bmp=:\
*.bz2=:\
*.c=:\
*.c++=:\
*.cab=:\
*.cbr=:\
*.cbz=:\
*.cc=:\
*.class=:\
*.clj=:\
*.cljc=:\
*.cljs=:\
*.cmake=:\
*.coffee=:\
*.conf=:\
*.cp=:\
*.cpio=:\
*.cpp=:\
*.cs=:\
*.css=:\
*.cue=:\
*.cvs=:\
*.cxx=:\
*.d=:\
*.dart=:\
*.db=:\
*.deb=:\
*.diff=:\
*.dll=:\
*.dng=:\
*.doc=:\
*.docx=:\
*.dump=:\
*.edn=:\
*.efi=:\
*.ejs=:\
*.elf=:\
*.epub=:\
*.erl=:\
*.exe=:\
*.f#=:\
*.fifo=|:\
*.fish=:\
*.flac=:\
*.flv=:\
*.fs=:\
*.fsi=:\
*.fsscript=:\
*.fsx=:\
*.gem=:\
*.gif=:\
*.go=:\
*.gpg=:\
*.gz=:\
*.gzip=:\
*.h=:\
*.hbs=:\
*.hrl=:\
*.hs=:\
*.htaccess=:\
*.htpasswd=:\
*.htm=:\
*.html=:\
*.ico=:\
*.img=:\
*.ini=:\
*.iso=:\
*.jar=:\
*.java=:\
*.jl=:\
*.jpeg=:\
*.webp=:\
*.jpg=:\
*.png=:\
*.js=:\
*.json=:\
*.jsx=:\
*.key=:\
*.less=:\
*.lha=:\
*.lhs=:\
*.log=:\
*.lua=:\
*.lzh=:\
*.lzma=:\
*.m4a=:\
*.m4v=:\
*.markdown=:\
*.md=:\
*.mkv=:\
*.ml=λ:\
*.mli=λ:\
*.mov=:\
*.mp3=:\
*.wma=:\
*.mp4=:\
*.mpeg=:\
*.mpg=:\
*.msi=:\
*.mustache=:\
*.o=:\
*.ogg=:\
*.oga=:\
*.otf=:\
*.pdf=:\
*.pem=:\
*.php=:\
*.pl=:\
*.pm=:\
*.pub=:\
*.ppt=:\
*.pptx=:\
*.psb=:\
*.psd=:\
*.py=:\
*.pyc=:\
*.pyd=:\
*.pyo=:\
*.rar=:\
*.rb=:\
*.rc=:\
*.rlib=:\
*.rom=:\
*.rpm=:\
*.rs=:\
*.rss=:\
*.rtf=:\
*.s=:\
*.so=:\
*.scala=:\
*.scss=:\
*.sh=:\
*.slim=:\
*.sln=:\
*.sql=:\
*.sqlite3=:\
*.srt=:\
*.styl=:\
*.suo=:\
*.svg=:\
*.t=:\
*.tar=:\
*.tgz=:\
*.tif=:\
*.ts=:\
*.ttf=:\
*.twig=:\
*.txt=:\
*.csv=:\
*.vtt=:\
*.vcf=:\
*.vim=:\
*.vimrc=:\
*.wav=:\
*.opus=:\
*.webm=:\
*.xbps=:\
*.xhtml=:\
*.xls=:\
*.xlsx=:\
*.xml=:\
*.xul=:\
*.xz=:\
*.zst=:\
*.yaml=:\
*.yml=:\
*.zip=:\
"

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
## }}}
## set, shopt and bind {{{
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

bind '"\ed":"django"'  ## alt+d
bind '"\ef":"find . -mindepth 1 -type f -iname "*.json""'  ## alt+f
bind '"\eg":"git_ -d ."'  ## alt+g
bind '"\ek":"kaddyify -s -d ."'  ## alt+k
bind '"\er":"rg_ -d ."'  ## alt+r
## }}}
## aliases {{{
alias a='cd "$HOME"/main/ariel/'
alias c='cd "$HOME"/main/configs/'
alias d='cd "$HOME"/main/downloads/'
alias e='cd "$HOME"/main/eterna/'
alias j='cd "$HOME"/main/journal/'
alias k='cd "$HOME"/kaddy/'
alias n='cd "$HOME"/main/nova/'
alias p='cd "$HOME"/main/packages-and-modules/'
alias r='cd "$HOME"/main/rcc/'
alias s='cd "$HOME"/main/scripts/'
alias t='cd "$HOME"/main/trash/'
alias v='cd "$HOME"/main/venvs/'
alias w='cd "$HOME"/main/website/'
alias lf='\lf "$HOME"/main/downloads/'
alias lfa='\lf "$HOME"/main/ariel/'
alias lfc='\lf "$HOME"/main/configs/'
alias lfd='\lf "$HOME"/main/downloads/'
alias lfe='\lf "$HOME"/main/eterna/'
alias lfj='\lf "$HOME"/main/journal'
alias lfk='\lf "$HOME"/kaddy/'
alias lfn='\lf "$HOME"/main/nova/'
alias lfp='\lf "$HOME"/main/packages-and-modules/'
alias lfr='\lf "$HOME"/main/rcc/'
alias lfs='\lf "$HOME"/main/scripts/'
alias lft='\lf "$HOME"/main/trash/'
alias lfv='\lf "$HOME"/main/venvs/'
alias lfw='\lf "$HOME"/main/website/'
alias ls="\ls $LS_FLAGS"
alias cp='cp -v'
alias rm='rm -v --preserve-root'
alias mv='mv -v'
alias mkdir='mkdir -v'
alias ln='ln -v'
alias chown='chown -v --preserve-root'
alias chmod='chmod -v --preserve-root'
alias sshalive='ssh -o TCPKeepAlive=yes -o ServerAliveCountMax=20 -o ServerAliveInterval=15'
# alias ftp='cd ${HOME}/main/website && ftp --passive ftp.davoudarsalani.ir && cd - >/dev/null'
alias grep='grep --color=always -n -i'
alias diff='\diff --color=always'
alias diff2='\diff --color=always -y --suppress-common-lines'  ## -y prints in columns; --suppress-common-lines removes common lines
alias xprop='xprop WM_CLASS'  ## class is the second string
alias swappiness='\cat /proc/sys/vm/swappiness'  ## OR cat /sys/fs/cgroup/memory/memory.swappiness
alias lsblk='lsblk -o NAME,LABEL,SIZE,UUID,FSTYPE,TYPE,MOUNTPOINT,OWNER,GROUP,MODE,MAJ:MIN,RM,RO'
alias month='cal'
alias season='cal -3'
alias year='cal -y'
alias jmonth='jcal -p'
alias jseason='jcal -3'
alias jyear='jcal -y'
alias mega='mega-cmd'
alias watch='watch --interval 2 --no-title --color'  ## --interval 2 --no-title --color also used in ~/.config/sublime/Packages/User/watch.sublime-build
alias journalctl='journalctl -exfu'
alias q='exit'
## }}}
## functions {{{
function command_not_found_handle {  ## {{{
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    red "not found: $1"
    return 127
}
## }}}
function gifify {  ## {{{
    source "$HOME"/main/scripts/gb-color

    local new_name mp4_reg webm_reg

    [ "$1" ] || {
        red "arg(s) needed"
        red "USAGE: $FUNCNAME ~/main/downloads/cars.webm [5]"
        return
    }

    [ -f "$1" ] || {
        red "$1 does not exist"
        return
    }

    mp4_reg='.*mp4$'
    webm_reg='.*webm$'
    if [[ "$1" =~ $mp4_reg ]]; then
        new_name="${1/.mp4/.gif}"
    elif [[ "$1" =~ $webm_reg ]]; then
        new_name="${1/.webm/.gif}"
    else
        red 'invalid suffix. only webm and mp4 files supported'
        return
    fi

    ## https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
    ffmpeg -i "$1" -ss "${2:-0}" -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$new_name"
}
## }}}
function mp4ify {  ## {{{
    source "$HOME"/main/scripts/gb-color

    local new_name webm_reg

    [ "$1" ] || {
        red "arg needed"
        red "USAGE: $FUNCNAME ~/main/downloads/cars.webm"
        return
    }

    [ -f "$1" ] || {
        red "$1 does not exist"
        return
    }

    webm_reg='.*webm$'
    if [[ "$1" =~ $webm_reg ]]; then
        new_name="${1/.webm/.mp4}"
    else
        red 'invalid suffix. only webm files supported'
        return
    fi

    ffmpeg -i "$1" "$new_name"
}
## }}}
function jpgify {  ## {{{
    source "$HOME"/main/scripts/gb-color

    local new_name webp_reg

    [ "$1" ] || {
        red 'arg needed'
        red "USAGE: $FUNCNAME ~/main/downloads/cars.webp"
        return
    }

    [ -f "$1" ] || {
        red "$1 does not exist"
        return
    }

    webp_reg='.*webp$'
    if [[ "$1" =~ $webp_reg ]]; then
        new_name="${1/.webp/.jpg}"
    else
        red 'invalid suffix. only webp files supported'
        return
    fi

    ffmpeg -i "$1" "$new_name"
}
## }}}
function webpify {  ## {{{
    source "$HOME"/main/scripts/gb-color

    local new_name jpg_reg jpeg_reg png_reg

    [ "$1" ] || {
        red "arg needed"
        red "USAGE: $FUNCNAME ~/main/downloads/cars.jpg"
        return
    }

    [ -f "$1" ] || {
        red "$1 does not exist"
        return
    }

    jpg_reg='.*jpg$'
    jpeg_reg='.*jpeg$'
    png_reg='.*png$'
    if [[ "$1" =~ $jpg_reg ]]; then
        new_name="${1/.jpg/.webp}"
    elif [[ "$1" =~ $jpeg_reg ]]; then
        new_name="${1/.jpeg/.webp}"
    elif [[ "$1" =~ $png_reg ]]; then
        new_name="${1/.png/.webp}"
    else
        red 'invalid suffix. only jpg/jpeg/png files supported'
        return
    fi

    ffmpeg -i "$1" "$new_name"
}
## }}}
function reset_bash_history {  ## {{{
    \cp -v ~/main/configs/cfg-bash/.bash_history "$HOME"/.bash_history
}
## }}}
function reset_sublime_configs {  ## {{{
    source "$HOME"/main/scripts/gb-color

    [ "$(pgrep 'sublime')" ] && {
        red 'sublime already running'
        return
    }

    \rm -rf "$HOME"/.cache/sublime-text/ && \
    \rm -rf "$HOME"/.config/sublime-text/ && \
    \cp -r "$HOME"/main/configs/cfg-sublime/ "$HOME"/.config/sublime-text/ && \
    \rm "$HOME"/.config/sublime-text/0-path.txt
}
## }}}
function images_containers {  ## {{{

    tmux split-window -v  ## don't know why, but we have to do this first!

    if (( "$(tput cols)" > 136 )); then
        tmux split-window -v -p 40 -c '#{pane_current_path}'  ## create pane3 down
        tmux split-window -h -d    -c '#{pane_current_path}'  ## create pane4 right in detached mode
        tmux select-pane -U  ## move to the top pane
    else
        tmux split-window -h -d -p 35 -c '#{pane_current_path}'  ## create pane3 right in detached mode
        tmux split-window -v -d -p 25 -c '#{pane_current_path}'  ## create pane4 down in detached mode
    fi

    tmux send-keys -t 3 'watch docker image ls -a' ENTER  ## send command to pane3
    tmux send-keys -t 4 'watch docker ps -a' ENTER  ## send command to pane4

    exit
}
## }}}
function shecan {  ## {{{
    local file pattern is_on

    file=/etc/resolv.conf
    pattern='shecan$'
    is_on="$(\grep "$pattern" "$file")"

    case "$1" in
        start )
            if [ "$is_on" ]; then
                printf 'shecan already on\n\n'
            else
                ## comment normal
                sed 's/^\(nameserver\)/# \1/' "$file" | sudo tee "$file" >/dev/null

                ## append shecan
                printf 'nameserver 178.22.122.100  ## shecan\n' | sudo tee -a "$file" >/dev/null
                printf 'nameserver 185.51.200.2    ## shecan\n' | sudo tee -a "$file" >/dev/null
            fi
        ;;
        stop )
            if [ "$is_on" ]; then
                ## delete shecan
                sed "/$pattern/d" "$file" | sudo tee "$file" >/dev/null

                ## uncomment normal
                sed 's/^# *\(nameserver\)/\1/' "$file" | sudo tee "$file" >/dev/null
            else
                printf 'shecan already off\n\n'
            fi
        ;;
        status )
            [ "$is_on" ] && printf 'shecan is started\n\n' || printf 'shecan is stopped\n\n'
        ;;
        * ) source "$HOME"/main/scripts/gb-color
            red 'valid args: start/stop/status'
            return
        ;;
    esac

    eval "${HIGHLIGHT/--line-numbers}" "$file" 2>/dev/null
}
## }}}
function lsl {  ## {{{ https://stackoverflow.com/questions/54949060/standardized-docstring-self-documentation-of-bash-scripts
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color
    shopt -s expand_aliases
    local first_line ls_command ls_output

    first_line='PERMISSIONS LINKS OWNER GROUP SIZE YYYY-MM-DD HH:MM:SS NAME'
    alias ls_command='\ls $LS_FLAGS -lbh --time-style=+"%Y-%m-%d %H:%M:%S"'
    if [ ! "$1" ] || [ -d "$1" ]; then
        ls_output="$(ls_command "${@}" | sed 1d)"
    else
        ls_output="$(ls_command "${@}")"
    fi

    printf '%s\n\n%s\n' "$(grey "$first_line")" "$ls_output" | column -t
    unalias ls_command
}
## }}}
function b {  ## {{{ black
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    [ "$1" ] || {
        red 'arg required'
        return
    }

    eval "$BLACK" "$1"
}
## }}}
function bd {  ## {{{ black diff
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    [ "$1" ] || {
        red 'arg required'
        return
    }

    eval "$BLACKDIFF" "$1" | less -R
}
## }}}
function rvj {  ## {{{ remove vim junk (i.e. tmp files and swap files)
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    [ "$(pgrep 'vim')" ] && {
        red 'vim is running'
        return
    }

    rm "$HOME"/.*tmp             2>/dev/null || printf '%s\n' 'no temp files'  ## do NOT change .*tmp
    rm "$HOME"/.cache/vim/swap/* 2>/dev/null || printf '%s\n' 'no swap files'
}
## }}}
function awesome_tail {  ## {{{ https://askubuntu.com/questions/830484/how-to-start-tmux-with-several-panes-open-at-the-same-time
    local DEST_WIN SESS

    DEST_WIN='awesome_std{out,err}'  ## dest window name
    SESS="$(tmux display-message -p '#S')"  ## current seesion name, e.g. 1, etc

    ## create window:
    tmux new-window -n "$DEST_WIN"  ## add -d to prevent from jumping to $DEST_WIN (https://unix.stackexchange.com/questions/445307/open-new-tmux-window-with-specific-name-only-if-missing)

    ## create panes:
    tmux split-window -h -t ${SESS}:${DEST_WIN}.1
    # tmux split-window -h -t ${SESS}:${DEST_WIN}.2  ## <-,-- no need to create pane 2
                                                     ##   |-- because when we create pane 1 in prev command,
                                                     ##   '-- we automatically end up with 2 panes

    ## send commands:
    tmux send-keys -t ${SESS}:${DEST_WIN}.1 "tail -f ${HOME}/.awesome_stdout" Enter
    tmux send-keys -t ${SESS}:${DEST_WIN}.2 "tail -f ${HOME}/.awesome_stderr" Enter
}

## }}}## create/activate/deactivate a virtual environmant
function vc {  ## {{{
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    local dirname
    dirname="${1:-venv}"

    [ -d "$dirname" ] && {
        red "$dirname already exists"
        return
    }

    python3 -m venv "$dirname" && \
    accomplished "$dirname created"
}
## }}}
function va {  ## {{{
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    local dirname
    dirname="${1:-venv}"

    ## return if another virtual env is already acticated
    [ "$VIRTUAL_ENV" ] && {
        red "another virtual env is already activated: (${VIRTUAL_ENV})"
        return
    }

    [ -d "$dirname" ] || {
        red "no such dir as $dirname"
        return
    }

    source "$dirname"/bin/activate
}
## }}}
function vu {  ## {{{
    source "$HOME"/main/scripts/gb
    source "$HOME"/main/scripts/gb-color

    local dirname
    dirname="${1:-venv}"

    [ -d "$dirname" ] || {
        red "no such dir as $dirname"
        return
    }

    python3 -m venv --upgrade "$dirname" && \
    accomplished "$dirname updated"
}
## }}}
function vd {  ## {{{
    deactivate
}
## }}}
function pip_upgrade {  ## {{{ https://dougie.io/answers/pip-update-all-packages/
    source "$HOME"/main/scripts/gb-color

    [ "$VIRTUAL_ENV" ] || {
        red 'virtual env not activated'
        return
    }

    pip freeze | cut -d'=' -f 1 | xargs -n 1 pip install -U
}
## }}}
function man {  ## {{{
    LESS_TERMCAP_md=$'\e[95m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[7;40;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[32m' \
    command man "$@"
}
## }}}
function less {  ## {{{
    LESS_TERMCAP_md=$'\e[95m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[7;40;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[32m' \
    eval "${HIGHLIGHT/--line-range=* }" "$@" 2>/dev/null | command less -R
    # command less "$@"
}
## }}}
# function kaddyify {  ## {{{
#     source "$HOME"/main/scripts/gb
#     source "$HOME"/main/scripts/gb-color
#
#     local src dest relative_path_reg_1 relative_path_reg_2 relative_path_reg_3 home_reg absolute_path_reg parent_reg
#
#     [ "$1" ] || {
#         red 'arg needed'
#         red "USAGE: $FUNCNAME ~/main/scripts"
#         red "       $FUNCNAME ~/main/scripts/application"
#         return
#     }
#
#     src="$1"
#
#     ## NOTE taking two steps to make sure screw-ups are avoided in JUMP_2
#     ##      where the path of destination directory in kaddy is obtained,
#     ##      otherwise, we will end up removing the source file/directory:
#     ##        STEP 1. (JUMP_3) turn src into an absolute path, if it is a relative one (e.g. ., ./, ./scripts, scripts, etc)
#     ##        STEP 2. (JUMP_4) return if:
#     ##                           a. src is still a relative path
#     ##                           b. src is .. or ../
#     ##
#     ##      What's more, and just to be on the safe side, a final check is done
#     ##      where it returns in case src and dest end up the same (JUMP_5)
#
#     ## JUMP_3 STEP 1: turn relative path into absolute
#     relative_path_reg_1='^\.\/?$'        ## . or ./
#     relative_path_reg_2='^\.\/.+$'       ## ./scripts
#     relative_path_reg_3='^[^\/\.\~\$]+'  ## scripts
#     if   [[ "$src" =~ $relative_path_reg_1 ]]; then src="$(sed "s|^\./\?|$PWD|" <<< "$src")"  ## . -> /home/nnnn  OR  ./ -> /home/nnnn
#     elif [[ "$src" =~ $relative_path_reg_2 ]]; then src="$(sed "s|^\.|$PWD|" <<< "$src")"     ## ./main/scripts -> /home/nnnn/main/scripts
#     elif [[ "$src" =~ $relative_path_reg_3 ]]; then src="$PWD"/"$src"                         ## main/scripts -> /home/nnnn/main/scripts
#     fi
#
#     ## return if src is home itself
#     home_reg="^$HOME/?$"
#     [[ "$src" =~ $home_reg ]] && {
#         red 'home itself cannot be used'
#         return
#     }
#
#     ## JUMP_4 STEP 2: return if:
#     ##                  a. src is still a relative path
#     ##                  b. src is .. or ../
#     absolute_path_reg="^$HOME.*$"  ## /home/nnnn or /home/nnnn/ or /home/nnnn/main/scripts or $HOME/main/scripts or ~/main/scripts
#     parent_reg='^\.{2}.*$'  ## .. or ../
#     if [[ ! "$src" =~ $absolute_path_reg ]] || [[ "$src" =~ $parent_reg ]]; then
#         red "wrong arg. $src is not valid"
#         red 'valid choices:'
#         red "  $FUNCNAME ."
#         red "  $FUNCNAME ./scripts"
#         red "  $FUNCNAME scripts"
#         red "  $FUNCNAME $HOME/main/scripts"
#         red "  $FUNCNAME \$HOME/main/scripts"
#         red "  $FUNCNAME ~/main/scripts"  ## this line should print literal ~
#         return
#     fi
#
#     dest="$(get_kaddy_counterpart "$src")"  ## JUMP_2
#
#     ## JUMP_5
#     [ "$src" == "$dest" ] && {
#         red 'source and destination file/directory are the same'
#         return
#     }
#
#     if [ ! -d "$src" ] && [ ! -f "$src" ]; then
#         red "${src/$HOME/\~} does not exist"
#         return
#     fi
#
#     action_now "removing ${dest/$HOME/\~}"
#     \rm -rf "$dest"
#
#     action_now "copying "${src/$HOME/\~}" to ${dest/$HOME/\~}"
#     \cp -r "$src" "$dest" && \
#     accomplished
# }
## }}}
## }}}

# if [[ "$PWD" =~ $HOME/main/website ]]; then
#     va "$HOME"/main/website/venv  ## exceptionally passing full dir path because we may be way inside ~/main/website and therefore 'va' won't work
# fi
