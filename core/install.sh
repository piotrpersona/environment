#!/usr/bin/env bash
# Bootstrap: Homebrew, the directory layout and the macOS key-repeat settings.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

if ! have brew; then
    say "installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew is not on PATH yet during a first install
if ! have brew && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
have brew || die "Homebrew install failed"
say "brew   $(brew --version | head -1)"

mkdir -p -- "${HOME}/work" "${HOME}/developer"
mkdir -p -m 700 -- "${HOME}/.ssh"

if [ "$(uname -s)" = Darwin ]; then
    defaults write -g InitialKeyRepeat -int 12  # minimum is 15 (225ms)
    defaults write -g KeyRepeat -int 1          # minimum is 2 (30ms)
    say "keyboard repeat rate set (re-login to apply)"
fi
