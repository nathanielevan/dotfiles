autoload -Uz colors
colors

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

eval "$(dircolors -b)"
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

alias sudo='sudo '

# Make ls display colors
alias ls='ls --color=auto'

# Clear .zsh_history
alias clear-history='rm ~/.zsh_history'

# Print neofetch for mere aesthetics
# neofetch

# Prompt config (no powerlevel10k, in case I ever screw up its config)
if [[ $EUID -ne 0 ]]; then
   PROMPT='%B%105F[%f%203F%n%f%105F@%f%120F%m%f %228F%1~%f%105F]%f%159F$%f %b'
else
   PROMPT='%B%214F[%n@%m %1~]# %f%b'
fi

# Fancy features - comment out to speed up load time

## Load zsh-autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
