#!/bin/bash

# TODO
# - Particular depth levels per adress

_replace_wave() {
    echo $1 | sed "s,~,$HOME,g" 
}

_emplace_wave() {
    echo $1 | sed "s,$HOME,~,g"
}

_check_dirs() {
    if [[ -f $1 ]]; 
    then
        mv $1 $1-bak
        touch $1
        for word in $(cat $1-bak)
        do
            if [[ -d $(_replace_wave $word) ]];
            then
                echo $word >> $1
            else
                echo "path: $word is not present so it has been deleted. 🗑️"
            fi
        done

        rm "$1-bak"
    fi
}

_search_dirs() {
    lpath=~/.sd-locations
    _check_dirs $lpath
    echo $(_emplace_wave "$(find $(_replace_wave "$(cat $lpath | tr "\n" " ")" ) -maxdepth 1 -mindepth 1 -type d)" | tr " " "\n" | fzf)
}

sd() {
    cd $(_replace_wave $(_search_dirs))
}

st() {
    dirpath=$(_replace_wave $(_search_dirs))
    dirname=$(basename $dirpath)
    tmux_running=$(pgrep tmux)

    # if tmux not running and not server
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new -s $dirname -c $dirpath
        exit 0
    fi

    if ! tmux has-session -t=$dirname 2> /dev/null; then
        tmux new -ds $dirname -c $dirpath        
    fi

    tmux switch-client -t $dirname
}

sp() {
    selected=$(find $(echo $PATH | tr ":" " ") | tr " " "\n" | fzf)
    cd $(dirname $selected)
}

sd-add() {
    lpath=~/.sd-locations
    if [[ -f $lpath ]]; 
    then
        for word in $(cat $lpath)
        do
            if [[ $word == $(_emplace_wave $1) ]];
            then
                echo "The path is already in the list!!! 📔"
                return 0
            fi
        done
    fi

    echo $(_emplace_wave $(realpath $1)) >> $lpath
    _check_dirs $lpath
}

sd-edit() {
    lpath=~/.sd-locations
    $EDITOR "$lpath"
}

sd-remove() {
    lpath=~/.sd-locations
    if [[ -f $lpath ]]; 
    then
        mv $lpath $lpath-bak
        touch $lpath
        for word in $(cat $lpath-bak)
        do
            if [[ ! $word == $(_emplace_wave $1) ]];
            then
                echo $word >> $lpath
            fi
        done

        rm "$lpath-bak"
    fi

}

sd-list() {
    lpath=~/.sd-locations
    cat $lpath
}
