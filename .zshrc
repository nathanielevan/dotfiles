# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz colors
colors

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
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
compinit

alias sudo='sudo '

# Load version control information
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# zstyle ':vcs_info:git:*' formats '  %b'

# Make ls display colors
alias ls='ls --color=auto'

# Clear .zsh_history
alias clear-history='rm ~/.zsh_history'

# Execute neofetch before first prompt for aesthetics
# neofetch

# Add newline before neofetch output
alias neofetch='echo "" && neofetch'

# Prompt config
# if [[ $EUID -ne 0 ]]; then
#   PROMPT='%B%210F %n%f %120F %m%f %228F %1~%f%081F${vcs_info_msg_0_}%f %b '
#   PROMPT='%B%210F %1~%f%159F${vcs_info_msg_0_}%f %b '
# else
#   PROMPT='%B%214F[%n@%m %1~]# %f%b'
# fi

# Fancy features - comment out to speed up load time

## Load zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Load powerlevel10k
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
