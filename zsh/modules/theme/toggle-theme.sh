fitermunction toggle-theme() {
	IS_DARK=$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode')
	if $IS_DARK; then
		toggle-light
	else
		toggle-dark
	fi
}

function tt() {
	if [[ "$OSTYPE"	== "darwin"* ]];
	then
		toggle-theme >/dev/null 2>&1
	fi
}


function toggle-light() {
	alias cat="bat --paging never --theme=GitHub"
	toggle-os-light
	toggle-yabai-light
	toggle-sketychbar-light
	toggle-iterm-light
}

function toggle-dark() {
	alias cat="bat --paging never --theme=default"
	toggle-os-dark
	toggle-yabai-dark
	toggle-sketchybar-dark
	toggle-iterm-dark
}
