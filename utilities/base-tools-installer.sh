#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Base Tools"

if ! check_ppa_exists git-core/ppa; then
    sudo add-apt-repository -y ppa:git-core/ppa
fi

apt-get-update

apt-get-install \
        curl \
        fail2ban \
        git \
        htop \
        iftop \
        iotop \
        nano \
        openssl \
        python3-dev \
        python3-pip \
        software-properties-common \
        sudo \
        supervisor \
        unzip \
        wget

sudo pip3 install thefuck

print_success "All done."
git --version
echo

pause_press_enter
show_main_menu