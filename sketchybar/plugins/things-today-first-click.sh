state=$(sketchybar --query $NAME | jq ".label.drawing")

if [ $state = "on" ]; then
  sketchybar --set $NAME label.drawing=off
  exit 0;
fi

if [ $state = "off" ]; then
  sketchybar --set $NAME label.drawing=on
  exit 0;
fi
