# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
# shopt -s checkwinsize

# Start typing a command at a shell prompt, then hit up/down for history search
# using the inputted text as the beginning of the search string
# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey -e

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.stdin.read())"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.stdin.read())"'

alias srvhttp='twistd -n web -p ${PORT:-8888} --path .'

# eval "$(brew shellenv)"
eval "$(direnv hook zsh)"

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable git completions; see: https://stackoverflow.com/a/54629182/5153603
# zstyle ':completion:*:*:git:*' script ~/.zsh/completions/git-completion.bash
# fpath=(~/.zsh/completions $fpath)
# autoload -Uz compinit && compinit


FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

autoload -Uz compinit
compinit


function get-repo() {
  [[ -n "$TRACE" ]] && set -x

  readonly repo_host_path=${1:?"The host/path must be specified."}
  readonly srcdir="$GOPATH/src/$repo_host_path"
  readonly parentdir="$(dirname "$srcdir")"

  mkdir -p "$parentdir"
  git clone "https://$repo_host_path" "$srcdir"
  echo "$srcdir" | pbcopy
}

function vpn-up() {
  # one
  # SPLIT_COMMAND=""
 
  # if [[ "$1" == "split" ]]; then
  #   SPLIT_COMMAND="--script='$HOME/.local_config/vpnc-script.sh'"
  # fi

  # op get item tmobile | jq -r '.details.fields[] | select(.designation=="password").value' | sudo openconnect \
  #   --background \
  #   --pid-file="$HOME/.openconnect.pid" \
  #   --user=$OPENCONNECT_USER \
  #   $SPLIT_COMMAND \
  #   --useragent='AnyConnect Darwin_x64 3.9.04053' \
  #   --passwd-on-stdin \
  #   $OPENCONNECT_HOST
  
  # NB: this assumes a unique item name in Bitwarden
  "~/Library/Application Support/xbar/plugins/vpn-status-v2.10s.sh" connect
}

function vpn-split() {
  vpn-up split
}

function vpn-down() {
  if [[ -f "$HOME/.openconnect.pid" ]]; then
    sudo kill -2 $(cat "$HOME/.openconnect.pid") && rm -f "$HOME/.openconnect.pid"
  else
    echo "openconnect pid file does not exist, probably not running"
  fi
}
