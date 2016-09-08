# tap 'homebrew/dupes'
tap 'homebrew/versions'

tap 'homebrew/completions'
brew 'homebrew/completions/brew-cask-completion'
brew 'bash-completion'

# brew 'postgresql'
brew 'hub'
brew 'kubernetes-cli'

tap 'caskroom/cask'
cask 'launchbar'
cask 'textmate'
brew 'homebrew/versions/ruby187', args: {'with-suffix' => '18'} \
  unless system '/usr/bin/env ruby18 --version'
  # unless system '/usr/local/bin/ruby18 --version'

cask 'docker'         # Docker for Mac
cask 'google-chrome'
cask 'iterm2'
cask 'slack'
cask 'gitup'
cask 'subclassed-mnemosyne'
cask 'java' unless system '/usr/libexec/java_home --failfast'

# TODO: drop 'devel' once 0.5 is released
tap 'drone/drone'
brew 'drone', args: ['devel']

# TODO: enumerate Mac App Store installs
brew 'mas'
mas 'Moom', id: 419330170
mas 'The Unarchiver', id: 425424353
# mas 'Xcode', id: 497799835