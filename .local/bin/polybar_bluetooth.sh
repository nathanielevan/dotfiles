#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -w) -eq 0 ];
then
        echo ""
else
        btname=$(echo info | bluetoothctl | grep 'Name')
        if [ $(echo "$btname" | wc -w) -eq 0 ];
        then 
                echo ""
        fi
        echo "$(echo "$btname" | cut -d' ' -f2-)"
fi
