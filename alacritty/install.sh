#!/usr/bin/env bash
ALA_HOME="${HOME}/.config/alacritty"}
mkdir -p "${ALA_HOME}"
cp -f "$( dirname ${0})/alacritty.yml" "${ALA_HOME}/alacritty.yml"
