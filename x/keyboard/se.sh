#!/bin/sh
setxkbmap se -model pc105
xmodmap ~/keyboard/xmodmap-se
sh ~/keyboard/sticky.sh 