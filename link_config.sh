#!/bin/bash
my_conf=(
    "tmux/.tmux.conf:.tmux.conf"
    "vim/.vimrc:.vimrc"
    "zsh/.zshrc:.zshrc"
    "nvim/:.config/nvim"
    "alacritty/:.config/alacritty"
)

dotfiles_dir=$(pwd)

for item in "${my_conf[@]}"; do
    IFS=":" read -r source destination <<< "$item"
    destination="$HOME/$destination"
    mkdir -p "$(dirname "$destination")"

    ln -sf "$dotfiles_dir/$source" "$destination"
done

