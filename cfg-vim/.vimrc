start  " {{{
syntax on
colorscheme gruvbox  " gruvbox8_hard
let mapleader = " "
" let &showbreak="\u21aa" " Show a left arrow (↪) when wrapping text
" let &titlestring= $USER . '@' . hostname() . ' : %F %r: VIM %m'
" set title
" set showcmd  " Show partial commands in the last line of the screen
" set backspace=indent,eol,start  " Allow backspacing over autoindent, line breaks and start of insert action
" set timeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings
" set showtabline=2  " always show tab bar
" set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
" set signcolumn=yes  " yes means do not turn off when no signs are present
" set preserveindent
" set showbreak=â€¦
" set noexpandtab  " convert spaces to tabs
" set ro
" set nomodifiable
" set foldlevel=1  " fold everything indented for more than 1 level (foldmethod should be indent)
" set foldclose=all  " makes the fold automatically re-close after you navigate out of the fold
" set smarttab  " insert tabs on the start of a line according to context
" set copyindent  " copy the previous indentation on autoindenting
" set pastetoggle=<F12>  " prevents screwed-up indentation when pasting
" set wildmode=full
set lazyredraw  " prevent redraw while executing macros (good performance config)
set expandtab  " convert tabs to spaces
set noshowmode  " prevent non-normal modes showing below status line
set wildmenu  " make tab completion for files/buffers act like bash
set wildchar=<Tab>
set incsearch  " jump to searched word as you type
set hlsearch
set showmatch
set nocompatible
set nowrap
set linebreak  " prevent splitting words when wrapping is set
set number relativenumber
set splitright splitbelow
set cursorline
set nocursorcolumn
set ignorecase
set smartcase
set autoindent
set smartindent
set nostartofline  " keep cursor in the same column when moving between lines
set foldtext=MyFoldText()
set fillchars=fold:\  ",vert:\│      " fold is for getting rid of fold dashes, vert is for separating the splits
set list listchars=tab:\│\  " set list listchars=tab:\│\ ,trail:.,eol:¬
set tabstop=4  " tab character width
set softtabstop=4
set shiftwidth=4  " needs to be the same as tabstop
set history=2000
set t_Co=256  " is it of any help ?
set scrolloff=5
set sidescroll=1  " scroll sideways 1 chraacter at a time not a whole screen
set sidescrolloff=10
set matchpairs+=<:>
set updatetime=1000  " Write swap files to disk and trigger CursorHold event faster (default is after 4000 ms of inactivity)
set timeoutlen=500  " to run maps (default 1000)
set foldmethod=marker
" set foldmarker=f[[,f]]
set laststatus=2
set encoding=utf-8
set background=dark
set whichwrap=b,s,<,>,[,]
set fileformat=unix
" set dictionary=~/.vim/words.txt
" }}}
set stl=  " {{{
hi dark ctermfg=4  ctermbg=none cterm=none
hi lite ctermfg=249 ctermbg=none cterm=none

hi dark_inactive ctermfg=235 ctermbg=none cterm=none
hi lite_inactive ctermfg=235 ctermbg=none cterm=none

hi alert   ctermfg=1 ctermbg=none cterm=none
hi warning ctermfg=202 ctermbg=none cterm=none

hi normal_mode  ctermfg=10  ctermbg=none
hi visual_mode  ctermfg=166 ctermbg=none
hi replace_mode ctermfg=126 ctermbg=none
hi command_mode ctermfg=220 ctermbg=none

" NOTE:
" %l                  returns e.g. 2
" %02l                returns e.g. 02
" %{IndentLevel()}    returns e.g. 2
" %02{IndentLevel()}  returns e.g. 02
"
" set statusline+=%#warningmsg#
set stl+=%#CurrentModeColor#\ %{CurrentMode()}
set stl+=%#dark#\ %{strpart(getline('.'),col('.')-1,1)}  " https://devhints.io/vimscript
" ^^ PREVIOUSLY: let &stl.="%2.2(%{matchstr(getline('.'), '\\%' . col('.') . 'c.')}%)"  " https://stackoverflow.com/questions/40508385/vim-statusline-show-the-character-itself
set stl+=%#lite#\ C:\ %v/%{strlen(getline('.'))}\ %o/%{line2byte(line('$')+1)-1}
set stl+=%#dark#\ L:\ %l/%L
set stl+=%#lite#\ W:\ %{wordcount().words}  " %p%%
set stl+=%#TFTBColor#\ %{TFTB()}
set stl+=%#CurrentTagColor#\ %{CurrentTag()}
set stl+=%#SyntasticColor#\ %{CheckSyntax()}  " or SyntasticStatuslineFlag()
set stl+=%#ReadonlyColor#\ %{ReadOnly()}
set stl+=%#ModifiedColor#\ %{Modified()}
set stl+=%#GitStatusColor#\ %{SignifyGitStatus()}
set stl+=%#lite#
" set stl+=%*  " reset color
set stl+=%=
set stl+=%#lite#\ %F  " %t for basename only
set stl+=%#dark#\ %{strlen(&ft)?&ft:'none'}  " https://github.com/einverne/dotfiles/blob/master/.vimrc OR %{''!=#&filetype?&filetype:'none'}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
" set stl+=%#dark#\ %{getfperm(expand('%:p'))}  " rw-r--r--
set stl+=%#CurrentModeColor#\ ▮
" set stl+=%{&fileencoding?&fileencoding:&encoding}
" set stl+=\ ascii:%03b\ hex:0x%04B
" set stl+=%{&ff}  " file format, e.g. unix
" set stl+=%{v:register}  " active register
" }}}
" {{{ abbrev
iabbrev writedatetime <c-r>=strftime('%Y%m%d%H%M%S')<CR>
" }}}
" {{{ maps
" {{{ F1-10
" write
noremap  <F1>      :qa!<CR>
inoremap <F1> <C-o>:qa!<CR>

