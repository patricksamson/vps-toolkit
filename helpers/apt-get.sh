#!/usr/bin/env bash

# Runs apt-get update silently without interaction
apt-get-update() {
    print_step_comment "Refreshing packages list..."
    apt-get update
}

# Runs apt-get upgrade silently without interaction
apt-get-upgrade() {
    print_step_comment "Upgrading packages..."
    sudo apt-get -y upgrade
}

# Check if a PPA is already registered in apt sources list
#
# e.g.: $(check-ppa-exists ondrej/php)
#
# string    The search keyword that will be used
#
# returns true if the PPA exists, false if nothing was found.
check_ppa_exists() {
    local grepout
    grepout=$(grep -s ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $1)

    if [ "$GREPOUT" == "" ]; then
        return 0 ;
    else
        return 1 ;
    fi
}

# Install software using apt-get
#
# e.g.: $(apt-get-install php7.2-cli php7.2-fpm)
#
# string    The name of the software to install
# This function supports an unlimited number of parameters
apt-get-install() {
    str=
    for i in "$@"; do
        str="$str $i"
    done
    # echo ${str# } # a string with all the parameters concatenated

    sudo apt-get -y install $str
}

# Remove software using apt-get
#
# e.g.: $(apt-get-remove php7.2-cli php7.2-fpm)
#
# string    The name of the software to remove
# This function supports an unlimited number of parameters
apt-get-remove() {
    str=
    for i in "$@"; do
        str="$str $i"
    done
    # echo ${str# } # a string with all the parameters concatenated

    sudo apt-get -y remove $str
    sudo apt-get -y autoremove
}