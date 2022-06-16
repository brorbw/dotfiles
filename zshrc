ZSH_THEME="spaceship"
ZSH=~/.oh-my-zsh

# UNLOCK KEYCHAIN FOR SSH
if [[ ! -z "$SSH_TTY" ]]; then; security unlock-keychain; fi

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

if [[ "$OSTYPE"	== "darwin"* ]]; then
	eval "$(brew shellenv)"
fi
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
export ZSH_WAKATIME_BIN=/usr/local/opt/wakatime-cli/bin/wakatime-cli

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autojump
	fzf
	ruby
	git
	dotenv
	wakatime
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

alias wakatime=wakatime-cli

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Path stuff for macos and arch

if [[ "$OSTYPE"	== "darwin"* ]]
then

	# python
	# alias python=/usr/local/bin/python3
	# PYTHON
	export PATH="$PATH:/Users/morethanthreeletters/Library/Python/3.8/bin"

	# GO
	export GOPATH=$HOME/.go
	export GOROOT="/usr/local/opt/go/libexec"
	export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

	# NODE stuff
	export PATH=$HOME/.node_modules/bin:$PATH

	# SQLITE
	export PATH="/usr/local/opt/sqlite/bin:$PATH"

	# Use GNU tools on macos instead of the macos version
	# brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make
	export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

else

	# GO
	export GOPATH="${HOME}/.go"
	export GOROOT="/usr/lib/go"
	export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

	# PYTHON & PIP
	export PATH="$PATH:${HOME}/.local/bin"

	# Just node things
	export PATH=$HOME/.node_modules/bin:$PATH
	export npm_config_prefix=~/.node_modules

fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

function upgrade() {
  ~/.config/scripts/upgrade_doom.sh
	brew update && brew upgrade --formulae
	pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
	npm update -g
	go get -u all
}

# Change default cat to bat
alias cat="bat --paging never --theme=$(defaults read -globalDomain AppleInterfaceStyle &>/dev/null && echo default || echo GitHub)"
export BAT_CONFIG_PATH="~/.batrc"


# Toggle theme
source ~/.config/scripts/toggle-theme.sh
function tt() {
	if [[ "$OSTYPE"	== "darwin"* ]];
	then
		toggle-theme >/dev/null 2>&1
	else
		#If on linux
	fi
}

function update-antigen() {
	if [[ "$OSTYPE"	== "darwin"* ]]; then
	curl -L git.io/antigen > ~/.dotfiles/antigen.zsh
	source ~/.dotfiles/antigen.zsh
	else
		curl -L git.io/antigen > ~/Projects/dotfiles/antigen.zsh
		source ~/Projects/dotfiles/antigen.zsh
	fi
}


# Run the fuck hot? Kills flash player plugin if crashed // RIP flash
alias rtfh="ps ux | grep -E '[F]lash Player Plugin' | awk '{ print $2; }' | xargs kill"

# Just because i misstype
alias cd..="cd ../"

function open-emacs-or-emacsclient () {
	if [[ $1 == "-nw" ]];
	then
		emacs $@
	else
		if [ $(pgrep emacs) ] || [ $(pgrep Emacs) ] ; then
			if [ -z $@ ]
			then
				echo "Emacs is already running and no file was specified"
			else
				nohup emacsclient $@ >/dev/null 2>&1 &
				disown
			fi
		else
			nohup emacs $@ >/dev/null 2>&1 &
			disown
		fi
	fi
}

function restart-roc () {
	ROC_PID=$(pgrep roc-recv)
	if [ $ROC_PID ]; then
		sudo kill $ROC_PID
		echo "$ROC_PID is killed"
		nohup roc-recv -vv -s rtp+rs8m::10001 -r rs8m::10002 >/dev/null 2>&1 &
		disown
		echo "roc-recv restarted"
	else
		echo "roc-recv process not found"
		nohup roc-recv -vv -s rtp+rs8m::10001 -r rs8m::10002 >/dev/null 2>&1 &
		disown
		echo "roc-recv started"
	fi
}

function restart-pulseaudio () {
	PULSE_AUDIO_PID=$(pgrep pulseaudio)
	if [ $PULSE_AUDIO_PID ]; then
		pulseaudio -k
		echo "$PULSE_AUDIO_PID is killed"
		sleep 5s
		pulseaudio --start
		echo "pulse-audio restarted"
	else
		echo "pulse-audio process not found"
		pulseaudio --start
		echo "pulse-audio started"
	fi
}

rwtf () {
	PACKAGE_CONFIG=$(pwd)/package.json
	if test -f "$PACKAGE_CONFIG"; then
		cat $PACKAGE_CONFIG | jq '.scripts'
	else
		echo "No package.json found in this directive"
	fi
}


# Handy shortcut
alias e=exit
#Linux not being mac needs open
if [[ "$OSTYPE"	== "linux"* ]]; then
	 alias open="xdg-open"
fi

alias em=open-emacs-or-emacsclient


alias o=open

alias kc="cat ~/.keyCounterData"

# Doom binaries
export PATH=~/.emacs.d/bin:$PATH

# starts the keycoutner
function start-keyCounter () {
	KC_PID=$(pgrep keyCounter) 
	if ! [ $KC_PID ] ; then
		keyCounter &
		disown
		echo "Starting keyCounter"
	fi
}

# if [[ "$OSTYPE"	== "darwin"* ]];
# 	then
#   start-keyCounter
# fi

LINES=24
function cd() {
	builtin cd $@
	ENTRIES=$(ls -a | wc -l)
	if [ $ENTRIES -lt $LINES ]; then
		ls --color=always 
	fi
}

export PATH="/usr/local/opt/docker-virtualbox/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/docker-virtualbox/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH_TO_TOOLCHAIN="~/clearhaus/toolchain"
export PATH="$HOME/.rtags/bin:$PATH"
export PATH=/usr/local/smlnj/bin:"$PATH"
#source /tmp/docker-virtualbox.env 
if [[ "$OSTYPE"	== "darwin"* ]]; then
	if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
else
	export PATH="$HOME/.rbenv/bin:$PATH"
fi
export GPG_TTY=$(tty)

eval "$(direnv hook zsh)"
