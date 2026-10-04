#!/usr/bin/env bash
# note - start a fresh timestamped markdown note in nvim, already in insert mode.
#
#   note            in the current terminal
#   note --window   in a new Ghostty window (what Log.app, and so Spotlight, runs)
#
# Launched from Spotlight this inherits launchd's environment, not the shell's,
# so nothing is assumed to be on PATH and Ghostty is addressed by full path.
set -euo pipefail

NOTES_DIR=${NOTES_DIR:-${HOME}/notes}
GHOSTTY_APP=${GHOSTTY_APP:-/Applications/Ghostty.app}

fail() {
    printf 'note: %s\n' "${1}" >&2
    # From Spotlight there is no terminal to print to, so say it in the corner.
    [ -t 2 ] || osascript -e "display notification \"${1}\" with title \"note\"" >/dev/null 2>&1 || true
    exit 1
}

case ":${PATH}:" in
    *:/opt/homebrew/bin:*) ;;
    *) PATH="/opt/homebrew/bin:${PATH}" ;;
esac
export PATH

command -v nvim >/dev/null 2>&1 || fail "nvim is not installed"

mkdir -p -- "${NOTES_DIR}" || fail "cannot create ${NOTES_DIR}"
# The file itself is deliberately not created: quit without writing and no empty
# note is left behind.
note="${NOTES_DIR}/$(date +%Y-%m-%d_%H%M%S).md"

# -c, not +startinsert: Ghostty's own CLI parser eats a leading + as an action.
if [ "${1:-}" != --window ]; then
    exec nvim -c startinsert -- "${note}"
fi

[ -d "${GHOSTTY_APP}" ] || fail "${GHOSTTY_APP} is not installed"

# Ghostty 1.2 has no macOS IPC for "new window in the running instance"
# (+new-window is GTK-only), so -n starts its own instance. It reads the same
# ~/.config/ghostty/config and exits when nvim does.
exec open -na "${GHOSTTY_APP}" --args --title=note -e nvim -c startinsert -- "${note}"
