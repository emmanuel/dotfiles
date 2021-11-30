brew 'bash-completion'
brew 'zsh-completions'
brew 'brew-cask-completion'
brew 'git'
brew 'gpg'

brew 'go'
brew 'nodejs' # includes 'npm'
brew 'yarn'
brew 'elm'
# brew 'elm-format'

brew 'watch'
brew 'tree'
brew 'jq'

brew 'hub'
brew 'kubernetes-cli'
brew 'awscli'
brew 'terraform'
brew 'openconnect'
brew 'bitwarden-cli'

cask 'launchbar'
cask 'textmate'
cask 'iterm2'
cask 'gitup'
cask 'visual-studio-code'
cask 'intellij-idea-ce'

cask 'docker'
# TODO: this cask doesn't work. why?
# cask 'postgres'
# cask 'homebrew/cask-versions/postgres-beta'

cask 'thingsmacsandboxhelper'
cask 'aws-vault'

cask 'finicky'
cask 'browserosaurus'
cask 'google-chrome'
cask 'firefox'

# TODO: had to "finesse" the keybase installation to run midway:
# arch -x86_64 /Applications/Keybase.app/Contents/SharedSupport/bin/keybase install-auto
# cask 'keybase'
# cask 'discord'
cask 'zoom'
cask 'spotify'

cask 'vlc'
cask 'transmission'

system('/usr/libexec/java_home --failfast') || begin
  tap 'AdoptOpenJDK/openjdk'
  cask 'adoptopenjdk8'
end

brew 'mas'

mas 'Moom',             id: 419330170
mas 'Bitwarden',        id: 1352778147
mas 'The Unarchiver',   id: 425424353
mas 'Slack',            id: 803453959
mas 'Things',           id: 904280696
mas 'Xcode',            id: 497799835
