# Always TMUX!
# Start with the tmux_chooser
if [[ ! -v TMUX && $TERM_PROGRAM != "vscode" ]]; then
  tmux_chooser && exit
fi
