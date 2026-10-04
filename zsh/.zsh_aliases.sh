alias v='nvim .'
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
alias g="git"
alias gc="git commit"
alias gcm="git commit -sm"
alias gca="git commit -asm"
alias ga="git add"
alias gaa="git add ."
alias gp="git push"
alias gpa='git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags'
alias gpaf='git push -u origin $(git rev-parse --abbrev-ref HEAD) --tags --force-with-lease'
alias gm="git merge"
alias goo="git checkout"
alias gob="git checkout -b"
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
alias ghome="cd $( git rev-parse --show-toplevel )"


alias uuid='TMP_UUID=$(python3 -c "import uuid; print(uuid.uuid7())") && echo "$TMP_UUID" && echo -n "$TMP_UUID" | pbcopy'

alias gitignore="curl -fsSL https://www.toptal.com/developers/gitignore/api/$1"

function mkgit() {
    mkdir -p $1
    git init $1 -b main
}
alias mkgit="mkgit" 

