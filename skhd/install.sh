#!/usr/bin/env bash
# Global hotkeys. skhd is not in brew/packages: it has no bottle and lives in a
# third-party tap that Homebrew makes you trust by hand, so it is installed
# once per machine with the three commands printed below.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

link skhd/skhdrc "${HOME}/.config/skhd/skhdrc"

if ! have skhd; then
    say "skhd not installed; config linked for when it is. To install:"
    say "  brew tap koekeishiya/formulae"
    say "  brew trust --formula koekeishiya/formulae/skhd"
    say "  brew install koekeishiya/formulae/skhd"
    exit 0
fi

# Restarting covers both "not loaded yet" and "running with the old config".
skhd --restart-service >/dev/null 2>&1 || skhd --start-service >/dev/null 2>&1 || {
    warn "could not start the skhd service; run 'skhd --start-service' by hand"
    exit 0
}
say "service running; cmd+alt+n opens a note"
say "needs Accessibility: System Settings > Privacy & Security > Accessibility"
