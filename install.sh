#!/bin/bash

dirs=".config bin"
for dir in $dirs;
do
	(mkdir -p $dir)
done

[[ -d ~/.oh-my-zsh ]] || git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
[[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
[[ -d ~/.tmux/plugins/tpm ]] || git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

packages="bash bin input media shell tmux zsh dev"
for package in $packages;
do
    ( stow -R $package )
done
