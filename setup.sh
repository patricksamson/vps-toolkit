#!/usr/bin/env bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.

# Determine the base path of this script.
# echo "The script you are running has basename `basename "$0"`, dirname `dirname "$0"`"
# echo "The present working directory is `pwd`"
SCRIPTPATH=$(dirname "$0")

source $SCRIPTPATH'/helpers/output.sh'
source $SCRIPTPATH'/helpers/apt-get.sh'
source $SCRIPTPATH'/helpers/filesystem.sh'

sudo chmod -R 775 * >/dev/null 2>&1

function pause(){
   read -p "$*"
}

if [ "$EUID" -ne 0 ]
  then
  echo
  echo -e $RED'Please run as root using the command: '$ENDCOLOR'sudo /opt/vps-toolkit/setup.sh'
  echo
  exit 0
fi

show_main_menu() {
    print_header

    echo
    echo -e 'NOTE: At this point, this script has been confirmed to work only on Ubuntu variants.'
    echo
    echo -e $YELLOW'00. '$ENDCOLOR'Check and Update Lykegenes VPS ToolKit'
    echo -e $YELLOW'02. '$ENDCOLOR'Install the Base Tool and Utilities'
    echo -e $YELLOW'03. '$ENDCOLOR'Configure a new User'
    echo -e $YELLOW'04. '$ENDCOLOR'Create a MySQL or MariaDB User'
    echo -e $YELLOW'10. '$ENDCOLOR'Nginx - Install'
    echo -e $YELLOW'11. '$ENDCOLOR'Nginx - Uninstall'
    echo -e $YELLOW'12. '$ENDCOLOR'Certbot - Install'
    echo -e $YELLOW'20. '$ENDCOLOR'PostgreSQL - Install'
    echo -e $YELLOW'21. '$ENDCOLOR'PostgreSQL - Uninstall'
    echo -e $YELLOW'22. '$ENDCOLOR'MySQL - Install'
    echo -e $YELLOW'23. '$ENDCOLOR'MySQL - Uninstall'
    echo -e $YELLOW'24. '$ENDCOLOR'MariaDB - Install'
    echo -e $YELLOW'25. '$ENDCOLOR'MariaDB - Uninstall'
    echo -e $YELLOW'28. '$ENDCOLOR'Automysqlbackup - Install'
    echo -e $YELLOW'30. '$ENDCOLOR'PHP - Install'
    echo -e $YELLOW'31. '$ENDCOLOR'PHP - Uninstall'
    echo -e $YELLOW'34. '$ENDCOLOR'Composer - Install'
    echo -e $YELLOW'35. '$ENDCOLOR'Composer - Uninstall'
    echo -e $YELLOW'36. '$ENDCOLOR'Node.js - Install'
    echo -e $YELLOW'37. '$ENDCOLOR'Node.js - Uninstall'
    echo -e $YELLOW'60. '$ENDCOLOR'Transmission Web UI - Install'
    echo -e $YELLOW'61. '$ENDCOLOR'Transmission Web UI - Uninstall'
    echo -e $YELLOW'62. '$ENDCOLOR'Invoice Ninja - Install'
    echo -e $YELLOW'63. '$ENDCOLOR'Invoice Ninja - Update'
    echo -e $YELLOW'98. '$ENDCOLOR'Tests'
    echo -e $YELLOW'99. '$ENDCOLOR'Exit'

    echo
    echo -n "What would you like to do? [00-99]: "
    read option
    case $option in
        0 | 00)
            echo
            echo -e $YELLOW'--->Checking for updates...'$ENDCOLOR
            cd $SCRIPTPATH
            git fetch origin bash-rewrite
            git reset --hard FETCH_HEAD
            git clean -df
            echo
            pause 'Press [Enter] to restart and continue...'
            cd $SCRIPTPATH
            sudo bash $SCRIPTPATH'/setup.sh'
            exit 0
            ;;
        2 | 02)
            source $SCRIPTPATH'/utilities/base-tools-installer.sh'
            ;;
        3| 03)
            source $SCRIPTPATH'/users/create-user.sh'
            ;;
        4| 04)
            sudo $SCRIPTPATH'/users/create-mysql-user.sh'
            ;;
        10)
            source $SCRIPTPATH'/webservers/nginx-installer.sh'
            ;;
        11)
            sudo $SCRIPTPATH'/webservers/nginx-uninstaller.sh'
            ;;
        12)
            source $SCRIPTPATH'/webservers/certbot-installer.sh'
            ;;
        20)
            sudo $SCRIPTPATH'/databases/pgsql-installer.sh'
            ;;
        21)
            sudo $SCRIPTPATH'/databases/pgsql-uninstaller.sh'
            ;;
        22)
            sudo $SCRIPTPATH'/databases/mysql-installer.sh'
            ;;
        23)
            sudo $SCRIPTPATH'/databases/mysql-uninstaller.sh'
            ;;
        24)
            source $SCRIPTPATH'/databases/mariadb-installer.sh'
            ;;
        25)
            sudo $SCRIPTPATH'/databases/mariadb-uninstaller.sh'
            ;;
        28)
            source $SCRIPTPATH'/databases/automysqlbackup-installer.sh'
            ;;
        30)
            source $SCRIPTPATH'/php/php-installer.sh'
            ;;
        31)
            sudo $SCRIPTPATH'/php/php-uninstaller.sh'
            ;;
        34)
            source $SCRIPTPATH'/php/composer-installer.sh'
            ;;
        35)
            sudo $SCRIPTPATH'/php/composer-uninstaller.sh'
            ;;
        36)
            source $SCRIPTPATH'/node/node-installer.sh'
            ;;
        37)
            sudo $SCRIPTPATH'/node/node-uninstaller.sh'
            ;;
        60)
            source $SCRIPTPATH'/utilities/transmission-webui-installer.sh'
            ;;
        61)
            sudo $SCRIPTPATH'/utilities/transmission-webui-uninstaller.sh'
            ;;
        62)
            sudo $SCRIPTPATH'/apps/invoice-ninja-installer.sh'
            ;;
        63)
            sudo $SCRIPTPATH'/apps/invoice-ninja-updater.sh'
            ;;
        98)
            source $SCRIPTPATH'/test.sh'
            ;;
        99)
            echo 'Exiting...'
            echo
            echo -e $YELLOW'Thank you for using the Lykegenes VPS ToolKit!'$ENDCOLOR
            echo
            ;;
        *)
            echo -e $RED'Invalid Option'$ENDCOLOR
            ScriptLoc=$(readlink -f "$0")
            sleep 1
            exec $ScriptLoc

    esac
}

##########################
# Start script execution #
##########################
show_main_menu
