#!/bin/sh

res_from_ha=$(curl -s -X GET https://ha.nobad.coffee/api/states/sensor.livingroom_sonoff_snzb_02_temperature -H "Authorization: Bearer $(cat $HOME/.ha-token)" | jq -r '.state + .attributes.unit_of_measurement')
sketchybar --set $NAME label="$res_from_ha"
