#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Duplicati"

# Add source for Mono
apt-get-install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-"$(lsb_release -sc)" main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

apt-get-update

# Install Mono
apt-get-install mono-devel


# Download the latest version of Duplicati on GitHub
wget https://github.com/duplicati/duplicati/releases/download/v2.0.4.5-2.0.4.5_beta_2018-11-28/duplicati_2.0.4.5-1_all.deb
sudo dpkg -i duplicati_2.0.4.5-1_all.deb

# Install and automatically run the service
sudo systemctl enable duplicati

print_success "All done."
mono --version
duplicati-cli
echo

pause_press_enter
show_main_menu
