# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Example aliases

export PATH=$PATH:/opt/homebrew/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Aliases

source ~/.zsh_aliases.sh
# local aliases sepcific to the machine
[ -f ~/.zsh_aliases.local.sh ] && source ~/.zsh_aliases.local.sh
# local prompt
[ -f ~/prompt.sh ] && source ~/prompt.sh

# RUST
# source $HOME/.cargo/env
# export CARGO_NET_GIT_FETCH_WITH_CLI=true


# UTILS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# SPOS
export EDITOR='nvim'

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#aaaaaa'
# Allow to define custom aliases
[ -f ~/.zsh_aliases_custom ] && source ~/.zsh_aliases_custom

# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Prompt

# https://robotmoon.com/zsh-prompt-generator/
GREEN="%F$(tput setaf 41)"
YELLOW="%F$(tput setaf 220)"
BLUE="%F$(tput setaf 33)"
ERROR="%F$(tput setaf 204)"
RESET="%f"

git_rev() {
    git status > /dev/null 2>&1 
    if [ $? -ne 0 ]; then
        echo ""
        return 0
    fi

    git status | grep detached > /dev/null \
        && git rev-parse --short HEAD \
        || git rev-parse --abbrev-ref HEAD
}

precmd() {
    export STATUS=$?

    STATUS_COLOR=${GREEN}
    if [ $STATUS -ne 0 ]; then
        STATUS_COLOR=${ERROR}
    fi

    local rev=$( git_rev )
    GIT_REV=""
    if [ "${rev}" != "" ]; then
        GIT_REV=" [${YELLOW}${rev}${RESET}]"
    fi
}

PROMPT='(${STATUS_COLOR}${STATUS}${RESET}) ${BLUE}%1~${RESET}${GIT_REV} $ '

