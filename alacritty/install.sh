#!/usr/bin/env bash
ALA_HOME="${HOME}/.config/alacritty"
mkdir -p "${ALA_HOME}"
cp -f "$( dirname ${0})/alacritty.toml" "${ALA_HOME}/alacritty.toml"
