#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Certbot"

if ! check_ppa_exists certbot; then
    sudo add-apt-repository -y ppa:certbot/certbot
fi

apt-get-update

apt-get-install python-certbot-nginx

print_step_comment "Adding crontab entry for certificate renewals."
(crontab -l | echo "23 3,18 * * * root certbot renew --quiet") | crontab -

print_success "All done."
certbot --version
echo

pause_press_enter
show_main_menu