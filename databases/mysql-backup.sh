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

SOFTNAME='MySQL'

OUTPUTDIR=/backups/mysql/

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
echo -e $YELLOW"If you're looking to restore a SQL dump, run this command : "$ENDCOLOR
echo -e $CYAN"zcat /path/to/file.sql.gz | mysql -u 'root' -p'password' your_database"$ENDCOLOR
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

echo -n "Enter the $SOFTNAME user to use and press [ENTER]: "
read UNAME
if [ -z "$UNAME" ]
     then
     echo -e '    '$RED'No Username entered.'$ENDCOLOR
     exit 1
fi

echo -n "Enter the $SOFTNAME password and press [ENTER]: "
stty -echo #hide input
read UPASS
stty echo #show input
if [ -z "$UPASS" ]
     then
     echo -e '    '$RED'No Password entered.'$ENDCOLOR
     exit 1
fi

echo
sleep 1

echo -e $YELLOW"--->Creating Backup directory..."$ENDCOLOR
mkdir -p $OUTPUTDIR
echo -e $CYAN"Backups will be placed in $GREEN$OUTPUTDIR"$ENDCOLOR

echo
sleep 1

echo -e $YELLOW"--->Backing up all MySQL databases..."$ENDCOLOR
DATABASES=`mysql -u $UNAME -p$UPASS --batch --skip-column-names -e "SHOW DATABASES;" | grep -E -v "(information|performance)_schema"`
for DB in $DATABASES; do
    echo -e "Dumping database:$CYAN $DB"$ENDCOLOR
    sudo mysqldump -u $UNAME -p$UPASS --databases $DB | gzip > $OUTPUTDIR$DB-`date +%Y%m%d%H%M%S`.sql.gz
done

echo
sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
mysql -V
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0
