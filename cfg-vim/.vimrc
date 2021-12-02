start  " {{{
syntax on
colorscheme gruvbox  " gruvbox8_hard
let mapleader = " "
" let &showbreak="\u21aa" " Show a left arrow (↪) when wrapping text
" let &titlestring= $USER . '@' . hostname() . ' : %F %r: VIM %m'
" set title
" set updatetime=2000  " Write swap files to disk and trigger CursorHold event faster (default is after 4000 ms of inactivity)
" set showcmd  " Show partial commands in the last line of the screen
" set backspace=indent,eol,start  " Allow backspacing over autoindent, line breaks and start of insert action
" set timeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings
" set showtabline=2  " always show tab bar
" set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
" set signcolumn=yes
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

hi dark_i ctermfg=235 ctermbg=none cterm=none
hi lite_i ctermfg=235 ctermbg=none cterm=none

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
set stl+=%#dark#
let &stl.="%2.2(%{matchstr(getline('.'), '\\%' . col('.') . 'c.')}%)"  " https://stackoverflow.com/questions/40508385/vim-statusline-show-the-character-itself
set stl+=%#lite#\ C:\ %v/%{strlen(getline('.'))}\ %o/%{line2byte(line('$')+1)-1}
set stl+=%#dark#\ L:\ %l/%L
set stl+=%#lite#\ W:\ %{wordcount().words}  " %p%%
set stl+=%#IndentLevelColor#\ %{IndentLevel()}
set stl+=%#lite#\ %{Uptime(2)}
set stl+=%#TFTBColor#\ %{TFTB()}
set stl+=%#ModifiedColor#\ %{Modified()}
set stl+=%#CurrentTagColor#\ %{CurrentTag()}
set stl+=%#SyntasticColor#\ %{CheckSyntax()}  " or SyntasticStatuslineFlag()
set stl+=%#ReadonlyColor#\ %{ReadOnly()}
set stl+=%#lite#
" set stl+=%*  " reset color
set stl+=%=
set stl+=%#dark#\ %F  " %t for basename only
set stl+=%#lite#\ %{strlen(&ft)?&ft:'none'}  " https://github.com/einverne/dotfiles/blob/master/.vimrc OR %{''!=#&filetype?&filetype:'none'}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
set stl+=%#dark#\ %{FileSize()}
set stl+=%#lite#\ %{getfperm(expand('%:p'))}
set stl+=%#CurrentModeColor#\ ▮
" set stl+=%{&fileencoding?&fileencoding:&encoding}
" set stl+=\ ascii:%03b\ hex:0x%04B
" set stl+=%{&ff}  " file format, e.g. unix
" set stl+=%{v:register}  " active register
" }}}
" abbreviations {{{
iabbrev writedatetime <c-r>=strftime('%Y%m%d%H%M%S')<CR>
" }}}
" maps {{{
" {{{ F1-10
" write
noremap  <F1>      :q!<CR>
inoremap <F1> <C-o>:q!<CR>

" quit
noremap  <F2>      :w<CR>
inoremap <F2> <C-o>:w<CR>

" write+quit
noremap  <F3>      :wq<CR>
inoremap <F3> <C-o>:wq<CR>

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

" python-mode
au FileType python noremap  <F9>      :PymodeLint<CR><C-w><Down>
au FileType python inoremap <F9> <Esc>:PymodeLint<CR><C-w><Down>

" ultisnips
let g:UltiSnipsListSnippets = "<F10>"

" watch
noremap  <F12>      :Watch<CR>
inoremap <F12> <C-o>:Watch<CR>
" }}}
" jump to prev/next function (https://vim.fandom.com/wiki/Jumping_to_the_start_and_end_of_a_code_block)
au FileType python noremap { :silent eval search('^ *def ',      'b')<CR>
au FileType python noremap } :silent eval search('^ *def '          )<CR>
au FileType sh     noremap { :silent eval search('^ *function ', 'b')<CR>
au FileType sh     noremap } :silent eval search('^ *function '     )<CR>

