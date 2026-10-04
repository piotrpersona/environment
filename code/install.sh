#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

CODE_DIR="${HOME}/Library/Application Support/Code/User"

if [ ! -d "$(dirname -- "${CODE_DIR}")" ]; then
    say "VS Code is not installed, skipping"
    exit 0
fi

link code/settings.json "${CODE_DIR}/settings.json"
