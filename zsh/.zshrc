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

alias l='ls -lah'
alias work='cd ~/work'
alias dev='cd ~/developer'
alias bpy='bpython'
alias distro='cat /etc/*-release'

# History
export HISTTIMEFORMAT="%d/%m/%y %T "
alias k='kubectl'
alias kt='kubetail'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kgpo='kubectl get po'
alias kdpo='kubectl describe po'

# git aliases
alias gc="git commit"
alias gcm="git commit -sm"
alias gca="git commit -asm"
alias ga="git add"
alias gaa="git add ."
alias gp="git push"
alias gpa='git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags'
alias gm="git merge"
alias gch="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gl="git log"
alias gs="git status"
alias gf="git fetch --all --tags"
alias gpl='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gcane='git commit --amend --no-edit'
alias gcam='git commit --amend'

# RUST
# source $HOME/.cargo/env
# export CARGO_NET_GIT_FETCH_WITH_CLI=true


# UTILS
alias uuid="python3 -c \"import uuid; print(uuid.uuid4(), end='')\""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias v='nvim'

# SPOS
export EDITOR='nvim'

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# zsh
alias zshrc='nvim ~/.zshrc && source ~/.zshrc'

