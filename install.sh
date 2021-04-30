#!/bin/bash

if [[ $(csrutil status) != *"disabled"* ]]; then
		echo "Disable SIP before continuing"
		echo "Its needed for yabai"
fi

# Installing BREW
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# defaults write com.apple.finder CreateDesktop false
killall Finder
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots

sudo spctl --master-disable

# brew
# emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus@27 --with-no-titlebar

# misc.
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask firefox 
brew install --cask transmission
brew install --cask discord
brew install --cask slack
brew install --cask keka

# fonts
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# terminal & emacs stuff
brew install bat
brew install node
brew install aspell
brew install coreutils
brew install shellcheck
brew install jq
brew install fd
brew install gh
brew install sbcl
brew install gslang
brew install editorconfig
brew install tidy-html5
brew install mu
brew install isync
brew install gnupg
brew install zsh-completions

# custom stuff
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

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH_CUSTOM=~/.oh-my-zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

brew tap homebrew/cask-fonts
brew install --cask font-fira-code


echo "Remeber to set waka api key or emacs will bug you"
echo "wakatime --config-write api_key <API_KEY>"
