#!//bin/bash
function toggle-sketychbar-light() {
	# sketchybar light values
	$(sketchybar --bar color=0xffe7eaf2 \
		border_color=0xffe7eaf2; \
	sketchybar --set '/.*/' label.color=0xff616377 \
		icon.color=0xff616377 &)
}

function toggle-sketchybar-dark() {
	# sketchybar dark values
	$(sketchybar --bar color=0xff272c34 \
		border_color=0xff262a32;\
	sketchybar --set '/.*/' label.color=0xffbbc2cf \
		icon.color=0xffbbc2cf)
}
