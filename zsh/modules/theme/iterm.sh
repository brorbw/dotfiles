function toggle-iterm-light() {
	$(python3 ~/Projects/iterm2-theme-toggle/main.py $LIGHT_THEME >/dev/null 2>&1 &)
}

function toggle-iterm-dark() {
	$(python3 ~/Projects/iterm2-theme-toggle/main.py $DARK_THEME >/dev/null 2>&1 &)
}
