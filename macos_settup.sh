#!/bin/bash

# https://github.com/nikitabobko/AeroSpace
# aerospace
brew install --cask nikitabobko/tap/aerospace

# nerd font
brew install --cask font-hack-nerd-font

# https://github.com/Jean-Tinland/simple-bar?tab=readme-ov-file
# simplebar
brew tap FelixKratz/formulae
brew install sketchybar
mkdir -p ~/.config/sketchybar
touch ~/.config/sketchybar/sketchybarrc
chmod +x ~/.config/sketchybar/sketchybarrc

# https://github.com/FelixKratz/JankyBorders
# borders
brew tap FelixKratz/formulae
brew install borders

# disable macos animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

defaults write com.apple.dock autohide -bool true
defaults write -g NSWindowResizeTime -float 0.001
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
killall Dock
