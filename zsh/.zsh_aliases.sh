alias zshrc='nvim ~/.zshrc && source ~/.zshrc'

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
alias kdpof='kubectl describe po $(kubectl get po | tail -n +2 | fzf | awk '{print $1}') | bat -lyml'
alias kgpoy='kubectl get po -o yaml $(kubectl get po | tail -n +2 | fzf | awk '{print $1}') | bat -lyml'

# git aliases
alias gc="git commit"
alias gcm="git commit -sm"
alias gca="git commit -asm"
alias ga="git add"
alias gaa="git add ."
alias gp="git push"
alias gpa='git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags'
alias gpaf='git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags --force-with-lease'
alias gm="git merge"
alias gch="git checkout"
alias gbr="git branch"
alias gba="git branch -a"
alias gl="git log"
alias gs="git status"
alias gf="git fetch --all --tags"
alias gpl='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gcane='git commit --amend --no-edit'
alias gcanef='git commit --amend --no-edit && git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags --force-with-lease'
alias gcam='git commit --amend'
alias gsq="git rebase -i --autosquash $( git merge-base HEAD origin/main )"
alias grs="git restore --staged ."


alias uuid="python3 -c \"import uuid; print(uuid.uuid4(), end='')\""

alias gitignore="curl -fsSL https://www.toptal.com/developers/gitignore/api/$1"

alias mkgit="mkdir -p $1; cd $1; git init -b main"


alias mkconda="conda create -c conda-forge python=3.12 pynvim jupyter pip opencv-python -y -n $1"


alias v='nvim'
