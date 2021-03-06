# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.stdin.read())"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.stdin.read())"'

alias srvhttp='twistd -n web -p ${PORT:-8888} --path .'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export GOPATH="${HOME}/Code"
export CARGOPATH="${HOME}/.cargo"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt/node@12/bin:$PATH"
PATH="${GOPATH}/bin:$PATH"
PATH="${CARGOPATH}/bin:$PATH"
PATH="${HOME}/.bin:$PATH"
# PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
# PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
# PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
export PATH
export DIFF='opendiff'
export EDITOR='mate -w'
export PAGER='less -R'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

eval "$(direnv hook bash)"
