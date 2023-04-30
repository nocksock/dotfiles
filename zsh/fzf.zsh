# check if fzf is installed
if ! command -v fzf &> /dev/null; then
    style -fg yellow "Warning: fzf wast not found"
    return
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# changing the default command to ignore vcs, git, node_modules etcp
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,node_modules.*/,.git/*,package-lock.json}" '
export FZF_DEFAUTLT_OPTS='--height 40% --layout=reverse --border --bind up:preview-up,down:preview-down'

source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
