#!/bin/sh

# general
WALLPAPER_DIR=$HOME/.config/wallpapers
WALLPAPER_STYLE=gradient

# start swww daemon if none already running
init () {
  SWWW_DAEMONS=$(ps -e | grep -c 'swww')
  if [ $SWWW_DAEMONS -le "0" ]; then
    swww init && swww clear 1e1e2e && echo "init: successful"
  fi
}

restore () {
  if [ -f "$HOME/.cache/wallpaper" ]; then
    WALLPAPER_FILE=$(cat $HOME/.cache/wallpaper)
  fi
}

# picks a random wallpaper
random () {
  WALLPAPER_FILE="$(ls $WALLPAPER_DIR/$WALLPAPER_STYLE | sort -R | head -n 1)"
}

# ask the user for a wallpaper through tofi
interactive () {
  TEXT_RANDOM=" Random $WALLPAPER_STYLE"
  TEXT_DARK=" Dark $WALLPAPER_STYLE"
  TEXT_MANUAL="Select manually..."
  CHOICE=$( echo -e "$TEXT_RANDOM\n$TEXT_DARK\n$TEXT_MANUAL" |
    tofi  --prompt-text="" --placeholder-text="Pick an option:" --placeholder-color="cdd6f4" --width=200 --height=112 )
  if [[ "$CHOICE" = "$TEXT_RANDOM" ]]; then
    random
  elif [[ "$CHOICE" = "$TEXT_DARK" ]]; then
    WALLPAPER_FILE="base-srf0.jpg"
  elif [[ "$CHOICE" = "$TEXT_MANUAL" ]]; then
    WALLPAPER_FILE=$(ls $WALLPAPER_DIR/$WALLPAPER_STYLE |
      tofi --prompt-text="" --placeholder-text="Pick a wallpaper:" --placeholder-color="cdd6f4" --width=240 )
  fi
}

# sets the wallpaper
apply () {
  if [ -f "$WALLPAPER_DIR/$WALLPAPER_STYLE/$WALLPAPER_FILE" ]; then
    sleep 0.2 && swww img --outputs=HDMI-A-1 $WALLPAPER_DIR/$WALLPAPER_STYLE/$WALLPAPER_FILE &&
      echo "applied: $WALLPAPER_STYLE/$WALLPAPER_FILE." &&
      echo "$WALLPAPER_FILE" > $HOME/.cache/wallpaper
  else
    echo "$WALLPAPER_DIR/$WALLPAPER_STYLE/$WALLPAPER_FILE: file does not exist."
  fi
}

init

if [[ "$1" == "--restore" ]]; then
  echo "restoring previous wallpaper."
  restore && apply
elif [[ "$1" = "--random" ]] || [[ "$1" = "-r" ]]; then
  echo "choosing random wallpaper."
  random && apply
elif [[ "$1" = "--interactive" ]] || [[ "$1" = "-i" ]]; then
  echo "running in interactive mode."
  interactive && apply
else
  echo "error: no/invalid mode supplied. exiting..."
fi
