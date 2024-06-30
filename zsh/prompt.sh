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
