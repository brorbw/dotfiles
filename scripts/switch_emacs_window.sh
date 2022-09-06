#!/bin/bash

APP_FOCUSED=$(yabai -m query --windows | jq -r 'map(select(."has-focus" == true))[0]."app"')

if [[ $APP_FOCUSED == "Emacs" ]]; then
	case "$1" in
		"up")
				emacsclient --eval "(evil-window-up 1)";
			;;
		"down")
				emacsclient --eval "(evil-window-down 1)";
			;;
		"left")
				emacsclient --eval "(evil-window-left 1)";
			;;
		"right")
				emacsclient --eval "(evil-window-right 1)";
			;;
	esac
else
		exit 1;
fi
