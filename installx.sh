#!/bin/sh

[[ -d ~/.xmonad ]] || mkdir ~/.xmonad

stow -R x
stow -R .xmonad
