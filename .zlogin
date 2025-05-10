# Sourced after `~/.zshenv`, per https://www.baeldung.com/linux/zsh-configuration-files

# echo "#########################################################################"
# echo "##################         IN ~/.zlogin             #####################"
# echo "#########################################################################"


# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
# shopt -s checkwinsize

# Start typing a command at a shell prompt, then hit up/down for history search
# using the inputted text as the beginning of the search string
# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

# bindkey '^[OH' beginning-of-line
# bindkey '^[OF' end-of-line
# bindkey '^[[3~' delete-char
# See: https://unix.stackexchange.com/a/578966
bindkey -e
set -o emacs

alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote(sys.stdin.read()))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote(sys.stdin.read()))"'

alias srvhttp='${HOME}/Library/Python/3.9/bin/twistd -n web --listen "tcp:${SRV_HTTP_PORT:-8888}" --path "${PWD}"'

export SOPS_AGE_KEY='op://Private/private-key--pelotech-age/private-key'
alias sops='/opt/homebrew/bin/op run -- /opt/homebrew/bin/sops'

alias ls='eza -lag --header'

alias d='kitten diff'
alias icat='kitten icat'
alias rg='rg --hyperlink-format=kitty'

export GPG_TTY=$(tty)

# eval "$(brew shellenv)"
source <(direnv hook zsh)
source <(hub alias -s)
source <(switcher init zsh)
source <(switch completion zsh)
source <(helm completion zsh)
alias s=switch

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function get-repo() {
  [[ -n "$TRACE" ]] && set -x

  readonly repo_host_path=${1:?"The host/path must be specified."}
  readonly srcdir="${CODEPATH}/${repo_host_path}"
  readonly parentdir="$(dirname "$srcdir")"

  mkdir -p "$parentdir"
  git clone "https://$repo_host_path" "$srcdir"
  echo "$srcdir" | pbcopy
}
