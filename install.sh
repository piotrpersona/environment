#!/usr/bin/env bash

main() {
    git submodule foreach git pull origin

    dirs=( core tmux nvim zsh git alacritty fonts wezterm )

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
