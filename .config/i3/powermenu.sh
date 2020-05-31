#!/bin/sh

# Script to call custom rofi menu for power-related functions

option=$(echo -e "lock\nlogout\nsuspend\nreboot\nshutdown" | rofi -dmenu -disable-history -i -p "power option")
locker="i3lock --blur 5 && sleep 1"

case "$option" in
        lock) eval "$locker" ;;
        logout) i3-msg exit ;;
        suspend) eval "$locker" && systemctl suspend ;;
        reboot) systemctl reboot ;;
        shutdown) systemctl poweroff ;;
esac
