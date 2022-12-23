#!/bin/sh

ACTION=$1

TEXT_CHANGE_WALLPAPER=" Change wallpaper"

if [[ "$ACTION" = "" ]]; then
  echo "no action pre-supplied, prompting the user..."
  ACTION=$( echo -e "$TEXT_CHANGE_WALLPAPER" |
    tofi --prompt-text="" --placeholder-text="What to do?" --placeholder-color="cdd6f4" --width=240 --height=112 )
fi

if [[ "$ACTION" = "--wallpaper" ]] || [[ "$ACTION" = "$TEXT_CHANGE_WALLPAPER" ]]; then
  $HOME/shell/wallpaper.sh --interactive
fi
