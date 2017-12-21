#!/usr/bin/env bash

source helpers/output.sh

print_header

print_error "erp derp"

# Default to Yes if the user presses enter without giving an answer:
if ask_yes_no "Do you want to do such-and-such?" Y; then
    echo "Yes"
else
    echo "No"
fi

return_var=''
ask_question return_var "What is your favourite fruit?"
echo $return_var

return_var=''
ask_password return_var "Enter your password"
echo $return_var