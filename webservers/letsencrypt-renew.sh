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

SOFTNAME='Lets Encrypt Shell Client'

ACME_BASEPATH='/var/www/letsencrypt'
ACME_SCRIPTPATH=$ACME_BASEPATH'/letsencrypt.sh'

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

echo
echo -n 'Set the domain or subdomain name that you want to renew and press [ENTER]: (default: empty; renew all)'
read TEMPDOMAIN
if [ -z "$TEMPDOMAIN" ]
     then
     echo -e 'No domain entered. '$CYAN'Attempting to renew all certificates...'$ENDCOLOR
     DOMAIN=''
else
    DOMAIN='-d '$TEMPDOMAIN
fi
echo

sleep 1

read -p 'Force certificate renewal? Type y/Y and press [ENTER]: (default: N)'
RESP=${REPLY,,}
if [ "$RESP" == "y" ]
then
    FORCE='--force'
fi
echo

sleep 1

echo -e $YELLOW"--->Renewing certificates..."$ENDCOLOR
bash $ACME_SCRIPTPATH -c $FORCE $DOMAIN

echo
sleep 1

echo -e $YELLOW"--->Archiving unused certificates..."$ENDCOLOR
bash $ACME_SCRIPTPATH --cleanup

echo
sleep 1

echo -e $YELLOW"--->Setting permissions..."$ENDCOLOR
sudo chown -R :www-data $ACME_BASEPATH
sudo chmod -R 775 $ACME_BASEPATH

echo
sleep 1

echo -e $YELLOW"--->Reloading Nginx configuration..."$ENDCOLOR
sudo nginx -s reload

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0
