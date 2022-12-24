#!/bin/sh

~/shell/hyprexit.sh &

echo "shutting down..."
if [ -x "$(command -v doas)" ]; then
  doas poweroff
else
  sudo shutdown -h now
fi