noremap <Leader>0 :ToggleJedi<CR>
noremap <Leader>1 :set list!<Bar>set relativenumber!<Bar>set invnumber<CR>
noremap <Leader>2 :TagbarToggle<CR>
noremap <Leader>3 :ToggleWhitespace<CR>
noremap <Leader>4 :UndotreeToggle<CR>
noremap <Leader>5 :MUcompleteAutoToggle<CR>
noremap <Leader>6 :SyntasticToggleMode<CR>
noremap <Leader>7 :SignatureToggleSigns<CR>
noremap <Leader>8 :IlluminationToggle<CR>
noremap <Leader>9 :DimInactiveToggle<CR>

noremap <Leader>a :AscendingNumbers END
noremap <Leader>b  :Black<CR>
noremap <Leader>bd :BlackDiff<CR>
noremap <Leader>c :CountCurrentWord<CR>
" toggle encode (https://vim.fandom.com/wiki/How_to_obscure_text_instantaneously):
noremap <Leader>e ggg?G``
noremap <Leader>f :FZF<CR>
noremap <Leader>h :HighlightLinesToggle<CR>
noremap <Leader>s :call SyntaxAttr()<CR>
noremap <Leader>t :TyperStart FILEPATH
noremap <Leader>q :QuickfixToggle<CR>
noremap <Leader>w :WordsFrequency<CR>
noremap <Leader>r :RenameTmuxWindow<CR>

" show help on current word in preview window (https://github.com/llh911001/vimrc/blob/master/.vimrc)
noremap <silent> K :execute 'help ' . expand('<cword>')<CR>

