#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# UNIX socket for MPD and ncmpcpp
export MPD_HOST=$HOME/.config/mpd/socket

# Set default text editor
export EDITOR=vim

# NNN file manager config
export NNN_BMS='h:~;m:/run/media/nate/;t:~/.local/share/Trash/files/;w:/mnt/win/Users/Nathaniel Evan/;'
export NNN_USE_EDITOR=1
export NNN_TRASH=1
export NNN_OPENER=xdg-open

# Startup programs
urxvtd -q -f -o
udiskie -s &
dunst &
picom -b
nitrogen --restore &
exec i3
