#!/usr/bin/env bash
# Install the brew formulae and casks this environment expects.
#
# Only missing entries are installed, so re-running is quick.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

have brew || die "brew is not installed; run ./install.sh core first"

install_missing() {
    local kind="${1}" list="${2}"
    local -a want=() missing=()

    while IFS= read -r pkg; do want+=( "${pkg}" ); done < <(read_list "${list}")
    [ "${#want[@]}" -gt 0 ] || return 0

    local have_now
    have_now="$(brew list "${kind}" 2>/dev/null)"

    local pkg
    for pkg in "${want[@]}"; do
        printf '%s\n' "${have_now}" | grep -qxF "${pkg##*/}" || missing+=( "${pkg}" )
    done

    if [ "${#missing[@]}" -eq 0 ]; then
        say "all ${kind#--} up to date (${#want[@]})"
        return 0
    fi

    say "installing ${#missing[@]} ${kind#--}: ${missing[*]}"
    # --adopt is cask-only: it takes over an app already on disk instead of
    # refusing, which is how a hand-installed cask comes under brew management.
    if [ "${kind}" = --cask ]; then
        brew install --adopt "${kind}" "${missing[@]}"
    else
        brew install "${kind}" "${missing[@]}"
    fi
}

brew update
install_missing --formula "${ENV_ROOT}/brew/packages"
install_missing --cask    "${ENV_ROOT}/brew/cask"
brew cleanup --prune=30
