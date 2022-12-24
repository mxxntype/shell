#!/bin/sh

~/shell/hyprexit &

if [ -x "$(command -v brillo)" ]; then
  brillo -O
fi

echo "rebooting..."
if [ -x "$(command -v doas)" ]; then
  doas reboot
else
  sudo reboot
fi
