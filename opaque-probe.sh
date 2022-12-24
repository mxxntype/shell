#!/bin/sh

THRESHOLD=2

if [ -x "$( command -v opaque.sh )" ]; then
  OPEN_TERMINALS=$( ps -e | grep -c 'zsh' )
  if [ $OPEN_TERMINALS -le $THRESHOLD ]; then
    exec opaque.sh
  fi
fi
