#!/usr/bin/env bash
# Spotlight-launchable scratch notes: CMD+Space, "log", Enter.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

APP="${HOME}/Applications/Log.app"
LSREGISTER=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister

mkdir -p -- "${HOME}/notes"

link notes/note.sh "${HOME}/.local/bin/note"

# The bundle is a real directory holding three symlinks, not a symlinked
# bundle. Spotlight does not index symlinks, so a symlinked Log.app would only
# ever be found at its path inside this repo - and an app under ~/developer
# ranks below one in ~/Applications.
[ -L "${APP}" ] && rm -- "${APP}" && say "unlink ${APP} (was a symlinked bundle)"
mkdir -p -- "${APP}/Contents/MacOS" "${APP}/Contents/Resources"

link notes/app/Info.plist "${APP}/Contents/Info.plist"
link notes/app/log        "${APP}/Contents/MacOS/log"
link notes/app/Log.icns   "${APP}/Contents/Resources/Log.icns"

# Finder and Spotlight cache the icon against the bundle's mtime.
touch -- "${APP}"
[ -x "${LSREGISTER}" ] && "${LSREGISTER}" -f "${APP}"
have mdimport && mdimport -- "${APP}" && say "indexed for Spotlight"

have nvim || say "nvim not installed; note is linked for when it is"
[ -d /Applications/Ghostty.app ] || say "Ghostty not installed; only 'note' in a terminal will work"
