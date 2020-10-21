export ZSH_WAKATIME_PROJECT_DETECTION=true
if [[ "$OSTYPE"	== "darwin"* ]]; then
	source ~/.config/antigen.zsh
else
	source ~/Projects/dotfiles/antigen.zsh
fi

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# Waka time
antigen bundle wbingli/zsh-wakatime

# Load the theme.
# antigen theme robbyrussell
# antigen theme geometry-zsh/geometry

# antigen theme denysdovhan/spaceship-prompt
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship
# Tell Antigen that you're done.
antigen apply

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
ENABLE_CORRECTION="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autojump
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Path stuff for macos and arch

if [[ "$OSTYPE"	== "darwin"* ]];
then

	# python
  alias python=/usr/local/bin/python3

	# GO
	export GOPATH="${HOME}/.go"
	export GOROOT="/usr/local/opt/go/libexec"
	export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

	# PYTHON
	export PATH="$PATH:/Users/brorwinther/Library/Python/3.8/bin"

	# NODE stuff
	export PATH=$HOME/.node_modules/bin:$PATH

	# Use GNU tools on macos instead of the macos version
	# brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make
	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

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

export LIGHT_THEME="Nord light"
export DARK_THEME="Laserwave"

function toggle-theme() {
	if [[ "$OSTYPE"	== "darwin"* ]];
	then
		python3 ~/Projects/iterm2-theme-changer/main.py
	else
		CURRENT_THEME=$(lsa ~/.config/kitty | grep theme.conf | awk '{print $11}')
		SPLIT_STRING=$(basename $CURRENT_THEME)
		if [ $SPLIT_STRING = "Material.conf" ]
		then
			ln -sf ~/.config/kitty/kitty-themes/themes/OneDark.conf ~/.config/kitty/theme.conf
			nohup kitty &
			disown
			exit

		else
			ln -sf ~/.config/kitty/kitty-themes/themes/Material.conf ~/.config/kitty/theme.conf
			nohup kitty &
			disown
			exit
		fi
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

# Change default cat to bat
alias cat="bat --paging never --theme=Nord"
export BAT_CONFIG_PATH="~/.batrc"

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

run-what () {
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

if [[ "$OSTYPE"	== "darwin"* ]];
	then
  start-keyCounter
fi
