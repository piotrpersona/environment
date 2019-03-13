export ZSH="/home/ppersona/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	docker
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#####################
# GIT
####################

function gerritco() { 
  git fetch origin "$(git ls-remote | grep /${1}/${2} | cut -f2 | sort -t/ -k5 -n | tail -1)" \
  && git checkout FETCH_HEAD
}

function git_rebase() {
  git rebase -i $( git rev-parse HEAD~"${1}" )
}

function git_above_head() {
  master="$( git rev-list --count origin/master )"
  head="$( git rev-list --count HEAD )"
  echo "$( ( ${head} - ${master} ) )"
}

function git_patch_head() {
  git commit --fixup "$( git rev-parse HEAD )"
  git rebase -i --autosquash "$( git rev-parse HEAD~2 )"
}

function git_commit_message() {
  git log --format=%B -n 1 "${1}" \
    || echo "Provide commit hash"
}

##################
# ALIASES
#################

alias im='cd ~/work/integrated-monitoring'
alias work='cd ~/work'
alias dev='cd ~/dev'
alias bpy='bpython'


##################
# ZSH
##################

function zshrc() {
  vim ~/.zshrc && source ~/.zshrc && echo "~/.zshrc is up to date"
}

function mkcd() {
  mkdir "${1}" && cd "${1}"
}

. /usr/local/bin/virtualenvwrapper.sh


##################
# DOCKER
##################

docker_ip() {
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${1}"
}


#################
# WORKON
#################

workon() {
  source "${HOME}/dev/py-envs/${1}/bin/activate" || echo "Provide virtual environment"
}

#################
# GO
#################

export GOPATH=/home/ppersona/go
export PATH=$PATH:$GOPATH/bin


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
