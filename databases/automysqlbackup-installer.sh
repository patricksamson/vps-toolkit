#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Automysqlbackup"

apt-get-update

apt-get-install automysqlbackup

print_success "All done."
echo

pause_press_enter
show_main_menu