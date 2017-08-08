#!/bin/sh
setxkbmap se -model pc105 -option 'caps:ctrl_modifier'
xmodmap ~/keyboard/xmodmap-se
xcape -e 'Caps_Lock=Escape' -t .175
sh ~/keyboard/sticky.sh
