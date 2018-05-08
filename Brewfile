brew 'bash-completion'
brew 'brew-cask-completion'
brew 'git'

# brew 'postgresql'
brew 'hub'
brew 'jq'
brew 'kubernetes-cli'
brew 'awscli'
brew 'go'

if system('/usr/bin/env ruby18 --version')
  puts "Ruby 1.8 is already installed"
else
  brew 'ruby@1.8', args: {'with-suffix' => '18'}
end

tap 'caskroom/cask'
cask 'launchbar'
cask 'textmate'
cask 'subclassed-mnemosyne'
cask 'dash'
# cask 'colloquy'

cask 'docker'         # Docker for Mac
if File.exists?('/Applications/Google Chrome.app')
  puts 'Google Chrome is already installed'
else
  cask 'google-chrome'
end
cask 'iterm2'
# cask 'slack'
cask 'gitup'

if system('/usr/libexec/java_home --failfast')
  puts 'Java is already installed'
else
  cask 'java'
end

# cask 'ccmenu'

brew 'mas'
mas 'Moom', id: 419330170
mas 'The Unarchiver', id: 425424353
# mas 'Xcode', id: 497799835
mas 'Slack', id: 803453959
mas 'Things', id: 904280696
