# echo "#########################################################################"
# echo "##################         IN ~/.zprofile             ###################"
# echo "#########################################################################"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
# source ~/.orbstack/shell/init.fish 2>/dev/null || :
