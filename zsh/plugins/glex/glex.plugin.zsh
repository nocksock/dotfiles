# standardized handling of $0
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

local GLEX_DIR="${0:h}"
local GLEX_BIN="${GLEX_DIR}/bin"
local GLEX_FUNCTION_DIR="${GLEX_DIR}/functions"

if [[ -z ${fpath[(r)${GLEX_DIR}/functions]} ]] {
    fpath+=( "${GLEX_DIR}/functions" )
}

if [[ -z ${path[(r)${GLEX_DIR}/bin]} ]] {
		path+=( "${GLEX_DIR}/bin" )
}

autoload -Uz ${GLEX_FUNCTION_DIR}/*(:t)

unset GLEX_DIR
unset GLEX_BIN
unset GLEX_FUNCTION_DIR
