#!/usr/bin/env bash
ls "$HOME/.zshrc" || cp -f "$( dirname ${0})/.zshrc" "$HOME/.zshrc"
cp -f "$( dirname ${0})/.zsh_aliases.sh" "$HOME/.zsh_aliases.sh"
cp -f "$( dirname ${0})/prompt.sh" "${HOME}/prompt.sh"
