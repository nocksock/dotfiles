#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.sh

if [[ $1 == "setup" ]]; then
  NAME=battery

  sketchybar                            \
    --add item $NAME $POSITION          \
    --set $NAME                         \
      script="$PLUGIN_DIR/battery.sh"   \
      update_freq=10                    \
      background.padding_left=$SPACE_2  \
      background.padding_right=$SPACE_2 \
      icon.padding_left=$SPACE          \
      icon.padding_right=$SPACE         \
      label.padding_left=$SPACE         \
      label.padding_right=$SPACE        \
    --subscribe battery system_woke

fi

# UPDATE

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $PERCENTAGE = "" ]]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

if [[ $CHARGING != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"
