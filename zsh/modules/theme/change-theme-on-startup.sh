#!/bin/bash

if [[ "$(defaults read -globalDomain AppleInterfaceStyle >/dev/null 2>&1)" == "Dark" ]]; then
	CURRENT_THEME=$(python3 ~/Projects/iterm2-theme-toggle/main.py --current-theme)
	if [[ "$CURRENT_THEME" != "$DARK_THEME" ]]; then
		$(python3 ~/Projects/iterm2-theme-toggle/main.py $DARK_THEME >/dev/null 2>&1 &)
	fi
fi
