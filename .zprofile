# Define PATH
export PATH="$HOME/.local/bin:$PATH"

# Define default applications
export TERMINAL="urxvtc"
export EDITOR="vim"
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
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"

# Defines location for mpd socket
export MPD_HOST="$XDG_DATA_HOME/mpd/socket"

# Disables less history file
export LESSHISTFILE=/dev/null

# nnn configuration
export NNN_BMS='h:~;m:/run/media/nate/;t:~/.local/share/Trash/files/;w:/mnt/win/Users/Nathaniel Evan/;'
export NNN_USE_EDITOR=1
export NNN_TRASH=1
export NNN_OPENER=xdg-open

# Defines fzf's default command
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --glob '!.git/*'"

# Set bat highlighting colour theme
export BAT_THEME="Nord"

# Displays file previews in fzf
# export FZF_DEFAULT_OPTS="
# --preview 'bat --style=numbers --color=always {} | head -19'
# "

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && "$(tty)" = "/dev/tty1" ]]; then
	exec startx "$XINITRC"
fi
