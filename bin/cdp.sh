#!/bin/bash
# --- cdproj.sh ------------------------------------------------------
# Change directory to project
# Copyright (C) 2010  Freddy Vulto
# Version: 1.2.5
# Usage: cdproj [DIR]
#
# Arguments: [DIR]  Project directory to go to
#
# Example:   $~> cdp ru  # Press tab + enter
#            $~/proj/ruby> 
#
# Installation:  See file INSTALL
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software 
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
# MA  02110-1301, USA
#
# The latest version of this software can be obtained here:
# http://fvue.nl/cdp/


 
    # @global string
    # Backup of `errtrace' setting
cdpEnvErrtrace=


    # @global string
    # Backup of `errtrace' setting
cdpEnvSetErrTrace=


    # @global string
    # Backup of `nounset' setting
cdpEnvSetNoUnset=


    # @global string
    # Prefix to use for environment variables
cdpPrefix=CDP


    # @global string
    # Project initialization file .projrc
cdpProjrcfile=.projrc


    # @global string
    # Terminal title.  Valid only if `--title' is specified
cdpOptArgTitle=


    #  @global boolean
    #  True (1) if option `--noprojrc' is specified and `.projrc' must be
    #+ executed, 0 if not.
cdpOptNoprojrc=


    # @global boolean
    # True (1) if option '--notitle' is specified, 0 if not
cdpOptNoTitle=0


	# @global string
	# Project directory
cdpArgProjDir=


	# @global string
	# Script version number
cdpVersion=1.2.5


function cdp_deinit() {
    trap - ERR                          # Reset ERR trap
    (( $cdpEnvSetNoUnset ))  && set +u  # Restore `nounset' setting
    (( $cdpEnvSetErrTrace )) && set +E  # Restore `errtrace' setting
    unset -v cdpArgProjDir cdpEnvErrtrace cdpEnvSetOptions cdpEnvShoptOptions \
             cdpOptArgTitle cdpOptNoprojrc cdpOptNoTitle cdpPrefix cdpProjrcfile cdpVersion
    unset -f cdp_deinit cdp_init cdp_main cdp_out_error cdp_process_arguments \
             cdp_process_options cdp_show_usage

} # cdp_deinit()


function cdp_init() {
    [[ $- = *u* ]]; cdpEnvSetNoUnset=$?      # Backup `nounset' setting
    [[ $- = *E* ]]; cdpEnvSetErrTrace=$?     # Backup `errtrace' setting
    set -o nounset   # Trigger error when expanding unset variables
    set -o errtrace  # Let shell functions inherit ERR trap
    trap 'break 255' ERR  #  255 Should be high enough to break out of all nested
                          #+ loops and reach the `trap-loop'
} # cdp_init()


    # Change directory to project
