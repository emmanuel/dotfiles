# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

alias srvhttp='twistd -n web -p ${PORT:-8888} --path .'

export GREP_OPTIONS='--color=auto'
export GOPATH="${HOME}/Code"
export PATH="${HOME}/.bin:${HOME}/.cargo/bin:${GOPATH}/bin:/usr/local/bin:$PATH"

export DIFF='opendiff'
export EDITOR='mate -w'
export PAGER='less -R'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
