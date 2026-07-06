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

if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing:"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew installed."
fi

if ! brew list node &>/dev/null; then
    brew install node
fi