" quit
noremap  <F2>      :w<CR>
inoremap <F2> <C-o>:w<CR>

" write+quit
noremap  <F3>      :wqa<CR>
inoremap <F3> <C-o>:wqa<CR>

noremap  <F4>      :Run<CR>
inoremap <F4> <C-o>:Run<CR>

" SurroundWord
noremap  <F5>      :SurroundWord {}
inoremap <F5> <C-o>:SurroundWord {}

" SurroundSelection
noremap  <F6>      :SurroundSelection {}
inoremap <F6> <C-o>:SurroundSelection {}

" replace
noremap  <F7>      :%s#\<<C-r>=expand("<cword>")<CR>\>##gc<Left><Left><Left>
inoremap <F7> <C-o>:%s#\<<C-r>=expand("<cword>")<CR>\>##gc<Left><Left><Left>
vnoremap <F7>      :s#\%V##gc<Left><Left><Left>

noremap  <F8>      :set cursorcolumn!<CR>
inoremap <F8> <C-o>:set cursorcolumn!<CR>

" python-mode JUMP_7
" '<F9>'

" ultisnips JUMP_6
" '<F10>'

" watch
noremap  <F12>      :Watch<CR>
inoremap <F12> <C-o>:Watch<CR>
" }}}
noremap <Leader>0  :ToggleJedi<CR>
noremap <Leader>1  :set list!<Bar>set relativenumber!<Bar>set invnumber<CR>
noremap <Leader>2  :SignifyToggle<CR>
noremap <Leader>3  :UndotreeToggle<CR>
noremap <Leader>4  :ToggleWhitespace<CR>
noremap <Leader>5  :MUcompleteAutoToggle<CR>
noremap <Leader>6  :SyntasticToggleMode<CR>
noremap <Leader>7  :SignatureToggleSigns<CR>
noremap <Leader>8  :IlluminationToggle<CR>
noremap <Leader>9  :DimInactiveToggle<CR>
noremap <Leader>10 :HighlightLinesToggle<CR>
noremap <Leader>11 :TagbarToggle<CR>

noremap <Leader>a  :AscendingNumbers END
noremap <Leader>b  :Black<CR>
noremap <Leader>bd :BlackDiff<CR>
noremap <Leader>c  :CountCurrentWord<CR>
noremap <Leader>e  :ToggleEncode<CR>
noremap <Leader>i  :IndentLevel<CR>
noremap <Leader>q  :QuickfixToggle<CR>
noremap <Leader>s  :SyntaxAttribute<CR>
noremap <Leader>t  :TyperStart PATH
noremap <Leader>w  :WordsFrequency<CR>

" bring the current line to top/middle/bottom of screen
noremap  TT      zt
noremap  MM      zz
noremap  BB      zb
inoremap TT <C-o>zt
inoremap MM <C-o>zz
inoremap BB <C-o>zb

" change/delete whole word no matter where the cursor is
noremap cw caw
noremap dw daw

nnoremap Y y$

" redo
map U <C-r>

noremap b B
noremap w W

" easymotion JUMP_5

map ; :

" show help on current word in preview window (https://github.com/llh911001/vimrc/blob/master/.vimrc)
noremap <silent> K :exec 'help ' . expand('<cword>')<CR>

" https://vim.fandom.com/wiki/Smart_home
noremap <expr>   <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap    <silent> <Home> <C-O><Home>
" noremap <expr>   <End>  (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
" imap             <End>  <C-o><End>
" vnoremap <expr>  <End>  (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')

" clear highlighted matches (https://nvie.com/posts/how-i-boosted-my-vim/):
noremap <silent> <CR> :nohlsearch<CR>
" toggle highlighting on/off (https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches):
" noremap <silent> <CR> :set hlsearch! hlsearch?<CR>

" insert single character in normal mode (https://vim.fandom.com/wiki/Insert_a_single_character):
nnoremap <C-i> :exec "normal i".nr2char(getchar())."\e"<CR>
" nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" insert new line below without leaving normal mode (https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode)
nnoremap <C-o> o<Esc>k

noremap <C-y> :CopyToClipboard<CR>

" jump to prev/next function (https://vim.fandom.com/wiki/Jumping_to_the_start_and_end_of_a_code_block)
au FileType python noremap { :silent eval search('^ *def ',      'b')<CR>
au FileType python noremap } :silent eval search('^ *def '          )<CR>
au FileType sh     noremap { :silent eval search('^ *function ', 'b')<CR>
au FileType sh     noremap } :silent eval search('^ *function '     )<CR>

" run current line:
au FileType sh      noremap <leader>. :.w !source %:p; bash<CR>
au FileType python  noremap <leader>. :.w !source %:p; python<CR>

" run selection:
au FileType sh     vnoremap <leader>v :w  !source %:p; bash<CR>
au FileType python vnoremap <leader>v :w  !source %:p; python<CR>

" }}}
" {{{ au & hi
" au VimEnter * :vertical resize +9  " widen main split so undotree split occupies less space
" au InsertLeave *  :call CursorLineInNonInsertMode()  " CurrentMode() function does the job, so better be commented
au InsertEnter *  hi CursorLineNr ctermbg=none ctermfg=4  cterm=none
au InsertEnter *  hi CursorLine   ctermbg=none

