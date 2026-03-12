#!/usr/bin/env sh

# Color Palette
# Tokyonight Night
BLACK=0xff24283b
WHITE=0xffa9b1d6
MAGENTA=0xffbb9af7
BLUE=0xff7aa2f7
CYAN=0xff7dcfff
GREEN=0xff9ece6a
YELLOW=0xffe0af68
ORANGE=0xffff9e64
RED=0xfff7768e
BAR_COLOR=0xff1a1b26
COMMENT=0xff565f89

TRANSPARENT=0x00000000

# Tokyonight Day
# BLACK=0xffe9e9ed
# WHITE=0xff3760bf
# MAGENTA=0xff9854f1
# BLUE=0xff2e7de9
# CYAN=0xff007197
# GREEN=0xff587539
# YELLOW=0xff8c6c3e
# ORANGE=0xffb15c00
# RED=0xfff52a65
# BAR_COLOR=0xffe1e2e7

# General bar colors
ICON_COLOR=$WHITE
LABEL_COLOR=$WHITE

ITEM_DIR="$HOME/.config/sketchybar/items"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

FONT="Hack Nerd Font:Bold:16.0"

PADDINGS=3

POPUP_BORDER_WIDTH=2
POPUP_CORNER_RADIUS=11
POPUP_BACKGROUND_COLOR=$BLACK
POPUP_BORDER_COLOR=$COMMENT

CORNER_RADIUS=15
BORDER_WIDTH=2

SHADOW=on

add_item() {
    local name="$1"
    local side="$2"
    local color="$3"
    local freq="$4"
    local icon="$5"

    local config=(
        "update_freq=$freq"
        "icon.color=$color"
        "icon.font=$FONT"
        "icon.padding_left=10"
        "label.color=$color"
        "label.font=$FONT"
        "label.padding_right=12"
        "background.height=26"
        "background.corner_radius=$CORNER_RADIUS"
        "background.padding_left=5"
        "background.padding_right=5"
        "background.border_width=$BORDER_WIDTH"
        "background.border_color=$color"
        "background.color=$BAR_COLOR"
        "background.drawing=on"
        "script=$PLUGIN_DIR/$name.sh"
    )

    if [ -n "$icon" ]; then
        config+=("icon=$icon")
    fi

    sketchybar --add item "$name" "$side" \
        --set "$name" "${config[@]}"
}
