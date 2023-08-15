#!/bin/sh
# Select space based on index of space on screen, e.g. if the active screen contains the
# spaces [ 2, 4, 5 ] and run `~/.dotfiles/yabai/select_space_on_current_display.sh 1`, we
# will switch to space 4. Used with skhd.
# - kba, bbw

readonly LOG_FILE=~/.config/scripts/log.txt

readonly SPACE_INDEX=$1
# echo "SPACE_INDEX=$SPACE_INDEX" | ts | tee -a $LOG_FILE

readonly ACTIVE_DISPLAY_ID=$(yabai -m query --spaces |
	jq '.[] | select(."has-focus" == true).display')
# echo "ACTIVE_DISPLAY_ID=$ACTIVE_DISPLAY_ID" | ts | tee -a $LOG_FILE

readonly SPACES_OF_ACTIVE_DISPLAY=$(yabai -m query --displays |
	jq ".[] | select(.index == $ACTIVE_DISPLAY_ID).spaces")
# echo "SPACES_OF_ACTIVE_DISPLAY=$SPACES_OF_ACTIVE_DISPLAY" | ts | tee -a $LOG_FILE

readonly TARGET_SPACE=$(echo $SPACES_OF_ACTIVE_DISPLAY |
	jq -r ".[$SPACE_INDEX]")
# echo "TARGET_SPACE=$TARGET_SPACE" | ts | tee -a $LOG_FILE

# We do the below twice, because yabai is broken and in some scenarios doesn't focus the window
# on the space it just switched to. Instead, it'll switch to the right space, but then focus the
# window on the main monitor. This fixes it.
yabai -m window --space $TARGET_SPACE
yabai -m space --focus $TARGET_SPACE
