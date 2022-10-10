#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.sh

update() {
  if [[ $SELECTED == true ]]; then

    sketchybar                         \
      --set $1                         \
        icon.color=$BLACK              \
        label.color=$BLACK             \
        background.color=$COLOR_ACTIVE \
        background.drawing=on

  else

    sketchybar                      \
      --set $1                      \
        icon.color=$COLOR_INACTIVE  \
        label.color=$COLOR_INACTIVE \
        background.drawing=off

  fi
}

if [[ $1 == "setup" ]]; then
  SPACE_ICONS=("" "" "" "" "" "")
  SPACE_LABELS=("SIDE" "MAIN" "COMM" "PLAN" "PLAY" "CHAT")

  for i in "${!SPACE_ICONS[@]}"; do

    sid=$(($i+1))
    case "$sid" in
      1) margin_left=0 ;;
      *) margin_left=$SPACE_2 ;;
    esac

    echo $margin_left

    sketchybar                                          \
      --add space space.$sid $POSITION                  \
      --set space.$sid                                  \
        associated_space=$sid                           \
        icon=${SPACE_ICONS[i]}                          \
        icon.padding_left=8                             \
        icon.padding_right=4                            \
        background.padding_right=0                      \
        background.padding_left=$margin_left            \
        background.corner_radius=5                      \
        background.height=24                            \
        background.drawing=off                          \
        label.drawing=on                                \
        label.padding_right=8                           \
        label=${SPACE_LABELS[i]}                        \
        script="$PLUGIN_DIR/spaces.sh"                  \
        click_script="$PLUGIN_DIR/spaces.sh click $sid" \

    update space.$sid
  done

  sketchybar                        \
    --add bracket primary_spaces    \
      space.1                       \
      space.2                       \
      space.3                       \
      space.4                       \
      space.5                       \
      space.6                       \
    --set primary_spaces            \
      background.color=$BLACK_ALPHA \
      background.corner_radius=5

  exit
fi

if [[ $1 == "click" ]]; then
  yabai -m space --focus $2
fi

update $NAME
