0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
[[ -z ${fpath[(r)${0:h}/picker]} ]] && fpath+=( "${0:h}/picker" )
[[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

autoload -Uz ${0:h}/functions/*(:t)
autoload -Uz ${0:h}/picker/*(:t)

export PICKARD_PATH="${0:h}"
export PICKARD_LOG="${PICKARD_LOG:-$HOME/.pickard.log}"

export PATH
export FPATH
