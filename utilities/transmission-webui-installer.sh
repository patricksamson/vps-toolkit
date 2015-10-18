#!/bin/bash
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.
YELLOW='\e[93m'
RED='\e[91m'
ENDCOLOR='\033[0m'
CYAN='\e[96m'
GREEN='\e[92m'
SCRIPTPATH=$(pwd)

SOFTNAME='Transmission Web UI'

# Test if Nginx is installed
NGINX_IS_INSTALLED=1
hash nginx 2>/dev/null || {
    NGINX_IS_INSTALLED=0
}

function pause(){
     read -p "$*"
}

clear
echo
echo -e $RED
echo -e "_    _   _ _  _ ____ ____ ____ _  _ ____ ____"
echo -e "|     \_/  |_/  |___ | __ |___ |\ | |___ [__ "
echo -e "|___   |   | \_ |___ |__] |___ | \| |___ ___]"
echo -e $CYAN
echo -e " __     ______  ____    _____           _ _    _ _   "
echo -e " \ \   / /  _ \/ ___|  |_   _|__   ___ | | | _(_) |_ "
echo -e "  \ \ / /| |_) \___ \    | |/ _ \ / _ \| | |/ / | __|"
echo -e "   \ V / |  __/ ___) |   | | (_) | (_) | |   <| | |_ "
echo -e "    \_/  |_|   |____/    |_|\___/ \___/|_|_|\_\_|\__|"
echo
echo -e $GREEN'Lykegenes '$SOFTNAME' Installer Script'$ENDCOLOR

echo
read -p 'Type y/Y and press [ENTER] to continue with the installation or any other key to exit: '
RESP=${REPLY,,}

if [ "$RESP" != "y" ]
then
        echo -e $RED'So you chickened out. May be you will try again later.'$ENDCOLOR
        echo
        pause 'Press [Enter] key to continue...'
        cd $SCRIPTPATH
        sudo ./setup.sh
        exit 0
fi

echo

echo -n 'Type the username of the user you want to run Transmission as and press [ENTER]. Typically, this is your system login name (IMPORTANT! Ensure correct spelling and case): '
read UNAME

if [ ! -d "/home/$UNAME" ] || [ -z "$UNAME" ]; then
        echo -e $RED'Bummer! You may not have entered your username correctly. Exiting now. Please rerun script.'$ENDCOLOR
        echo
        pause 'Press [Enter] key to continue...'
        cd $SCRIPTPATH
        sudo ./setup.sh
        exit 0
fi
UGROUP=($(id -gn $UNAME))

echo

echo -e $YELLOW'--->Refreshing packages list...'$ENDCOLOR
sudo apt-get update

echo
sleep 1

echo -e $YELLOW"--->Installing prerequisites..."$ENDCOLOR
sudo apt-get -y install python-software-properties

echo
sleep 1

echo -e $YELLOW"--->Adding Transmission repository..."$ENDCOLOR
GREPOUT=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep transmissionbt)
if [ "$GREPOUT" == "" ]; then
        sudo add-apt-repository -y ppa:transmissionbt/ppa
else
        echo "Transmission PPA repository already exists..."
fi

echo
sleep 1

echo -e $YELLOW"--->Refreshing packages list again..."$ENDCOLOR
sudo apt-get update

echo
sleep 1

echo -e $YELLOW"--->Installing Transmission commandline, and web interface..."$ENDCOLOR
sudo apt-get -y install transmission-cli transmission-common transmission-daemon

echo
sleep 1

echo -e $YELLOW"--->Stopping Transmission temporarily..."$ENDCOLOR
sudo /etc/init.d/transmission-daemon stop > /dev/null 2>&1
sleep 2
sudo service transmission-daemon stop > /dev/null 2>&1
sleep 2
sudo killall transmission-daemon > /dev/null 2>&1
sleep 2

echo
sleep 1

echo -e $YELLOW"--->Creating download directories..."$ENDCOLOR
if [ ! -d "/home/$UNAME/transmission" ]; then
        mkdir /home/$UNAME/transmission
fi
if [ ! -d "/home/$UNAME/transmission/completed" ]; then
        mkdir /home/$UNAME/transmission/completed
fi
if [ ! -d "/home/$UNAME/transmission/incomplete" ]; then
        mkdir /home/$UNAME/transmission/incomplete
fi

echo -e 'Following directories created...'
echo -e $CYAN'/home/'$UNAME'/transmission/completed'$ENDCOLOR ' - Completed Downloads'
echo -e $CYAN'/home/'$UNAME'/transmission/incomplete'$ENDCOLOR ' - Incomplete Downloads'

sleep 1
echo

echo -e $YELLOW"--->Copying settings file..."$ENDCOLOR
CONFIG_FILE="/etc/transmission-daemon/settings.json"
sudo cp -a -f $CONFIG_FILE $CONFIG_FILE.default
sudo cp -f $SCRIPTPATH/utilities/transmission-initial-settings.json $CONFIG_FILE

sleep 1
echo

echo -e $YELLOW"--->Setting permissions..."$ENDCOLOR
sudo usermod -aG debian-transmission $UNAME  || { echo -e $RED'Adding debian-transmission group to user failed.'$ENDCOLOR ; exit 1; }
sudo chown $UNAME:debian-transmission $CONFIG_FILE  || { echo -e $RED'Chown settings.json failed'$ENDCOLOR ; exit 1; }
sudo chmod 775 $CONFIG_FILE
sudo chown -R $UNAME:debian-transmission /home/$UNAME/transmission
sudo chmod -R 775 /home/$UNAME/transmission
sudo chmod g+s /home/$UNAME/transmission

