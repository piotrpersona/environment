#!/usr/bin/env bash
GITCONFIG="${HOME}/.gitconfig"
GITIGNORE="${HOME}/.gitignore"
[[ -e "${GITCONFIG}" ]] || cp -f "$( dirname ${0})/.gitconfig" "${GITCONFIG}"
[[ -e "${GITIGNORE}" ]] || cp -f "$( dirname ${0})/.gitignore" "${GITIGNORE}"

