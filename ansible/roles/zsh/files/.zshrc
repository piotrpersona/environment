ZSH_THEME="agnoster"

plugins=(
  git
)

export LANG=en_US.UTF-8


########################
# GIT
########################

gitignore() {
  curl -L -s "https://www.gitignore.io/api/${@}"
}


########################
# PYTHON
########################

pypkg() {
  if [[ -z ${1} ]] then; echo "Please provide package name"; fi
  mkdir ${1} && touch ${1}/__init__.py
}


########################
# ZSH
########################

zshrc() {
  vim ${ZSHRC} && source ${ZSHRC}
}

