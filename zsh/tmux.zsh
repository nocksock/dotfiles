alias tml="tmux-live"
alias tat="tmux -u attach -t"
alias tp="tmux-qp"

# TODO: find out why I created this alias
alias tmux="TERM=screen-256color-bce tmux"


alias tr="tmux-recent"
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

alias trn="tmux-recent-nvim"
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

alias tn="tmux-new"
function tmux-new {
	tmux new -s ${PWD##*/}
}

alias tnn="tmux-new-nvim"
function  tmux-new-nvim {
  local session_name="${PWD##/*/}"

	tmux new       -s $session_name -c $PWD -d
  tmux send-keys -t $session_name:1.1 "nvim" C-m
  tmux attach    -t $session_name
}

function pwd-session-name {
  echo ${PWD##/*/}
}
