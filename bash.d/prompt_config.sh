# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt Items:
# 
#   \u              Username of the current user
#   \h              Hostname up to the first '.'
#   \w              Current working directory
#   $debian_chroot  Current chroot (if any)
#   `__git_ps1`     Current git branch if any
#
PS1NOCOLOR='\[\033[0m\]${debian_chroot:+($debian_chroot)}\u@\h:\w`__git_ps1`\$ '
PS1NOCOLOR='\u@\h:\w`__git_ps1`\$ '
PS1="\[\033[0m\]$PS1NOCOLOR"

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac



ansi_color()
{
   local COLOR_BLACK="\033[0;30m"
   local COLOR_RED="\033[0;31m"
   local COLOR_GREEN="\033[0;32m"
   local COLOR_BROWN="\033[0;33m"
   local COLOR_BLUE="\033[0;34m"
   local COLOR_PURPLE="\033[0;35m"
   local COLOR_CYAN="\033[0;36m"
   local COLOR_LIGHT_GRAY="\033[0;37m"
   local COLOR_DARK_GRAY="\033[1;30m"
   local COLOR_LIGHT_RED="\033[1;31m"
   local COLOR_LIGHT_GREEN="\033[1;32m"
   local COLOR_YELLOW="\033[1;33m"
   local COLOR_LIGHT_BLUE="\033[1;34m"
   local COLOR_LIGHT_PURPLE="\033[1;35m"
   local COLOR_LIGHT_CYAN="\033[1;36m"
   local COLOR_WHITE="\033[1;37m"
   local COLOR_NONE="\033[m"
   local color=$COLOR_NONE
   case "$1" in
      black)        color=$COLOR_BLACK;;
      red)          color=$COLOR_RED;;
      green)        color=$COLOR_GREEN;;
      brown)        color=$COLOR_BROWN;;
      blue)         color=$COLOR_BLUE;;
      purple)       color=$COLOR_PURPLE;;
      cyan)         color=$COLOR_CYAN;;
      light_gray)   color=$COLOR_LIGHT_GRAY;;
      dark_gray)    color=$COLOR_DARK_GRAY;;
      light_red)    color=$COLOR_LIGHT_RED;;
      light_green)  color=$COLOR_LIGHT_GREEN;;
      yellow)       color=$COLOR_YELLOW;;
      light_blue)   color=$COLOR_LIGHT_BLUE;;
      light_purple) color=$COLOR_LIGHT_PURPLE;;
      light_cyan)   color=$COLOR_LIGHT_CYAN;;
      white)        color=$COLOR_WHITE;;
      none)         color=$COLOR_NONE;;
   esac
   echo "$color"
}

set_prompt_color()
{
   local colorname=${1:-none}
   local promptcolor="\[$(ansi_color "$colorname")\]"
   local nocolor="\[$(ansi_color none)\]"
   PS1BAK="$PS1"
   PS1="${promptcolor}${PS1NOCOLOR}${nocolor}"
}  

default_prompt_color()
{
   PS1='\[\033[0m\]$PS1NOCOLOR'
}
