#!/bin/sh

THRESHOLD=0
SWWW_DAEMONS=$(ps -e | grep -c 'swww')
if [ $SWWW_DAEMONS -le $THRESHOLD ]; then
  swww init && swww clear 1e1e2e
fi

WALLPAPER_DIR=$HOME/.config/wallpapers
WALLPAPER_STYLE=gradient

WALLPAPER_FILE="$(ls $WALLPAPER_DIR/$WALLPAPER_STYLE | sort -R | head -n 1)"
echo $WALLPAPER_FILE

sleep 0.2 && swww img --outputs=HDMI-A-1 $WALLPAPER_DIR/$WALLPAPER_STYLE/$WALLPAPER_FILE
