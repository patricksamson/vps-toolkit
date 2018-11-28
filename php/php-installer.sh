#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "PHP"

if ! check_ppa_exists ondrej/php; then
    LC_ALL=en_US.UTF-8 sudo add-apt-repository -y ppa:ondrej/php
fi

apt-get-update

apt-get-install php7.2-bcmath php7.2-cli php7.2-common php7.2-curl php7.2-fpm php7.2-gd php7.2-gmp php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-pgsql php7.2-sqlite3 php7.2-readline php7.2-xml php7.2-zip

print_success "All done."
php -v
echo

pause_press_enter
show_main_menu