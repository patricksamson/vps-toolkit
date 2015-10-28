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

SOFTNAME='Invoice Ninja'

# Test if MySQL is installed
MYSQL_IS_INSTALLED=1
hash mysql 2>/dev/null || {
    MYSQL_IS_INSTALLED=0
}

# Test if PHP is installed
PHP_IS_INSTALLED=1
hash mysql 2>/dev/null || {
    PHP_IS_INSTALLED=0
}

# Test if Composer is installed
COMPOSER_IS_INSTALLED=1
hash composer 2>/dev/null || {
    COMPOSER_IS_INSTALLED=0
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
sleep 1

echo -e $YELLOW"--->Cloning Git Repository..."$ENDCOLOR
git clone --depth 1 https://github.com/hillelcoren/invoice-ninja.git /var/www/invoice-ninja

echo
sleep 1

echo -e $YELLOW"--->Installing dependencies..."$ENDCOLOR
composer install -d /var/www/invoice-ninja

echo
sleep 1

echo -e $YELLOW"--->Setting permissions..."$ENDCOLOR
sudo chown -R $UNAME:www-data /var/www/invoice-ninja

echo
sleep 1

echo -e $YELLOW"--->Creating Database..."$ENDCOLOR
# create the database if it does exist
sudo mysql -e "create database IF NOT EXISTS ninja;"
echo -e 'Database '$CYAN'ninja'$ENDCOLOR ' was configured'

echo -e $YELLOW"--->Granting permissions to Database..."$ENDCOLOR
# create the user if it doesn't exist, and grant permissions
sudo mysql -e "GRANT ALL ON ninja.* To 'ninja'@'localhost' IDENTIFIED BY 'ninja';"
echo -e 'User '$CYAN'ninja'$ENDCOLOR' was granted permissions on database '$CYAN'ninja'$ENDCOLOR

echo
sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
composer -V
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0