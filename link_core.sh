#!/bin/bash

if [ -z "${my_conf[*]}" ]; then
    echo "Error: my_conf array is empty or not defined."
    exit 1
fi

# Get dir path of current script
dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for item in "${my_conf[@]}"; do
    IFS=":" read -r source destination <<< "$item"
    destination="$HOME/$destination"
    mkdir -p "$(dirname "$destination")"

    if [ -L "$destination" ]; then
        rm "$destination"
    elif [ -d "$destination" ] || [ -f "$destination" ]; then
        echo "$destination exists. Making .bak"
        mv "$destination" "${destination}.bak_$(date +%Y%m%d_%H%M%S)"
    fi
    
    ln -s "$dotfiles_dir/$source" "$destination"
done
