# https://robotmoon.com/zsh-prompt-generator/
GREEN="%F$(tput setaf 41)"
YELLOW="%F$(tput setaf 220)"
BLUE="%F$(tput setaf 33)"
WARNING="%F$(tput setaf 202)"
ERROR="%F$(tput setaf 204)"
RESET="%f"

in_git() {
    git status > /dev/null 2>&1 
    if [ $? -ne 0 ]; then
        echo "false"
        return 0
    fi
    echo "true"
}

git_rev() {

    git status | grep detached > /dev/null \
        && git rev-parse --short HEAD \
        || git rev-parse --abbrev-ref HEAD
}

git_status() {
    git status -s | wc -l | tr -d ' '
}

precmd()  {
    export STATUS=$?

    STATUS_COLOR=${GREEN}
    if [ $STATUS -ne 0 ]; then
        STATUS_COLOR=${ERROR}
    fi

    GIT_PROMPT=""
    if [ $( in_git ) = "true" ]; then
        STATUS_MARK_WARNING=""
        local number_of_changes=$( git_status )
        GIT_STATUS="${GREEN}${number_of_changes}${RESET}"
        if [ "${number_of_changes}" != "0" ]; then
            GIT_STATUS="${WARNING}${number_of_changes}${RESET}"
        fi

        local rev=$( git_rev )
        if [ "${rev}" != "" ]; then
            GIT_PROMPT=" [${YELLOW}${rev}${RESET}|${GIT_STATUS}]"
        fi
    fi
}


PROMPT='(${STATUS_COLOR}${STATUS}${RESET}) ${BLUE}%1~${RESET}${GIT_PROMPT} $ '
