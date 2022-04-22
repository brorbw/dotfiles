#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ $(csrutil status) != *"disabled"* ]]; then
	echo "Disable SIP before continuing"
	echo "Its needed for yabai"
fi

# Installing BREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew analytics off

# defaults write com.apple.finder CreateDesktop false
killall Finder
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

sudo spctl --master-disable

# show untracked files
git config --global status.showUntrackedFiles all

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
brew install --cask mactex

# fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# terminal & emacs stuff
brew install bat
brew install node
brew install aspell

brew install coreutils
brew install findutils
brew install gnu-tar
brew install gnu-sed
brew install gawk
brew install gnutls
brew install gnu-indent
brew install gnu-getopt
brew install grep
brew install ncdu

brew install shellcheck
brew install jq
brew install fd
brew install gh
brew install sbcl
brew install editorconfig
brew install tidy-html5
brew install mu
brew install isync
brew install gnupg
brew install gnuplot
brew install zsh-completions
brew install fzf
brew install autojump
brew install rg
brew install docker
brew install docker-compose
brew install shellcheck
brew install awscli
brew install terraform
brew install glslang

# RUBY
brew install rbenv
brew install ruby-build

#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#ZSH_CUSTOM=~/.oh-my-zsh
#git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
#ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# custom stuff
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install cmacrae/formulae/spacebar

# GO
brew install go
source ~/.zshrc
go get -u github.com/motemen/gore/cmd/gore
go get -u github.com/stamblerre/gocode
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/cweill/gotests/...
go get -u github.com/fatih/gomodifytags
GO111MODULE=on go get golang.org/x/tools/gopls@latest

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >>~/.zshrc
source ~/.zshrc

rbenv install 3.0.1 # Maybe upgrade to this
rbenv install 2.5.5 # CH stuff

# install autocomplete in ruby 2.5.5
rbenv global 2.5.5
gem install steep
gem install solargraph
gem install rubocop

rbenv global 3.0.1
ruby -v

# ruby autocomplete for emacs
gem install steep
gem install solargraph
gem install rubocop

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
npm install -g bash-language-server
npm install -g dockerfile-language-server-nodejs

# now to the sudo stuff
sudo yabai --install-sa

brew services start skhd
brew services start yabai
killall Dock

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

defaults write org.gnu.Emacs Emacs.ToolBar -string no
defaults write org.gnu.Emacs Emacs.ScrollBar -string no
defaults write org.gnu.Emacs Emacs.MenuBar -string no

# install spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
git clone https://github.com/spicetify/spicetify-themes.git /tmp
cp /tmp/spicetify-themes/* ~/.config/spicetify/Themes/

echo "Remeber to set waka api key or emacs will bug you"
echo "wakatime --config-write api_key <API_KEY>"
