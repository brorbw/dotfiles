#!/usr/bin/env bash

function toggle-theme() {
	IS_DARK=$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode')
	if $IS_DARK; then
		toggle-light >/dev/null 2>&1
	else
		toggle-dark
	fi
}

export LIGHT_THEME="AtomOneLight"
export DARK_THEME="DoomOne"
export CYBERPUNK="cyberpunk-2077"

function toggle-light() {
	alias cat="bat --paging never --theme=GitHub"
	osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' &
	toggle-light-yabai-and-spacebar &
	python3 ~/Projects/iterm2-theme-toggle/main.py $LIGHT_THEME >/dev/null 2>&1 &
	# $($(spicetify config current_theme Ziro && spicetify config color_scheme Rose-Pine-dawn && spicetify apply) &)
}

function toggle-light-yabai-and-spacebar() {
	# yabai light values
	yabai -m config normal_window_border_color 0xffdee4ec
	yabai -m config active_window_border_color 0xfff5a9e0
	yabai -m config window_border_width 3
	# sketchybar light values

	sketchybar --bar color=0xffe7eaf2 \
									 border_color=0xffe7eaf2
	sketchybar --set '/.*/' label.color=0xff616377 \
													icon.color=0xff616377
}

function toggle-dark() {
	alias cat="bat --paging never --theme=default"
	osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' &
	toggle-dark-yabai-and-spacebar &
	python3 ~/Projects/iterm2-theme-toggle/main.py $DARK_THEME >/dev/null 2>&1 &
	# $($(spicetify config current_theme Ziro && spicetify config color_scheme Rose-Pine-moon && spicetify apply) &)
}

function toggle-dark-yabai-and-spacebar() {
	# yabai dark values
	yabai -m config active_window_border_color 0xff5698f1
	yabai -m config normal_window_border_color 0xff171933
	yabai -m config window_border_width 2
	# sketchybar dark values
	sketchybar --bar color=0xff272c34 \
									 border_color=0xff262a32
	sketchybar --set '/.*/' label.color=0xffbbc2cf \
													icon.color=0xffbbc2cf
}

function toggle-cyberpunk() {
	alias cat="bat --paging never --theme=default"
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' &)
	BAK_PIPFILE=$PIPENV_PIPFILE
	(PIPENV_PIPFILE=~/Projects/iterm2-theme-toggle/Pipfile exec pipenv run python3 ~/Projects/iterm2-theme-toggle/main.py $CYBERPUNK >/dev/null 2>&1 &)
	PIPENV_PIPFILE=$BAK_PIPFILE
	# yabai dark values
	yabai -m config active_window_border_color 0xff5df5fd
	yabai -m config normal_window_border_color 0xff2b5f5c
	yabai -m config window_border_width 2
	# sketchybar dark values
	sketchybar --bar color=0xff1e080a \
									 border_color=0xff262a32
	sketchybar --set '/.*/' label.color=0xff47b7aa \
													icon.color=0xff47b7aa
}
