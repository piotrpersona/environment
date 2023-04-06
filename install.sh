#!/bin/bash

set -e

SCRIPT_HOME="$( dirname "${0}" )"
ANSIBLE_HOME="${SCRIPT_HOME}/ansible"


log() {
    echo "$( date '+%Y-%m-%d %H:%M:%S' ) INFO: ${1}"
    "${1}"
    echo "$( date '+%Y-%m-%d %H:%M:%S' ) INFO: done"
}

installXcodeCommandLineTools() {
    xcode-select --install || echo "Xcode command line tools are already installed"
}

installHomebrew() {
    brew -v \
        || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor || echo "Fix brew doctor issues before proceeding" || :
}

installPython() {
    python3 -V || brew install python3
}

installAnsible() {
    ansible -v || brew install ansible
}

runPlaybook() {
    ansible-playbook "${ANSIBLE_HOME}/environment.yml" ${@}
}

main() {
    log installXcodeCommandLineTools
    log installHomebrew
    log installPython
    log installAnsible
    log runPlaybook "${@}"
}

main "${@}"

