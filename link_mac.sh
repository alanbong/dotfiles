#!/bin/bash
my_conf=(
    "aerospace.aerospace.toml:.aerospace.toml"
    "sketchybar:.config/sketchybar"
    "karabiner:.config/karabiner"
)

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link macOS specific dotfiles
source "$script_dir/link_core.sh"

# Link universal dotfiles
source "$script_dir/link_universal.sh"
