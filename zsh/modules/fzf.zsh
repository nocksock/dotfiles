# check if fzf is installed
if ! command -v fzf &> /dev/null; then
    style -fg yellow "Warning: fzf wast not found"
    return
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# changing the default command to ignore vcs, git, node_modules etcp
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,node_modules.*/,.git/*,package-lock.json}" '
export FZF_DEFAULT_OPTS='-m --bind shift-up:preview-up,shift-down:preview-down,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-t:toggle-all'

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
