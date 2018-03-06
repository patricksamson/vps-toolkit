#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Nginx"

if ! check_ppa_exists nginx; then
    sudo add-apt-repository -y ppa:nginx/development
fi

apt-get-update

apt-get-install nginx

echo -e $YELLOW"--->Creating SSL Certificates folder..."$ENDCOLOR
sudo mkdir /certs
sudo chown -R :www-data /certs
echo -e $CYAN'/certs/'$ENDCOLOR ' - Folder created; put your SSL Certs in there'

echo -e $YELLOW"--->Generating Diffie-Hellman keys; this will take some time..."$ENDCOLOR
sudo rm -r /certs/dhparams.pem
sudo openssl dhparam -out /certs/dhparams.pem 2048
sudo chown -R :www-data /certs

echo -e $YELLOW"--->Copying Configuration files..."$ENDCOLOR
sudo mkdir -p /etc/nginx/vps-toolkit
sudo cp -R -f $SCRIPTPATH/webservers/nginx-conf/. /etc/nginx/vps-toolkit

print_success "All done."
nginx -v
echo

pause_press_enter
show_main_menu