echo
sleep 1

echo -e $YELLOW"--->Setting up Transmission User, WebUI User and Password..."$ENDCOLOR
sed -i 's|USER_NAME|'$UNAME'|g' $CONFIG_FILE || { echo -e $RED'Replacing username in settings-json failed.'$ENDCOLOR ; exit 1; }

echo -n 'Set a username for Transmission WebUI and press [ENTER]: '
read TUNAME
if [ -z "$TUNAME" ]
     then
     echo -e '    No username entered so setting default username: '$CYAN'transmission'$ENDCOLOR
     TUNAME=transmission
     else
     echo -e '    WebUI username set to:'$CYAN $TUNAME $ENDCOLOR
fi
sed -i 's|WEBUI_USERNAME|'$TUNAME'|g' $CONFIG_FILE || { echo -e $RED'Setting new username in settings.json failed.'$ENDCOLOR ; exit 1; }

echo -n 'Set a password for Transmission WebUI and press [ENTER]: '
stty -echo #hide input
read TPASS
stty echo #show input
if [ -z "$TPASS" ]
     then
     echo -e '    No password entered so setting default password: '$CYAN'transmission'$ENDCOLOR
     TPASS=transmission
     else
     echo -e '    WebUI password set successfully.'
fi
sed -i 's|WEBUI_PASSWORD|'$TPASS'|g' $CONFIG_FILE || { echo -e $RED'Setting new password in settings.json failed.'$ENDCOLOR ; exit 1; }
sed -i 's|USER_NAME|'$UNAME'|g' $CONFIG_FILE || { echo -e $RED'Replacing username in settings.json failed.'$ENDCOLOR ; exit 1; }

echo
sleep 1

if [[ $NGINX_IS_INSTALLED -eq 1 ]]; then
    read -p 'You may create a Nginx Proxy for Transmission. Do you want to create a proxy? Type y/Y and press [ENTER]: '
    NGINX_PROXY=${REPLY,,}
    if [ "$NGINX_PROXY" = "y" ]; then
        echo
        echo -n 'Set a server name for the Nginx Proxy and press [ENTER]: (transmission.localhost)'
        read TRANS_SERVER
        if [ -z "$TRANS_SERVER" ]
             then
             echo -e '    No server name entered so setting default server name: '$CYAN'transmission.localhost'$ENDCOLOR
             TRANS_SERVER=transmission.localhost
        fi
        echo
        echo -e $YELLOW'--->Configuring Nginx Proxy for Transmission...'$ENDCOLOR
        sudo cp -f $SCRIPTPATH/utilities/transmission-nginx-proxy /etc/nginx/sites-available/transmission-proxy
        sudo ln -f -s /etc/nginx/sites-available/transmission-proxy /etc/nginx/sites-enabled/transmission-proxy #symlink
        sed -i 's|TRANSMISSION_SERVER_NAME|'$TRANS_SERVER'|g' /etc/nginx/sites-available/transmission-proxy # change server name to listen to
    fi

    echo
    sleep 1

    read -p 'You may setup Nginx to download your completed Transmission file via HTTP. Do you want to do this? Type y/Y and press [ENTER]: '
    NGINX_DOWNLOAD=${REPLY,,}
    if [ "$NGINX_DOWNLOAD" = "y" ]; then
        echo
        echo -n 'Set a server name for the Nginx Downloads and press [ENTER]: (downloads.localhost)'
        read TRANS_SERVER
        if [ -z "$TRANS_SERVER" ]
             then
             echo -e '    No server name entered so setting default server name: '$CYAN'downloads.localhost'$ENDCOLOR
             TRANS_SERVER=downloads.localhost
        fi
        echo
        echo -e $YELLOW'--->Configuring Nginx for HTTP downloads...'$ENDCOLOR
        sudo cp -f $SCRIPTPATH/utilities/transmission-nginx-downloads /etc/nginx/sites-available/transmission-downloads
        sudo ln -f -s /etc/nginx/sites-available/transmission-downloads /etc/nginx/sites-enabled/transmission-downloads #symlink
        sed -i 's|TRANSMISSION_USERNAME|'$UNAME'|g' /etc/nginx/sites-available/transmission-downloads # change root to completed folder
        sed -i 's|TRANSMISSION_SERVER_NAME|'$TRANS_SERVER'|g' /etc/nginx/sites-available/transmission-downloads # change server name to listen to
        echo "${TUNAME}:$(openssl passwd -apr1 ${TPASS})" >> /etc/nginx/conf.d/transmission-downloads.htpasswd # append at end of file
    fi

    echo
    sleep 1

    echo -e $YELLOW"--->Restarting nginx..."$ENDCOLOR
    sudo service nginx reload
fi

echo -e $YELLOW"--->Starting Transmission..."$ENDCOLOR
sudo service transmission-daemon start

echo
sleep 1

echo -e $YELLOW"--->Updating Transmission Peers Blocklist..."$ENDCOLOR
transmission-remote --auth $TUNAME:$TPASS --blocklist-update

echo
sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0