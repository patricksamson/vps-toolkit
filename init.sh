#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#


# Determine the base path of this script.
# echo "The script you are running has basename `basename "$0"`, dirname `dirname "$0"`"
# echo "The present working directory is `pwd`"
SCRIPTPATH=$(dirname "$0")

source $SCRIPTPATH'/helpers/output.sh'
source $SCRIPTPATH'/helpers/apt-get.sh'

sudo chmod -R 775 * >/dev/null 2>&1

if [ "$EUID" -ne 0 ]
  then
  echo
  echo -e $RED'Please run as root using the command: '$ENDCOLOR'sudo /opt/vps-toolkit/setup.sh'
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

# Change default shell for current user
sudo chsh $(whoami) -s $(which zsh)

zsh $SCRIPTPATH/users/init-zsh.sh


print_success "Done!"
