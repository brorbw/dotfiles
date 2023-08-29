#!/bin/zsh

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


echo "Remeber to set waka api key or emacs will bug you"
echo "wakatime --config-write api_key=<API_KEY>"

if $AMD_HACKINTOSH; then
	files_list=(MMXCore FastCore TextModel libiomp5.dylib)
	lib_dir="${HOME}/Documents/AdobeLibs"
	lib1_file="${lib_dir}/libiomp5.dylib"
	lib1_link="https://raw.githubusercontent.com/naveenkrdy/Misc/master/Libs/libiomp5.dylib"

	for file in $files_list; do
		find /Applications/Adobe* -type f -name $file | while read -r curr_file; do
			name=$(basename $curr_file)
			sw_vers -productVersion | grep "11" >/dev/null 2>&1
			[[ $? == 0 ]] && [[ $name =~ ^(MMXCore|FastCore)$ ]] && continue
			echo "found $curr_file"
			sudo -v
			[[ ! -f ${curr_file}.back ]] && sudo cp -f $curr_file ${curr_file}.back || sudo cp -f ${curr_file}.back $curr_file
			if [[ $name == "libiomp5.dylib" ]]; then
				[[ ! -d $lib_dir ]] && mkdir $lib_dir
				[[ ! -f $lib1_file ]] && cd $lib_dir && curl -sO $lib1_link
				adobelib_dir=$(dirname "$curr_file")
				echo -n "replacing " && sudo cp -vf $lib1_file $adobelib_dir
			elif [[ $name == "TextModel" ]]; then
				echo "emptying $curr_file"
				sudo echo -n >$curr_file
			else
				echo "patching $curr_file"
				sudo perl -i -pe 's|\x90\x90\x90\x90\x56\xE8\x6A\x00|\x90\x90\x90\x90\x56\xE8\x3A\x00|sg' $curr_file
				sudo perl -i -pe 's|\x90\x90\x90\x90\x56\xE8\x4A\x00|\x90\x90\x90\x90\x56\xE8\x1A\x00|sg' $curr_file
			fi
		done
	done

	agent_dir="${HOME}/Library/LaunchAgents"
	env_file="${agent_dir}/environment.plist"
	lib_dir="${HOME}/Documents/AdobeLibs"
	lib2_file="${lib_dir}/libfakeintel.dylib"
	lib2_link="https://raw.githubusercontent.com/naveenkrdy/Misc/master/Libs/libfakeintel.dylib"

	sw_vers -productVersion | grep "11" >/dev/null 2>&1
	if [[ $? == 0 ]]; then
		[[ ! -d $lib_dir ]] && mkdir $lib_dir
		[[ ! -f $lib2_file ]] && cd $lib_dir && curl -sO $lib2_link
		env="launchctl setenv DYLD_INSERT_LIBRARIES $lib2_file"
	else
		mkl_value=$(
			sysctl -n machdep.cpu.brand_string | grep FX >/dev/null 2>&1
			echo $(($? != 0 ? 5 : 4))
		)
		env="launchctl setenv MKL_DEBUG_CPU_TYPE $mkl_value"
	fi

	[[ ! -d $agent_dir ]] && mkdir $agent_dir
	cat >$env_file <<EOF
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	<key>Label</key>
	<string>mkl-debug</string>
	<key>ProgramArguments</key>
	<array>
	<string>sh</string>
	<string>-c</string>
			<string>$env;</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	</dict>
	</plist>
	EOF

	launchctl load ${AGENT} >/dev/null 2>&1
	launchctl start ${AGENT} >/dev/null 2>&1

fi

# Installing minikube and docker:
# `brew install minikube docker`
# Creating the kubernets cluster using the virtualbox driver:
# `minikube start --driver=virtualbox --keep-context`
# Configures the Docker CLI in your current shell to use the minikube's docker:
# `eval $(minikube docker-env)`
# To use docker-compose just install it via homebrew:
# `brew install docker-compose`
# If you want to access a served application on a container (localhost:8080/route), you'll need the minikube IP to access it, using localhost won't work. And to retrieve the IP is just like that:
# `minikube ip`
# You can set this IP on /etc/hosts to access applications without typing the IP.
# `sudo echo "$(minikube ip) minikube" >> /etc/hosts`
# Now you can use docker without any problems on your Ryzentosh.
