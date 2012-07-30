#!/bin/bash

alias vish='vim $DBASH'
alias gvish='gvim $DBASH'
alias reloadsh='source $HOME/.bashrc'

alias myalias='showaliases $DBASH/* $DBASH/local/after/* $DBASH/local/before/*'

alias vivi='vim $HOME/.vimrc'
alias gvivi='gvim $HOME/.vimrc'

alias viil='vim $DSYSDATA/install.log -c "\$"'
alias gviil='gvim $DSYSDATA/install.log -c "\$"'

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..?='show_parent_dirs'

alias du1='du --max-depth 1'
alias dumd='du --max-depth'

alias lesstail='less +F'
alias less='less -R'
alias ll='ls -lha'
