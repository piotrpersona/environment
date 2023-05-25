#!/usr/bin/env bash

main() {
    dirs=( tmux nvim zsh git alacritty )
    for dir in "${dirs[@]}"; do
        echo ">>>>>>>> Installing ${dir}"
        "./${dir}/install.sh" || echo "Error installing ${dir}"
        echo "<<<<<<<< Done!"
        echo
    done
}

main "${@}"
