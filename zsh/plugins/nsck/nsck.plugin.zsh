# standardized handling of $0
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
[[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

autoload -Uz ${0:h}/functions/*(:t)

# aliases
alias sudo='sudo '
alias reload="exec zsh"

alias pick="pickard"
alias kqw="kitty-quick-window"
alias nnn='nnn -ei'
alias qf='qufo'
alias pio='pnpm install --prefer-offline .'
alias piio='pnpm install --ignore-scripts --ignore-workspace --prefer-offline .'

# {{{ git
alias gss='git status'
alias gs='git status -s .'
alias ngs='nvim +:Git status'
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gg='lazygit'
alias gsw='pushd "$(git worktree list --porcelain | ggrep -Po "(?<=worktree ).*" | fzf)"'
alias gb="git branch -l --format='%(refname:short)' | fzf | xargs git switch" 
alias ggl='git-grouped-log'
alias gsb='git-switch-branch'
# }}}
# {{{ navigation
alias slurp="pushd && pushd -"
alias c='cd $(list-projects | fzf)'
alias ..='cd ..'
alias q='cd ~ && clear'
alias pd="pushd"
alias gd="popd"
alias ndf="cd $DOTDIR; nvim '+Telescope find_files'"
alias cdp="cd \$(list-projects | fzf)"

alias ls='exa -1 --group-directories-first -a'
alias ll='exa -l --group-directories-first -a'
# }}}
# tmux {{{

alias tma="tmux attach -t"
alias tml="tmux-live"
alias tmn="tmux-new"
alias tmnn="tmux-new-nvim"
alias tmp="tmux-qp"
alias tmr="tmux-recent"
alias tmrn="tmux-recent-nvim"

# }}}
#
export PATH
export FPATH
