#!/usr/bin/env bash

LAYOUT=$(osascript -e 'tell application "System Events" to get (name of every login item whose name is "Text Input")' 2>/dev/null)

if [ -z "$LAYOUT" ]; then
    LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -f 4 -d '"')
fi

case "$LAYOUT" in
    *"Russian"*) LABEL="RU" ;;
    *"US"*)      LABEL="EN" ;;
    *"U.S."*)    LABEL="EN" ;;
    *)           LABEL="RU" ;;
esac

sketchybar --set "$NAME" label="$LABEL"
