#!/usr/bin/env bash

langauges=$(echo "typescript javascript rust" | tr " " "\n")
core_utils=$(echo "find xargs sed awk" | tr " " "\n") 
selected=$(echo -e "$langauges\n$core_utils" | fzf)

read -p "Query: " query

if echo "$langauges" | grep -qs $selected; then
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
