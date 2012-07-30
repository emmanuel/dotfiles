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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# vim: ft=bash fdm=marker expandtab ts=3 sw=3 :

