function toggle-os-light() {
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' &)
}

function toggle-os-dark() {
	$(osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' &)
}
