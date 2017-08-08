#!/bin/sh
setxkbmap us -model pc105 -variant altgr-intl -option 'caps:ctrl_modifier'
xmodmap ~/keyboard/xmodmap-us
xcape -e 'Caps_Lock=Escape' -t .175
sh ~/keyboard/sticky.sh
