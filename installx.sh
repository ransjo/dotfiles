#!/bin/bash

dirs=".xmonad"
for d in $dirs;
do
	(mkdir -p $dir)
done

packages="x dmenu .xmonad"
for package in $packages;
do
    ( stow -R $package )
done
