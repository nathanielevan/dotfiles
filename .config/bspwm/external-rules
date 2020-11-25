#! /bin/sh

wid=$1
class=$2
instance=$3
consequences=$4

# Set Android emulator to floating automatically
wintitle=$(xprop -id "$wid" _NET_WM_NAME | cut -d\" -f2)
case "$wintitle" in
        *Emulator) echo state=floating ;;
esac
