0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# [[ -z ${fpath[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
# [[ -z ${path[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

declare -Ag WM_COLORS
WM_COLORS=(
  white       "0xFFDEE9F7"
  white_alpha "0x88DEE9F7"
  blue_dark   "0xFF7188A8"
  grey        "0xFF394351"
  black       "0xFF14161B"
  black_alpha "0x8814161B"
  green_alt   "0xFF1AC77F"
  green       "0xFF41E6A2"
  green_alpha "0x8041E6A2"
  lavender    "0xFF9AA2F4"
  blue        "0xFF7DCFFF"
  blue_trans  "0x007DCFFF"
  pink        "0xFFF7A1C5"
  pink_alpha  "0xAAF7A1C5"
	magenta     "0xFFEF3885"
  trans       "0x00F7A1C5"
)
export WM_COLORS

# autoload -Uz ${0:h}/functions/*(:t)
