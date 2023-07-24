# check if fzf is installed
if ! command -v fzf &> /dev/null; then
    style -fg yellow "Warning: fzf was not found!"
    return
fi

export FZF_OPTS=(
  "-m"
  "--bind ctrl-j:down,ctrl-k:up"
  "--bind ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
  "--bind ctrl-a:select-all,ctrl-t:toggle-all"
  "--bind ctrl-s:toggle-sort,ctrl-r:toggle-preview,ctrl-/:toggle-search"
)

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
export FZF_DEFAULT_OPTS="$FZF_OPTS"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -pf --line-range :999 {}' --bind='ctrl-o:execute(nvim {})'"

if [[ $OSTYPE == darwin* ]]; then
  test -f /opt/homebrew/opt/fzf/shell/completion.zsh   \
    && source /opt/homebrew/opt/fzf/shell/completion.zsh
  test -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
    && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

if [[ $OSTYPE == linux-gnu ]]; then
  test -f /usr/share/doc/fzf/examples/completion.zsh   \
    && source /usr/share/doc/fzf/examples/completion.zsh
  test -f /usr/share/doc/fzf/examples/key-bindings.zsh \
    && source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

