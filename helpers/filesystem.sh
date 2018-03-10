#!/usr/bin/env bash


# Copy a configuration file to the specified destination
#
# e.g.: $(copy_config_file $SCRIPTPATH/utilities/transmission-initial-settings.json /etc/transmission-daemon/settings.json)
#
# string    The source config file
# string    The destination config file
copy_config_file() {
    sudo cp -f $1 $2
}

# Replace all occurences of a keyword in the specified configuration file
#
# e.g.: $(replace_in_config USER_NAME Lykegenes /etc/transmission-daemon/settings.json)
#
# string    The search keyword that will be used
# string    The new value that will be set
# string    The path to the config file
replace_in_config() {
    sed -i 's|'$1'|'$2'|g' $3 || { print_error "Failed to replace ${1} in file ${2}"; exit 1; }
}


# Create a directory structure recursively if it doesn't exist.
#
# e.g.: $(create_directory /home/someuser/transmission/completed)
#
# string    The search keyword that will be used
create_directory() {
    if [ ! -d "${1}" ]; then
        mkdir -p $1
    fi
}


# Set owner of directory structure recursively
#
# e.g.: $(set_file_owner user:group /home/someuser/transmission/completed)
#
# string    The username and/or usergroup names
# string    The file or directory
set_file_owner() {
    sudo chown -R $1 $2 || { print_error "Failed to set owner of file ${2}"; exit 1; }
}


# Set permissions of directory structure recursively
#
# e.g.: $(set_file_permission 775 /home/someuser/transmission/completed)
#
# string    The username and/or usergroup names
# string    The file or directory
set_file_permission() {
    sudo chmod -R $1 $2 || { print_error "Failed to set permissions of file ${2}"; exit 1; }
}