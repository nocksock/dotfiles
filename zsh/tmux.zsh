alias tml="tmux-live"
alias tat="tmux -u attach -t"
alias tp="tmux-qp"

# TODO: find out why I created this alias
alias tmux="TERM=screen-256color-bce tmux"


# x and z keys are too unconvenient to type for aliases and I observed
# how I didn't use as much as I wanted to.

# mnemonic: Tmux Recent
tr () {
  local dir=$(z | awk '{print $2}' | sed "s#$HOME#~#" | fzf | sed "s#~#$HOME#")
	tmux new -s ${dir##*/}
}

# mnemonic: Tmux Recent Nvim
trn () {
  local dir=$(z | awk '{print $2}' | sed "s#$HOME#~#" | fzf | sed "s#~#$HOME#")
  tmux new -s ${dir##*/}
  tmux send-keys -t ${dir##*/} "nvim" C-m
}

# mnemonic: TMux New
function tmn() {
	tmux -u new -s ${PWD##*/}
}

