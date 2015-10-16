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

SOFTNAME='PHP 5.6'

# Test if Nginx is installed
nginx -v > /dev/null 2>&1
NGINX_IS_INSTALLED=$?

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

echo -e $YELLOW'--->Refreshing packages list...'$ENDCOLOR
sudo apt-get update

echo
sleep 1

echo -e $YELLOW"--->Adding "$SOFTNAME" repository..."$ENDCOLOR
GREPOUT=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep php5-5.6)
if [ "$GREPOUT" == "" ]; then
    sudo add-apt-repository -y ppa:ondrej/php5-5.6
else
    echo $SOFTNAME" PPA repository already exists..."
fi

echo
sleep 1

echo -e $YELLOW"--->Refreshing packages list again..."$ENDCOLOR
sudo apt-get update

echo
sleep 1

echo -e $YELLOW"--->Installing "$SOFTNAME"..."$ENDCOLOR
sudo apt-get -y install php5-cli php5-fpm php5-json php5-curl php5-mysql php5-pgsql php5-sqlite php5-mcrypt

echo
sleep 1

echo -e $YELLOW"--->Configuring mcrypt extension..."$ENDCOLOR
sudo php5enmod mcrypt

echo
sleep 1

if [[ $NGINX_IS_INSTALLED -ne 0 ]]; then
    echo -e $YELLOW"--->Restarting nginx..."$ENDCOLOR
    sudo service nginx restart
fi

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0