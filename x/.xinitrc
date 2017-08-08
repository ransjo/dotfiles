#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xbindkeys
#syndaemon -k -i 1 -d &
urxvtd -q -o -f

export _JAVA_AWT_WM_NONREPARENTING=1

xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
compton -CGb
sh ~/.fehbg &

#~/keyboard/se.sh

exec dbus-launch startxfce4
cmst -m -w 3&
#exec xmonad
