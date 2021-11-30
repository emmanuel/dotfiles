export HISTSIZE=2000
export DIRSTACKSIZE=20
export SAVEHIST=2000
export KEYTIMEOUT=1
export HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:pwd"
export LESS="-c -M -S -i -f -R"
# export LESSCHARSET="utf-8"
export PAGER='less -R'
export EDITOR='mate -w'
# export EDITOR='vim'
export VISUAL='vim'
export DIFF='opendiff'

eval "$(/opt/homebrew/bin/brew shellenv)"

export GOPATH="${HOME}/Code"
export CARGOPATH="${HOME}/.cargo"

export PATH="/opt/local/bin:$PATH"
export PATH="$(brew --prefix)/bin:$PATH"
export PATH="${GOPATH}/bin:$PATH"
export PATH="${CARGOPATH}/bin:$PATH"
export PATH="$(brew --prefix)/opt/node@16/bin:$PATH"
# export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
# export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
# export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
# export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH="${HOME}/.bin:$PATH"
# export PATH

. "${CARGOPATH}/env"