" vv needed because restore_view.vim opens buffer with current fold open
au VimEnter    *  normal zM
au VimEnter    *  set noshowmode
au vimEnter    *  RestoreCursorPosition
au VimEnter    *  normal zz
au VimEnter    *  UndotreeShow
au BufWritePre *  :call LastModified()  " :LastModified command did not work

" https://vi.stackexchange.com/questions/3897/how-to-label-tmux-tabs-with-the-name-of-the-file-edited-in-vim
if exists('$TMUX')

    " sometime, for example when we open file with the command vim ~/scripts/application instead of opening it from lf,
    " base would be /home/nnnn/scripts/application if we use expand("%:t") - which is not what we want.
    " so have to do some substitution:
    let base = substitute(expand('%'), ".*/", "", 1)

    let orig_win_name = system("tmux display-message -p '#W'")

    autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window " . base)
    autocmd VimLeave *                                     call system("tmux rename-window " . orig_win_name)

endif

au FileType sh,dockerfile,javascript,css,html* :MatchTodoInSh
au BufRead,BufNewFile *.htm,*.html*,*.php,*.css,*.js setlocal tabstop=2 shiftwidth=2 softtabstop=2

hi Comment      cterm=italic
hi CursorColumn ctermbg=233
hi LineNr       ctermbg=none ctermfg=235 cterm=none
hi Normal       ctermbg=none
hi Search       ctermbg=none cterm=underline
hi SignColumn   ctermbg=none
hi StatusLine   ctermbg=none ctermfg=12  cterm=none
hi StatusLineNC ctermbg=none ctermfg=235 cterm=none
hi TodoInSh     ctermbg=none ctermfg=246 cterm=italic,bold
hi VertSplit    ctermfg=4

" jedi JUMP_3

" illuminate JUMP_4
" }}}
" {{{ functions
" statusline functions:
function! CurrentMode() " {{{
    let l:currentmode = mode()
    if currentmode == 'i'
        hi link CurrentModeColor lite
        return 'INSERT'
    endif

    call CursorLineInNonInsertMode()
    if currentmode == 'n'
        hi link CurrentModeColor normal_mode
        return 'NORMAL'
    elseif currentmode == 'v'
        hi link CurrentModeColor visual_mode
        return 'VISUAL [C: ' . wordcount().visual_bytes . ' W: ' . wordcount().visual_words . ']'
    elseif currentmode == 'r'
        hi link CurrentModeColor replace_mode
        return 'REPLACE'
    elseif currentmode == 'c'
        hi link CurrentModeColor command_mode
        return 'COMMAND'
    elseif currentmode == 't'
        hi link CurrentModeColor terminal_mode_color
        return 'TERMINAL'
    elseif currentmode == 's'
        hi link CurrentModeColor select_mode_color
        return 'SELECT'
    elseif currentmode == '!'
        hi link CurrentModeColor shell_mode_color
        return 'SHELL'
    elseif currentmode == +'v'  " put lower than replace
        hi link CurrentModeColor visual_mode
        return 'VISUAL-BLOCK [C: ' . wordcount().visual_bytes . ' W: ' . wordcount().visual_words . ']'
    endif
endfunction
" }}}
function! TFTB() " {{{ https://stackoverflow.com/questions/66051261/how-to-the-display-the-number-of-instances-of-a-string-in-vim-statusline/
    if &filetype != 'vim'
        let l:todos_count  = len(filter(getline(1, '$'), 'v:val =~? "TODO"'))
        let l:fixmes_count = len(filter(getline(1, '$'), 'v:val =~? "FIXME"'))
        let l:tempos_count = len(filter(getline(1, '$'), 'v:val =~? "TEMPORARY"'))
        let l:breaks_count = len(filter(getline(1, '$'), 'v:val =~? "breakpoint()"'))

        if todos_count > 0 || fixmes_count > 0 || tempos_count > 0 || breaks_count > 0
            hi link TFTBColor dark
            let l:all = todos_count . ' ' . fixmes_count . ' ' . tempos_count . ' ' . breaks_count
        else
            hi link TFTBColor dark_inactive
            let l:all = 'TFTB'
        endif

    else
        hi link TFTBColor dark_inactive
        let l:all = 'TFTB'
    endif
    return all
endfunction
" }}}
function! CurrentTag() " {{{
    let l:text = tagbar#currenttag('%s','','f','scoped-stl')
    if len(text) == 0 || &filetype != 'python'
        hi link CurrentTagColor lite_inactive
        let l:text = 'TA'
    else
        hi link CurrentTagColor lite
    endif
    return text
endfunction
" }}}
function! CheckSyntax() " {{{
   let l:error_text = SyntasticStatuslineFlag()
   if len(error_text) == 0
       hi link SyntasticColor dark_inactive
       let l:text = 'ER'
   else
       hi link SyntasticColor alert
       let l:text = error_text
   endif
   return text
endfunction
" }}}
function! ReadOnly() " {{{
    if &readonly
        hi link ReadonlyColor alert
    else
        hi link ReadonlyColor lite_inactive
    endi
    return 'RE'
    " set statusline+=%#ReadonlyColor#%{&readonly?'\ \ LOCKED':''}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
endfunction
" }}}
function! Modified() " {{{
    let l:mo_index = &modified
    if &modified
        hi link ModifiedColor warning
    else
        hi link ModifiedColor dark_inactive
    endi
    return 'MO'
    " set statusline+=%#ModifiedColor#%{&modified?'\ \ X':''}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
