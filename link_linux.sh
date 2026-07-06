#!/bin/bash
my_conf=(
    "xorg/.Xresources:.Xresources"
    "xorg/.xinitrc:.xinitrc"
    "i3/:.config/i3"
)

# Link Linux specific dotfiles
source "$script_dir/link_core.sh"

# Link universal dotfiles
source "$script_dir/link_universal.sh"
