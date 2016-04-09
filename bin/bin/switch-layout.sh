#!/bin/bash

if [[ -n "$1" ]]; then
    setxkbmap $1
else
    layout=$(setxkbmap -query | awk 'END{print $2}')
    echo $layout
    case $layout in
        us)
            setxkbmap se
            ;;
        *)
            setxkbmap us
            ;;
    esac
fi