noremap ` :ShowMarks<CR>

" https://vim.fandom.com/wiki/Smart_home
noremap <expr>   <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap    <silent> <Home> <C-O><Home>
" noremap <expr>   <End>  (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
" imap             <End>  <C-o><End>
" vnoremap <expr>  <End>  (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')

noremap <C-y> :CopyToClipboard<CR>

" insert new line below without leaving normal mode (https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode)
nnoremap <C-o> o<Esc>k

" sudo write (https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission/)
command! SW :execute ':silent w !sudo tee %:p > /dev/null'

" bring the current line to top/middle/bottom of screen
noremap  TT      zt
noremap  MM      zz
noremap  BB      zb
inoremap TT <C-o>zt
inoremap MM <C-o>zz
inoremap BB <C-o>zb

" insert single character in normal mode (https://vim.fandom.com/wiki/Insert_a_single_character):
nnoremap <C-i> :exec "normal i".nr2char(getchar())."\e"<CR>
" nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" clear highlighted matches (https://nvie.com/posts/how-i-boosted-my-vim/):
noremap <silent> <CR> :nohlsearch<CR>
" toggle highlighting on/off (https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches):
" noremap <silent> <CR> :set hlsearch! hlsearch?<CR>

" prevent x from screwing-up last yanked string (❗ do NOT change the noremap)
noremap x "_x

" easymotion
map f <Plug>(easymotion-bd-w)
map F <Plug>(easymotion-s2)

" change/delete whole word no matter where the cursor is
noremap cw caw
noremap dw daw

nnoremap Y y$

" redo
map U <C-r>

noremap b B
noremap w W

noremap J J<Home>

map ; :
" }}}
" au & hi {{{
" au VimEnter * :vertical resize +9  " widen main split so undotree split occupies less space
" vv needed because restore_view.vim opens buffer with current fold open
au vimEnter    *  RestoreCursorPosition
au VimEnter    *  normal zM
au VimEnter    *  normal zz
au VimEnter    *  set noshowmode
au VimEnter    *  UndotreeShow
au InsertEnter *  hi CursorLineNr ctermbg=none ctermfg=4  cterm=none
au InsertLeave *  hi CursorLineNr ctermbg=none ctermfg=235 cterm=none
au InsertEnter *  hi CursorLine   ctermbg=none
au InsertLeave *  hi CursorLine   ctermbg=233
au BufWritePre * :call LastModified()
au FileType    sh MatchTodoInSh
" run selection:
au FileType sh     vnoremap <leader>v :w  !source %:p; bash<CR>
au FileType python vnoremap <leader>v :w  !source %:p; python<CR>
" run current line:
au FileType sh      noremap <leader>. :.w !source %:p; bash<CR>
au FileType python  noremap <leader>. :.w !source %:p; python<CR>

hi Comment      cterm=italic
hi Search       ctermbg=none cterm=underline
hi Normal       ctermbg=none
hi SignColumn   ctermbg=none
hi StatusLine   ctermbg=none ctermfg=12  cterm=none
hi StatusLineNC ctermbg=none ctermfg=235 cterm=none
hi LineNr       ctermbg=none ctermfg=235 cterm=none
hi CursorColumn ctermbg=233
hi VertSplit    ctermfg=4
hi TodoInSh     ctermbg=none ctermfg=246 cterm=italic,bold

" jedi
hi def jediFat       ctermbg=none ctermfg=67   cterm=none
hi def jediUsage     ctermbg=5    ctermfg=0    cterm=none
hi def jediFunction  ctermbg=none ctermfg=none cterm=none
hi def jediFatSymbol ctermbg=202  ctermfg=202  cterm=none

" illuminate
hi WordUnderCursorTheme ctermbg=235
hi link illuminatedWord WordUnderCursorTheme
" }}}
" functions {{{
function! CurrentMode() " {{{
    let currentmode = mode()
    if currentmode == "i"
        hi link CurrentModeColor lite
        return "INSERT"
    elseif currentmode == "n"
        hi link CurrentModeColor normal_mode
        return "NORMAL"
    elseif currentmode == "v"
        hi link CurrentModeColor visual_mode
        let selected_bytes = wordcount().visual_bytes
        let selected_words = wordcount().visual_words
        return "VISUAL " . selected_bytes . " " . selected_words
    elseif currentmode == "r"
        hi link CurrentModeColor replace_mode
        return "REPLACE"
    elseif currentmode == "c"
        hi link CurrentModeColor command_mode
        return "COMMAND"
    elseif currentmode == "t"
        hi link CurrentModeColor terminal_mode_color
        return "TERMINAL"
    elseif currentmode == "s"
        hi link CurrentModeColor select_mode_color
        return "SELECT"
    elseif currentmode == "!"
        hi link CurrentModeColor shell_mode_color
        return "SHELL"
    elseif currentmode == +"v"  " put lower than replace
        hi link CurrentModeColor visual_mode
        let selected_bytes = wordcount().visual_bytes
        let selected_words = wordcount().visual_words
        return "VISUAL-BLOCK " . selected_bytes . " " . selected_words
    endif
endfunction
" }}}
function! IndentLevel() " {{{ https://vim.fandom.com/wiki/Put_the_indentation_level_on_the_status_line
    if &filetype == "python"
        let TabLevel = (indent(".") / &ts )
        hi link IndentLevelColor dark
        return TabLevel
    else
        hi link IndentLevelColor dark_i
        return "0"
    endif
endfunction
" }}}
function! TFTB() " {{{ https://stackoverflow.com/questions/66051261/how-to-the-display-the-number-of-instances-of-a-string-in-vim-statusline/
    if &filetype != "vim"
        let lines = getline(1, '$')
        let todos = filter(lines, 'v:val =~? "TODO"')

        let lines = getline(1, '$')
        let fixmes = filter(lines, 'v:val =~? "FIXME"')

        let lines = getline(1, '$')
        let tempos = filter(lines, 'v:val =~? "TEMPORARY"')

        let lines = getline(1, '$')
        let breaks = filter(lines, 'v:val =~? "breakpoint()"')

        let todos_count  = len(todos)
        let fixmes_count = len(fixmes)
        let tempos_count = len(tempos)
        let breaks_count = len(breaks)

        if todos_count > 0 || fixmes_count > 0 || tempos_count > 0 || breaks_count > 0
            hi link TFTBColor dark
            let all = todos_count . " " . fixmes_count . " " . tempos_count . " " . breaks_count
        else
            hi link TFTBColor dark_i
            let all = "TFTB"
        endif

    else
        hi link TFTBColor dark_i
        let all = "TFTB"
    endif
    return all
endfunction
" }}}
function! Modified() " {{{
    let mo_index = &modified
    if mo_index == 0
        hi link ModifiedColor lite_i
    else
        hi link ModifiedColor lite
    endi
    return "MO"
    " set statusline+=%#ModifiedColor#%{&modified?'\ \ X':''}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
endfunction
" }}}
function! CurrentTag() " {{{
    let text = tagbar#currenttag("%s","","f","scoped-stl")
    if len(text) == 0 || &filetype != "python"
        hi link CurrentTagColor dark_i
        let text = "TA"
    else
        hi link CurrentTagColor dark
    endif
    return text
endfunction
" }}}
function! CheckSyntax() " {{{
   let error_text = SyntasticStatuslineFlag()
   if len(error_text) == 0
       hi link SyntasticColor lite_i
       let text = "ER"
   else
       hi link SyntasticColor lite
       let text = error_text
   endif
   return text
endfunction
" }}}
function! ReadOnly() " {{{
    let ro_index = &readonly
    if ro_index == 0
        hi link ReadonlyColor dark_i
    else
        hi link ReadonlyColor dark
    endi
    return "RE"
    " set statusline+=%#ReadonlyColor#%{&readonly?'\ \ LOCKED':''}  " https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/?st=jc4oipo5&sh=d41a21b1
endfunction
" }}}
function! FileSize() " {{{ https://github.com/sd65/MiniVim/blob/master/vimrc
    let bytes = getfsize(expand('%:p'))
    if bytes <= 0
        return '0B'
    elseif bytes > 1024000000
       return (bytes / 1024000000) . 'GB'
    elseif bytes > 1024000
       return (bytes / 10241000) . 'MB'
    elseif bytes > 1024
       return (bytes / 1024) . 'KB'
    else
       return bytes . 'B'
    endif
endfunction
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

function! CountCurrentWord() " {{{ https://stackoverflow.com/questions/11492258/find-number-of-occurrences-of-word-under-cursor
    :execute ":%s@\\<" . expand("<cword>") . "\\>\@&@gn"
endfunction
command! CountCurrentWord :call CountCurrentWord()
" }}}
function! ToggleJedi() " {{{
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
function! MyFoldText() " {{{ https://stackoverflow.com/questions/5983396/change-the-text-in-folds
    let lines_count = v:foldend - v:foldstart + 1
    if     strlen(lines_count) == 1
        let lines_count = '  ' . lines_count
    elseif strlen(lines_count) == 2
        let lines_count = ' ' . lines_count
    endif
    let comment = substitute(getline(v:foldstart), "^[^a-zA-Z0-9]* *", "", 1)
    let comment = substitute(comment,              " *[^a-zA-Z0-9)'\\]]* *\{\{\{.*",  "", 1)
    let txt     = lines_count . ' ' . comment                    " ^^ why had to use \\] instead of \] ?
    return txt
endfunction
" }}}
function! RestoreCursorPosition() " {{{ https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
command! RestoreCursorPosition :call RestoreCursorPosition()
" }}}
function! ShowMarks() " {{{ https://vi.stackexchange.com/questions/8451/is-it-possible-to-have-vim-show-the-list-of-available-marks-when-using-marks
    marks
    PrintfMsg 'Mark: '

    " getchar() - prompts user for a single character and returns the chars
    " ascii representation
    " nr2char() - converts ASCII `NUMBER TO CHAR'

    let s:mark = nr2char(getchar())
    " remove the `press any key prompt'
    redraw

    " build a string which uses the `normal' command plus the var holding the
    " mark - then eval it.
    execute "normal! '" . s:mark
