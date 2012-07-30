#!/bin/bash

export DIFF='opendiff'
export EDITOR='mate -w'
export PAGER='less -R'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# an argument to the cd builtin command that is not a directory is assumed to
# be the name of a variable whose value is the directory to change to.
shopt -s cdable_vars

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize
