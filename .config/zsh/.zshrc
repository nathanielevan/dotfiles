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
zstyle ':completion:*:corrections' format '%214F%B--- %d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

autoload -Uz add-zsh-hook

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

# Displays information about Git repository status
# git_info() {
#
#     # Exit if not inside a Git repository
#     ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return
#
#     # Display git branch/tag, or name-rev if on detached head
#     local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}
#
#     local AHEAD="⇡NUM"
#     local BEHIND="⇣NUM"
#     local STASHED="*"
#     local UNTRACKED="?"
#     local MODIFIED="!"
#     local STAGED="+"
#
#     local -a DIVERGENCES
#     local -a FLAGS
#
#     local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
#     if [ "$NUM_AHEAD" -gt 0 ]; then
#         DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
#     fi
#
#     local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
#     if [ "$NUM_BEHIND" -gt 0 ]; then
#         DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
#     fi
#
#     if [[ -n $(git rev-parse --verify refs/stash 2> /dev/null) ]]; then
#         FLAGS+=( "$STASHED" )
#     fi
#
#     if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
#         FLAGS+=( "$UNTRACKED" )
#     fi
#
#     if ! git diff --quiet 2> /dev/null; then
#         FLAGS+=( "$MODIFIED" )
#     fi
#
#     if ! git diff --cached --quiet 2> /dev/null; then
#         FLAGS+=( "$STAGED" )
#     fi
#
#     local -a GIT_INFO
#     GIT_INFO+=( " $GIT_LOCATION" )
#     [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
#     [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
#     echo "${(j: :)GIT_INFO}"
#
# }

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
#     PROMPT="%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%5F\$(git_info)%f%1F]%f%7F$%f %b"
    PROMPT="%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%1F]%f%7F$%f %b"
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
