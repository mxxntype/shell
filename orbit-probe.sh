#!/bin/sh

THRESHOLD=2
ORBIT_PATH="$HOME/go/src/orbit/orbit"

if [ -x "$(command -v $ORBIT_PATH)" ]; then
  OPEN_TERMINALS=$(ps -e | grep -c 'zsh')
  if [ $OPEN_TERMINALS -le $THRESHOLD ]; then
    exec $ORBIT_PATH $@
  fi
fi
