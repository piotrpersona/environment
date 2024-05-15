#!/usr/bin/env bash
mkdir -p ~/.grc
cp -f "$(dirname ${0})/grc.conf" "${HOME}/.grc/grc.conf"
cp -f "$(dirname ${0})/conf.gotest" "${HOME}/.grc/conf.gotest"

