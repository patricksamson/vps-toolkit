#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

print_header

ask_proceed_installation "Transmission"

DOWNLOADS_PATH="/var/lib/transmission-daemon"

UNAME=''
ask_question UNAME "Type the username of the user you want to run Transmission :"

UGROUP=($(id -gn $UNAME))


if ! check_ppa_exists transmissionbt; then
    sudo add-apt-repository -y ppa:transmissionbt/ppa
fi

apt-get-update

apt-get-install python-software-properties transmission-cli transmission-common transmission-daemon


print_step_comment "Stopping Transmission temporarily..."
sudo /etc/init.d/transmission-daemon stop > /dev/null 2>&1
sudo service transmission-daemon stop > /dev/null 2>&1
sudo killall transmission-daemon > /dev/null 2>&1


print_step_comment "Creating download directories..."
create_directory ${DOWNLOADS_PATH}/completed
create_directory ${DOWNLOADS_PATH}/incomplete


print_step_comment "Copying settings file..."
CONFIG_FILE="/etc/transmission-daemon/settings.json"
copy_config_file $CONFIG_FILE $CONFIG_FILE.default # Keep the default or previous config file
copy_config_file $SCRIPTPATH/utilities/transmission-initial-settings.json $CONFIG_FILE


print_step_comment "Setting permissions..."
sudo usermod -aG debian-transmission $UNAME  || { print_error "Adding debian-transmission group to user failed."; exit 1; }
sudo chown :debian-transmission $CONFIG_FILE  || { print_error "Chown settings.json failed"; exit 1; }
sudo chmod 775 $CONFIG_FILE
sudo chown -R :debian-transmission $DOWNLOADS_PATH
sudo chmod -R 775 $DOWNLOADS_PATH
sudo chmod g+s $DOWNLOADS_PATH


print_step_comment "Setting up Transmission User, WebUI User and Password..."
TUNAME=''
ask_question TUNAME "Set a username for Transmission WebUI :"
replace_in_config WEBUI_USERNAME $TUNAME $CONFIG_FILE

TPASS=''
ask_password TPASS "Set a password for Transmission WebUI :"
replace_in_config WEBUI_PASSWORD $TPASS $CONFIG_FILE


if program_is_installed "nginx"; then
    # Nginx Proxy
    if ask_yes_no "You may create a Nginx proxy for Transmission WebUI. Dou you want to create a proxy?" N; then

        TRANS_SERVER=''
        ask_question TRANS_SERVER "Set a domain name for the Nginx proxy :"

        print_step_comment "Configuring Nginx proxy for Transmission..."
        sudo cp -f $SCRIPTPATH/utilities/transmission-nginx-proxy /etc/nginx/sites-available/transmission-proxy
        sudo ln -f -s /etc/nginx/sites-available/transmission-proxy /etc/nginx/sites-enabled/transmission-proxy #symlink
        replace_in_config TRANSMISSION_SERVER_NAME $TRANS_SERVER /etc/nginx/sites-available/transmission-proxy # change server name to listen to


        if program_is_installed "certbot"; then
            # With manual config : certbot certonly -d your.domain.com
            sudo certbot --nginx -d $TRANS_SERVER
        fi
    fi


    # Nginx HTTP Downloads
    if ask_yes_no "You may setup Nginx to download your completed Transmission files via HTTP. Do you want to do this?" N; then

        TRANS_SERVER=''
        ask_question TRANS_SERVER "Set a domain name for the Nginx Downloads :"

        print_step_comment "Configuring Nginx for HTTP downloads..."
        sudo cp -f $SCRIPTPATH/utilities/transmission-nginx-downloads /etc/nginx/sites-available/transmission-downloads
        sudo ln -f -s /etc/nginx/sites-available/transmission-downloads /etc/nginx/sites-enabled/transmission-downloads #symlink
        replace_in_config TRANSMISSION_SERVER_NAME $TRANS_SERVER /etc/nginx/sites-available/transmission-downloads # change server name to listen to
        echo "${TUNAME}:$(openssl passwd -apr1 ${TPASS})" >> /etc/nginx/conf.d/transmission-downloads.htpasswd # append at end of file


        if program_is_installed "certbot"; then
            # With manual config : certbot certonly -d your.domain.com
            sudo certbot --nginx -d $TRANS_SERVER
        fi
    fi


    print_step_comment "Reloading Nginx..."
    sudo service nginx reload
fi


print_step_comment "Starting Transmission..."
sudo service transmission-daemon start


print_success "All done."
transmission-daemon --version
echo

pause_press_enter
show_main_menu