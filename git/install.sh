#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

link git/.gitignore "${HOME}/.gitignore"

git config --global core.editor nvim
git config --global core.whitespace "fix,-indent-with-non-tab,trailing-space,cr-at-eol"
git config --global core.excludesfile "${HOME}/.gitignore"
git config --global pull.rebase true
git config --global rebase.autoStash true
