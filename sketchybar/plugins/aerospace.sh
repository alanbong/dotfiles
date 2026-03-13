#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

WS_NAME="$1"
CURRENT_FOCUSED=$(aerospace list-workspaces --focused | xargs)

case $WS_NAME in
    "1") ICON="" ;;
    "2") ICON="" ;;
    "3") ICON="" ;;
    "4") ICON="" ;;
    "5") ICON="" ;;
    "6") ICON="󰼏" ;;
    "7") ICON="󰼐" ;;
    "8") ICON="󰼑" ;;
    *) ICON="$WS_NAME" ;;
esac

if [ "$WS_NAME" = "$CURRENT_FOCUSED" ]; then
    sketchybar --set "$NAME" \
        drawing=on \
        icon="$ICON" \
        icon.color="$YELLOW"
else
    sketchybar --set "$NAME" \
        drawing=on \
        icon="$ICON" \
        icon.color="$WHITE"
fi
