#!/bin/sh

THRESHOLD=0
SWWW_DAEMONS=$(ps -e | grep -c 'swww')
if [ $SWWW_DAEMONS -le $THRESHOLD ]; then
  swww init && swww clear 1e1e2e
fi

WALLPAPER="$(ls $HOME/.config/wallpapers | grep '.gif' | sort -R | head -n 1)"
echo $WALLPAPER

sleep 0.2 && swww img --outputs=HDMI-A-1 $HOME/.config/wallpapers/$WALLPAPER
