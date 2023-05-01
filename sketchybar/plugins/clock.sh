#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.zsh

if [[ $1 == "setup" ]]; then
  NAME=clock

  sketchybar                        \
    --add item $NAME $POSITION      \
    --set $NAME                     \
      update_freq=25                \
      label.padding_right=$SPACE_2 \
      script="$PLUGIN_DIR/clock.sh"

fi

# UPDATE

sketchybar --set $NAME label="$(date '+%d/%m %H:%M')"

