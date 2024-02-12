#!/usr/bin/env bash

main() {
    dirs=( core tmux nvim zsh git alacritty fonts )

    if [[ "${1}" == "brew" ]]; then
        dirs+=( brew )
    fi

    for dir in "${dirs[@]}"; do
        echo ">>>>>>>> Installing ${dir}"
        "./${dir}/install.sh" || echo "Error installing ${dir}"
        echo "<<<<<<<< Done!"
        echo
    done
}

main "${@}"
