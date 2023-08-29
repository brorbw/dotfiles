function toggle-cyberpunk() {
	alias cat="bat --paging never --theme=default"
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' &)
	$(python3 ~/Projects/iterm2-theme-toggle/main.py $CYBERPUNK >/dev/null 2>&1 &)
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
