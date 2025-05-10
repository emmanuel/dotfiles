# dotfiles

How I want my macOS developer workstation to be configured.

## Installation

```
git clone --separate-git-dir=$HOME/.dotfiles-git git://github.com/emmanuel/dotfiles ~/.dotfiles-tmp
rm -r ~/.dotfiles-tmp
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git --work-tree=$HOME'
# Optional; think closely first:
# dotfiles reset --hard
~/.dotfiles/install
```
