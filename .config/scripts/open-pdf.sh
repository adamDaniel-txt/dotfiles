#!/bin/bash

DIRS=(
    "$HOME/dox"
    "$HOME/dl"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(fdfind . "${DIRS[@]}" --max-depth=2 --extension="djvu" --extension="epub" --extension="pdf" --full-path --base-directory $HOME \
        | sed "s|^$HOME/||" \
        | fzf)

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

tmux neww -d zathura $selected
