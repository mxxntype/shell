#!/bin/sh

# kill running waybar instances
if [ "$(ps -e | grep -c waybar)" -gt "0" ]; then
  killall -9 waybar
fi

# start waybar & send a notification
waybar &
notify-send "Waybar reloaded." -i /usr/share/icons/ePapirus-Dark/32x32/apps/systemtray.svg

# waybar doesn't seem to show the keyboard language until it is changed
# for the first time, this does nothing noticeable but fixes the issue
sleep 0.25 &&
hyprctl switchxkblayout cooler-master-technology-inc.-gaming-mech-kb 1
hyprctl switchxkblayout cooler-master-technology-inc.-gaming-mech-kb 0
