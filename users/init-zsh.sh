#!/usr/bin/env zsh
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#


# Determine the base path of this script.
# echo "The script you are running has basename `basename "$0"`, dirname `dirname "$0"`"
# echo "The present working directory is `pwd`"
SCRIPTPATH=$(dirname "$0")

source $SCRIPTPATH'/../helpers/output.sh'


if [ -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  # Control will enter here if the directory exists.

  # We don't want to install it if it's already there, exit
  print_success "Prezto is already installed!"
  exit 0
fi

# Install custom Prezto theme
git clone --recursive https://github.com/patricksamson/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Create symlinks
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
