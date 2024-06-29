#!/usr/bin/env bash
GITIGNORE="${HOME}/.gitignore"
cp -f "$( dirname ${0})/.gitignore" "${GITIGNORE}"

git config --global core.editor nvim
git config --global core.whitespace "fix,-indent-with-non-tab,trailing-space,cr-at-eol"
git config --global core.excludesfile ~/.gitignore

