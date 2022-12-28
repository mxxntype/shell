#!/bin/sh

if [ "$(ps -e | grep -c waybar)" -eq "0" ]; then
  waybar & # start waybar if not running already
else
  killall -SIGUSR2 waybar && # reload waybar & send notification
    notify-send "Waybar reloaded." -i /usr/share/icons/ePapirus-Dark/32x32/apps/systemtray.svg
fi

# waybar doesn't seem to show the keyboard language until it is changed
# for the first time, this does nothing noticeable but fixes the issue
sleep 0.1 &&
hyprctl switchxkblayout cooler-master-technology-inc.-gaming-mech-kb 1
hyprctl switchxkblayout cooler-master-technology-inc.-gaming-mech-kb 0
