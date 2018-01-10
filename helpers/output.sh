#!/usr/bin/env bash

# Text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'

# Background colors
BGRED='\033[0;41m'
BGGREEN='\033[0;42m'
BGYELLOW='\033[0;43m'
BGBLUE='\033[0;44m'
BGMAGENTA='\033[0;45m'
BGCYAN='\033[0;46m'

# Reset colors
ENDCOLOR='\033[0m'

#for (( i = 30; i < 50; i++ )); do echo -e "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i)"; done

print_header() {
    clear
    echo
    echo -e $RED
    echo -e "    _    _   _ _  _ ____ ____ ____ _  _ ____ ____"
    echo -e "    |     \_/  |_/  |___ | __ |___ |\ | |___ [__ "
    echo -e "    |___   |   | \_ |___ |__] |___ | \| |___ ___]"
    echo -e $CYAN
    echo -e " __     ______  ____    _____           _ _    _ _   "
    echo -e " \ \   / /  _ \/ ___|  |_   _|__   ___ | | | _(_) |_ "
    echo -e "  \ \ / /| |_) \___ \    | |/ _ \ / _ \| | |/ / | __|"
    echo -e "   \ V / |  __/ ___) |   | | (_) | (_) | |   <| | |_ "
    echo -e "    \_/  |_|   |____/    |_|\___/ \___/|_|_|\_\_|\__|"
    echo
}

# Print an error message.
#
# e.g.: $(print_error "This is an error!")
#
# string    The error message
print_error() {
    echo -e $RED$1$ENDCOLOR
}

# Print a success message.
#
# e.g.: $(print_success "It works!")
#
# string    The success message
print_success() {
    echo
    echo -e $GREEN$1$ENDCOLOR
}

# Print a message that indicates the progress or step that will be executed.
#
# e.g.: $(print_step_comment "Executing some code...")
#
# string    The step message
print_step_comment() {
    echo
    echo -e $YELLOW'--->'$1$ENDCOLOR
}

# Pause the program execution until the user presses on Enter.
pause_press_enter() {
    echo
    echo -en $BGBLUE'Press [Enter] key to continue... '$ENDCOLOR
    read -p "$*"
}

# Ask a simple yes/no question to the user.
#
# e.g.: $(ask_yes_no "Do you want to do such-and-such?" Y)
#
# string    The question or message
# Y || N    Optional. The default value.
ask_yes_no() {
    # https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -en "$YELLOW$1 [$prompt]$ENDCOLOR "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

# Ask a simple question to the user.
#
# e.g.: $(ask_question return_var "What is your favourite fruit?")
#
# variable  The variable that will contain the user's answer
# string    The question or message
ask_question() {
    local reply

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -en "$YELLOW$2 $ENDCOLOR"

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    eval "$1=$reply"
}

# Ask the user to type in a password. The input is hidden.
#
# e.g.: $(ask_password return_var "Enter your password")
#
# variable  The variable that will contain the user's answer
# string    The question or message
ask_password() {
    local reply

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -en "$YELLOW$2 $ENDCOLOR"

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    stty -echo #hide input
    read reply </dev/tty
    stty echo #show input

    echo # newline

    eval "$1=$reply"
}


ask_proceed_installation() {
    if ! ask_yes_no "This will install $1 on your system. Do you want to continue?" N; then
        print_error "So you chickened out. May be you will try again later."
        pause_press_enter
        show_main_menu
    fi
}


# Determine if the specified program is installed, and found in the PATH.
#
# e.g.: $(program_is_installed "nginx")
#
# string    The program's command name
program_is_installed() {
    hash $1 2>/dev/null || {
        # It's not installed
        return 1;
    }

    # We found it!
    return 0;
}