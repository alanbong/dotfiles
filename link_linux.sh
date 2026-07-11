#!/bin/bash
my_conf=(
    "xorg/.Xresources:.Xresources"
    "xorg/.xinitrc:.xinitrc"
    "i3/:.config/i3"
)


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Link Linux specific dotfiles
source "$script_dir/link_core.sh"

# Link universal dotfiles
source "$script_dir/link_universal.sh"

sudo pacman -S --needed --noconfirm base-devel nodejs npm xclip wl-clipboard inotify-tools
