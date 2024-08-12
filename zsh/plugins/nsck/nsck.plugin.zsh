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
