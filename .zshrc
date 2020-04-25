# Use directory colors from ~/.dir_colors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# Use vim keybinds
bindkey -v

# Export to PATH variable
export PATH=/home/nate/.local/bin:$PATH

autoload -Uz colors
colors

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

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
compinit

alias sudo='sudo '

# Load version control information
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash git-st
+vi-git-st() {
    local ahead behind remote
    local -a gitstatus
    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        # for git prior to 1.7
        # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        (( $ahead )) && gitstatus+=( "${c3}⇡${ahead}${c2}" )

        # for git prior to 1.7
        # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
        (( $behind )) && gitstatus+=( "${c4}⇣${behind}${c2}" )

        hook_com[misc]+="${(j::)gitstatus}"
    fi
}
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]+='?'
    fi
}
+vi-git-stash() {
    local -a stashes
    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        hook_com[misc]+="*"
    fi
}
zstyle ':vcs_info:git:*' formats " %b%m%u%c"

# Add colors to ls
alias ls='ls --color'

# Clear .zsh_history
alias clear-history='rm ~/.zsh_history'

# Execute neofetch before first prompt for aesthetics
# neofetch

# Add newline before neofetch output
alias neofetch='echo "" && neofetch'

# Prompt config
if [[ $EUID -ne 0 ]]; then
    PROMPT='%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%5F${vcs_info_msg_0_}%f%1F]%f%7F$%f %b'
#   PROMPT='%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%1F]%f%7F$%f %b'
else
    PROMPT='%B%3F[%n@%m %1~]# %f%b'
fi

# Fancy features - comment out to speed up load time

## Load zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Source fzf files
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
