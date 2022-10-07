#!/usr/bin/env sh

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

