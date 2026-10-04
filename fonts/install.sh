#!/usr/bin/env bash
# Install the Nerd Fonts the terminal configs reference.
#
# Deliberately a short list: `brew search '/font-.*-nerd-font/' | xargs install`
# pulls ~70 casks and several GB of fonts for no benefit.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

have brew || die "brew is not installed"

while IFS= read -r font; do
    if brew list --cask "${font}" >/dev/null 2>&1; then
        say "ok     ${font}"
    else
        brew install --adopt --cask "${font}" && say "font   ${font}"
    fi
done < <(read_list "${ENV_ROOT}/fonts/fonts")
