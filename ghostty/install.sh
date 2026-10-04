#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

link ghostty/config "${HOME}/.config/ghostty/config"

GHOSTTY=/Applications/Ghostty.app/Contents/MacOS/ghostty
if [ -x "${GHOSTTY}" ]; then
    "${GHOSTTY}" +validate-config --config-file="${HOME}/.config/ghostty/config" \
        && say "config valid"
else
    say "Ghostty.app not installed; config linked for when it is"
fi