endfunction
" }}}
function! SignifyGitStatus()  " {{{
  let l:gs = sy#repo#get_stats_decorated()
  if len(gs) == 0
    hi link GitStatusColor lite_inactive
    return 'GI'
  else
    hi link GitStatusColor warning
    return gs
  endif
endfunction
" }}}

function! AscendingNumbers(end) " {{{ https://vim.fandom.com/wiki/Making_a_list_of_numbers
    exec "put =map(range(1, " . a:end . "), 'printf(''%03d'', v:val)')"
endfunction
command! -nargs=1 AscendingNumbers :call AscendingNumbers(<f-args>)
" }}}
function! Black() " {{{
    if &filetype == "python"
        let l:answer = confirm("Apply black? ", "&Yes\n&No")
        if answer == "1"
            " do NOT quote $BLACK
            exec "!clear; eval $BLACK %:p"
        endif
    else
        PrintfWarning 'For python file type only'
    endif
endfunction
command! Black :call Black()
" }}}
function! BlackDiff() " {{{
    if &filetype == "python"
        " do NOT quote $BLACKDIFF
        exec "!clear; eval $BLACKDIFF %:p | less \-R"
    else
        PrintfWarning 'For python file type only'
    endif
endfunction
command! BlackDiff :call BlackDiff()
" }}}
function! CopyToClipboard() " {{{ copy yanked text to clipboard (https://github.com/ryukinix/dotfiles/blob/master/.vimrc)
    call system('xclip -selection clipboard', @0)
    PrintfMsg 'Copied to clipboard'
endfunction
command! CopyToClipboard :call CopyToClipboard()
" }}}
function! CountCurrentWord() " {{{ https://stackoverflow.com/questions/11492258/find-number-of-occurrences-of-word-under-cursor
    :exec ":%s@\\<" . expand("<cword>") . "\\>\@&@gn"
endfunction
command! CountCurrentWord :call CountCurrentWord()
" }}}
function! CursorLineInNonInsertMode()  " {{{
    hi CursorLineNr ctermbg=none ctermfg=235 cterm=none
    hi CursorLine ctermbg=233
endfunction
" }}}
function! Filter(string) " {{{ https://vim.fandom.com/wiki/Redirect_g_search_output
    let @a='' | exec 'g/' . a:string . '/y A' | new | setlocal bt=nofile | put! a
endfunction
command! -nargs=1 Filter :call Filter(<f-args>)
" }}}
function! IndentLevel() " {{{ https://vim.fandom.com/wiki/Put_the_indentation_level_on_the_status_line
    if &filetype == 'python'
        :echo 'Indent level: ' . (indent('.') / &ts )
    else
        PrintfWarning 'For python file type only'
    endif
endfunction
command! IndentLevel :call IndentLevel()
" }}}
function! InsertLineNumbers() " {{{ https://vim.fandom.com/wiki/Insert_line_numbers
    :%s/^/\=printf('%-4d', line('.'))/g
    :%s/\([0-9]\+\)\s*$/\1/g
endfunction
command! InsertLineNumbers :call InsertLineNumbers()
" }}}
function! LastModified()  " {{{ https://superuser.com/questions/504733/how-to-make-vim-change-a-date-when-a-section-of-a-file-was-edited
    if !&modified || &filetype == 'vim' || (&filetype != 'python' && &filetype != 'sh')
        return
    endif

    let l:today=system("echo -n $(jdate +'%Y-%m-%d %H:%M:%S %Z %A') 2>/dev/null")  " JUMP_1 -n is needed to get rid of the annoying trailing ^@
    " use date if, for any reason, jdate fails
    if today !~ '.*day'
        let l:today=system("echo -n $(date +'%Y-%m-%d %H:%M:%S %Z %A') 2>/dev/null")  " JUMP_1 -n is needed to get rid of the annoying trailing ^@
    endif

    let l:dest_line_pattern='## @last-modified '

    " save current cursor position
    let l:lnum = line('.')
    let l:col  = col('.')

    if search(dest_line_pattern, 'w')
        let l:line1 = getline('.')
        if line1 =~ today
            call cursor(lnum, col)  " restore cursor position
            return
        endif
        let l:line2 = substitute(line1,
                               \dest_line_pattern . '.*',
                               \dest_line_pattern . today,
                               \'')
        call setline('.', line2)
    endif

    call cursor(lnum, col)  " restore cursor position
endfunction
command! LastModified :call LastModified()
" }}}
function! MatchTodoInSh()  " {{{
    match TodoInSh /\<\(TODO\|TEMPORARY\|FIXME\|NOTE\|JUMP_[0-9]\+\)\>/
endfunction
command! MatchTodoInSh :call MatchTodoInSh()
" }}}
function! MyFoldText() " {{{ https://stackoverflow.com/questions/5983396/change-the-text-in-folds
    let l:lines_count = v:foldend - v:foldstart + 1
    if     strlen(lines_count) == 1
        let l:lines_count = '  ' . lines_count
    elseif strlen(lines_count) == 2
        let l:lines_count = ' ' . lines_count
    endif
    let l:comment = substitute(getline(v:foldstart), "^[^a-zA-Z0-9]* *", "", 1)
    let l:comment = substitute(comment,              " *[^a-zA-Z0-9)'\\]]* *\{\{\{.*",  "", 1)
    let l:txt     = lines_count . ' ' . comment                    " ^^ why had to use \\] instead of \] ?
    return txt
