#!/bin/bash
my_conf=(
    "aerospace.aerospace.toml:.aerospace.toml"
    "sketchybar:.config/sketchybar"
    "karabiner:.config/karabiner"
)

dotfiles_dir=$(pwd)

for item in "${my_conf[@]}"; do
    IFS=":" read -r source destination <<< "$item"
    destination="$HOME/$destination"
    mkdir -p "$(dirname "$destination")"

    ln -sf "$dotfiles_dir/$source" "$destination"
done

