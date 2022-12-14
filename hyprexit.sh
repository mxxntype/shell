#!/bin/sh

# choices
TEXT_EXIT=" Exit Hyprland"
TEXT_REBOOT=" Reboot"
TEXT_SHUTDOWN="⏻ Shutdown"

if [[ "$1" != "-i" ]] && [[ "$1" != "--interactive" ]]; then
  # if called with no arguments, exit Hyprland
  swww kill
  brillo -O
  hyprctl dispatch exit yes

elif [ -x $( command -v tofi ) ]; then
  # if running interactively, ask for an action through tofi
  ACTION=$(echo -e "$TEXT_EXIT\n$TEXT_REBOOT\n$TEXT_SHUTDOWN" |
    tofi --height=112 --width=188 --prompt-text="" --placeholder-text="Choose an action:" --placeholder-color="cdd6f4")
  echo "selected: $ACTION"

  # exit Hyprland
  if [[ "$ACTION" = "$TEXT_EXIT" ]]; then
    echo "exiting wayland..."
    $HOME/shell/hyprexit.sh &

  # reboot the system
  elif [[ "$ACTION" = "$TEXT_REBOOT" ]]; then
    echo "rebooting..."
    $HOME/shell/reboot.sh &

  # power off the system
  elif [[ "$ACTION" = "$TEXT_SHUTDOWN" ]]; then
    echo "shutting down..."
    $HOME/shell/shutdown.sh &

  # fallback
  else
    echo "error: no valid action provided."
  fi

else
  echo "error: couldn't run tofi."

fi
