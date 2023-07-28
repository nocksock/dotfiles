SELF=$(realpath $0)
QUICK_WINDOW_TITLE="Kitty Quick Window"

close-quick-window () {
  QUICK_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.title == "Kitty Quick Window") | .id')
  if [[ -n $QUICK_WINDOW_ID ]]; then
    yabai -m query --windows | jq '.[] | select(.app == "kitty") | {id: .id, title: .title}'
    yabai -m window $QUICK_WINDOW_ID --close
  fi
}

on-create () {
  WINDOW_ID=$1
  WINDOW_DATA=$(yabai -m query --windows --window $WINDOW_ID)
  IS_RESIZABLE=$(echo ${WINDOW_DATA} | jq '.resizable')
  WINDOW_TITLE=$(echo ${WINDOW_DATA} | jq '.title')

  if [[ "$WINDOW_TITLE" = "Kitty Quick Window" ]]; then
    yabai-toggle-prop -t -f $WINDOW_ID
  fi
}

on-focus () {
  WINDOW_DATA=$(yabai -m query --windows --window $WINDOW_ID)
  WINDOW_TITLE=$(echo ${WINDOW_DATA} | jq -r '.title')
  if [[ ! "$WINDOW_TITLE" == "Kitty Quick Window" ]]; then
    close-quick-window
  fi
}

cleanup () {
  yabai -m rule   --remove "mod:kitty"
  yabai -m signal --remove "mod:kitty"
}

setup () {
  cleanup 2>/dev/null

  yabai -m rule   --add label="mod:kitty" title="Kitty Quick Window" manage=off grid="12:8:2:4:4:4" sticky=on
  yabai -m signal --add label="mod:kitty" app="kitty" event=window_created action="zsh $SELF on-create"
  yabai -m signal --add label="mod:kitty"             event=window_focused action="zsh $SELF on-focus"
}


fns=(cleanup setup on-focus on-create)
if [[ " ${fns[@]} " =~ " $SUBCOMMAND " ]]; then
  shift; eval "$SUBCOMMAND $@"
else
  echo "ERR: Unknown Subcommand: $SUBCOMMAND"
  echo "    Available Subcommands: ${fns[@]}"
  exit 1
fi
