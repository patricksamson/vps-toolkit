#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

source helpers/output.sh
source helpers/apt-get.sh

SCRIPTPATH=$(pwd)

sudo chmod -R 775 * >/dev/null 2>&1

function pause(){
   read -p "$*"
}

if [ "$EUID" -ne 0 ]
  then
  echo
  echo -e $RED'Please run as root using the command: '$ENDCOLOR'sudo ./setup.sh'
  echo
  exit 0
fi


print_step_comment "Updating system..."
apt-get-update
apt-get-upgrade

print_step_comment "Removing Apache..."
apt-get-remove apache2*

print_step_comment "Setting server locales..."
sudo locale-gen en_CA en_CA.UTF-8 en_US en_US.UTF-8


print_step_comment "Enabling passwordless sudo commands..."
sudo echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/NOPASSWD



print_step_comment "Installing ZSH shell environment..."
apt-get-install zsh

# We must execute this in a ZSH shell
zsh users/init-zsh.sh