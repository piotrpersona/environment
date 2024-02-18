#!/usr/bin/env bash
GITCONFIG="${HOME}/.gitconfig"
GITIGNORE="${HOME}/.gitignore"
cp -f "$( dirname ${0})/.gitconfig" "${GITCONFIG}"
cp -f "$( dirname ${0})/.gitignore" "${GITIGNORE}"

