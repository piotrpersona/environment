#!/usr/bin/env bash
# Install and sync the developer environment.
#
#   ./install.sh                 sync every module (no brew packages)
#   ./install.sh --brew          ... and install brew formulae, casks and fonts
#   ./install.sh zsh git         only the named modules
#   ./install.sh --list          show the modules
#
# A module is any top-level directory holding an install.sh. Config is
# symlinked, so re-running this is cheap and safe.
#
# nvim and the Claude Code config are separate repos, not modules here. See
# the "Related repos" section of README.md.

set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
ENV_ROOT="${PWD}"
ENV_STAMP="$(date +%Y%m%d-%H%M%S)"
export ENV_ROOT ENV_STAMP

source ./lib.sh

# brew and fonts download a lot, so they only run when asked for.
OPT_IN=( brew fonts )

modules() {
    local dir name
    for dir in */; do
        name="${dir%/}"
        [ -x "${name}/install.sh" ] && printf '%s\n' "${name}"
    done
}

is_opt_in() {
    local m
    for m in "${OPT_IN[@]}"; do
        [ "${m}" = "${1}" ] && return 0
    done
    return 1
}

run_module() {
    printf '\n>>> %s\n' "${1}"
    if ( ./"${1}"/install.sh ); then
        printf '<<< %s ok\n' "${1}"
    else
        warn "${1} failed"
        FAILED+=( "${1}" )
    fi
}

main() {
    local with_opt_in=false
    local -a selected=()

    for arg in ${1+"$@"}; do
        case "${arg}" in
            --brew|brew) with_opt_in=true ;;
            --list) modules; return 0 ;;
            -h|--help) sed -n '2,13p' "${BASH_SOURCE[0]}"; return 0 ;;
            -*) die "unknown flag: ${arg}" ;;
            *)  [ -x "${arg}/install.sh" ] || die "not a module: ${arg}"
                selected+=( "${arg}" ) ;;
        esac
    done

    if [ "${#selected[@]}" -eq 0 ]; then
        # core first: it installs brew, which the other modules rely on.
        selected=( core )
        while read -r m; do
            [ "${m}" = core ] && continue
            if is_opt_in "${m}" && [ "${with_opt_in}" = false ]; then
                continue
            fi
            selected+=( "${m}" )
        done < <(modules)
    fi

    FAILED=()
    for m in "${selected[@]}"; do
        run_module "${m}"
    done

    printf '\n'
    if [ "${#FAILED[@]}" -gt 0 ]; then
        die "failed: ${FAILED[*]}"
    fi
    say "done: ${selected[*]}"
    [ "${with_opt_in}" = false ] && say "run with --brew to install packages, casks and fonts"
    return 0
}

main ${1+"$@"}