endfunction
" }}}
" {{{ function! s:QuickfixToggle()  " https://github.com/nvie/vimrc/blob/master/vimrc
let g:quickfix_is_open = 0
function! s:QuickfixToggle()  " ## TODO what doses it do exatly?
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        exec g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
command! QuickfixToggle :call <SID>QuickfixToggle()
" }}}
function! RestoreCursorPosition() " {{{ https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
command! RestoreCursorPosition :call RestoreCursorPosition()
" }}}
function! Run() " {{{
    if &filetype != "python" && &filetype != "sh"
        PrintfWarning 'Invalid file type'
        return
    endif

    if exists('$TMUX')
        " in tmux pane below (https://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim)
        call system("tmux split-window -v -p 40")  " open pane below (add -d to prevent from jumping to the pane), -p 40 is pane size
        call system("sleep .2; tmux send-keys '" . expand('%:p') . "' ENTER")
    else
        " in split below:
        :w | below terminal %
        " previously:
        " :w
        " !clear; sleep .5; %
    endif
endfunction
command! Run :call Run()
" }}}
function! RemoveCommentsAndEmptyLines()  " {{{
    :g/^ *#/d|g/^$/d
endfunction
command! RemoveCommentsAndEmptyLines :call RemoveCommentsAndEmptyLines()
" }}}
function! SudoWrite()  " {{{ https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission/
    :exec ':silent w !sudo tee %:p >/dev/null'
endfunction
command! SudoWrite :call SudoWrite()
" }}}
function! SyntaxAttribute()  " {{{
    call SyntaxAttr()
endfunction
command! SyntaxAttribute :call SyntaxAttribute()
" }}}
function! ToggleEncode()  " {{{ https://vim.fandom.com/wiki/How_to_obscure_text_instantaneously
    normal! ggg?G``
endfunction
command! ToggleEncode :call ToggleEncode()
" }}}
function! ToggleJedi()  " {{{ JUMP_3
    if g:jedi#show_call_signatures == 2
        let g:jedi#show_call_signatures = 0
        PrintfMsg 'jedi is off'
    else
        let g:jedi#show_call_signatures = 2  " 2 shows call signatures in the command line instead of a popup window2
        PrintfMsg 'jedi is on'
    endif
endfunction
command! ToggleJedi :call ToggleJedi()
" }}}
function! TyperStart(file) " {{{
    set wrap  " FIXME does not work
    set nohlsearch
    set showtabline=0
    let g:better_whitespace_enabled=0
    :IlluminationDisable
    au InsertLeave * hi CursorLine ctermbg=none
    exec "Typer " . a:file
endfunction
command! -nargs=1 TyperStart :call TyperStart(<f-args>)
" }}}
function! Watch() " {{{
    if &filetype != "python" && &filetype != "sh"
        PrintfWarning 'Invalid file type'
        return
    endif

    let l:current_file = expand('%:p')
    if current_file == '/home/nnnn/scripts/0-test' || current_file == '/home/nnnn/scripts/0-test.py'
        let l:permission = 'true'
    else
        let l:permission = confirm("Not a 0-test{.py} file. Run anyway?", "&Yes\n&No")
    endif

    let l:if_watch = system("pgrep -a 'watch' | grep '" . current_file . "'")  " -a makes it list all data and not just the pid
    if if_watch != ''
        let l:permission = 'false'
        PrintfWarning 'Watch already running'
    endif

    if permission == 'true' || permission == '1'
        if exists('$TMUX')
            " in tmux pane below (https://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim)
            call system("tmux split-window -v -d -p 40")  " open pane below (-d prevents from jumping to the pane), -p 40 is pane size
            call system("tmux send-keys -t 2 'watch " . expand('%:p') . "' ENTER")  " -t 2 means pane 2
        else
            " in split below:
            :w | below terminal echo %:p
        endif
    endif
endfunction
command! Watch :call Watch()
" }}}
" {{{ function! WordsFrequency() (https://vim.fandom.com/wiki/Word_frequency_statistics_for_a_file)
" Sorts numbers in ascending order.
" Examples:
" [2, 3, 1, 11, 2] --> [1, 2, 2, 3, 11]
" ['2', '1', '10','-1'] --> [-1, 1, 2, 10]
function! Sorted(list)
    " Make sure the list consists of numbers (and not strings)
    " This also ensures that the original list is not modified
    let nrs = ToNrs(a:list)
    let sortedList = sort(nrs, "NaturalOrder")
    " echo sortedList
    return sortedList
endfunction

" Comparator function for natural ordering of numbers
function! NaturalOrder(firstNr, secondNr)
    if a:firstNr < a:secondNr
        return -1
    elseif a:firstNr > a:secondNr
        return 1
    else
        return 0
    endif
endfunction

" Coerces every element of a list to a number. Returns a new list without modifying the original list.
function! ToNrs(list)
    let nrs = []
    for elem in a:list
        let nr = 0 + elem
        call add(nrs, nr)
    endfor
    return nrs
endfunction

function! WordsFrequency() range
    " Words are separated by whitespace or punctuation characters
    let l:wordSeparators = '[[:blank:][:punct:]]\+'
    let l:allWords = split(join(getline(a:firstline, a:lastline)), wordSeparators)
    let l:wordToCount = {}
    for word in allWords
        let l:wordToCount[word] = get(wordToCount, word, 0) + 1
    endfor

    let l:countToWords = {}
    for [word,cnt] in items(wordToCount)
        let l:words = get(countToWords,cnt,"")
        " Append this word to the other words that occur as many times in the text
        let l:countToWords[cnt] = words . " " . word
    endfor

    " Create a new buffer to show the results in
    new
    setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20

    " List of word counts in ascending order
    let l:sortedWordCounts = Sorted(keys(countToWords))

    call append("$", "count    words")
    call append("$", "--------------")
    " Show the most frequent words first -> Descending order
    for cnt in reverse(sortedWordCounts)
        let l:words = countToWords[cnt]
        call append("$", cnt . "    " . words)
    endfor
