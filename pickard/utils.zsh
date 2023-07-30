PICKARD_LOG="${PICKARD_LOG:-$HOME/.pickard.log}"

_log() {
  # check if stdin
  if [ -t 0 ]; then
    echo "$(date) $@" >> $PICKARD_LOG
    return
  else
    while read line; do
      echo "$(date) $line" >> $PICKARD_LOG
    done
    return
  fi
}

_check-fns() {
  # every picker must implement these functions
  fns=(pick list view open)
  for fn in "${fns[@]}"; do
    if ! command -v $fn &> /dev/null
    then
        exec >&2
        echo "error: missing function"
        echo "    $fn() could not be found in the picker: $SELF_NAME"
        exit 1
    fi
  done

  echo "Functions OK"
}

_check-dependencies() {
  dependencies=(fzf)
  for dep in "${dependencies[@]}"; do
    if ! command -v $dep &> /dev/null
    then
        echo "$dep could not be found"
        exit 1
    fi
  done

  echo "Dependencies OK"
}

_check() {
  if [[ $1 == "-q" ]]; then
    exec 1>/dev/null
  fi
  _check-fns
  _check-dependencies
}

_run() {
  SUBCOMMAND=$1
  shift
  eval "$SUBCOMMAND $@"
}
