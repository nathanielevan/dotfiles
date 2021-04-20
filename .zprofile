# Define PATH
export PATH="$HOME/.local/bin/dwmblocks:$HOME/.local/bin:$PATH"

# Define default applications
export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"
export READER="zathura"

# Set no. of lines in history
export HISTSIZE=1000
export SAVEHIST=1000

# Default directories in compliance with XDG standards
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export XAUTHORITY="$XDG_DATA_HOME/Xauthority"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/config"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
# export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
# export URXVT_PERL_LIB="$XDG_DATA_HOME/urxvt/perl"

# Defines location for mpd socket
export MPD_HOST="$XDG_DATA_HOME/mpd/socket"

# Disables less history file
export LESSHISTFILE=/dev/null

# nnn configuration
export NNN_OPTS=eo
export NNN_FCOLORS='030304020006060801050501'
export NNN_BMS='h:~;m:/run/media/nate/;t:~/.local/share/Trash/files/;'
export NNN_OPENER=xdg-open
export NNN_TRASH=1

# Set bat highlighting colour theme
export BAT_THEME="base16"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && "$(tty)" = "/dev/tty1" ]]; then
	exec startx "$XINITRC"
fi
