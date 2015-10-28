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

echo -e $YELLOW'--->Setting up Username and Password...'$ENDCOLOR
echo -n 'Set a Username and press [ENTER]: '
read UNAME
if [ -z "$UNAME" ]
     then
     echo -e '    '$RED'No Username entered.'$ENDCOLOR
     exit 1
fi
sudo useradd $UNAME --create-home --shell /bin/bash || { echo -e $RED'Creating user failed.'$ENDCOLOR ; exit 1; }

echo -n 'Set a Password and press [ENTER]: '
stty -echo #hide input
read UPASS
stty echo #show input
if [ -z "$UPASS" ]
     then
     echo -e '    '$RED'No Password entered.'$ENDCOLOR
     exit 1
fi
echo ${UNAME}:${UPASS} | chpasswd

echo
sleep 1

echo -e $YELLOW'--->Configuring user...'$ENDCOLOR
read -p 'Do you want to create a SSH key for this user? Type y/Y and press [ENTER]: '
SSHKEY=${REPLY,,}
if [ "$SSHKEY" = "y" ]; then
    echo -n 'Enter your email and press [ENTER]: '
    read EMAIL
    sudo mkdir /home/$UNAME/.ssh
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f /home/$UNAME/.shh/id_rsa
    eval "$(ssh-agent -s)"
    ssh-add /home/$UNAME/.ssh/id_rsa
    cat /home/$UNAME/.ssh/id_rsa.pub
    sudo chown -R $UNAME:$UNAME /home/$UNAME/.ssh
fi

read -p 'Add User to Sudoers? Type y/Y and press [ENTER]: '
ANSWER=${REPLY,,}
if [ "$ANSWER" = "y" ]; then
    sudo usermod -aG sudo $UNAME
fi

read -p 'Add User to "www-data" group? Type y/Y and press [ENTER]: '
ANSWER=${REPLY,,}
if [ "$ANSWER" = "y" ]; then
    sudo usermod -aG www-data $UNAME
fi

echo
sleep 1

echo -e $YELLOW'--->Reloading SSH service...'$ENDCOLOR
service ssh reload

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0