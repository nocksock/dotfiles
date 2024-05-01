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
alias prb='pnpm run build'
alias prs='pnpm run start'

alias pio='pnpm install --prefer-offline .'
alias pii='pnpm install --ignore-scripts --ignore-workspace .'
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
alias gca='git commit --amend'
function gcm() {
	git commit -m "$*"
}
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

# check if exa is istalled
if command -v exa &> /dev/null; then
  alias ls='exa --icons -1 --group-directories-first -a'
  alias ll='exa --icons -l --group-directories-first -a'
fi

# }}}

export PATH
export FPATH
