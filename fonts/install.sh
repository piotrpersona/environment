#!/usr/bin/env bash

ls ~/Library/Fonts | grep -i nerd > /dev/null
if [ $? -ne 0 ]; then
    brew tap homebrew/cask-fonts \
    && brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
else
    echo "Nerd fonts already installed"
fi
