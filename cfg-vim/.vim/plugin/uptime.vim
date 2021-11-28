" doc {{{
"*uptime.txt*    The Uptime Plugin                            1.2, May 22, 2004
"
"Author:  Ciaran McCreesh <ciaranm at gentoo dot org>
"
"==============================================================================
"1. Contents                                         *uptime* *uptime-contents*
"
"    1. Contents                                          |uptime-contents|
"    2. :Uptime Command                                           |:Uptime|
"        Arguments                                       |uptime-arguments|
"        Uptime in statusline                           |uptime-statusline|
"    3. Uptime ChangeLog                                 |uptime-changelog|
"
"==============================================================================
"2. :Uptime Command                                                   *:Uptime*
"
"        The :Uptime command echos the current application uptime (uptime is
"        the amount of time since the application was launched).
"
"    Arguments                                               *uptime-arguments*
"
"        The :Uptime command takes an optional argument which controls the
"        output format. Allowed values are:
"
"        'regular', '1' (default)
"            Uses a verbose, human-readable output. For example, "gvim has been
"            up for 2 days, 1 hour, 17 minutes and 2 seconds". For shorter
"            uptimes, leading components are dropped: "vim has been up for 16
"            seconds".
"
"        'short', '2'
"            Display a concise output. For example, "2d 01:17:02". If the
"            uptime is less than a day, the leading component is dropped:
"            "00:00:16".
"
"        'seconds', '3'
"            Display the uptime in seconds. For example, "264".
"
"        If an unrecognised format is supplied, an exception will be thrown.
"
"    Uptime in the statusline                               *uptime-statusline*
"               {not avaliable when compiled without the |+statusline| feature}
"
"        As well as the :Uptime command, a function named Uptime() is exported.
"        This function optionally takes one argument controlling the format, as
"        per |uptime-arguments|. This function can be used to include the
"        uptime in the statusline. For example:
"
"        :set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P\ %{Uptime(2)}
"
"==============================================================================
"3. Uptime ChangeLog                                         *uptime-changelog*
"
"        v1.3 (20040522)
"            * move the echo outside of the Uptime() function to make it easier
"              to include Uptime in the statusline.
"                       - Thanks to Salman Halim <salmanhalim at yahoo dot com>
"            * added 1, 2, 3 as aliases for regular, short, seconds
"
"        v1.2 (20040522)
"            * added optional argument controlling the format
"            * added help document
"
"        v1.1 (20040417)
"            * display times in a 'pretty' format
"
"        v1.0 (20040417)
"            * initial release
"
"==============================================================================
" }}}
" creds {{{
" Name:          uptime (global plugin)
" Version:       1.3
" Author:        Ciaran McCreesh <ciaranm at gentoo.org>
" Updates:       http://dev.gentoo.org/~ciaranm/vim/
" Purpose:       Display vim uptime
"
" License:       You may redistribute this plugin under the same terms as Vim
"                itself.
"
" Usage:         :Uptime
"                :Uptime regular   " default format
"                :Uptime short     " for 'short' format output
"                :Uptime seconds   " uptime in seconds
"
" Requirements:  Untested on Vim versions below 6.2
"
" ChangeLog:     see :help uptime-history
" }}}

" when the plugin is sourced, record the time
let s:start_time = localtime()

function! s:AddLeadingZero(i)
    if a:i < 10
        return "0" . a:i
    else
        return a:i
    endif
endfun

function! Uptime(...)
    let l:current_time = localtime()
    let l:uptime_in_seconds = l:current_time - s:start_time

    " get days, hours, minutes, seconds
    let l:m_s = (l:uptime_in_seconds) % 60
    let l:m_m = (l:uptime_in_seconds / 60) % 60
    let l:m_h = (l:uptime_in_seconds / (60 * 60)) % 24
    let l:m_d = (l:uptime_in_seconds / (60 * 60 * 24))

    let l:msg = ""
    if (l:m_d > 0)
        let l:msg = l:msg . l:m_d . ":"
    endif
    let l:msg = l:msg . s:AddLeadingZero(l:m_h) . ":" .
                \       s:AddLeadingZero(l:m_m) . ":" .
                \       s:AddLeadingZero(l:m_s)
    return l:msg
endfun

command! -nargs=? Uptime :echo Uptime(<q-args>)

" vim: set tw=80 ts=4 et :
