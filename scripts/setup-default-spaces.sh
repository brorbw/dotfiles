#!/bin/bash
# Create the standard amount of displays

default_amount_of_spaces=$1
: "${default_amount_of_spaces:=5}"
readonly display_info=$(yabai -m query --displays)
readonly number_of_displays=$(echo "$display_info" | jq length)
readonly max_index_of_display=$((number_of_displays - 1))

echo "number of displays" $number_of_displays
echo "max index of display" $max_index_of_display

for ((display_index=0;  display_index<=$max_index_of_display; display_index++)) do
	number_of_spaces=$(echo "$display_info" | jq ".[$display_index].spaces" | jq length)
	echo "nubmer of spaces" $number_of_spaces
	missing_spaces=$((default_amount_of_spaces - number_of_spaces))
	echo "missing spaces" $missing_spaces "for display" $display_index
	while [ $missing_spaces -gt 0 ]; do
		yabai -m space --create $(($display_index + 1))
		missing_spaces=$((missing_spaces - 1))
	done
done
