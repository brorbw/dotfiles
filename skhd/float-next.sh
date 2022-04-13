#!/usr/bin/env bash

yabai -m signal --add label=float_next_window_created event=window_created action='yabai -m signal --remove float_next_window_created; yabai -m signal --remove float_next_application_launched; yabai -m window $YABAI_WINDOW_ID --toggle float; yabai -m window $YABAI_WINDOW_ID --grid 4:4:1:1:2:2'
yabai -m signal --add label=float_next_application_launched event=application_launched action='yabai -m signal --remove float_next_window_created; yabai -m signal --remove float_next_application_launched; yabai -m query --windows | jq -r ".[] | select(.pid == $YABAI_PROCESS_ID).id" | xargs -I{} yabai -m window {} --toggle float; yabai -m window $YABAI_WINDOW_ID --grid 4:4:1:1:2:2'