function cdp_main() {
    local is_cded=0
		# Process arguments
	cdp_process_arguments "$@"

    local dirs="${cdpPrefix}_DIRS[@]"
    for dir in "${!dirs}"; do
        [ -r "$dir/$cdpArgProjDir" ] && cd -P "$dir/$cdpArgProjDir" && is_cded=1 && break
    done
    if (( $is_cded )); then
        # Name terminal
        # See also: http://fvue.nl/NameTerminal
        if (( ! $cdpOptNoTitle )); then
            # If name not set, use first dir of project directory argument
            [ $cdpOptArgTitle ] || cdpOptArgTitle=${cdpArgProjDir/%\/*/}  # Remove suffix '/*'

            [ "${TERM:0:5}" = "xterm" ]   && local ansiNr=0
            [ "$TERM"       = "rxvt" ]    && local ansiNr=61
            [ "$TERM"       = "konsole" ] && local ansiNr=30
                # Change tab title
            [ ${ansiNr:-} ] && echo -n $'\e'"]$ansiNr;$cdpOptArgTitle"$'\a'
        fi
            # Source possible .projrc
        (( $cdpOptNoprojrc )) || [ -r "$cdpProjrcfile" ] && . "$cdpProjrcfile" "$@"
    else
        cdp_out_error "$cdpArgProjDir: No such file or directory"
        false  # Indicate error
    fi
} # cdp_main()


# Show error
# @param $1 string  Error message
function cdp_out_error() {
	echo $(basename $0): $1 1>&2
} # cdp_out_error()


# Process command line arguments
# @param $*  Command line arguments
# @return integer  0 if successful, 1 if not
function cdp_process_arguments {
	local parsedArgs
        # Parse arguments
        # @NOTE: Output of `getopt' is not passed directly to `set',
        #        because this would circumvent the error trap (errexit)
    local options="${cdpPrefix}_OPTIONS"
    parsedArgs=$(getopt -n $0 -o 'hpTt:v' -l 'help,noprojrc,notitle,prefix:,projrcfile:,title:,version' -- ${!options:-} "$@")
    eval set -- $parsedArgs
    cdp_process_options "$@"
        # Skip processed options
    until [ "$1" = "--" ]; do
        shift
    done
    shift  # Skip argument separator '--'

    [[ $# > 0 ]] && cdpArgProjDir="$1"

    return 0
} # cdp_process_arguments()


# Process command line options.
# NOTE: option arguments are already checked by `getopt'
# @param $*  Command line options
# @modifies $bak_show_usage_level
# @modifies $bak_do_exec_main_cmd 
# @return integer  0 if successful, 1 if not.
function cdp_process_options() {
	while true; do
		case "$1" in
            -h | --help) 
                cdp_show_usage verbose
                break 255  # Exit `trap-loop'
                ;;
            -P | --noprojrc)
                cdpOptNoprojrc=1
                ;;
            -T | --notitle)
                cdpOptNoTitle=1
                ;;
            --prefix)
                shift
                cdpPrefix=$1
                ;;
            -p | --projrcfile)
                shift
                cdpProjrcfile="$1"
                ;;
            -t)
                shift
                cdpOptArgTitle="${1#=}"
                ;;
            --title)
                shift
                cdpOptArgTitle="$1"
                ;;
            -v | --version)
                cdp_show_usage version
                break 255  # Exit `trap-loop'
                ;;
            --)
                break
                ;;
		esac
		shift
	done
} # cdp_process_options()


# Show usage
# @param $1  Level: - NULL: no usage must be shown
#                   - 'usage': show basic information
#                   - 'verbose': show verbose information
#                   - 'hint': show hint to --help
function cdp_show_usage() {
	if [ $1 ]; then
        case "$1" in
            hint)
                echo "Try 'cdp --help' for more information."
                ;;
            usage)
                echo "Usage: cdp [options] [DIR]"
                ;;
            verbose) 
                cat <<TXT
Usage: cdp [options] [dir]
Change the current directory to (project) DIR.  The array variable CDP_DIRS
contains a list of directories to be searched.  If the directory is not found,
cd to the first valid directory of CDP_DIRS.

If DIR contains a file .projrc, it is executed unless --noprojrc is specified.

OPTIONS
    -h, --help             display this help and exit
        --prefix=PREFIX    use PREFIX for environment variables.  Default is CDP_
    -p, --projrcfile=FILE  execute commands from FILE instead of standard
                           initialization file .projrc
    -P, --noprojrc         do not execute project initialization file .projrc
    -t, --title=TITLE      specify terminal title.  Default is first dir of DIR.
    -T, --notitle          do not set terminal title
    -v, --version          show version

ENVIRONMENT
    CDP_DIRS     
        An array variable whose members are the directories to be searched when
        the cdp command is executed.  Example definition:

            CDP_DIRS=(\$HOME/proj "\$HOME/Program Files")

    CDP_OPTIONS 
        Default options to be placed in front of any explicit options.

INSTALLING
    1.  Copy the file cdp.sh to a \$PATH directory
    2.  Within ~/.bashrc, create an alias cdp to source cdp.sh in the
        current shell:

            alias cdp='. cdp.sh'

    3.  Copy the file cdp-completion.inc.sh to /etc/bash_completion.d
        If this directory doesn't exist, consider installing 
        http://freshmeat.net/projects/bashcompletion

    4.  Within ~/.bashrc, set an environment variable CDP_DIRS.
        CDP_DIRS is an array variable containing directories to be
        searched by cdp.  Example declaration:

            CDP_DIRS=(\$HOME/proj "\$HOME/Program Files")

EXTENDING
    Suppose you want to have an additional command cdq.  With these settings in
    ~/.bashrc:

        alias cdq='. cdp.sh --prefix=CDQ'
        complete -o filenames -o nospace -F _cdp cdq

    the command cdq will use environment variable CDQ_DIRS instead of CDP_DIRS for
    both cdq tab completion and execution.
TXT
                ;;
            version)
                set > set.txt
                echo cdp $cdpVersion
                ;;
            *)
                echo "show_usage(): Invalid parameter '$1'"
                ;;
        esac
    fi
} # cdp_show_usage()




cdp_init
    # `trap-loop'.  See: http://fvue.nl/wiki/Bash:_Error_handling
while true; do
    cdp_main "$@"
    break
done
cdp_deinit
