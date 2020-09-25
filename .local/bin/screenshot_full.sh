#!/bin/sh

# Script to take screenshot, put on clipboard and save it in screenshot folder

SCREENSHOT_FILE=~/Pictures/screenshots/$(date +%F-%H%M%S).png
maim | xclip -selection clipboard -t image/png
xclip -selection clipboard -t image/png -o > "$SCREENSHOT_FILE"
notify-send 'Screenshot taken!' "Saved at $SCREENSHOT_FILE" --icon=camera-photo
