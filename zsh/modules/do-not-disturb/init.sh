function focus_base() {
	if [ -z $1 ];then
		FOCUS_TIME=25
	else
		FOCUS_TIME=$1
	fi
	pkill Messenger
	pkill Slack
	/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli\
		start\
		--blocklist ~/.config/SelfControl/blocklist.selfcontrol\
		--enddate $(date -d "+$FOCUS_TIME minute" -u +"%Y-%m-%dT%H:%M:%S%z") >/dev/null 2>&1
	enable_dnd
at now +"$FOCUS_TIME" minutes <<END
defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean false
killall NotificationCenter
END
}

function focus {
	if [[ "$1" != "status" ]]; then
		focus_base $@
	fi
	focus_status
}

RED="\033[0;31m"
GREEN="\033[0;32m"
COLOR_OFF="\033[0m"

function focus_status() {
	echo "FOCUS STATE:"
	OUTPUT=""
	OUTPUT="$OUTPUT$(_get_messenger_focus_status)\n"
	OUTPUT="$OUTPUT$(_get_slack_focus_status)\n"
	OUTPUT="$OUTPUT$(_get_selfcontrol_focus_status)\n"
	OUTPUT="$OUTPUT$(_get_dnd_focus_status)\n"
	OUTPUT="$OUTPUT$(_get_dnd_unload_task_loaded_status)\n"
	echo "$OUTPUT" | column -t -s$'\t'
	echo "\n"$(_time_until_focus_end)
}

alias fs=focus_status

function _time_until_focus_end {
	START_DATE=$(date -u +"%Y-%m-%dT%H:%M:%S")
	END_DATE=$(selfcontrol print-settings 2>&1 | grep BlockEndDate | cut -d "\"" -f 2 | cut -d " " -f 1-2 | sed 's/ /T/')

	START_TIME=$(date -d "${START_DATE}" +%s)
	END_TIME=$(date -d "${END_DATE}" +%s)
	DIFF_SECONDS="$(($END_TIME-$START_TIME))"
	DIFF_TIME=$(gdate -d@${DIFF_SECONDS} -u +"%HH %MM")
	if [[ $(selfcontrol is-running 2>&1 | cut -d ' ' -f 4) == NO ]];then DIFF_TIME=0; fi
	echo Time until dnd ends:"\t"$DIFF_TIME
}

function _get_dnd_unload_task_loaded_status {
	echo DND disable job:"\t"$([[ $(atq | wc -l) -gt 0 ]] && echo ${GREEN}LOADED${COLOR_OFF} || echo ${RED}NOT LOADED${COLOR_OFF})
}

function _get_messenger_focus_status {
	echo Messenger:"\t"$(pgrep -q Messenger && echo ${RED}OPEN${COLOR_OFF} || echo ${GREEN}CLOSED${COLOR_OFF})
}

function _get_slack_focus_status {
	echo Slack:"\t"$(pgrep -q Slack && echo ${RED}OPEN${COLOR_OFF} || echo ${GREEN}CLOSED${COLOR_OFF})
}

function _get_selfcontrol_focus_status {
	echo SelfControl:"\t"$([[ $(selfcontrol is-running 2>&1 | cut -d ' ' -f 4) == YES ]]&&\
	echo ${GREEN}RUNNING${COLOR_OFF} || echo ${RED}STOPPED${COLOR_OFF})
}

function _get_dnd_focus_status {
	echo DND:"\t"$([[ $(defaults -currentHost read ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb) == 1 ]] &&\
	echo ${GREEN}EABLED${COLOR_OFF} || echo ${RED}STOPPED${COLOR_OFF})
}

function enable_dnd {
	defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true
	defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date "`date -u +\"%Y-%m-%d %H:%M:%S +000\"`"
	killall NotificationCenter
}

function disable_dnd {
	defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean false
	killall NotificationCenter
}
