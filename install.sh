#!/usr/bin/bash

[[ -d ~/.config ]] || mkdir ~/.config
[[ -d ~/.xmonad ]] || mkdir ~/.xmonad
[[ -d ~/.oh-my-zsh ]] || git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
[[ -d ~/.tmux/plugins/tpm ]] || git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

for d in `ls .`;
do
    ( stow -R $d )
done
