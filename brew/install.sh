#!/usr/bin/env bash
brew install $( cat "$( dirname ${0} )/packages" )
