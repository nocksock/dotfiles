# check if tmux is installed
if ! command -v tmux &> /dev/null; then
    style -fg yellow "Warning: tmux wast not found"
    return
fi

alias tml="tmux-live"
alias tmp="tmux-qp"
alias tma="tmux attach -t"

# TODO: find out why I created this alias
alias tmux="TERM=screen-256color-bce tmux"

alias tmr="tmux-recent"
function tmux-recent {
  local dir

  if [[ -z $1 ]]; then
    dir=$(select-z)
  else
    dir=$(z -e $1)
  fi

  [[ -z $dir ]] && return 1

  local session_name=${dir##/*/}

	tmux new -s $session_name -c $dir
}

alias tmrn="tmux-recent-nvim"
function tmux-recent-nvim {
  local dir
  if [[ -z $1 ]]; then
    dir=$(select-z)
  else
    dir=$(z $1)
  fi
  [[ -z $dir ]] && return 1
  local dir=$(select-z)
  [[ -z $dir ]] && return 1

  local session_name=${dir##/*/}

	tmux new       -s $session_name -c $dir -d
  tmux send-keys -t $session_name:1.1 "nvim" C-m
  tmux attach    -t $session_name
}

alias tmn="tmux-new"
function tmux-new {
	tmux new -s ${PWD##*/}
}

alias tmnn="tmux-new-nvim"
function  tmux-new-nvim {
  local session_name="${PWD##/*/}"

	tmux new       -s $session_name -c $PWD -d
  tmux send-keys -t $session_name:1.1 "nvim" C-m
  tmux attach    -t $session_name
}

function pwd-session-name {
  echo ${PWD##/*/}
}
