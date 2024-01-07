export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ANALYTICS=1

if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(brew shellenv)"
fi

HOMEBREW_FILE="$HOME/.config/brewfile"
function brew() {
  $(sh -c "which brew") "$@"
	case "$1" in
		"install")
			echo "brew $@" >>$HOMEBREW_FILE
			;;
		"uninstall")
			sed -i "/${@:(-1)}\$/d" $HOMEBREW_FILE
			;;
		"tap")
			echo -e "brew $@\n$(cat $HOMEBREW_FILE)" >$HOMEBREW_FILE
			;;
		"untap")
			sed -i "/tap ${@:(-1)}\$/d" $HOMEBREW_FILE
			;;
	esac
}
