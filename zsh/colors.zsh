typeset -Ag FX FG BG UC SU DU

FX=(
  reset            "[00m"
  bold             "[01m" no-bold      "[22m"
  faint            "[02m" no-faint     "[22m"
  italic           "[03m" no-italic    "[23m"
  underline        "[04m" no-underline "[24m"
  blink            "[05m" no-blink     "[25m"
  rapid-blink      "[06m" no-rapid-blink "[26m"
  reverse          "[07m" no-reverse   "[27m"
  crossed-out      "[09m" no-crossed-out "[29m"
  double-underline "[21m"
  undercurl        "[4:3m" no-undercurl "[4:0m"
)

local SUPPORT

if (( $# == 0 )); then
  SUPPORT=256
else
  SUPPORT=$1
fi

# Fill the color maps.
for color in {000..$SUPPORT}; do
  FG[$color]="[38;5;${color}m"
  BG[$color]="[48;5;${color}m"
  UC[$color]="[58;5;${color}m"
  SU[$color]="[4:3m;"
done

# Define the color names and their corresponding numbers.
typeset -A colors
colors=(
    black   000
    red     001
    green   002
    yellow  003
    blue    004
    magenta 005
    cyan    006
    white   007
)

# Assign the color numbers to the color names in each array.
for color num in ${(kv)colors}; do
    FG[$color]=$FG[$num]
    BG[$color]=$BG[$num]
    UC[$color]=$UC[$num]
done

export function style() {
  local text fg bg fx curl;

  # Parse the options.
  while (( $# )); do
    case "$1" in
      -fg)
        fg="${FG[$2]}"
        shift 2
        ;;
      -bg)
        bg="${BG[$2]}"
        shift 2
        ;;
      -fx)
        if [[ -z $fx ]]; then
          fx="${FX[$2]}"
        else
          fx+="${FX[$2]}"
        fi
        shift 2
        ;;
      -uc)
        curl="${FX[undercurl]}${UC[$2]}"
        shift 2
        ;;
      *)
        # the rest of the arguments are the text.
        text="$*"
        break
        ;;
    esac
  done

  # Apply the styles and print the text.
  echo "${fg}${bg}${fx}${curl}${text}${FX[reset]}"
}

export FG
export BG
export UC
export SU
export DU
export FX
