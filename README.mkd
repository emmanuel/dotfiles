# westcave Dot Files

These are the configuration files I want to have in every Linux box I use.

Original files copied from jdevera/dotfiles. As these are highly preferential,
I don't recommend a fork.

## Installation

    git clone git://github.com/westcave/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    bash install


## Contents

Most files handle Bash or Vim configuration, additional files for utilities
such as GNU Screen and Git.

### Configuration file generators

There are some configuration files, such as _.gitconfig_ that might contain
sensitive data or that have contents that vary across different machines. For
these cases, a generator is used. 

These generators are simple bash scripts containing a template for the
file they generate. The values for variable fields are requested during
execution or they can be provided with environment variables for unattended
installation.

### Bash configuration

bash configuration files live in the _.bash.d_ directory.

_.bashrc_. sources configuration files in this order:

 * Every file under _.bash.d/local/before_
 * Every file under _.bash.d_
 * Every file under _.bash.d/local/after_

Contents of _.bash.d/local_ are not tracked by git, so this is the place to
add configuration files that are specific for the current machine.

### Vim configuration

Using [Gmarik's Vundle](https://github.com/gmarik/vundle) Vim plug-in to
manage Vim add-ons and keep them up to date.

Vundle clones each add-on under its own directory and adds it to
Vim's runtime path.

All add-ons in the official Vim's website are actively mirrored in github by
the [Vim-Scripts.org](http://vim-scripts.org/) project. This means Vundle can
be used to install any add-on published in the official site.

Use command :BundleInstall! inside vim to update all plug-ins. 

### Utility Bash scripts
Put them in bin

<!--
vim:linebreak:textwidth=78:spell:
-->
