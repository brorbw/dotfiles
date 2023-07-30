#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if $SELECTED
then
	sketchybar --set $NAME \
									 background.drawing=$SELECTED \
									 icon.color=0xff21242b
else
	sketchybar --set $NAME \
									 background.drawing=$SELECTED \
									 icon.color=0xffbbc2cf
fi
