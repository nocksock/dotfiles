FONT="Recursive Mono Linear Static:SemiBold:14.0"
ICONFONT="JetBrainsMono NF:Bold:14.0"
PLUGIN_DIR="$HOME/.config/sketchybar/modules"

RADIUS=5
SPACE=4
SPACE_2=8
SPACE_3=16
SPACE_4=32

# color palette
WHITE=0xFFDEE9F7
WHITE_TRANS=0x88DEE9F7
BLUE_DARK=0xFF7188A8
GREY=0xFF394351
BLACK=0xFF14161B
BLACK_ALPHA=0x4414161B
GREEN_ALT=0xFF1AC77F
GREEN=0xFF41E6A2
GREEN_ALPHA=0x8041E6A2
LAVENDER=0xFF9AA2F4
BLUE=0xFF7DCFFF
BLUE_TRANS=0x007DCFFF
PINK=0xFFF7A1C5
TRANS=0x00F7A1C5

function opacity() {
  local color=$1
  local opacity=$(printf '%x' $(( $2 * 2.55 + 1)))
  local hex=$(printf '%x' $color)
  local r=${hex:2:2}
  local g=${hex:4:2}
  local b=${hex:6:2}
  echo "0x$opacity$r$g$b"
}

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

MAGENTA=0xFFEF3885
MAGENTA_ALPHA=0x80EF3885

COLOR_NONE=0x00FFFFFF

COLOR_ACTIVE="$WHITE"
COLOR_ACTIVE_TRANS=$BLUE_TRANS
COLOR_INACTIVE="${WM_COLORS[black_alpha]}"
COLOR_HIGHLIGHT=$MAGENTA
COLOR_INFO=$GREEN
