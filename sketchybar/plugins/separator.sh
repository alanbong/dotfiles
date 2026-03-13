#!/usr/bin/env bash

NON_EMPTY_S=$(aerospace list-workspaces --monitor all --empty no | grep "S")
CURRENT_FOCUSED=$(aerospace list-workspaces --focused | xargs)

if [[ -n "$NON_EMPTY_S" ]] || [[ "$CURRENT_FOCUSED" == *S* ]]; then
    sketchybar --set space.separator drawing=on
else
    sketchybar --set space.separator drawing=off
fi
