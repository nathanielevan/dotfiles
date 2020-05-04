# Use directory colors from ~/.dir_colors
test -r ~/.config/dir_colors && eval $(dircolors ~/.config/dir_colors)

# Use Vim keybinds
bindkey -v
export KEYTIMEOUT=1

# Displays file previews in fzf
# export FZF_DEFAULT_OPTS="
# --preview 'bat --style=numbers --color=always {} | head -19'
# "
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --glob '!.git/*'"

# Set bat highlighting color theme
export BAT_THEME="Nord"

# Export to PATH variable
export PATH=/home/nate/.local/bin:$PATH

# Disable less history
export LESSHISTFILE=/dev/null

autoload -Uz colors
colors

setopt histignorealldups sharehistory
setopt prompt_subst

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

# Displays information about Git repository status
git_info() {

    # Exit if not inside a Git repository
    ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

    # Display git branch/tag, or name-rev if on detached head
    local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

    local AHEAD="⇡NUM"
    local BEHIND="⇣NUM"
    local STASHED="*"
    local UNTRACKED="?"
    local MODIFIED="!"
    local STAGED="+"

    local -a DIVERGENCES
    local -a FLAGS

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
    fi

    if [[ -n $(git rev-parse --verify refs/stash 2> /dev/null) ]]; then
        FLAGS+=( "$STASHED" )
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        FLAGS+=( "$UNTRACKED" )
    fi

    if ! git diff --quiet 2> /dev/null; then
        FLAGS+=( "$MODIFIED" )
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        FLAGS+=( "$STAGED" )
    fi

    local -a GIT_INFO
    GIT_INFO+=( " $GIT_LOCATION" )
    [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
    [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
    echo "${(j: :)GIT_INFO}"

}
# Add colors to ls
alias ls='ls --color'

# Clear .zsh_history
alias clear-history='rm ~/.zsh_history'

# Prompt config
if [[ $EUID -ne 0 ]]; then
    PROMPT="%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%5F\$(git_info)%f%1F]%f%7F$%f %b"
#   PROMPT='%B%1F[%f%3F%n%f%2F@%f%6F%m%f %4F%1~%f%1F]%f%7F$%f %b'
else
    PROMPT='%B%3F[%n@%m %1~]# %f%b'
fi

# Fancy features - comment out to speed up load time

## Load zsh-autosuggestions
source ~/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load zsh-syntax-highlighting
source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Source fzf files
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