endfunction
command! -range=% WordsFrequency <line1>,<line2>call WordsFrequency()
" }}}

function! PrintfMsg(msg)  " {{{
  echohl Identifier
  echo a:msg
  echohl None
endfunction
command! -nargs=1 PrintfMsg :call PrintfMsg(<f-args>)
" }}}
function! PrintfWarning(msg)  " {{{
  echohl WarningMsg
  echo 'Warning '
  echohl Identifier
  echon a:msg
  echohl None
endfunction
command! -nargs=1 PrintfWarning :call PrintfWarning(<f-args>)
" }}}
" }}}
" {{{ plugins
" {{{ better-whitespace
let g:better_whitespace_ctermcolor = 24
" }}}
" {{{ commentary
au FileType php,html         setlocal commentstring=<!--\ %s\ -->
au FileType css,javascript   setlocal commentstring=/*\ %s\ */
au FileType c,cpp,java,scala setlocal commentstring=//\ %s
au FileType sh,ruby,python   setlocal commentstring=#\ %s
au FileType conf,fstab,tmux  setlocal commentstring=#\ %s
au FileType text             setlocal commentstring=#\ %s
au FileType tex              setlocal commentstring=%\ %s
au FileType mail             setlocal commentstring=>\ %s
au FileType vim              setlocal commentstring=\"\ %s
au FileType lua              setlocal commentstring=--\ %s
" }}}
" {{{ CtrlXA
silent! nmap <unique>  <C-X> <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>  <C-A> <Plug>(CtrlXA-CtrlX)
silent! xmap <unique>  <C-X> <Plug>(CtrlXA-CtrlA)
silent! xmap <unique>  <C-A> <Plug>(CtrlXA-CtrlX)
silent! xmap <silent> g<C-X> <Plug>(CtrlXA-gCtrlA)
silent! xmap <silent> g<C-A> <Plug>(CtrlXA-gCtrlX)
" }}}
" {{{ easymotion JUMP_5
map f <Plug>(easymotion-bd-w)
map F <Plug>(easymotion-s2)
let g:EasyMotion_keys = 'hklyuiopnmqwertzxcvbasdgjf'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 0
" }}}
" {{{ fzf
noremap `  :Marks<CR>
noremap :: :History:<CR>
noremap ;; :History:<CR>
noremap // :History/<CR>

noremap  <C-l>      :BLines<CR>
inoremap <C-l> <C-o>:BLines<CR>

noremap  <C-\>      :Maps<CR>
inoremap <C-\> <C-o>:Maps<CR>
" }}}
" {{{ illuminate JUMP_4
hi WordUnderCursorTheme ctermbg=235
hi link illuminatedWord WordUnderCursorTheme
" }}}
" {{{ jedi JUMP_3
hi def jediFat       ctermbg=none ctermfg=67   cterm=none
hi def jediUsage     ctermbg=5    ctermfg=0    cterm=none
hi def jediFunction  ctermbg=none ctermfg=none cterm=none
hi def jediFatSymbol ctermbg=202  ctermfg=202  cterm=none

let g:jedi#goto_assignments_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#call_signatures_command = ""
let g:jedi#usages_command = "<leader>u"
let g:jedi#documentation_command = "<Leader>k"
let g:jedi#rename_command = ""
let g:jedi#show_call_signatures = 2  " 2 shows call signatures in the command line instead of a popup window
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#popup_on_dot = 0
let g:pymode_rope = 0
" }}}
" {{{ mucomplete
set completeopt-=preview  " disable doc preview in omnicomplete
set completeopt+=menuone
set completeopt+=noinsert
set complete=.,w,b,u,t
" set complete+=k~/bgls/words  " use C-n to access suggestions (https://superuser.com/questions/102343/can-i-add-a-set-of-words-to-the-vim-autocomplete-vocabulary)
" }}}
" {{{ multiple-cursors
hi multiple_cursors_cursor term=reverse ctermfg=0 ctermbg=yellow
" }}}
" {{{ python-mode
let g:pymode_run = 0
let g:pymode_run_bind = ""
let g:pymode_breakpoint_bind = ""
let g:pymode_options_max_line_length = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_lint_on_write = 0
let g:pymode_warning = 0
let g:pymode_indent = 0
" newly added:
let g:pymode_virtualenv = 0
let g:pymode_motion = 0
let g:pymode_doc = 0
let g:pymode_breakpoint = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_lint_ignore = ["E501", "C901", "E252", "E266", "E262"]
" ^^ for example ['W', 'E271'] (Skip all Warnings and the Errors starting with E271)
" E271 multiple spaces after keyword (e.g. after if)
" E221 multiple spaces before operator (e.g. before =)
" C901 <FUNCTION> is too complex
" E401 multiple imports on one line
" E501 line too long
" E252 missing whitespace around parameter equals
" E266 too many leading '#' for block comment
" E262 inline comment should start with '# '

" JUMP_7
au FileType python noremap  <F9>      :PymodeLint<CR><C-w><Down>
au FileType python inoremap <F9> <Esc>:PymodeLint<CR><C-w><Down>
" }}}
" {{{ python-syntax
let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1
" }}}
" {{{ signify  if you remove this plugin, remember to enable syntastic signs back in JUMP_2
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '¯'
let g:signify_sign_change            = '×'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line

highlight SignifySignAdd    ctermfg=2   cterm=none
highlight SignifySignDelete ctermfg=1   cterm=none
highlight SignifySignChange ctermfg=202 cterm=none

" https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
exec "set <M-j>=\ej"
exec "set <M-k>=\ek"
exec "set <M-d>=\ed"
exec "set <M-h>=\eh"
exec "set <M-u>=\eu"
exec "set <M-t>=\et"
exec "set <M-f>=\ef"
exec "set <M-r>=\er"

nmap    <silent> <M-j> <plug>(signify-next-hunk)
nmap    <silent> <M-k> <plug>(signify-prev-hunk)
noremap <silent> <A-d> :SignifyDiff<CR>
noremap <silent> <A-h> :SignifyHunkDiff<CR>
noremap <silent> <A-u> :SignifyHunkUndo<CR>
noremap <silent> <A-t> :SignifyToggle<CR>
noremap <silent> <A-f> :SignifyFold<CR>
noremap <silent> <A-r> :SignifyRefresh<CR>

autocmd User SignifyHunk call s:show_current_hunk()
function! s:show_current_hunk() abort
    let l:h = sy#util#get_hunk_stats()
    if !empty(h)
        redraw
        echohl ModeMsg
        echo printf(' %d/%d', h.current_hunk, h.total_hunks)
        echohl Identifier
        echon ' hunk'
        echohl None
    endif
endfunction

"}}}
" {{{ sparkup
let g:sparkupExecuteMapping = '<S-Tab>'
" }}}
" {{{ syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 0  " JUMP_2 signs by signify clobber these so better get disabled
let g:syntastic_error_symbol = 'ER'
let g:syntastic_style_error_symbol = 'SE'
let g:syntastic_warning_symbol = 'WE'
let g:syntastic_style_warning_symbol = 'SW'
let g:syntastic_stl_format = 'SYNTAX:L%F[%t]'
" let g:syntastic_auto_jump = 1
hi SyntasticErrorSign ctermfg=1 ctermbg=none cterm=none
hi SyntasticError     ctermfg=0 ctermbg=1    cterm=none
" }}}
" {{{ ultisnips JUMP_6
let g:UltiSnipsListSnippets = '<F10>'
" }}}
" {{{ undotree
let g:undotree_SplitWidth = 12
let g:undotree_WindowLayout = 1
let g:undotree_DiffAutoOpen = 0
let g:undotree_ShortIndicators = 1
let g:undotree_HighlightChangedText = 0
let g:undotree_HelpLine = 0
" }}}
" {{{ GitGutter
" exec "set <M-j>=\ej"
" exec "set <M-k>=\ek"
" nmap <silent> <M-j> :GitGutterPrevHunk<CR>
" nmap <silent> <M-k> :GitGutterNextHunk<CR>

" exec "set <M-p>=\ep"
" noremap <silent> <A-p> :GitGutterPreviewHunk<CR>

" exec "set <M-u>=\eu"
" noremap <silent> <A-u> :GitGutterUndoHunk<CR>

" exec "set <M-t>=\et"
" noremap <silent> <A-t> :GitGutterToggle<CR>

" exec "set <M-f>=\ef"
" noremap <silent> <A-f> :GitGutterFold<CR>

" exec "set <M-r>=\er"
" noremap <silent> <A-r> :GitGutter<CR>

" exec "set <M-s>=\es"
" noremap <silent> <A-s> :GitGutterStageHunk<CR>

" function! GitGutterStatus()
"   let [a, m, r] = GitGutterGetHunkSummary()
"   if a > 0 || m > 0 || r > 0
"     return printf('+%d -%d ×%d', a, r, m)
"   else
"     return ''
"   endif
" endfunction

" let g:gitgutter_map_keys = 0
" let g:gitgutter_sign_allow_clobber = 1
" let g:gitgutter_sign_added              = '+'
" let g:gitgutter_sign_modified           = '×'
" let g:gitgutter_sign_removed            = '-'
" let g:gitgutter_sign_removed_first_line = '¯'
" let g:gitgutter_sign_removed_above_and_below = '¯_'
" let g:gitgutter_sign_modified_removed   = '×-'

" highlight GitGutterAdd    ctermfg=2
" highlight GitGutterChange ctermfg=202
" highlight GitGutterDelete ctermfg=1
" }}}
" }}}


" {{{ MISC
" number of windows in the current buffer
" winnr("$")

" try
"     source ~/.vim/vim_config.vim
" catch
" endtry

" expand('%')     " /home/nnnn/.vimrc
" expand('%:p')   " /home/nnnn/.vimrc
" expand('%:h')   " /home/nnnn
" expand('%:p:h') " /home/nnnn
" expand('%:t')   " .vimrc
" expand('%:r')   " (extension e.g. py)

" winwidth('%')    " 139
" winheight('%')   " 34
" winline()        " 12 (12th line from the top of screen)

" let l:cur_column = col(".")

" echo localtime()  ## 1640082085

" substitute (https://github.com/ppwwyyxx/dotvim/blob/master/vimrc)
" set statusline+=%{substitute(getcwd(),expand(\"$HOME\"),\'+\',\'g\')}

" au BufEnter * if &buftype == 'help' | wincmd L | endif  " display help window on vertically. do NOT change BufEnter

" if exists('$TMUX')
" if exists('g:breaker_map_cr_omni_complete')
" if exists("variable")
" if exists(":command")
" if exists("+option")
" if system('uname -s') == 'Darwin\n'
" if filereadable(expand("~/.vimrc.local"))
" if isdirectory(expand("~/.vim/bundle/nerdtree"))
" if count(g:breaker_bundle_groups, 'youcompleteme')  " what does it do?

" use a function output in another function (https://stackoverflow.com/questions/48271865/vim-whats-the-best-way-to-set-statusline-color-to-change-based-on-mode):
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" noremap <Leader>h :HighlightWords <C-r>=expand("<cword>")<CR><CR>

" prevent cursor from jumping when wrap is enabled (https://nvie.com/posts/how-i-boosted-my-vim/)
" map k gk
" map j gj

" trigger mucomplete
" imap <c-j> <plug>(MUcompleteFwd)
" imap <c-k> <plug>(MUcompleteBwd)

" show syntax highlighting attribute of current word (https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor):
" map <Leader>a :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" to be able to use tab completion in command mode (https://vi.stackexchange.com/questions/11974/autocompletion-in-command-line-search)
" cmap <Tab> <C-f>a<Tab>

" prvent cursor from jumping to next occurrence when pressing * (https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches)
" nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>

" for s:path in split(glob('~/.vim/vimrc/*.vim'), "\n")
"     exe 'source ' . s:path
" endfor

" https://github.com/theniceboy/nvim/blob/master/init.vim
" if empty(glob('~/.config/nvim/autoload/plug.vim'))

" Tell vim to remember certain things when we exit (https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session)
" '10  :  marks will be remembered for up to 10 previously edited files
" "100 :  will save up to 100 lines for each register
" :20  :  up to 20 lines of command-line history will be remembered
" %    :  saves and restores the buffer list
" n... :  where to save the viminfo files
" set viminfo='10,\"100,:20,%,n~/.viminfo

" disable arrow keys for normal mode
" noremap <up>    <Nop>
" noremap <down>  <Nop>
" noremap <left>  <Nop>
" noremap <right> <Nop>

" Identifier
" WarningMsg
" ModeMsg
" MoreMsg
" ErrorMsg

" function! Paste()  " {{{
"     let l:pa_index = &paste
"     if pa_index == 0
"         hi link PasteColor lite_inactive
"     else
"         hi link PasteColor lite
"     endi
"     return "PASTE"
" endfunction
" }}}
" function! HeaderPython()  " {{{ https://github.com/gatieme/vimrc/blob/master/vim/vimrc
"     call setline(1,          '#!/usr/bin/env python')
"     call append(line("."),   '')
"     call append(line(".")+1, '#####################################')
"     call append(line(".")+2, '# File Name: ' . expand("%"))
"     call append(line(".")+3, '# Created Time: ' . strftime("%c"))  " Mon 22 Nov 2021 03:51:10 PM +0330
"     call append(line(".")+4, '#####################################')
"     call append(line(".")+5, '')
"     normal G
"     normal o
" endf
" }}}
" function! ReplaceChn()  " {{{ https://github.com/ppwwyyxx/dotvim/blob/master/vimrc
"     let l:chinese={"（" : "(" , "）" : ")" , "，" : ",", "；" : ";", "：" : ":",
"     "？" : "?", "！" : "!", "“" : "\"", "’" : "'" ,
"     ""”" : "\"", "℃" : "\\\\textcelsius", "μ" : "$\\\\mu$"}
"     for i in keys(chinese)
"         silent! exec '%substitute/' . i . '/'. chinese[i] . '/g'
"     endfor
" endfunction
" nnoremap <leader>sch :call ReplaceChn()<cr>
" }}}
" function! s:AskToExpandAbbr(abbr, expansion, defprompt)  " {{{ https://vim.fandom.com/wiki/Abbreviation_that_prompts_whether_to_expand_it_or_not
"   let l:answer = confirm("Expand '" . a:abbr . "'?", "&Yes\n&No", a:defprompt)
"   " testing against 1 and not 2, I correctly take care of <abort>
"   return answer == 1 ? a:expansion : a:abbr
" endfunction
" iabbrev <expr> for <SID>AskToExpandAbbr('for', "for () {\n}", 2)
" }}}
" function! SyntAttr()  " {{{ https://www.reddit.com/r/vim/comments/e19bu/whats_your_status_line/
"     let l:name = synIDattr(synID(line('.'),col('.'),1),'name')
"     if name == ''
"         hi link SyntAttrColor dark_inactive
"         let l:synt_attr = 'SYNT-ATTR'
"     else
"         hi link SyntAttrColor dark
"         let l:synt_attr = name
"     endif
"     return synt_attr
" endfunction
" }}}
" function! TrailingWhiteSpace()  " {{{
"     if search('\s\+$', 'nw') != 0
"         hi link TrailingWhiteSpaceColor dark
"     else
"         hi link TrailingWhiteSpaceColor dark_inactive
"     endif
"     return 'TWS'
" endfunction
" }}}
" function! Replace()  " {{{ Search for <cword> and replace with input() in all open buffers (https://github.com/vgod/vimrc/blob/master/vimrc)
"     let s:word = input("Replace " . expand('<cword>') . " with:")
"     :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
"     :unlet! s:word
" endfunction
"}}}
" {{{ users
" hi User1 ctermbg=7   ctermfg=none
" hi User2 ctermbg=3   ctermfg=16
" hi User3 ctermbg=1   ctermfg=7
" hi User2 ctermbg=239 ctermfg=black
" hi User3 ctermbg=244 ctermfg=black
" hi User4 ctermbg=244 ctermfg=239
" hi User5 ctermbg=239 ctermfg=244
" hi User6 ctermbg=234 ctermfg=239
" hi User7 ctermbg=239 ctermfg=1
" hi User8 ctermbg=234 ctermfg=244
" hi User9 ctermbg=234 ctermfg=black
" }}}
" }}}
