#!/bin/sh

# Script to call custom rofi menu for power-related functions

option=$(echo -e "lock\nlogout\nsuspend\nreboot\nshutdown" | rofi -dmenu -disable-history -i -p "power option")

case "$option" in
        lock) betterlockscreen -l blur 0.5 ;;
        logout) bspc quit ;;
        suspend) systemctl suspend ;;
        reboot) systemctl reboot ;;
        shutdown) systemctl poweroff ;;
esac
