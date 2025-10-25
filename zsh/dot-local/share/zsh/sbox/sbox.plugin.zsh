0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# [[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
[[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

# autoload -Uz ${0:h}/functions/*(:t)
