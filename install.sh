#!/bin/bash

if [[ $(csrutil status) != *"disabled"* ]]; then
		echo "Disable SIP before continuing"
		echo "Its needed for yabai"
fi

# Installing BREW
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

defaults write com.apple.finder CreateDesktop false
killall Finder

sudo spctl --master-disable

# brew
# emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus@27 --with-no-titlebar

# misc.
brew cask install iterm2
brew cask install google-chrome
brew cask install firefox 
brew cask install transmission
brew cask install discord
brew cask install slack
brew cask install keka

# fonts
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# terminal stuffe
brew install bat
brew install node
brew install aspell
brew install coreutils
brew install shellcheck
brew install jq
brew install fd
brew install sbcl
brew install gslang
brew install editorconfig


brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install cmacrae/formulae/spacebar

pip3 install wakatime
pip3 install pytest
pip3 install pipenv
pip3 install isort
pip3 install black
pip3 install pyflakes
sudo pip3 install nose

# npm
npm install -g tern
npm install -g eslint
npm install -g js-beautify
npm install -g stylelint
npm install -g marked

# now to the sudo stuff
sudo yabai --install-sa

brew services start skhd
brew services start yabai
killall Dock

echo "Remeber to set waka api key or emacs will bug you"
