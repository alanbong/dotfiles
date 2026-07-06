#!/bin/bash
my_conf=(
    "tmux/.tmux.conf:.tmux.conf"
    "vim/.vimrc:.vimrc"
    "zsh/.zshrc:.zshrc"
    "alacritty:.config/alacritty"
    "nvim:.config/nvim"
    "kitty:.config/kitty"
    "xnviewmp:.config/xnviewmp"
)

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/link_core.sh"

