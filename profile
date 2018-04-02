# executed by command interpreter for login shells

# if running bash
if [ -n "$BASH_VERSION" ]; then
   # include .bashrc if it exists
   if [ -f "$HOME/.bashrc" ]; then
     . "$HOME/.bashrc"
   fi
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f "${HOME}/.prompt_config.sh" ]; then
  "${HOME}/.prompt_config.sh"
fi

# No duplicate lines or lines beginning with spaces
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="ls:cd:pwd"

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

# Start typing a command at a shell prompt, then hit up/down for history search
# using the inputted text as the beginning of the search string
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
