# This file is part of ranger, the console file manager.
# License: GNU GPL version 3, see the file "AUTHORS" for details.
# ------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    black, blue, cyan, green, magenta, red, white, yellow, default,
    normal, bold, reverse, dim, blink, BRIGHT,
    default_colors,
)

class Default(ColorScheme):
    progress_bar_color = blue

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                # attr = reverse
                bg =  black
                bg += BRIGHT
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = yellow
                else:
                    fg = magenta
            if context.container:
                fg = red
            if context.directory:
                attr |= normal
                fg = blue
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= normal
                fg = green
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = yellow
                if context.device:
                    attr |= bold
            if context.link:
                fg = cyan if context.good else magenta
#            if context.tag_marker and not context.selected:
            if context.tag_marker:
                # attr |= dim
#                if fg in (red, magenta):
#                    fg = white
#                else:
#                    fg = red
                fg = fg
#            if not context.selected and (context.cut or context.copied):
#                fg = black
#                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= normal
                if context.marked:
                    attr |= dim
                    if context.selected:
                        bg = black
                        bg += BRIGHT
#                        if context.directory:
#                            fg = blue
#                        else:
#                            fg = yellow
#                    else:
#                        if context.directory:
#                            fg = blue
#                        else:
#                            fg = yellow
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.inactive_pane:
                attr |= bold | dim
                fg    = black
                fg   += BRIGHT

        elif context.in_titlebar:
            attr |= normal
            if context.hostname:
                fg = red if context.bad else green
            elif context.directory:
                fg = blue
            elif context.tab:
                if context.good:
                    fg = black
                    bg = green
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = white
                elif context.bad:
                    attr |= blink
                    fg = red
            if context.marked:
#                attr |= bold | reverse
                attr |= blink
                fg    = yellow
            if context.frozen:
                attr |= bold | reverse
                fg = cyan
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
#                attr &= ~bold
                fg = green
            if context.vcscommit:
                fg = yellow
#                attr &= ~bold
            if context.vcsdate:
                fg = cyan
#                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

#        if context.vcsfile and not context.selected:
        if context.vcsfile:
            if context.inactive_pane:
                attr |= bold | dim
                fg    = black
                fg   += BRIGHT
            else:
#                attr &= ~bold
                if context.vcsconflict:
                    attr |= blink | bold
                    fg = red
                elif context.vcschanged:
                    attr |= blink | bold
                    fg = red
                elif context.vcsunknown:
                    attr |= blink | bold
                    fg = red
                elif context.vcsstaged:
                    attr |= blink | bold
                    fg = red
                elif context.vcssync:
                    attr |= bold
                    fg = green
                elif context.vcsignored:
                    attr |= bold
                    fg = green

#        elif context.vcsremote and not context.selected:
        elif context.vcsremote:
            if context.inactive_pane:
                attr |= bold | dim
                fg    = black
                fg   += BRIGHT
            else:
#                attr &= ~bold
                if context.vcssync or context.vcsnone:
                    attr |= bold
                    fg = green
                elif context.vcsbehind:
                    attr |= blink | bold
                    fg = red
                elif context.vcsahead:
                    attr |= blink | bold
                    fg = red
                elif context.vcsdiverged:
                    attr |= blink | bold
                    fg = red
                elif context.vcsunknown:
                    attr |= blink | bold
                    fg = red

        return fg, bg, attr
