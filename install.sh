#!/usr/bin/bash

[[ -d ~/.config ]] || mkdir ~/.config
[[ -d ~/.oh-my-zsh ]] || git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

#for d in `ls .`;
#do
#    ( stow -R $d )
#done
