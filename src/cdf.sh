#!/bin/bash

sd() {
    current=$(dirname pwd)
    echo $current

    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find $current -mindepth 1 -maxdepth 3 -type d | fzf)
    fi

    if [[ $selected == "home" ]]; then
        cd ~/
    else
        cd $selected
    fi
}
