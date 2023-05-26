#!/usr/bin/env bash
GITCONFIG="${HOME}/.gitconfig"
[[ -e "${GITCONFIG}" ]] || cp -f "$( dirname ${0})/.gitconfig" "${GITCONFIG}"

