#!/usr/bin/env zsh
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

# Install custom Prezto theme
git clone --recursive https://github.com/lykegenes/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Create symlinks
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done