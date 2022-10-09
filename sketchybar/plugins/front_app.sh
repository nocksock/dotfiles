#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.sh

if [[ $1 == "setup" ]]; then
  NAME=front_app

  sketchybar                            \
    --add item $NAME $POSITION          \
    --set $NAME                         \
      script="$PLUGIN_DIR/front_app.sh" \
      label.color=$COLOR_ACTIVE         \
      icon.drawing=off                  \
    --subscribe front_app front_app_switched

fi

# UPDATE

sketchybar --set $NAME label="$INFO"
