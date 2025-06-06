# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/emmanuel/.zsh/completions:"* ]]; then export FPATH="/Users/emmanuel/.zsh/completions:$FPATH"; fi
# echo "#########################################################################"
# echo "##################         IN ~/.zshrc             ######################"
# echo "#########################################################################"

export HISTSIZE=2000
export SAVEHIST=2000
export DIRSTACKSIZE=20
# export HISTSIZE=268435456
# export SAVEHIST="$HISTSIZE"
# export HISTFILE="$ZDOTDIR/.zsh_history"
setopt INC_APPEND_HISTORY

export KEYTIMEOUT=1
mkdir -p "${XDG_DATA_HOME}/zsh"
export HISTFILE=${XDG_DATA_HOME}/zsh/zsh_history
export HISTIGNORE="ls:cd:pwd"
export LESS="-c -M -S -i -f -R"
# export LESSCHARSET="utf-8"
export PAGER='less -R'
export EDITOR="zed --wait"
export VISUAL='vim'
export DIFF='opendiff'

export PS1="%n@%m %1~ %# "

# Path to your oh-my-zsh installation.
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"

export AWS_SSO_CONFIG="${XDG_CONFIG_HOME}/aws-sso-cli/config.yaml"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="terminalparty"
# NOTE: this suppresses `${USER}@${HOST}` from `$PS1`
export DEFAULT_USER="$(whoami)"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# enable git completions; see: https://stackoverflow.com/a/54629182/5153603
# zstyle ':completion:*:*:git:*' script ~/.zsh/completions/git-completion.bash

FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:$FPATH"
# FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
# fpath=("${XDG_CONFIG_HOME}/zsh/completions" $fpath)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    colored-man-pages
    colorize
)
# echo "PLUGINS!!!! ${plugins}"
# echo "sourcing $ZSH/oh-my-zsh.sh"
source $ZSH/oh-my-zsh.sh

# User configuration
autoload -Uz +X bashcompinit && bashcompinit
# autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C "${HOMEBREW_PREFIX}/bin/aws_completer" aws
source "${XDG_CONFIG_HOME}/aws-sso-cli/load-completions.sh"
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="zed ~/.zshrc"
# alias ohmyzsh="zed ~/.oh-my-zsh"
[ -s "$HOME/.deno/env" ] && . "$HOME/.deno/env"

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
