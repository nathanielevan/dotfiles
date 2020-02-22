if systemctl -q is-active graphical.target && [[ ! $DISPLAY && "$(tty)" = "/dev/tty1" ]]; then
	exec startx
fi
# Prevent ranger from loading both default and custom rc.conf
export RANGER_LOAD_DEFAULT_RC=FALSE
# UNIX socket for MPD and ncmpcpp
export MPD_HOST=$HOME/.config/mpd/socket
