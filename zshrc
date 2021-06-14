# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.stdin.read())"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.stdin.read())"'

alias srvhttp='twistd -n web -p ${PORT:-8888} --path .'

export GOPATH="${HOME}/Code"
export CARGOPATH="${HOME}/.cargo"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt/node@12/bin:$PATH"
PATH="${GOPATH}/bin:$PATH"
PATH="${CARGOPATH}/bin:$PATH"
PATH="${HOME}/.bin:$PATH"
# export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
# export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
# export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH

export DIFF='opendiff'
export EDITOR='mate -w'
export PAGER='less -R'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

eval "$(direnv hook zsh)"

# enable git completions; see: https://stackoverflow.com/a/54629182/5153603
zstyle ':completion:*:*:git:*' script ~/.zsh/completions/git-completion.bash
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