endfunction
command! ShowMarks :call ShowMarks()
" }}}
function! TyperStart(file) " {{{
    set wrap  " FIXME does not work
    set nohlsearch
    set showtabline=0
    let g:better_whitespace_enabled=0
    :IlluminationDisable
    au InsertLeave * hi CursorLine ctermbg=none
    execute "Typer " . a:file
endfunction
command! -nargs=1 TyperStart :call TyperStart(<f-args>)
" }}}
function! AscendingNumbers(end) " {{{ https://vim.fandom.com/wiki/Making_a_list_of_numbers
    execute "put =map(range(1, " . a:end . "), 'printf(''%03d'', v:val)')"
endfunction
command! -nargs=1 AscendingNumbers :call AscendingNumbers(<f-args>)
" }}}
function! CopyToClipboard() " {{{ copy yanked text to clipboard (https://github.com/ryukinix/dotfiles/blob/master/.vimrc)
    call system('xclip -selection clipboard', @0)
    PrintfMsg 'Copied to clipboard'
endfunction
command! CopyToClipboard :call CopyToClipboard()
" }}}
function! MatchTodoInSh()  " {{{
    match TodoInSh /\<\(TODO\|TEMPORARY\|FIXME\|NOTE\|JUMP_[0-9]\+\)\>/
