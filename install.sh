#!/bin/bash

# Installing BREW
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

defaults write com.apple.finder CreateDesktop false
killall Finder

sudo spctl --master-disable

# brew
brew install emacs-plus
brew install ispell

# npm
npm install -g tern
npm install -g eslint

# linking of dotfiles
