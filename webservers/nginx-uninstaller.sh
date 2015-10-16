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

SOFTNAME='Nginx'

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
read -p 'Type y/Y and press [ENTER] to continue with the uninstallation or any other key to exit: '
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

echo -e $YELLOW'--->Stopping '$SOFTNAME'...'$ENDCOLOR
sudo service nginx stop >/dev/null 2>&1
sudo killall nginx >/dev/null 2>&1

echo
sleep 1

echo -e $YELLOW"--->Uninstalling "$SOFTNAME"..."$ENDCOLOR
sudo apt-get -y remove nginx

echo
sleep 1

echo -e $YELLOW'--->Removing '$SOFTNAME' Autostart scripts...'$ENDCOLOR
sudo update-rc.d -f nginx remove || { echo -e $RED'Warning! update-rc.d remove failed.'$ENDCOLOR ; }
sudo rm /etc/init.d/nginx || { echo -e $RED'Warning! Removing init script failed.'$ENDCOLOR ; }

echo
sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo -e $SOFTNAME' Uninstalled.'
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0