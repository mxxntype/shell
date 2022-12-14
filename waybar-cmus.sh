#!/bin/sh

CMUS_FILE=$( cmus-remote -C "format_print %f" )

CMUS_TRACKNAME=$(
  echo "$CMUS_FILE" |
  sed -e "s/^\/.*\///"    | # remove path
  sed -e "s/.* - //"      | # remove artist
  sed -e "s/ \[\+.*\]//"  | # remove [features]
  sed -e "s/ (.*)$//"     | # remove (tags)
  sed -e "s/\..*$//"        # remove extension
)

CMUS_OUTPUT=$CMUS_TRACKNAME

CMUS_STATUS="$( echo -e $( cmus-remote -C status ) )"

if [ "$( echo $CMUS_STATUS | grep -c 'status playing' )" -gt "0" ]; then
  if [ "$( echo $CMUS_STATUS | grep -c 'set repeat_current true' )" -gt "0" ]; then
    CMUS_OUTPUT="$CMUS_OUTPUT "
  fi
  echo "$CMUS_OUTPUT"
fi
