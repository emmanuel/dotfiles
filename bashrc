# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source_file()
{
    local conf_file="$1"
    if [[ -f $conf_file && $(basename $conf_file) != 'README' ]]
    then
        source "$conf_file"
    fi
}

source_dir()
{
    local dir="$1"
    if [[ -d $dir ]]
    then
        local conf_file
        for conf_file in "$dir"/*
        do
            source_file $conf_file
        done
    fi
}

source_dir /usr/local/etc/bash_completion.d
source_dir ~/.bash.d/local/before
source_dir ~/.bash.d
source_dir ~/.bash.d/local/after
