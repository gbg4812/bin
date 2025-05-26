#!/bin/bash

apy() {
    venvs=$(find . -maxdepth 5 -type d -name .venv)

    cnt=$(echo "$venvs" | sed '/^\s*$/d' | wc -l)

    if [[ $cnt -eq 1 ]]; then
        source "$venvs"/bin/activate
    elif [[ $cnt -gt 1 ]]; then
        selected=$(echo "$venvs" | fzf)
        source "$selected"/bin/activate
    elif [[ $cnt -eq 0 ]]; then
        venvs=$(find ../../ -maxdepth 5 -type d -name .venv)
        cnt=$(echo "$venvs" | sed '/^\s*$/d' | wc -l)
        if [[ $cnt -eq 1 ]]; then
            source "$venvs"/bin/activate
        elif [[ $cnt -gt 1 ]]; then
            selected=$(echo "$venvs" | fzf)
            source "$selected"/bin/activate
        fi
    fi

}
