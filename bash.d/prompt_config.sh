#!/bin/bash

# bash_prompt (mainly) from: https://github.com/necolas/dotfiles
# with further inspiration from:
# http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/

# Example:
# nicolas@host: ~/.dotfiles on master[+!?$]
# $

# Screenshot: http://i.imgur.com/DSJ1G.png
# iTerm2 prefs: import Solarized theme (disable bright colors for bold text)
# Color ref: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
# More tips: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html


# Check that terminfo exists before changing TERM var to xterm-256color
# Prevents prompt flashing in Mac OS X 10.6 Terminal.app
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
fi

tput sgr 0 0

# Base styles and color palette
# Solarized colors
# https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
BOLD=$(tput bold)
RESET=$(tput sgr0)
SOLAR_YELLOW=$(tput setaf 136)
SOLAR_ORANGE=$(tput setaf 166)
SOLAR_RED=$(tput setaf 124)
SOLAR_MAGENTA=$(tput setaf 125)
SOLAR_VIOLET=$(tput setaf 61)
SOLAR_BLUE=$(tput setaf 33)
SOLAR_CYAN=$(tput setaf 37)
SOLAR_GREEN=$(tput setaf 64)
SOLAR_WHITE=$(tput setaf 254)

style_user="\[${RESET}${SOLAR_ORANGE}\]"
style_host="\[${RESET}${SOLAR_YELLOW}\]"
style_path="\[${RESET}${SOLAR_GREEN}\]"
style_chars="\[${RESET}${SOLAR_WHITE}\]"
style_status_clean="\[${RESET}${SOLAR_GREEN}\]"
style_status_nonzero="\[${RESET}${SOLAR_RED}\]"
style_branch="\[${SOLAR_CYAN}\]"

if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    style_host="\[${BOLD}${SOLAR_RED}\]"
elif [[ "$USER" == "root" ]]; then
    # logged in as root
    style_user="\[${BOLD}${SOLAR_RED}\]"
fi

is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}

is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}

get_git_branch() {
    local branch_name

    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"

    printf $branch_name
}

# Git status information
prompt_git() {
    local git_info git_info_colorized git_state uncommitted unstaged untracked stashed

    if ! is_git_repo || is_git_dir; then
        return 1
    fi

    git_info=$(__git_ps1)

    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        uncommitted="+"
    fi

    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        unstaged="!"
    fi

    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        untracked="?"
    fi

    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        stashed="$"
    fi

    git_state=$uncommitted$unstaged$untracked$stashed

    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="${git_info}[${git_state}]"
    fi

    printf "${git_info}"
}

# set up command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    # Set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    # Build the prompt
    if [ $EXIT -eq 0 ]; then
      PS1+="[${style_status_clean}\!\[${RESET}\]] "
    else
      PS1+="[${style_status_nonzero}\!\[${RESET}\]] "
    fi
    # PS1+="\n" # Newline
    PS1+="${style_user}\u" # Username
    PS1+="${style_chars}@" # @
    PS1+="${style_host}\h" # Host
    PS1+="${style_chars}: " # :
    PS1+="${style_path}\w" # Working directory
    PS1+="${style_branch}$(prompt_git)\[${RESET}\]" # Git details
    # PS1+="\n" # Newline
    PS1+="${style_chars}\$ \[${RESET}\]" # $ (and reset color)
}

PROMPT_COMMAND=__prompt_command
