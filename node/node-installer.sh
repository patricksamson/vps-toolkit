#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Node.js"

# Add Node repo
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Install Yarn package manager
if ! check_ppa_exists yarn; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi

apt-get-update

apt-get-install nodejs build-essential yarn

print_success "All done."
node -v
echo

pause_press_enter
show_main_menu