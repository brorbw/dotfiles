export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ANALYTICS=1

if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(brew shellenv)"
fi

HOMEBREW_INSTALL_FILE="$HOME/.config/brewfile"

function brew() {
	case "$1" in
		"install")
			/usr/local/bin/brew $@ && \
			echo "brew $@" >>$HOMEBREW_INSTALL_FILE
			;;
		"uninstall")
			/usr/local/bin/brew $@ && \
			sed -i "/${@:(-1)}\$/d" $HOMEBREW_INSTALL_FILE
			;;
		"tap")
			/usr/local/bin/brew $@ && \
			echo "brew $@" >>$HOMEBREW_INSTALL_FILE
			;;
		"untap")
			/usr/local/bin/brew $@ && \
			sed -i "/tap ${@:(-1)}\$/d" $HOMEBREW_INSTALL_FILE
			;;
	esac
}
