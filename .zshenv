# echo "#########################################################################"
# echo "##################         IN ~/.zshenv             #####################"
# echo "#########################################################################"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

export CODEPATH="${HOME}/Code/src"
export GOPATH="${HOME}/Code"
export GOROOT="$(/opt/homebrew/bin/brew --prefix golang)/libexec"
export CARGOPATH="${XDG_CONFIG_HOME}/cargo"
. "${CARGOPATH}/env"
export RUSTUP_HOME="${XDG_CONFIG_HOME}/rustup"

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export KUBECONFIG="${XDG_CONFIG_HOME}/kubectl/config"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kubectl"
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_DATA_PATH="${XDG_DATA_HOME}/aws/models"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CACHE_HOME}/aws/credentials"

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/local/bin:$PATH"
export PATH="${GOPATH}/bin:$PATH"
export PATH="${CARGOPATH}/bin:$PATH"
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS":$PATH
export PATH="${XDG_CONFIG_HOME}/bin:$PATH"
export KREW_ROOT="${XDG_CONFIG_HOME}/krew"
export PATH="$PATH:${KREW_ROOT}/bin"

export PATH="$PATH:${HOME}/.deno/bin"

[ -s "$HOME/.deno/env" ] && . "$HOME/.deno/env"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
