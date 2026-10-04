#!/usr/bin/env bash
# Shared helpers for the module installers. Source it, do not execute it.
#
# Config is symlinked out of the repo instead of copied, so editing a file in
# ~ edits the repo and `git pull` is enough to roll out a change.

set -euo pipefail

ENV_ROOT=${ENV_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)}
ENV_STAMP=${ENV_STAMP:-$(date +%Y%m%d-%H%M%S)}

say()  { printf '  %s\n' "$*"; }
warn() { printf '  warning: %s\n' "$*" >&2; }
die()  { printf 'error: %s\n' "$*" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

# link <path relative to repo root> <absolute target>
# Idempotent. A real file or directory already at the target is moved aside
# rather than deleted, so a hand-made config is never lost.
link() {
    local src="${ENV_ROOT}/${1}" dst="${2}"

    [ -e "${src}" ] || die "missing source: ${src}"
    mkdir -p -- "$(dirname -- "${dst}")"

    if [ -L "${dst}" ]; then
        [ "$(readlink -- "${dst}")" = "${src}" ] && return 0
        rm -- "${dst}"
    elif [ -e "${dst}" ]; then
        mv -- "${dst}" "${dst}.${ENV_STAMP}.bak"
        say "kept   ${dst} -> $(basename -- "${dst}").${ENV_STAMP}.bak"
    fi

    ln -s -- "${src}" "${dst}"
    say "link   ${dst}"
}

# read_list <file> - package lists, one entry per line, # comments and blanks ignored
read_list() {
    sed -e 's/#.*//' -e 's/[[:space:]]*$//' -- "${1}" | grep -v '^$' || true
}
