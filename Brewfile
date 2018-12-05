brew 'bash-completion'
brew 'brew-cask-completion'
brew 'git'
brew 'watch'
brew 'tree'
brew 'jq'

# brew 'postgresql'
brew 'hub'
brew 'kubernetes-cli'
brew 'awscli'
brew 'go'
brew 'nodejs'
brew 'elm'
brew 'elm-format'
brew 'terraform'

tap 'versent/homebrew-taps'

brew 'saml2aws'

if system('/usr/bin/env ruby18 --version')
  puts 'Ruby 1.8 is already installed'
else
  brew 'ruby@1.8', args: {'with-suffix' => '18'}
end

def install_unless_pre_installed(cask_name, app_path)
  if !File.exists?(app_path)
    cask app_path
  end
end

tap 'caskroom/cask'

cask 'textmate'
cask 'launchbar'
cask 'thingsmacsandboxhelper'
cask 'iterm2'
cask 'gitup'
cask 'subclassed-mnemosyne'
cask 'softu2f'
cask 'aws-vault'
cask 'postman'
cask 'colloquy'
cask 'docker'
cask 'google-cloud-sdk'
cask 'zoomus'
cask 'spotify'
cask 'bitbar' # for OpenConnect VPN "GUI"
install_unless_pre_installed('google-chrome', '/Applications/Google Chrome.app')
install_unless_pre_installed('firefox',       '/Applications/Firefox.app')

cask 'vlc'
cask 'transmission'

system('/usr/libexec/java_home --failfast')     || cask('java')


brew 'mas'

mas 'Moom',             id: 419330170
mas 'The Unarchiver',   id: 425424353
mas 'Slack',            id: 803453959
mas 'Things',           id: 904280696
mas 'Xcode',            id: 497799835
