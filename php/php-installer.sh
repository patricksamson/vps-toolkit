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

apt-get-install php7.3-bcmath php7.3-cli php7.3-common php7.3-curl php7.3-fpm php7.3-gd php7.3-gmp php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-pgsql php7.3-sqlite3 php7.3-readline php7.3-xml php7.3-zip

print_success "All done."
php -v
echo

pause_press_enter
show_main_menu