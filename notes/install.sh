#!/usr/bin/env bash
# Spotlight-launchable scratch notes: CMD+Space, "log", Enter.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

mkdir -p -- "${HOME}/notes"

link notes/note.sh "${HOME}/.local/bin/note"
link notes/Log.app "${HOME}/Applications/Log.app"

# Spotlight only offers the app once the bundle is in its index.
if have mdimport; then
    mdimport -- "${HOME}/Applications/Log.app" && say "indexed for Spotlight"
fi

have nvim || say "nvim not installed; note is linked for when it is"
[ -d /Applications/Ghostty.app ] || say "Ghostty not installed; only 'note' in a terminal will work"
