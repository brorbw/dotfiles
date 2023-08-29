function toggle-yabai-light() {
	# yabai light values
	$(yabai -m config normal_window_border_color 0xffdee4ec;\
	yabai -m config active_window_border_color 0xfff5a9e0;\
	yabai -m config window_border_width 3)
}

function toggle-yabai-dark() {
	# yabai dark values
	$(yabai -m config active_window_border_color 0xff5698f1;\
	yabai -m config normal_window_border_color 0xff171933;\
	yabai -m config window_border_width 2)
}
