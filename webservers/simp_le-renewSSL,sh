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

SOFTNAME='Simp_le Lets Encrypt Client'

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
echo -e $GREEN'Lykegenes '$SOFTNAME' SSL Renew Script'$ENDCOLOR

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
echo -n 'Set the domain or subdomain name that you want to renew and press [ENTER]: (required)'
read DOMAIN
if [ -z "$DOMAIN" ]
     then
     echo -e $RED'No domain name entered. Exiting now.'$ENDCOLOR
     echo
     pause 'Press [Enter] key to continue...'
     cd $SCRIPTPATH
     sudo ./setup.sh
     exit 0
fi
echo

sleep 1

echo
echo -n 'Set the full webroot path for this domain and press [ENTER]: (/var/www/)'
read WEBROOT
if [ -z "$WEBROOT" ]
     then
     echo -e '    No webroot path entered so setting default webroot: '$CYAN'/var/www/'$ENDCOLOR
     WEBROOT=/var/www/
fi
echo

echo
sleep 1

echo -e $YELLOW"--->Renewing SSL Certificate..."$ENDCOLOR
sudo mkdir -p /certs/$DOMAIN
cd /certs/$DOMAIN
sudo simp_le -d $DOMAIN:$WEBROOT -f account_key.json -f key.pem -f cert.pem -f fullchain.pem

echo
sleep 1

echo -e $YELLOW"--->Setting permissions..."$ENDCOLOR
sudo chown -R :www-data /certs/$DOMAIN

echo
sleep 1

echo -e $YELLOW"--->Reloading Nginx configuration..."$ENDCOLOR
sudo nginx -s reload

echo
sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
simp_le --version
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0
