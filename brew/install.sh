#!/usr/bin/env bash
brew install $( cat "$( dirname ${0} )/packages" )
brew install --cask $( cat "$( dirname ${0} )/cask" )
