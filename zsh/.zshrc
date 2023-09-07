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