endfunction
command! MatchTodoInSh :call MatchTodoInSh()
" }}}
function! Black() " {{{
    if &filetype == "python"
        let answer = confirm("Apply black? ", "&Yes\n&No")
        if answer == "1"
            " do NOT quote $BLACK
            execute "!clear; eval $BLACK %:p"
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
        execute "!clear; eval $BLACKDIFF %:p | less \-R"
    else
        PrintfWarning 'For python file type only'
    endif
endfunction
command! BlackDiff :call BlackDiff()
" }}}
function! Filter(string) " {{{ https://vim.fandom.com/wiki/Redirect_g_search_output
    let @a='' | execute 'g/' . a:string . '/y A' | new | setlocal bt=nofile | put! a
endfunction
command! -nargs=1 Filter :call Filter(<f-args>)
" }}}
function! InsertLineNumbers() " {{{ https://vim.fandom.com/wiki/Insert_line_numbers
    :%s/^/\=printf('%-4d', line('.'))/g
    :%s/\([0-9]\+\)\s*$/\1/g
endfunction
command! InsertLineNumbers :call InsertLineNumbers()
" }}}
" function! WordsFrequency() {{{ (https://vim.fandom.com/wiki/Word_frequency_statistics_for_a_file)
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
    let wordSeparators = '[[:blank:][:punct:]]\+'
    let allWords = split(join(getline(a:firstline, a:lastline)), wordSeparators)
    let wordToCount = {}
    for word in allWords
        let wordToCount[word] = get(wordToCount, word, 0) + 1
    endfor

    let countToWords = {}
    for [word,cnt] in items(wordToCount)
        let words = get(countToWords,cnt,"")
        " Append this word to the other words that occur as many times in the text
        let countToWords[cnt] = words . " " . word
    endfor

    " Create a new buffer to show the results in
    new
    setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20

    " List of word counts in ascending order
    let sortedWordCounts = Sorted(keys(countToWords))

    call append("$", "count    words")
    call append("$", "--------------")
    " Show the most frequent words first -> Descending order
    for cnt in reverse(sortedWordCounts)
        let words = countToWords[cnt]
        call append("$", cnt . "    " . words)
    endfor
