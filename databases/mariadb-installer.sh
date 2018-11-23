#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "MariaDB"

if ! check_ppa_exists mariadb; then
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
    sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu '$(lsb_release -sc)' main'
fi

apt-get-update

apt-get-install mariadb-server

print_success "All done."
mysql -V
echo

pause_press_enter
show_main_menu