#!/bin/sh

[ $(bluetoothctl show | grep "Powered: yes" | wc -w) -eq 0 ] && echo "" || ( [ $(echo info | bluetoothctl | grep 'Name' | wc -w) -eq 0 ] && echo "" || echo "" )