endfunction
command! -range=% WordsFrequency <line1>,<line2>call WordsFrequency()
" }}}
" function! s:QuickfixToggle() " {{{ https://github.com/nvie/vimrc/blob/master/vimrc
let g:quickfix_is_open = 0
function! s:QuickfixToggle()  " ## TODO what doses it do exatly?
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
command! QuickfixToggle :call <SID>QuickfixToggle()
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
function! Watch() " {{{
    if &filetype != "python" && &filetype != "sh"
        PrintfWarning 'Invalid file type'
        return
    endif

    let current_file = expand('%:p')
    if current_file == '/home/nnnn/scripts/0-test' || current_file == '/home/nnnn/scripts/0-test.py'
        let permission = 'true'
    else
        let permission = confirm("Not a 0-test{.py} file. Run anyway?", "&Yes\n&No")
    endif

    let if_watch = system("pgrep -a 'watch' | grep '" . current_file . "'")  " -a makes it list all data and not just the pid
    if if_watch != ''
        let permission = 'false'
        PrintfWarning 'Watch already running'
    endif

    if permission == 'true' || permission == '1'
        if exists('$TMUX')
            " in tmux pane below (https://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim)
            call system("tmux split-window -v -d -p 40")  " open pane below (-d prevents from jumping to the pane), -p 40 is pane size
            call system("tmux send-keys -t 2 'watch --interval 1 --no-title --color " . expand('%:p') . "' ENTER")  " -t 2 means pane 2
        else
            " in split below:
            :w | below terminal echo %:p
        endif
    endif
endfunction
command! Watch :call Watch()
" }}}
function! LastModified()  " {{{ https://superuser.com/questions/504733/how-to-make-vim-change-a-date-when-a-section-of-a-file-was-edited
    if !&modified || &filetype == 'vim' || (&filetype != 'python' && &filetype != 'sh')
        return
    endif

    let today=system("echo -n $(jdate +'%Y-%m-%d %H:%M:%S %Z %A') 2>/dev/null")  " JUMP_1 -n is needed to get rid of the annoying trailing ^@
    " use date if, for any reason, jdate fails
    if today !~ '.*day'
        let today=system("echo -n $(date +'%Y-%m-%d %H:%M:%S %Z %A') 2>/dev/null")  " JUMP_1 -n is needed to get rid of the annoying trailing ^@
    endif

    let dest_line_pattern='## last modified: '

    " save current cursor position
    let lnum = line('.')
    let col  = col('.')

    if search(dest_line_pattern, 'w')
        let line1 = getline('.')
        if line1 =~ today
            call cursor(lnum, col)  " restore cursor position
            return
        endif
        let line2 = substitute(line1,
                               \dest_line_pattern . '.*',
                               \dest_line_pattern . today,
                               \'')
        call setline('.', line2)
    endif

    call cursor(lnum, col)  " restore cursor position
endfunction
" }}}
function! RenameTmuxWindow() " {{{

    if exists('$TMUX')
        " sometime, for example when we open file with the command vim ~/scripts/application instead of opening it from lf,
        " base would be /home/nnnn/scripts/application which is not what we want
        " so have to do some substitution:
        let base = substitute(expand('%'), ".*/", "", 1)

        call system("tmux rename-window " . base)
    else
        PrintfWarning 'in tmux only'
    endif

endfunction
command! RenameTmuxWindow :call RenameTmuxWindow()
" }}}
" }}}
" plugins {{{
" commentary {{{
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
" mucomplete {{{
set completeopt-=preview  " disable doc preview in omnicomplete
set completeopt+=menuone
set completeopt+=noinsert
set complete=.,w,b,u,t
" set complete+=k~/bgls/words  " use C-n to access suggestions (https://superuser.com/questions/102343/can-i-add-a-set-of-words-to-the-vim-autocomplete-vocabulary)
" }}}
" syntastic {{{
let g:syntastic_check_on_open = 1
" let g:syntastic_auto_jump = 1
hi SyntasticErrorSign ctermfg=1 ctermbg=none cterm=none
hi SyntasticError     ctermfg=0 ctermbg=1    cterm=none
" }}}
" python-mode {{{
let g:pymode_run = 0
let g:pymode_run_bind = ""
let g:pymode_breakpoint_bind = ""
let g:pymode_options_max_line_length = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_lint_on_write = 0
let g:pymode_warning = 0
let g:pymode_indent = 0
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
" }}}
" jedi {{{
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
" undotree {{{
let g:undotree_SplitWidth = 11
let g:undotree_WindowLayout = 3
let g:undotree_DiffAutoOpen = 0
let g:undotree_ShortIndicators = 1
let g:undotree_HighlightChangedText = 0
" }}}
" CtrlXA {{{
silent! nmap <unique>  <C-X> <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>  <C-A> <Plug>(CtrlXA-CtrlX)
silent! xmap <unique>  <C-X> <Plug>(CtrlXA-CtrlA)
silent! xmap <unique>  <C-A> <Plug>(CtrlXA-CtrlX)
silent! xmap <silent> g<C-X> <Plug>(CtrlXA-gCtrlA)
silent! xmap <silent> g<C-A> <Plug>(CtrlXA-gCtrlX)
" }}}
" better-whitespace {{{
let g:better_whitespace_ctermcolor = 24
" }}}
" multiple-cursors {{{
hi multiple_cursors_cursor term=reverse ctermfg=0 ctermbg=yellow
" }}}
" }}}


" MISC {{{
" number of windows in the current buffer
" winnr("$")

" try
"     source ~/.vim/vim_config.vim
" catch
" endtry

" expand("%:p:h")  " returns base directory (e.g. /home/nnnn if file name is ~/.vimrc)
" expand("%:h")    " returns base directory (e.g. /home/nnnn if file name is ~/.vimrc)
" expand("%:p")    " returns full path (e.g. /home/nnnn/.vimrc)
" winwidth('%')    " 139
" winheight('%')   " 34
" winline()        " 12 (12th line from the top of screen)

" substitute (https://github.com/ppwwyyxx/dotvim/blob/master/vimrc)
" set statusline+=%{substitute(getcwd(),expand(\"$HOME\"),\'+\',\'g\')}

" au BufEnter * if &buftype == 'help' | wincmd L | endif  " display help window on vertically. do NOT change BufEnter

" if exists('$TMUX')
" if system('uname -s') == 'Darwin\n'
" if exists('g:breaker_map_cr_omni_complete')
" if filereadable(expand("~/.vimrc.local"))
" if isdirectory(expand("~/.vim/bundle/nerdtree"))
" if count(g:breaker_bundle_groups, 'youcompleteme')  " what does it do?

" let cur_column = col(".")

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

" function! Paste() " {{{
"     let pa_index = &paste
"     if pa_index == 0
"         hi link PasteColor lite_i
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
" function! ReplaceChn() " {{{ https://github.com/ppwwyyxx/dotvim/blob/master/vimrc
"     let chinese={"（" : "(" , "）" : ")" , "，" : ",", "；" : ";", "：" : ":",
"     "？" : "?", "！" : "!", "“" : "\"", "’" : "'" ,
"     ""”" : "\"", "℃" : "\\\\textcelsius", "μ" : "$\\\\mu$"}
"     for i in keys(chinese)
"         silent! exec '%substitute/' . i . '/'. chinese[i] . '/g'
"     endfor
" endfunction
" nnoremap <leader>sch :call ReplaceChn()<cr>
" }}}
" function! s:AskToExpandAbbr(abbr, expansion, defprompt) " {{{ https://vim.fandom.com/wiki/Abbreviation_that_prompts_whether_to_expand_it_or_not
"   let answer = confirm("Expand '" . a:abbr . "'?", "&Yes\n&No", a:defprompt)
"   " testing against 1 and not 2, I correctly take care of <abort>
"   return answer == 1 ? a:expansion : a:abbr
" endfunction
" iabbrev <expr> for <SID>AskToExpandAbbr('for', "for () {\n}", 2)
" }}}
" function! SyntAttr() " {{{ https://www.reddit.com/r/vim/comments/e19bu/whats_your_status_line/
"     let name = synIDattr(synID(line('.'),col('.'),1),'name')
"     if name == ''
"         hi link SyntAttrColor dark_i
"         let synt_attr = 'SYNT-ATTR'
"     else
"         hi link SyntAttrColor dark
"         let synt_attr = name
"     endif
"     return synt_attr
" endfunction
" }}}
" function! TrailingWhiteSpace() " {{{
"     if search('\s\+$', 'nw') != 0
"         hi link TrailingWhiteSpaceColor dark
"     else
"         hi link TrailingWhiteSpaceColor dark_i
"     endif
"     return 'TWS'
" endfunction
" }}}
" function! Replace() " {{{ Search for <cword> and replace with input() in all open buffers (https://github.com/vgod/vimrc/blob/master/vimrc)
"     let s:word = input("Replace " . expand('<cword>') . " with:")
"     :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
"     :unlet! s:word
" endfunction
"}}}
" users {{{
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

" Identifier
" WarningMsg
" ModeMsg
" MoreMsg
" ErrorMsg
