#!/bin/sh

if [ -x "$(command -v gum)" ]; then
  gum style --align="center" --padding="0 2" --border=rounded --border-foreground="0" "warden: greetings, $USER..."
fi
