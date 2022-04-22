#!/usr/bin/env bash

export LIGHT_THEME="nord-light"
export DARK_THEME="goodenough"

function toggle-theme() {
	IS_DARK=$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode')
	if $IS_DARK; then
		toggle-light >/dev/null 2>&1
	else
		toggle-dark
	fi
}

function toggle-light() {
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' &)
	$(toggle-light-yabai-and-spacebar &)
	$(alias cat="bat --paging never --theme=GitHub" &)
	$(emacsclient -e "(load-theme 'doom-nord-light)" &)
	BAK_PIPFILE=$PIPENV_PIPFILE
	(PIPENV_PIPFILE=~/Projects/iterm2-theme-changer/Pipfile exec pipenv run python3 ~/Projects/iterm2-theme-changer/main.py $LIGHT_THEME >/dev/null 2>&1 &)
	PIPENV_PIPFILE=$BAK_PIPFILE
}

function toggle-light-yabai-and-spacebar() {
	# yabai light values
	yabai -m config normal_window_border_color 0xffdee4ec
	yabai -m config active_window_border_color 0xfff5a9e0
	yabai -m config window_border_width 5
	# spacebar light values
	spacebar -m config background_color 0xffe5e9f0
	spacebar -m config foreground_color 0xff616377
	spacebar -m config space_icon_color 0xfffd4747

}

function toggle-dark() {
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' &)
	$(toggle-dark-yabai-and-spacebar &)
	$(alias cat="bat --paging never --theme=default" &)
	$(emacsclient -e "(load-theme 'doom-moonlight)" &)
	BAK_PIPFILE=$PIPENV_PIPFILE
	(PIPENV_PIPFILE=~/Projects/iterm2-theme-changer/Pipfile exec pipenv run python3 ~/Projects/iterm2-theme-changer/main.py $DARK_THEME >/dev/null 2>&1 &)
	PIPENV_PIPFILE=$BAK_PIPFILE
}

function toggle-dark-yabai-and-spacebar() {
	# yabai dark values
	yabai -m config active_window_border_color 0xff5698f1
	yabai -m config normal_window_border_color 0xff171933
	yabai -m config window_border_width 3
	# spacebar dark values
	spacebar -m config background_color 0xff212337
	spacebar -m config foreground_color 0xffc8d3f5
	spacebar -m config space_icon_color 0xff5698f1
}
