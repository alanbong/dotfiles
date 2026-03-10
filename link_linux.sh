#!/bin/bash
my_conf=(
    "xorg/.Xresources:.Xresources"
    "xorg/.xinitrc:.xinitrc"
    "i3/:.config/i3"
)

dotfiles_dir=$(pwd)

for item in "${my_conf[@]}"; do
    IFS=":" read -r source destination <<< "$item"
    destination="$HOME/$destination"
    mkdir -p "$(dirname "$destination")"

    ln -sf "$dotfiles_dir/$source" "$destination"
done

