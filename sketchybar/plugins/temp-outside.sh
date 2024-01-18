#!/bin/sh

res=$(weather --city Aarhus --country Denmark)
temperature=$(echo "$res" | grep Temperature | cut -d ":" -f 2 | awk '{$1=$1};1')
sketchybar --set $NAME label="$temperature"
