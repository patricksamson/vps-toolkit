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

SOFTNAME='Lets Encrypt Sell Client'

ACME_PATH='/var/www/letsencrypt'

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
echo -e $CYAN"You might need to stop some services in low-memory environments..."$ENDCOLOR
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

echo -e $YELLOW"--->Installing "$SOFTNAME"..."$ENDCOLOR
sudo git clone https://github.com/lukas2511/letsencrypt.sh $ACME_PATH

echo
sleep 1

echo -e $YELLOW"--->Creating SSL Certificates folder..."$ENDCOLOR
sudo mkdir -p $ACME_PATH/certs/
sudo mkdir -p $ACME_PATH/archive/
sudo mkdir -p $ACME_PATH/.acme-challenge/
sudo chown -R :www-data $ACME_PATH
sudo chmod -R 775 $ACME_PATH
echo -e $CYAN$ACME_PATH$ENDCOLOR ' - Folder created; your SSL Certificates will be in there'

echo

echo -e $YELLOW"--->Copying Configuration files..."$ENDCOLOR
sudo cp -R -f $SCRIPTPATH/webservers/letsencrypt-settings.conf $ACME_PATH/settings.sh

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0
