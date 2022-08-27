# Use directory colors from ~/.dir_colors
test -r ~/.config/dir_colors && eval $(dircolors ~/.config/dir_colors)

# Use Vim keybinds
bindkey -v
export KEYTIMEOUT=1

autoload -Uz colors
colors

setopt histignorealldups sharehistory
setopt prompt_subst

# Use modern completion system
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose true
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:descriptions' format "%2F%B--- %d%b%f"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "%1F%B--- No matches found%b%f"
zstyle ':completion:*:corrections' format '%3F%B--- %d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

autoload -Uz add-zsh-hook

# Xterm window title
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|st*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Git information on prompt
autoload -Uz vcs_info
add-zsh-hook -Uz precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats ' %1Fon branch%f %B%5F%b%u%c%f%%b'
zstyle ':vcs_info:git:*' actionformats ' %1Fon branch%f %B%5F%b|%a%u%c%f%%b'

# Display vim mode text -- thanks to Paweł Gościcki for this bit!
vim_ins_mode="%{$fg[cyan]%}(INS)%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}(CMD)%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}

zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}

zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# This will also set the vim mode text to red [abort]
function TRAPINT () {
    vim_mode=" %1F[abort]%f"
    zle reset-prompt
    vim_mode=$vim_ins_mode
    return $(( 128 + $1 ))
}

# Erase vim mode text when entering
function erase_mode_accept_line () {
    vim_mode=""
    zle reset-prompt
    vim_mode=$vim_ins_mode
    zle accept-line
}

zle -N erase_mode_accept_line
bindkey "^M" erase_mode_accept_line
bindkey -M vicmd "^M" erase_mode_accept_line

# Do ls -a after every cd
function do-ls () {
    emulate -L zsh;
    ls --color -a;
}

add-zsh-hook -Uz chpwd do-ls

# Print a newline between prompts
function newline_between_prompts () {
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        print ""
    fi
}

add-zsh-hook -Uz precmd newline_between_prompts

# Expand aliases after sudo
alias sudo='sudo '

# Add colors to ls
alias ls='ls --color'

# Alias vim to nvim because I'm braindead
alias vim='nvim'
alias vimdiff='nvim -d'

# Clear history
alias ch='rm ~/.cache/zsh/history'

# Clear primary selection
alias clp='xclip -sel primary -i /dev/null'

# Clear clipboard selection
alias clc='xclip -sel clipboard -i /dev/null'

# Screen recording at 30fps without audio
alias screenrec='ffmpeg -framerate 30 -f x11grab -i :0.0 -pix_fmt yuv420p $HOME/screc-`date +%d%m%y-%H%M%S`.mp4'

# Record audio from microphone
alias micrec='ffmpeg -f pulse -i default -ac 1 $HOME/audio-`date +%d%m%y-%H%M%S`.m4a'

# Record screen with audio from mic
alias screenmicrec='ffmpeg -framerate 30 -f x11grab -i :0.0 -pix_fmt yuv420p -f pulse -i default -ac 1 $HOME/screc-`date +%d%m%y-%H%M%S`.mp4'

# Prompt config
if [[ $EUID -ne 0 ]]; then
    PROMPT="%B%3F%n%f%b at %B%2F%m%f%b in %B%4F%(5~|%-1~/…/%3~|%4~)%f%b\${vcs_info_msg_0_}\${vim_mode}"$'\n'"%7F>>%f "
    # PROMPT="%B%3F%n%f%b at %B%2F%m%f%b in %B%4F%(5~|%-1~/…/%3~|%4~)%f%b\${vim_mode}"$'\n'">> "
else
    PROMPT="%B%3F[%n@%m %1~]# %f%b"
fi

# Fancy features - comment out to speed up load time

## Load zsh-autosuggestions
# source $XDG_DATA_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load zsh-syntax-highlighting
# source $XDG_DATA_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Refer to zsh-users/zsh-syntax-highlighting#510
# ZSH_HIGHLIGHT_STYLES[comment]='none'

## Load powerlevel10k
# source $XDG_DATA_HOME/zsh/plugins/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
