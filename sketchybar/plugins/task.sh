#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.zsh

if [[ $1 == "setup" ]]; then
  NAME=focus

  sketchybar                                   \
    --add item $NAME $POSITION                 \
    --set $NAME                                \
      update_freq=10                           \
      script="$PLUGIN_DIR/task.sh"             \
      click_script="$PLUGIN_DIR/task.sh click" \
      background.padding_left=8                \
      background.padding_right=8               \
      background.height=24                     \
      label.padding_right=8                    \
      icon.padding_left=8                      \
      background.color=$BLACK                  \
      background.corner_radius=4               \
      label.color=$COLOR_HIGHLIGHT             \
      icon.color=$COLOR_HIGHLIGHT

fi

if [[ $1 == "click" ]]; then
  state=$(sketchybar --query $NAME | jq -a '.label.drawing ==  "on"')

  if [ $state = "true" ]; then
      sketchybar --set $NAME icon.color=$COLOR_INACTIVE label.drawing=off
  fi

  if [ $state = "false" ]; then
      sketchybar --set $NAME icon.color=$COLOR_HIGHLIGHT label.drawing=on
  fi

  exit
fi

# UPDATE

# The applescript is a copy from raycast's script-commands repo
#   source: https://github.com/raycast/script-commands/blob/775ccbf8f635caa58bce679802dba4cee422fac0/commands/apps/things/things-current-todo.applescript
TMP=$(mktemp)
osascript <<EOD 2> $TMP
if application "Things3" is not running then
  log "NOT_RUNNING"
  return
end if

tell application "Things3"
  set todayTodos to to dos of list "Today"

  repeat with i from 1 to count of todayToDos
    set todo to item i of todayToDos

    if status of todo is open then
      set currentTodoName to name of todo as text
      log currentTodoName
      return
    end if
  end repeat

  log "EMPTY"
end tell
EOD

result=$(cat $TMP)
rm $TMP

case $result in
  EMPTY)
    sketchybar --set $NAME label="" icon=""
  ;;
  NOT_RUNNING)
    sketchybar --set $NAME icon="" label="things is not running" label.color=0xffff0000
  ;;
  *)
    sketchybar --set $NAME icon="" label="$result"
  ;;
esac
