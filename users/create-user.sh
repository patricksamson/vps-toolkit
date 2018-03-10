#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Create a new user"


print_step_comment "Setting up username and password..."
UNAME=''
ask_question UNAME "Set a Username :"
sudo useradd $UNAME --create-home --shell /bin/zsh || { print_error "Creating user failed."; exit 1; }


UPASS=''
ask_password UPASS "Set a password :"
echo ${UNAME}:${UPASS} | chpasswd


print_step_comment "Configuring user..."


if ask_yes_no "Do you want to create a SSH key for this user?"; then
    EMAIL=''
    ask_question EMAIL "Enter your email address :"
    udo mkdir /home/$UNAME/.ssh
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f /home/$UNAME/.ssh/id_rsa
    eval "$(ssh-agent -s)"
    ssh-add /home/$UNAME/.ssh/id_rsa
    cat /home/$UNAME/.ssh/id_rsa.pub
    sudo chown -R $UNAME:$UNAME /home/$UNAME/.ssh
fi


if ask_yes_no "Add this user to Sudoers?"; then
    sudo usermod -aG sudo $UNAME
fi


if ask_yes_no "Add this user to 'www-data' group?"; then
    sudo usermod -aG www-data $UNAME
fi


if ask_yes_no "Add this user to 'debian-transmission' group?"; then
    sudo usermod -aG debian-transmission $UNAME
fi


print_step_comment "Reloading SSH service..."
service ssh reload

print_success "All done."
echo

pause_press_enter
show_main_menu