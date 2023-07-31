# standardized handling of $0
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

# [[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
# autoload -Uz ${0:h}/functions/*(:t)
