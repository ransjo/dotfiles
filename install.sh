#!/usr/bin/bash

[[ -d ~/.config ]] || mkdir ~/.config
[[ -d ~/.oh-my-zsh ]] || git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
[[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
[[ -d ~/.tmux/plugins/tpm ]] || git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

for d in "bash bin input media shell tmux zsh";
do
    ( stow -R $d )
done
