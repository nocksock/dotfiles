# standardized handling of $0
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
[[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

autoload -Uz ${0:h}/functions/*(:t)

# aliases
alias sudo='sudo '
alias reload="exec zsh"

alias nnn='nnn -ei'
alias qf='qufo'

alias pio='pnpm install --prefer-offline .'
alias pii='pnpm install --ignore-scripts --ignore-workspace .'
alias piio='pnpm install --ignore-scripts --ignore-workspace --prefer-offline .'

alias ll='ls -la'

alias love='/Applications/love.app/Contents/MacOS/love'

alias jr='cd $(jj root)'

# {{{ navigation
alias slurp="pushd && pushd -"
alias c='cd $(list-projects | fzf)'
alias ..='cd ..'
alias q='cd ~ && clear'
alias pd="pushd"
alias gd="popd"
alias ndf="cd $DOTDIR; nvim '+Telescope find_files'"
alias oc="cd $HOME/code/bleepbloop.studio/content/collections; nvim '+Telescope find_files'"
alias cdp="cd \$(list-projects | fzf)"

# }}}

export PATH
export FPATH
