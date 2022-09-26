#!/usr/bin/env sh
yabai -m query --windows | jq '.[] | select(."has-focus" == true) | .display, .id'
