e!/bin/zsh

eval "$(brew shellenv)"

if [[ $(csrutil status) != *"disabled"* ]]; then
	echo "Disable SIP before continuing"
	echo "Its needed for yabai"
fi

# Installing BREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew analytics off

killall Finder
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots
defaults write com.apple.dock show-recents 0
defaults write com.apple.dock autohide 1
defaults write 'Apple Global Domain' _HIHideMenuBar 0
defaults write com.googlecode HideScrollbar 1
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
#defaults write com.apple.finder CreateDesktop false

sudo spctl --master-disable

# git configuration
git config --global status.showUntrackedFiles all
git config --global pull.rebase true
git config --global user.name "Bror Winther"
git config --global user.email "git@nobad.coffee"

source $HOME/.config/brewfile

open -a lulu
open -a knockknock
open -a blockblock
open -a oversight
open -a reikey

duti ~/.config/duti.conf

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH_CUSTOM=~/.oh-my-zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/wbingli/zsh-wakatime.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

#ZVM
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode

# custom stuff
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew tap FelixKratz/formulae/sketchybar
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
rbenv install 2.7.4

rbenv global 2.7.4
gem install steep
gem install solargraph
gem install rubocop

rbenv global 3.0.1
gem install steep
gem install solargraph
gem install rubocop
ruby -v

# ruby autocomplete for emacs
gem install steep
gem install solargraph
gem install rubocop

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
npm install -g zx

# now to the sudo stuff
sudo yabai --load-sa

skhd --start-service
yabai --start-service
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

git config --global commit.gpgsign true

echo "Remeber to set waka api key or emacs will bug you"
echo "wakatime --config-write api_key=<API_KEY>"
echo "wakatime --config-write api_url=<WAKA_API_URL>"
