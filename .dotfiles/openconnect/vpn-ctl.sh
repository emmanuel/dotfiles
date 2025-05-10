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
