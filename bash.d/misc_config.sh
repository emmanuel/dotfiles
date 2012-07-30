#!/bin/bash

# Get my name from the system to make it easily available everywhere I might
# need it
if [[ "$( type -t 'getent' )" == 'function' ]]; then
  export MYFULLNAME=$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)
fi

# an argument to the cd builtin command that is not a directory is assumed to
# be the name of a variable whose value is the directory to change to.
shopt -s cdable_vars


# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

# Start typing a command at a shell prompt, then hit up/down for history search
# using the inputted text as the beginning of the search string
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
