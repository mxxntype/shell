#!/bin/sh

THRESHOLD=0
SWWW_DAEMONS=$(ps -e | grep -c 'swww')
if [ $SWWW_DAEMONS -le $THRESHOLD ]; then
  swww init
fi

sleep 0.2 && swww img ~/.config/wallpapers/sunset.gif
